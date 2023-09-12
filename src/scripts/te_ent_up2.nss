void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    SetLocalInt(oItem,"te_ent_up",2);
}
