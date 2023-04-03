//:://////////////////////////////////////////////
//:: MainEntryScript
//:: TE_FirstArea
//:: Function(D20) 2016
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: March 22, 2016
//:://////////////////////////////////////////////
#include "loi_functions"
#include "nwnx_creature"
void main()
{
    object oUser = GetEnteringObject();
    object oItem = GetItemPossessedBy(oUser, "PC_Data_Object");


    if(GetHasFeat(3000,oUser) == FALSE)
    {
        NWNX_Creature_AddFeat(oUser, 3000);
    }
    if(GetHasFeat(3001,oUser) == FALSE)
    {
        NWNX_Creature_AddFeat(oUser, 3001);
    }
    if(GetHasFeat(995,oUser) == FALSE)
    {
        SetLocalInt(GetItemPossessedBy(oUser, "PC_Data_Object"),"nEschew",0);
    }


    // If a new player...
    if ((GetHitDice(oUser) < 3) &&(!GetIsDM(oUser))) //Aka: Below level 3.
    {
        SetSubRace(oUser,"");
        //Create PC Data Object
        if (GetItemPossessedBy(oUser, "PC_Data_Object") == OBJECT_INVALID)
        {
            CreateItemOnObject("PC_Data_Object",oUser, 1);
            AddJournalQuestEntry("quest_welcome",1,oUser);
            AddJournalQuestEntry("quest_amn",1,oUser);
            AddJournalQuestEntry("quest_calimshan",1,oUser);
            AddJournalQuestEntry("quest_tethyr",1,oUser);
        }

        //Setup all initial integers, strings, and locations.
        SetLocalLocation(oItem, "lPCLoc", GetLocation(GetObjectByTag("WP_Starting_Area")));
        SetLocalString(oItem, "sPCFName", GetName(oUser));
        SetLocalString(oItem, "SPCTName", GetName(oUser));
        SetLocalString(oItem, "sPCCDKEY", GetPCPublicCDKey(oUser,FALSE));
        SetLocalString(oItem, "sPCIP", GetPCIPAddress(oUser));
        SetLocalString(oItem, "sPCIP2", GetPCIPAddress(oUser));
        SetLocalString(oItem, "sPCTitle", "None.");
        SetLocalInt(oItem,"iPCNotoriety",0);
        SetLocalInt(oItem, "iPCSubrace",0);
        SetLocalInt(oItem, "iPCAffliction",0);
        SetLocalInt(oItem, "iUndead",0);
        SetLocalInt(oItem,"iPCDead",0);
        SetLocalLocation(oItem, "lPCRespawn",GetLocation(GetObjectByTag("WP_WateryCave")));
        SetLocalInt(oItem,"iPCXP",0);
        SetLocalInt(oItem, "iPCGP",0);
        SetLocalInt(oItem,"iPCMAXGP",0);
        SetLocalInt(oItem,"iPCSubBonus",0);

        //Make them level 3
        SetXP(oUser, 3000);
        AssignCommand(oUser, JumpToLocation(GetLocation(GetObjectByTag("WP_NewCharacter")))); //Put them in the Starting Area.


    }
    else if (GetIsPC(oUser) == TRUE)
    {
        if(GetItemPossessedBy(oUser,"ceb_crcombinera") == OBJECT_INVALID)
        {
            object oCombiner = CreateItemOnObject("ceb_crcombinera",oUser,1);
            SetIdentified(oCombiner,TRUE);
        }

        if(GetItemPossessedBy(oUser,"ceb_crcraftbox") == OBJECT_INVALID)
        {
            object oCraftBox = CreateItemOnObject("ceb_crcraftbox",oUser,1);
            SetIdentified(oCraftBox,TRUE);
        }
        if(GetItemPossessedBy(oUser,"te_serverrules") == OBJECT_INVALID)
        {
            object oRules = CreateItemOnObject("te_serverrules",oUser,1);
            SetIdentified(oRules,TRUE);
        }

        if(GetLocalFloat(oItem,"fScale") != 0.0f && GetObjectVisualTransform(oUser,OBJECT_VISUAL_TRANSFORM_SCALE) == 0.0f)
        {
            SetObjectVisualTransform(oUser,OBJECT_VISUAL_TRANSFORM_SCALE,GetLocalFloat(oItem,"fScale"));
        }

        int nUndeadStamp = GetCalendarYear()*10000+GetCalendarMonth()*100+GetCalendarDay();

        if(GetIsUndead(oUser) == TRUE && GetLocalInt(oItem,"UndeadRespawn") > nUndeadStamp)
        {
            AssignCommand(oUser, JumpToLocation(GetLocation(GetObjectByTag("WP_UndeadDeath"))));
        }

        if (GetLocalInt(oItem, "iPCDead") == 1)
        {
            AssignCommand(oUser, JumpToLocation(GetLocation(GetObjectByTag("wp_respawn_fugue"))));
        }
    }
}
