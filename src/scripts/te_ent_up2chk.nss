int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    int iEntUp = GetLocalInt(oItem,"te_ent_up");

    if(iEntUp == 2)
        return TRUE;

    return FALSE;


}
