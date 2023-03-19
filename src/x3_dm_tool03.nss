//::///////////////////////////////////////////////
//:: DM Tool 3 Instant Feat
//:: x3_dm_tool03
//:: Copyright (c) 2007 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is a blank feat script for use with the
    10 DM instant feats provided in NWN v1.69.

    Look up feats.2da, spells.2da and iprp_feats.2da

*/
//:://////////////////////////////////////////////
//:: Created By: Brian Chung
//:: Created On: 2007-12-05
//:://////////////////////////////////////////////
#include "loi_functions"
#include "te_afflic_func"
#include "NWNX_Creature"
void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nAffliction = GetPCAffliction(oTarget);

        if (nAffliction == 0)
        {
            Affliction_Items(oTarget, 2);
            SetPCAffliction(oTarget, 2);
            SetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"iUndead",0);
            SendMessageToPC(oPC, "This person is now a vampire thrall.");
            NWNX_Creature_AddFeat(oTarget, 1413);
        }
        if (nAffliction == 2)
        {
            Affliction_Items(oTarget, 3);
            SetPCAffliction(oTarget, 3);
            SetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"iUndead",1);
            SendMessageToPC(oPC, "This person is now a vampire.");

            NWNX_Creature_AddFeat(oTarget, 1414);
            NWNX_Creature_AddFeat(oTarget, 1415);
            NWNX_Creature_AddFeat(oTarget, 1422);
            NWNX_Creature_AddFeat(oTarget, 1423);
            NWNX_Creature_AddFeat(oTarget, 1424);
        }
        if (nAffliction == 3)
        {
            Affliction_Items(oTarget, 8);
            SetPCAffliction(oTarget, 8);
            SetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"iUndead",1);
            SendMessageToPC(oPC, "This person is now a Crimson Mist.");
        }
        if (nAffliction == 8)
        {
            Affliction_Items(oTarget, 0);
            SetPCAffliction(oTarget, 0);
            SetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"iUndead",0);
            SendMessageToPC(oPC, "This person is now normal.");
            NWNX_Creature_RemoveFeat(oTarget,1413);
            NWNX_Creature_RemoveFeat(oTarget, 1414);
            NWNX_Creature_RemoveFeat(oTarget, 1415);
            NWNX_Creature_RemoveFeat(oTarget, 1422);
            NWNX_Creature_RemoveFeat(oTarget, 1423);
            NWNX_Creature_RemoveFeat(oTarget, 1424);


        }

}
