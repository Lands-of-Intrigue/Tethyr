#include "loi_functions"
#include "te_afflic_func"
#include "so_inc_weather"
#include "spawn_main"
#include "rest_include"

void main() {
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    object oMod = GetModule();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    int iPop = GetLocalInt(OBJECT_SELF, "iPop");
    int iHB = GetLocalInt(OBJECT_SELF, "iHB");
    int iHBOn = GetLocalInt(OBJECT_SELF, "iHBOn");

    if(oPC==OBJECT_INVALID)
    {
        return;
    }

    // WEATHER SYSTEM
    int iWeather = GetLocalInt(oMod, "iWeather");
    if(GetLocalInt(OBJECT_SELF,"iWeather") != 1)
    {
        SetLocalInt(oArea,"WeatherUpdate",TRUE);
        UpdateAreaWeather(oArea,TRUE);
        SetLocalInt(OBJECT_SELF,"iWeather",1);
    }

    WriteTimestampedLogEntry(GetName(oPC)+"("+GetPCPublicCDKey(oPC)+") enters "+GetName(OBJECT_SELF)+".");
    SendMessageToPC(oPC, GetWeatherFeedback(oPC));

    // BEGIN PCs, Possessed Familiars, and DMs ---------------------------------
    if ( GetIsPC(oPC))
    {
        if(GetLocalInt(OBJECT_SELF, REST_UNRESTRICTED))
            SetLocalInt(oPC, REST_UNRESTRICTED, TRUE);
        if(GetLocalInt(OBJECT_SELF, REST_RESTRICTED))
            SetLocalInt(oPC, REST_RESTRICTED, TRUE);

        int nRestShelter = GetLocalInt(oPC, REST_SHELTER);
        if( GetLocalInt(OBJECT_SELF, "REST_IGNORE_TIME") )
            nRestShelter = nRestShelter | REST_IGNORE_TIME;
        if(GetLocalInt(OBJECT_SELF, "REST_IGNORE_WARMTH"))
            nRestShelter = nRestShelter | REST_IGNORE_WARMTH;
        if(GetLocalInt(OBJECT_SELF, "REST_IGNORE_BED"))
            nRestShelter = nRestShelter | REST_IGNORE_BED;
        if(GetLocalInt(OBJECT_SELF, "REST_IGNORE_FOOD"))
            nRestShelter = nRestShelter | REST_IGNORE_FOOD;
        SetLocalInt(oPC, REST_SHELTER, nRestShelter);

        string sMessage = GetLocalString(OBJECT_SELF, "REST_MESSAGE_ENTER");
        if(sMessage!="")
        {
            SendMessageToPC(oPC, "<c#ßþ>"+sMessage);
        }


        //Advance number of times person has been in the area.
        SetLocalInt(oItem,GetTag(oArea),GetLocalInt(oItem,GetTag(oArea))+1);

        // COUNT PCS IN AREA
        int nPCs    = GetLocalInt(OBJECT_SELF, SPAWN_PCS_IN_AREA)+1;

        // NESS Spawns -- only works for PCs or PCScriers
        if ( GetLocalInt(OBJECT_SELF, "AREA_NESS_DISABLE") )
        {
            // Maintain PC count even if NESS is disabled
            SetLocalInt(OBJECT_SELF, SPAWN_PCS_IN_AREA, nPCs);
        }
        else
        {
            // File: spawn_functions  -- init NESS pseudo heartbeat
            Spawn_OnAreaEnter();
        }

        // GIVE AREA DESCRIPTION
        if (GetLocalInt(oArea, "iEntryMsg") == 1)
        {
            SendMessageToPC(oPC, GetLocalString(oArea, "sEntryMsg"));
        }

        if( GetIsDM(oPC) )
        {
            ExploreAreaForPlayer(OBJECT_SELF, oPC);
        }
        else
        {
            // PCs and Familiars
            // ensure PCs are not in cutscenemode and are mortal
            SetCutsceneMode(oPC,FALSE);
            SetPlotFlag(oPC,FALSE);
            SetImmortal(oPC,FALSE);

        }
    } // END PCs, Possessed Familiars, and DMs ---------------------------------


    if(GetObjectType(oPC)==OBJECT_TYPE_CREATURE)
    {
        // Run custom OnEnter script on all entering Creatures
        string  sOnEnterExecute = GetLocalString (OBJECT_SELF, "AREA_SCRIPT_ENTER");
        if (sOnEnterExecute != "")
        {
            SetLocalObject(oPC, "ENTERING_AREA", OBJECT_SELF);
            ExecuteScript(sOnEnterExecute, oPC);
            DeleteLocalObject(oPC, "ENTERING_AREA");
        }
    }

    SetLocalString(oPC,"IN_AREA",ObjectToString(OBJECT_SELF)); // tracking whether Area Enter has finished and PC is in an area

    ExecuteScript("s_cleartrash",oArea);
}
