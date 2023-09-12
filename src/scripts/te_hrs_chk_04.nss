int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    if(GetLocalInt(oItem,"hrs_04") == TRUE && GetLocalInt(oPC,"hrs_04") == FALSE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
