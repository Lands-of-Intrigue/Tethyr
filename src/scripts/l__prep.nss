void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");

    int nInt = GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);

    SetLocalInt(oItem,"nIntMod",nInt);
    SetLocalInt(oItem,"nLangSelect",nInt);
}

