void main()
{
    object oPC = GetLastAttacker(OBJECT_SELF);
    object oPlace = OBJECT_SELF;

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage((GetMaxHitPoints(oPC)/4),DAMAGE_TYPE_NEGATIVE,DAMAGE_POWER_PLUS_TWO),oPC);
}
