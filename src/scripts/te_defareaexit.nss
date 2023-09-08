#include "te_functions"
#include "spawn_main"
#include "rest_include"

void main() {
    object oPC = GetExitingObject();
    int iPop = GetLocalInt(OBJECT_SELF, "iPop");
    int iHB = GetLocalInt(OBJECT_SELF, "iHB");
    int iHBOn = GetLocalInt(OBJECT_SELF, "iHBOn");
    if(!GetIsObjectValid(oPC))
    {
        return;
    }
    int nPCs;

    //Old Population Counter Script
    /*
    int iPop = GetLocalInt(OBJECT_SELF, "iPop");
    if (GetIsPC(oPC)) {
        //SendMessageToPC(oPC, "You exited a trigger"); // for debugging
        iPop--;
        SetLocalInt(OBJECT_SELF, "iPop", iPop);
        if (iPop < 1) {
            SetLocalInt(OBJECT_SELF, "iHB", 0);
        }
    }
    */

    if (GetIsPC(oPC))
    {
        iPop--;
        SetLocalInt(OBJECT_SELF, "iPop", iPop);
        if (iPop < 1) {
            SetLocalInt(OBJECT_SELF, "iHB", 0);
        }


        if(GetLocalInt(OBJECT_SELF, REST_UNRESTRICTED))
        DeleteLocalInt(oPC, REST_UNRESTRICTED);
        if(GetLocalInt(OBJECT_SELF, REST_RESTRICTED))
            DeleteLocalInt(oPC, REST_RESTRICTED);

        int nRestShelter    = GetLocalInt(oPC, REST_SHELTER);
        if(     GetLocalInt(OBJECT_SELF, "REST_IGNORE_TIME")
            &&  nRestShelter & REST_IGNORE_TIME
          )
            nRestShelter -= REST_IGNORE_TIME;
        if(     GetLocalInt(OBJECT_SELF, "REST_IGNORE_WARMTH")
            &&  nRestShelter & REST_IGNORE_WARMTH
          )
            nRestShelter -= REST_IGNORE_WARMTH;
        if(     GetLocalInt(OBJECT_SELF, "REST_IGNORE_BED")
            &&  nRestShelter & REST_IGNORE_BED
          )
            nRestShelter -= REST_IGNORE_BED;
        if(     GetLocalInt(OBJECT_SELF, "REST_IGNORE_FOOD")
            &&  nRestShelter & REST_IGNORE_FOOD
          )
            nRestShelter -= REST_IGNORE_FOOD;
        SetLocalInt(oPC, REST_SHELTER, nRestShelter);

        string sMessage = GetLocalString(OBJECT_SELF, "REST_MESSAGE_EXIT");
        if(sMessage!="")
        {
            SendMessageToPC(oPC, "<c#ßþ>"+sMessage);
        }

        nPCs = GetLocalInt(OBJECT_SELF, SPAWN_PCS_IN_AREA)-1;
        if(nPCs<1)
            nPCs=0;
        // NESS pseudo heartbeat -- PCs or PCScriers only -- File: spawn_functions Fnc: Spawn_OnAreaEnter()
        if ( !GetLocalInt(OBJECT_SELF, "AREA_NESS_DISABLE") )
        {
            Spawn_OnAreaExit();
        }
        else
            SetLocalInt(OBJECT_SELF, SPAWN_PCS_IN_AREA, nPCs);// Maintain PC Count even when NESS disabled

    if(GetObjectType(oPC)==OBJECT_TYPE_CREATURE)
    {
        // Run custom OnExit script on all exiting Creatures
        string  sOnExitExecute = GetLocalString (OBJECT_SELF, "AREA_SCRIPT_EXIT");
        if (sOnExitExecute != "")
        {
            SetLocalObject(oPC, "EXITING_AREA", OBJECT_SELF);
            ExecuteScript(sOnExitExecute, oPC);
            DeleteLocalObject(oPC, "EXITING_AREA");
        }
    }
        /*
        // Housing System
        string sHouseTag    = GetLocalString(OBJECT_SELF, "HOUSE");
        if(sHouseTag!="")
            HousingOnAreaExit(sHouseTag, oPC);
        */
        // saving data
        //if(bPC && bGameOn)
        //    SavePCData(oPC);

    }



}
