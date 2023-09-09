int StartingConditional()
{
    object oPC    = GetPCSpeaker();
    object oItem  = GetItemPossessedBy(oPC,"PC_Data_Object");
    int    nPiety = GetLocalInt(oItem,"nPiety");

    if(GetLocalInt(oPC,"hrs_10") == FALSE && nPiety >= 60 && GetLevelByClass(CLASS_TYPE_PALADIN,oPC) >=1 && GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) <1)
    {
        SetLocalInt(oItem,"hrs_10",TRUE);
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
