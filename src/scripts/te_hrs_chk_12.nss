int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    if((GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) >=1 || GetLevelByClass(47,oPC) >=1) && GetLocalInt(oPC,"hrs_12") == FALSE)
    {
        SetLocalInt(oItem,"hrs_12",TRUE);
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
