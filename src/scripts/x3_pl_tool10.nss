//::///////////////////////////////////////////////
//:: Player Tool 9 Instant Feat
//:: x3_pl_tool09
//:: Copyright (c) 2007 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is a blank feat script for use with the
    10 Player instant feats provided in NWN v1.69.

    Look up feats.2da, spells.2da and iprp_feats.2da

*/
//:://////////////////////////////////////////////
//:: Created By: Brian Chung
//:: Created On: 2007-12-05
//:://////////////////////////////////////////////
#include "NWNX_Creature"

void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    NWNX_Creature_AddFeat(oTarget,1139);
    SetLocalInt(GetItemPossessedBy(oTarget,"PC_Date_Object"),"12",1);

    SendMessageToPC(oPC, "This person is now assigned to the Infernal Faction.");

}
