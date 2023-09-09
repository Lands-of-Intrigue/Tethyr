//::///////////////////////////////////////////////
//:: Temps persistant
//:: Par Zyzko
//:://////////////////////////////////////////////

void main()
{
    // Met a jour le nouveau temps
    // Update time in the database
    object oMod=GetModule();
    SetCampaignInt("Dates","TIMEHOUR",GetTimeHour(),oMod);
    SetCampaignInt("Dates","TIMEDAY",GetCalendarDay(),oMod);
    SetCampaignInt("Dates","TIMEMONTH",GetCalendarMonth(),oMod);
    SetCampaignInt("Dates","TIMEYEAR",GetCalendarYear(),oMod);
}
