int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    if(GetLocalInt(oItem,"hrs_01") == TRUE && GetLocalInt(oPC,"hrs_01") == FALSE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
