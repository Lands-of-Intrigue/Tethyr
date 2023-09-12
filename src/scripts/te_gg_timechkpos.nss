int StartingConditional()
{
    object oPlace = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    int nTimeStamp = (GetCalendarYear()*1000000)+(GetCalendarMonth()*10000)+(GetCalendarDay()*100)+GetTimeHour();

    if(nTimeStamp >= GetLocalInt(oPlace,"nLastMod"))
    {
        return TRUE;
    }

    return FALSE;

}
