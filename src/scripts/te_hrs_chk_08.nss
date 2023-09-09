int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    if(GetLocalInt(oItem,"hrs_08") == TRUE && GetLocalInt(oPC,"hrs_08") == FALSE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
