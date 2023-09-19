void main()
{
    effect eEffect;

    // Get the creature who triggered this event.
    object oPC = GetEnteringObject();

    // Only fire for (real) PCs.
    if ( !GetIsPC(oPC)  ||  GetIsDMPossessed(oPC) )
        return;

    // Apply an effect.
    eEffect = SupernaturalEffect(EffectHeal(1000));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);
}

