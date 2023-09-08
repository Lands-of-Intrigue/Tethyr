int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    if(GetLocalInt(oItem,"hrs_05") == TRUE && GetLocalInt(oPC,"hrs_05") == FALSE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
