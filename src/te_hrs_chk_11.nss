int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    if((GetLevelByClass(CLASS_TYPE_PALEMASTER,oPC) >= 1 || GetLevelByClass(50,oPC) >= 1)&& GetLocalInt(oPC,"hrs_11") == FALSE)
    {
        SetLocalInt(oItem,"hrs_11",TRUE);
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
