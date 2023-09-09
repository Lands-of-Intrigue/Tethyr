//:: [Phylactery Reflect Range Mechanic]
//:: [tn_phyreflect.nss]
//:://////////////////////////////////////////////
//:: Identify who is damaging the artifact
//:: If the damaging attacker is farther than 10m
//:: (A.K.A. out of negative pulse range)
//:: Damage the attacker with reflected damage
//:: 2d6 Negative damage & 1d4 Sonic damage
//:: Deafness will Negate the Sonic damage
//:: 20% chance to anger the spirit:
//:: (This will cause an 8-24 sec fear effect)
//:: The purpose of this script is to deter range
//:: characters from camping outside the pulse area
//:://////////////////////////////////////////////
//:: Created By: Tsurani.Nevericy
//:: Created On: 1/30/2018
//:: Created For: Knights of Noromath
//:://////////////////////////////////////////////
#include "x0_i0_match"
void main(){
    object oAttacker = GetLastDamager(OBJECT_SELF);
    float fAttacker = GetDistanceToObject(oAttacker);
    effect eNegative = EffectDamage(d6(2), DAMAGE_TYPE_NEGATIVE);
    effect eSonic = EffectDamage(d4(1), DAMAGE_TYPE_SONIC);
    if(GetHasEffect(EFFECT_TYPE_DEAF, oAttacker)){eSonic = EffectDamage(0, DAMAGE_TYPE_SONIC);}
    effect eReflect = EffectLinkEffects(eSonic, eNegative);
    effect eFear = EffectFrightened(); effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR); effect eSpook = EffectLinkEffects(eVis, eFear);
    if (fAttacker > 10.0){ApplyEffectToObject(DURATION_TYPE_INSTANT, eReflect, oAttacker);
    if (Random(5) < 1){PlaySound("sff_combansh");
    FloatingTextStringOnCreature("Your cowardice angers the malevolent spirit!", oAttacker, FALSE);
    DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSpook, oAttacker, IntToFloat(d3(8))));}}
}
