void main()
{
    object oTarget = GetSpellTargetObject();
    effect eNoConcen = EffectSkillDecrease(SKILL_CONCENTRATION, 10);
    float fDuration = RoundsToSeconds(2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eNoConcen, oTarget, fDuration);
}
