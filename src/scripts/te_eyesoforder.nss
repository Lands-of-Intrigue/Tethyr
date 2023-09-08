//::///////////////////////////////////////////////
//:: Eyes of the Order
//:: TE_eyesoforder.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: David Novotny
//:: Modified On: Feb 22, 2016
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetSpellTargetObject();
    float fDur = HoursToSeconds(1);

    effect eSkill1 = EffectSkillIncrease(SKILL_SPOT, 6);
    effect eSkill2 = EffectSkillIncrease(SKILL_SEARCH, 6);
    effect eLink = EffectLinkEffects(eSkill1, eSkill2);
    eLink = EffectLinkEffects(eLink, EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, MagicalEffect(eLink), oPC, fDur);
}
