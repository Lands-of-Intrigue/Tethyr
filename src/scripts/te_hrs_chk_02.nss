int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    if(GetLocalInt(oItem,"hrs_02") == TRUE && GetLocalInt(oPC,"hrs_02") == FALSE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
