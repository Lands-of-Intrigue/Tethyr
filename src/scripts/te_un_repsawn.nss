int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    int nTimestamp = GetCalendarYear()*10000+GetCalendarMonth()*100+GetCalendarDay();
    if(GetLocalInt(oItem,"UndeadRespawn") < nTimestamp)
    {return TRUE;}
    else
    {return FALSE;}
}
