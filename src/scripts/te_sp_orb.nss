#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nCL = TE_GetCasterLevel(oPC,CLASS_TYPE_WARLOCK);
    int nTouch = TouchAttackRanged(oTarget);
    int nSpell = GetSpellId();
    effect eVis;
    effect eDamage;
    effect eLink;

    int nDamage = nCL/2;

    if(nDamage >= 5)
    {
        nDamage = 5;
    }

    if(nSpell == 1070)
    {
        eVis = EffectVisualEffect(VFX_COM_HIT_ACID);
        eDamage = EffectDamage(d8(nDamage),DAMAGE_TYPE_ACID,DAMAGE_POWER_NORMAL);
    }
    else if (nSpell == 1071)
    {
        eVis = EffectVisualEffect(VFX_COM_HIT_FROST);
        eDamage = EffectDamage(d8(nDamage),DAMAGE_TYPE_COLD,DAMAGE_POWER_NORMAL);
    }
    else if (nSpell == 1072)
    {
        eVis = EffectVisualEffect(VFX_COM_HIT_ELECTRICAL);
        eDamage = EffectDamage(d8(nDamage),DAMAGE_TYPE_ELECTRICAL,DAMAGE_POWER_NORMAL);
    }
    else if (nSpell == 1073)
    {
        eVis = EffectVisualEffect(VFX_COM_HIT_FIRE);
        eDamage = EffectDamage(d8(nDamage),DAMAGE_TYPE_FIRE,DAMAGE_POWER_NORMAL);
    }
    else if (nSpell == 1074)
    {
        eVis = EffectVisualEffect(VFX_COM_HIT_SONIC);
        eDamage = EffectDamage(d8(nDamage),DAMAGE_TYPE_SONIC,DAMAGE_POWER_NORMAL);
    }

    eLink = EffectLinkEffects(eVis,eDamage);

    if(nTouch != 0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget);
    }
}

