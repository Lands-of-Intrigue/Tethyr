//::///////////////////////////////////////////////
//:: SpellWard
//:: TE_spellward.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: David Novotny
//:: Modified On: Feb 22, 2016
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetSpellTargetObject();
    int nCL = GetLevelByClass(51, oPC);
    float fDur = TurnsToSeconds(nCL);
    effect eLink;
    effect ePFA1;
    effect ePFA2;
    effect ePFA3;
    effect eAid1;
    effect eAid2;
    effect eNeg1;
    effect eNeg2;
    effect eNeg3;
    effect eDWar;
    effect eSR;
    // Level 1: PFA  s
    // Level 2: AID  s
    // Level 3: Clarity  s
    // Level 4: Death Ward
    // Level 5: Spell Resistance

    eLink =  EffectLinkEffects(EffectSpellResistanceIncrease(13+nCL),  EffectVisualEffect (VFX_DUR_CESSATE_POSITIVE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,  MagicalEffect (eLink), oPC, fDur);
}
