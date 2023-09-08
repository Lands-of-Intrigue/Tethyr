int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    if(GetLocalInt(oItem,"hrs_07") == TRUE && GetLocalInt(oPC,"hrs_07") == FALSE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
