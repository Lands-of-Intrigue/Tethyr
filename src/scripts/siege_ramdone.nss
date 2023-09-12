////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_ramdone:
// Rams the door.
////////////////////////////
// Added in v1.1

void main()
{
    ClearAllActions(TRUE); //Disrupt combat.
    //Get variables
    object oWeapon = GetLocalObject(OBJECT_SELF, "siege_used");
    object oDoor = GetLocalObject(OBJECT_SELF, "siege_target");

    SetLocalInt(oWeapon, "firing", FALSE);

    //Modifies the damage based on the PC's strength score. Anyone with 10 or lower strength
    //has a chance of not doing any damage.
    int iModifier = GetAbilityScore(OBJECT_SELF, ABILITY_STRENGTH) - 14;

    int iDamage = d6(4) + iModifier;

    if(iDamage <= 0)    //Did we do damage?
    {
        SendMessageToPC(OBJECT_SELF, "You fail to do any damage to the door.");
        return;
    }

    effect eDamage = EffectDamage(iDamage, DAMAGE_TYPE_BLUDGEONING);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oDoor);

    effect eVisual = EffectVisualEffect(VFX_COM_SPARKS_PARRY);

    if(GetLocalInt(oWeapon, "on_fire"))//Are we on fire?
    {
        eVisual = EffectVisualEffect(VFX_COM_HIT_FIRE); //If so change the VFX and deal damage
        eDamage = EffectDamage(d6() + 1, DAMAGE_TYPE_FIRE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oDoor);
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oDoor);

    float fDamage = (GetCurrentHitPoints(oWeapon) / GetMaxHitPoints(oWeapon)) * 100.0;
    iDamage = FloatToInt(fDamage);
    SendMessageToPC(OBJECT_SELF, "Your ram is at " + IntToString(iDamage) + "% condition.");

}
