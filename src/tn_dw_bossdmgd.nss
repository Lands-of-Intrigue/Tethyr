void main()
{
    if (GetCurrentHitPoints(OBJECT_SELF) < 200)
    {
        SetImmortal(OBJECT_SELF, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDisappear(), OBJECT_SELF);
        SpeakString("Agghh! You shall not defeat me that easily!");
        CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2001",GetLocation(GetWaypointByTag("tn_boss_wp")), FALSE);
    }
    ExecuteScript("x2_def_ondamage", OBJECT_SELF);
}
