void main()
{
    object oPC = OBJECT_SELF;

    effect eAttack = TagEffect(EffectAttackDecrease(3), "MBreakStance");
    effect eArmor = TagEffect(EffectACDecrease(4), "MBreakStance");
    effect eMove = TagEffect(EffectMovementSpeedDecrease(99), "MBreakStance");

    effect eSR = TagEffect(EffectSpellResistanceIncrease(GetSpellResistance(oPC)+10), "MBreakStance");
    effect eDam = TagEffect(EffectDamageIncrease(5), "MBreakStance");

    float fDuration = RoundsToSeconds(GetLevelByClass(58, oPC)/2);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttack, oPC , fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eArmor, oPC, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eMove, oPC, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSR, oPC, fDuration);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDam, oPC, fDuration);
}
