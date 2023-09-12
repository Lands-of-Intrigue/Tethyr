void main()
{
    object oPC = OBJECT_SELF;
    int iCL = GetHitDice(oPC);
    if (GetHasFeat(1179, oPC) )
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectSpellResistanceIncrease(11+iCL)),oPC);
    }
    else if (GetHasFeat(1186, oPC) )
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageResistance(DAMAGE_TYPE_ACID, 5, 0)), oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageResistance(DAMAGE_TYPE_COLD, 5, 0)), oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, 5, 0)), oPC);
    }
    else if (GetHasFeat(1187, oPC) )
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageResistance(DAMAGE_TYPE_FIRE, 5, 0)), oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageResistance(DAMAGE_TYPE_COLD, 5, 0)), oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL, 5, 0)), oPC);
    }
    else if (GetHasFeat(1183, oPC) )
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_POISON)),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_PARALYSIS)),oPC);
    }
    SendMessageToPC(oPC, "The subrace traits that cannot be permanently applied have been updated.");
}
