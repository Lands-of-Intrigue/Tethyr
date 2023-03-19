int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    if(GetLocalInt(oItem,"hrs_06") == TRUE && GetLocalInt(oPC,"hrs_06") == FALSE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
