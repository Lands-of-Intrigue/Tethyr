int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    if(GetLocalInt(oItem,"hrs_03") == TRUE && GetLocalInt(oPC,"hrs_03") == FALSE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
