//::///////////////////////////////////////////////
//:: DM Tool 8 Instant Feat
//:: x3_dm_tool08
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

void main()
{
    object oUser = OBJECT_SELF;
    object oPC = GetSpellTargetObject();

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetCurrentHitPoints(oPC)-1),oPC);
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC, PlayAnimation( ANIMATION_LOOPING_DEAD_FRONT, 1.0, HoursToSeconds(999)));
    SetPlotFlag(oPC,TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectAbilityDecrease(ABILITY_CONSTITUTION,12),oPC);

}
