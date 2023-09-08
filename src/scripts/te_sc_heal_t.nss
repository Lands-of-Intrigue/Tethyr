void main()
{
    object oPC = OBJECT_SELF;
    object oTar = GetSpellTargetObject();
    int nLevel = GetLevelByClass(49, oPC);
    effect eHeal = EffectHeal(d4(nLevel));
    effect eVis = EffectVisualEffect(822);
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    int nMana = GetLocalInt(oItem,"nMana");
    if (nMana >= 1)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTar);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTar);

        if(oPC == oTar)
        {
            SetLocalInt(oItem,"nMana",nMana-2);
        }
        else
        {
            SetLocalInt(oItem,"nMana",nMana-1);
        }
    }
    else
    {
        SendMessageToPC(oPC,"You reach into your well of stored power and find it empty.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(1),DAMAGE_TYPE_FIRE),oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(1),DAMAGE_TYPE_MAGICAL),oPC);
    }
}
