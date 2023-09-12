void main()
{
    effect eFire = EffectVisualEffect(VFX_DUR_INFERNO);
    if (GetLastSpell() == SPELL_BURNING_HANDS
    || GetLastSpell() == SPELL_COMBUST
    || GetLastSpell() == SPELL_FLAME_STRIKE
    || GetLastSpell() == SPELL_FLAME_ARROW
    || GetLastSpell() == SPELL_FLAME_LASH
    || GetLastSpell() == SPELL_CONTINUAL_FLAME
    || GetLastSpell() == SPELL_FLARE
    || GetLastSpell() == SPELL_INFERNO
    || GetLastSpell() == SPELL_FIREBALL
    || GetLastSpell() == SPELL_SHADES_FIREBALL
    || GetLastSpell() == SPELL_GRENADE_FIRE
    || GetLastSpell() == SPELL_SEARING_LIGHT
    || GetLastSpell() == SPELLABILITY_HELL_HOUND_FIREBREATH
    || GetLastSpell() == SPELLABILITY_CONE_FIRE
    || GetLastSpell() == SPELLABILITY_BOLT_FIRE
    || GetLastSpell() == SPELLABILITY_AA_IMBUE_ARROW
    || GetLastSpell() == 911
    || GetLastSpell() == 901)
    {
        if (GetTag(GetArea(OBJECT_SELF)) == "bcstfli")
        {
            SetLocalInt(OBJECT_SELF, "Burned", 1);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFire, GetNearestObjectByTag("tn_dw_zomfire"));
        }
    }
}
