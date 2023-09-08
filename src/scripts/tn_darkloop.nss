//:: [Dark Loop]
//:: [tn_darkloop.nss]
//:://////////////////////////////////////////////
//:: Pulse 10m 4d6 Negative damage
//:: Fort Save vs Negative for Strength Drain (-1)
//:: Pulse 05m 2d8 Sonic damage
//:: Fort Save vs Sonic for Stun (8-24s)
//:: Creates 1 Shadow Fiend if there is none alive
//:: Creates 3-10 Shadows
//:: 75% Shadow, Greater
//:: 25% Shadow
//:: While Shadow Fiend is alive Artifact is PLOT
//:: Repeat every 15-60s
//:: Undeads Heal from Negative Damage
//:: Undeads Ignore Sonic Damage
//:: Constructs Ignore Negative Damage
//:: Constructs Ignore Sonic Damage
//:://////////////////////////////////////////////
//:: Created By: Tsurani.Nevericy
//:: Created On: 1/30/2018
//:: Created For: Knights of Noromath
//:: Updated: 2/4/2018
//:://////////////////////////////////////////////
#include "x0_i0_match"
#include "x2_inc_spellhook"
void CallOfTheDark()
{
    int i;
    int nDamage;
    int nDamage2;
    string sMob1 = "te_shad1";
    string sMob2 = "te_shad2";
    string sMob3 = "te_shad3";
    float fDelay;
    effect eVisHarm2 = EffectVisualEffect(VFX_IMP_SONIC);
    effect eStun = EffectStunned();
    effect eHeal;
    effect eVisHeal = EffectVisualEffect(VFX_IMP_HEAD_EVIL);
    effect eVisHarm = EffectVisualEffect(VFX_IMP_DOOM);
    effect eBurst = EffectVisualEffect(VFX_FNF_LOS_EVIL_20);
    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    effect eBurst2 = EffectVisualEffect(VFX_FNF_SOUND_BURST);
    effect eDam2 = EffectDamage(nDamage2, DAMAGE_TYPE_SONIC);;
    if (OBJECT_SELF == OBJECT_INVALID || GetIsDead(OBJECT_SELF)) {return;}
    else
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBurst, GetLocation(OBJECT_SELF));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBurst2, GetLocation(OBJECT_SELF));


        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 10.0f, GetLocation(OBJECT_SELF));
        while (GetIsObjectValid(oTarget))
        {
            nDamage = d6(4);
            fDelay = GetDistanceBetweenLocations(GetLocation(OBJECT_SELF), GetLocation(oTarget))/20;
            if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
            {
                eHeal = EffectHeal(nDamage);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectAbilityIncrease(ABILITY_STRENGTH,1), oTarget));
            }
            else if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD || GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT)
            {
                if (MySavingThrow(SAVING_THROW_FORT, oTarget, 17, SAVING_THROW_TYPE_NEGATIVE) == 1 || 2)
                {
                    nDamage /= 2;
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHarm, oTarget));
                }
                else
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHarm, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectAbilityDecrease(ABILITY_STRENGTH,1), oTarget));
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, 10.0f, GetLocation(OBJECT_SELF));
        }

        object oTarget2 = GetFirstObjectInShape(SHAPE_SPHERE, 5.0f, GetLocation(OBJECT_SELF));
        while (GetIsObjectValid(oTarget2))
        {
            nDamage2 = d8(2);
            eDam2 = EffectDamage(nDamage2, DAMAGE_TYPE_SONIC);
            fDelay = GetDistanceBetweenLocations(GetLocation(OBJECT_SELF), GetLocation(oTarget2))/10;
             if(GetHasEffect(EFFECT_TYPE_DEAF, oTarget2))
            {
                nDamage2 = 0;
            }
            if(GetRacialType(oTarget2) == RACIAL_TYPE_UNDEAD || GetRacialType(oTarget2) == RACIAL_TYPE_CONSTRUCT)
            {
                nDamage2 = 0;
            }
            else
            {
                if (MySavingThrow(SAVING_THROW_FORT, oTarget, 15, SAVING_THROW_TYPE_SONIC) == 1 || 2)
                {
                    nDamage2 /= 2;
                    //eDam2 = EffectDamage(nDamage2, DAMAGE_TYPE_SONIC);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam2, oTarget2));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHarm2, oTarget2));
                }
                else
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam2, oTarget2));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHarm2, oTarget2));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget2, IntToFloat(d8(3))));
                }
            }
            oTarget2 = GetNextObjectInShape(SHAPE_SPHERE, 5.0f, GetLocation(OBJECT_SELF));
        }

        if (GetObjectByTag("te_shad3") == OBJECT_INVALID || GetIsDead(GetObjectByTag("te_shad3")) == TRUE)
        {
            CreateObject(OBJECT_TYPE_CREATURE, "te_shad3", GetLocation(GetNearestObjectByTag("tn_shadowspawn", OBJECT_SELF, d10(1))), FALSE);
            if (GetPlotFlag(OBJECT_SELF) == FALSE)
            {
                SetPlotFlag(OBJECT_SELF, TRUE);
            }
        }
        while ( i < Random(8)+3)
        {
            if ( d20(1) < 6 )CreateObject(OBJECT_TYPE_CREATURE, sMob1, GetLocation(GetNearestObjectByTag("tn_shadowspawn", OBJECT_SELF, d10(1))), FALSE);
            else CreateObject(OBJECT_TYPE_CREATURE, sMob2, GetLocation(GetNearestObjectByTag("tn_shadowspawn", OBJECT_SELF, d10(1))), FALSE);
            i++;
        }
    DelayCommand(15.0+Random(46), CallOfTheDark());
    return;
    }
}

void main(){CallOfTheDark();}
