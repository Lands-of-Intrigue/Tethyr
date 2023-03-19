void main()
{
    object oPC = GetLastSpellCaster();
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    if (GetLastSpell() == SPELL_CURE_MINOR_WOUNDS
    || GetLastSpell() == SPELL_CURE_LIGHT_WOUNDS
    || GetLastSpell() == SPELL_CURE_MODERATE_WOUNDS
    || GetLastSpell() == SPELL_CURE_SERIOUS_WOUNDS
    || GetLastSpell() == SPELL_CURE_CRITICAL_WOUNDS
    || GetLastSpell() == SPELL_HEAL
    || GetLastSpell() == SPELL_LESSER_RESTORATION
    || GetLastSpell() == SPELL_RESTORATION
    || GetLastSpell() == SPELL_GREATER_RESTORATION
    || GetLastSpell() == SPELLABILITY_LAY_ON_HANDS)
    {
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eShake, GetLocation(OBJECT_SELF));
        FloatingTextStringOnCreature("The house shakes, and you hear angry cursing in the darkness!", oPC, TRUE);
        ActionOpenDoor(OBJECT_SELF);
        DelayCommand(30.0, ActionCloseDoor(OBJECT_SELF));
    }
}

