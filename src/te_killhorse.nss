void main()
{
    object oPC = GetEnteringObject();
    effect eDeath = EffectDeath();

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
}
