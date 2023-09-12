int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    if(GetLocalInt(oItem,"hrs_09") == TRUE && GetLocalInt(oPC,"hrs_09") == FALSE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
