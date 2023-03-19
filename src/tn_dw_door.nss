#include "x2_inc_spellhook"
void main()
{
    int nDamage = d6(2);
    int nDamage2 = d6(1);
    object oAttacker = GetLastDamager(OBJECT_SELF);
    effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eBurst = EffectVisualEffect(VFX_FNF_LOS_EVIL_10);
    effect eBurst2 = EffectVisualEffect(VFX_IMP_MAGBLUE);
    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
    effect eDamage2 = EffectDamage(nDamage2, DAMAGE_TYPE_MAGICAL);

    if (GetRacialType(oAttacker) == RACIAL_TYPE_UNDEAD || RACIAL_TYPE_CONSTRUCT)
    {
        if (MySavingThrow(SAVING_THROW_FORT, oAttacker, 15) == 0)
        {nDamage2 = d6(1);}else{nDamage2 /= 2;}
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage2, oAttacker);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBurst2, oAttacker);
    }
    else
    {
        if (MySavingThrow(SAVING_THROW_WILL, oAttacker, 15, SAVING_THROW_TYPE_NEGATIVE) == 0)
        {nDamage = d6(2);}else{nDamage /= 2;}
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oAttacker);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBurst, GetLocation(OBJECT_SELF));
    }
    if (GetCurrentHitPoints(OBJECT_SELF) < 450)
    {
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eShake, GetLocation(OBJECT_SELF));
        FloatingTextStringOnCreature("The house shakes, and you hear angry cursing in the darkness!", oAttacker, TRUE);
        ActionOpenDoor(OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(OBJECT_SELF)-GetCurrentHitPoints(OBJECT_SELF)), OBJECT_SELF);
        DelayCommand(15.0, ActionCloseDoor(OBJECT_SELF));
    }
}
