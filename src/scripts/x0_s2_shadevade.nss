//::///////////////////////////////////////////////
//:: Shadow Evade
//:: X0_S2_ShadEvade    .nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the caster the following bonuses:
    Level 4:
      5% concealment
      5/+1 DR
      +1 AC
    Level 6
      10% concealment
      5/+2 DR
      +2 AC

    Level 8
      15% concealment
      10/+2 DR
      +3 AC

    Level 10
      20% concealment
      10/+3 DR
      +4 AC

    Lasts: 5 rounds


   Epic:
   +2 DR Amount +1 DR Power per 5 levels after 10

*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 26, 2001
//:: Updated for Epic Level: 2003-07-24 Georg
//:://////////////////////////////////////////////


void main()
{
    //Declare major variables
    int nLevel = GetLevelByClass(CLASS_TYPE_SHADOWDANCER);
    int nConceal, nDRAmount, nDRPower, nAC;
    int nDuration = 5 + nLevel;

    nConceal = 50; nDRAmount = 10; nDRPower = DAMAGE_POWER_PLUS_TWO; nAC = 5;

    //Declare effects
    effect eConceal = EffectConcealment(nConceal);
    effect eDR = EffectDamageReduction(nDRAmount, nDRPower);
    effect eAC = EffectACIncrease(nAC);
    effect eDur= EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eVis2 = EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR);

    //Link effects
    effect eLink = EffectLinkEffects(eConceal, eDR);

    eLink = EffectLinkEffects(eLink, eAC);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eVis2);

    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    //Signal Spell Event
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, 477, FALSE));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nDuration));
}


