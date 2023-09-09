#include "X0_I0_PARTYWIDE"

void main()
{
     object oPC = GetLastDisarmed();
     object oTrap = OBJECT_SELF;
     int nTimeStamp = (GetCalendarYear()*1000000)+(GetCalendarMonth()*10000)+(GetCalendarDay()*100)+GetTimeHour();
     if (GetIsPC(oPC)&& GetLocalInt(oTrap,"TimeDisabled")>nTimeStamp)
     {
          GiveXPToAll(oPC, 25);
     }

    SetLocalInt(oTrap,"TimeDisabled",nTimeStamp+5);
}


