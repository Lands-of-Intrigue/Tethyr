//::///////////////////////////////////////////////
//:: Improved Grenade weapons script
//:: x2_s3_bomb
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    More powerful versions of the standard grenade
    weapons.
    They do 3d6 points of damage and create an
    persistant AOE effect for 3 rounds
    1d6 points of damage splash

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-08-18
//:: Updated By: DM Djinn 7/14/18
//:://////////////////////////////////////////////

#include "x0_i0_spells"
void main()
{
    int nSpell = GetSpellId();


    if (nSpell == 745)  // acid bomb
    {
         DoGrenade(d6(3),d6(1), VFX_IMP_ACID_L, VFX_FNF_LOS_NORMAL_30,DAMAGE_TYPE_ACID,RADIUS_SIZE_LARGE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
         ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectAreaOfEffect(AOE_PER_FOGACID), GetSpellTargetLocation(), RoundsToSeconds(3));
    } else if (nSpell == 744)
    {
         DoGrenade(d6(3),d6(1), VFX_IMP_FLAME_M, VFX_FNF_FIREBALL,DAMAGE_TYPE_FIRE,RADIUS_SIZE_LARGE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
         ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectAreaOfEffect(AOE_PER_FOGFIRE), GetSpellTargetLocation(), RoundsToSeconds(3));
    }




}
