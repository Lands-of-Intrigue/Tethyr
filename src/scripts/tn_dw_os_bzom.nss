void main()
{
    effect eFlies = EffectVisualEffect(VFX_DUR_FLIES);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFlies, OBJECT_SELF);
    ActionMoveToLocation(GetLocation(GetNearestObjectByTag("tn_dw_boss_wp")), TRUE);
    ExecuteScript("nw_c2_default9", OBJECT_SELF);
}
