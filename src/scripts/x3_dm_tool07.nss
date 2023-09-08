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
#include "X2_I0_SPELLS"
#include "x2_inc_itemprop"
#include "x2_inc_spellhook"

void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    location lLoc = GetSpellTargetLocation();

    DoGrenade(d6(6),d8(3)+1, VFX_IMP_FLAME_M, VFX_FNF_FIREBALL,DAMAGE_TYPE_BLUDGEONING,RADIUS_SIZE_GARGANTUAN, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
}
