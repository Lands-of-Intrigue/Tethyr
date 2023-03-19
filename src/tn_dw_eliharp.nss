void main()
{
    object oGhostBoss = GetObjectByTag("te_npc_2001");
    effect eDamage1 = EffectDamage((GetCurrentHitPoints(oGhostBoss)-GetMaxHitPoints(oGhostBoss)), DAMAGE_TYPE_MAGICAL);
    if (GetTag(GetArea(OBJECT_SELF)) == "bcstfli")
    {

        if (oGhostBoss == OBJECT_INVALID)
        {
            FloatingTextStringOnCreature("The harp has no effect at this moment", OBJECT_SELF, FALSE);
            return;
        }
        if (GetLocalInt(OBJECT_SELF, "HarpUsed") == 1){return;}
        else
        {
            if (GetItemPossessedBy(OBJECT_SELF, "tn_dw_elisong") != OBJECT_INVALID)
            {
                effect eBuff1 = EffectDamageResistance(DAMAGE_TYPE_BASE_WEAPON, 2, 50);
                effect eBuff2 = EffectDamageResistance(DAMAGE_TYPE_NEGATIVE, 1, 25);
                effect eBuff3 = EffectACIncrease(2, AC_DODGE_BONUS);
                effect eLink = EffectLinkEffects(eBuff2, eBuff1);
                eLink = EffectLinkEffects(eBuff3, eLink);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, TurnsToSeconds(5));
                }
                    SetLocalInt(OBJECT_SELF, "HarpUsed", 1);
            }
        }
        SetLocalInt(oGhostBoss, "Weakened", 1);
        if (GetCurrentHitPoints(oGhostBoss) >= GetMaxHitPoints(oGhostBoss))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage1, oGhostBoss);
        }
    else {return;}
}
