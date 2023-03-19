void main()
{
    object oPC = OBJECT_SELF;
    int nLevel = GetLevelByClass(49, oPC);
    int nCON = GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
    int nAbs = (nLevel + nCON);
    effect eAbsorb = EffectSpellLevelAbsorption(9, nAbs, SPELL_SCHOOL_GENERAL);
    effect eVis = EffectVisualEffect(VFX_DUR_SPELLTURNING);
    effect eVis2 = EffectVisualEffect(VFX_IMP_SPELL_MANTLE_USE);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAbsorb, oPC, 12.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oPC, 12.0f);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oPC);
}
