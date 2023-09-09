void main()
{
    effect eInvis = ExtraordinaryEffect(EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY));
    effect eGhost = EffectCutsceneGhost();
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);
}
