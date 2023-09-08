void main()
{
    object oPC = OBJECT_SELF;
    int nCL = GetLevelByClass(47, oPC);
    float fDur = TurnsToSeconds(nCL/2);


    effect eSR = EffectSpellResistanceIncrease(nCL*2);
    effect eAC = EffectACIncrease((nCL/2), AC_DODGE_BONUS, AC_VS_DAMAGE_TYPE_ALL);
    effect eVis1 = EffectVisualEffect(VFX_IMP_DEATH_WARD);
    effect eVis2 = EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY);
    effect eVis4 = EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSR, oPC, fDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, oPC, fDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis1, oPC, fDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oPC, fDur);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis4, oPC, fDur);
}
