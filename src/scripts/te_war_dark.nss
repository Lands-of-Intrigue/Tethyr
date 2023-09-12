void main()
{
	object oPC = OBJECT_SELF;
	float fDur = HoursToSeconds(24);
	int nCHA = GetAbilityModifier(ABILITY_CHARISMA, oPC);
	effect eSav = EffectSavingThrowIncrease(SAVING_THROW_ALL, nCHA);
	eSav = MagicalEffect(eSav);

	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSav, oPC, fDur);
}
