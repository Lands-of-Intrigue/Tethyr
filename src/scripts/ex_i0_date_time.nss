//::////////////////////////////////////////////////////////////////////////////
//::
//:: Name: Time and Date Function Include for the Module
//:: FileName: ex_i0_date_time
//::
//::////////////////////////////////////////////////////////////////////////////
/*
    Checks to see if a date assigned has passed the current date.
    You can set up time function requirements using this script to prevent PC's
    from over using some skill, task by adding a required wait period.

    Added hc_inc_time for the SecondsSinceBegun()

*/
//::////////////////////////////////////////////////////////////////////////////
//:: Author : Ardimus
//:: Created On : 30 Oct 2005
//::////////////////////////////////////////////////////////////////////////////
#include "pf_facade"

////////////////////////////////////////////////////////////////////////////////
//  G L O B A L    C O N S T A N T S
////////////////////////////////////////////////////////////////////////////////
const string DATETIMEDB = "DATE_TIME_DB";

int nConv = FloatToInt(HoursToSeconds(1));

////////////////////////////////////////////////////////////////////////////////
//  F U N C T I O N S
////////////////////////////////////////////////////////////////////////////////
// Calculates the time in seconds since the server was started.  This can then
// be used to determine spell duration or other timed delay/duration functions.
// See ex_i0_date_time.
int SecondsSinceBegin();

////////////////////////////////////////////////////////////////////////////////
// Sets a predetermined, persistent date/time variable on a PC for a specific
// string tied to a specific function, as a parsed string.
// see ex_i0_date_time.
void SetDateString(object oPC, string sVar, int nAdvYr=0, int nAdvMn=0, int nAdvDy=0, int nAdvHr=0, int nAdvM=0, int nAdvS=0);

////////////////////////////////////////////////////////////////////////////////
// Checks to see if the persistent date/time set has expired.
// see ex_i0_date_time.
int CheckDateStringExpired(object oPC, string sVar);

////////////////////////////////////////////////////////////////////////////////
// Converts the date/time persistent parsed string to a readable date/time
// message.
// see ex_i0_date_time.
string ConvertDateString(object oPC, string sVar);

////////////////////////////////////////////////////////////////////////////////
// Used internally in conjunction with CheckDateStringExpired()
// see ex_i0_date_time.
int DateExpired(int nDay, int nMonth, int nYear, int nHour=0, int nMin=0, int nSec=0);

////////////////////////////////////////////////////////////////////////////////
// Adds more time to an already persistent date/time parsed string.
// see ex_i0_date_time.
void IncrementDateString(object oPC, string sVar, int nAdvYr=0, int nAdvMn=0, int nAdvDy=0, int nAdvHr=0, int nAdvM=0, int nAdvS=0);

////////////////////////////////////////////////////////////////////////////////
// Changes Game Time to Real Time, based on 27min/hour set time.
// see ex_i0_date_time.
void IncrementDateStringRealTime(object oPC, string sVar, int nAdvYr=0, int nAdvMn=0, int nAdvDy=0, int nAdvHr=0, int nAdvM=0, int nAdvS=0);

////////////////////////////////////////////////////////////////////////////////
// Deletes the persistent date/time.  Note: Doesn't really delete the persistent
// DB information, just flags it as un-usable.
// see ex_i0_date_time.
void DeleteDateString(object oPC, string sVar);

////////////////////////////////////////////////////////////////////////////////
//  Main functions
////////////////////////////////////////////////////////////////////////////////
void DeleteDateString(object oPC, string sVar)
{
     //if(GetIsPC(oPC))
     //{
     DeletePFCampaignVariable(DATETIMEDB, sVar, oPC);
     /*}
     else
     {
     DeletePFCampaignVariable(DATETIMEDB, GetResRef(oPC) + GetTag(oPC), oPC);
     } */
}

////////////////////////////////////////////////////////////////////////////////
void IncrementDateStringRealTime(object oPC, string sVar, int nAdvYr=0, int nAdvMn=0, int nAdvDy=0, int nAdvHr=0, int nAdvM=0, int nAdvS=0)
{
     int nDay, nMonth, nYear, nHour, nMini, nSec, nPos;
     string sDate;

     //if(GetIsPC(oPC))
     //{
     sDate = GetPFCampaignString(DATETIMEDB, sVar, oPC);
     /*}
     else
     {
     sDate = GetPFCampaignString(DATETIMEDB, GetResRef(oPC) + GetTag(oPC), oPC);
     } */

     nPos = FindSubString(sDate,"#");
     if(nPos == -1)
     {
         nYear=GetCalendarYear();
         nMonth=GetCalendarMonth();
         nDay=GetCalendarDay();
         nHour=GetTimeHour();
         nMini=GetTimeMinute();
         nSec=GetTimeSecond();
     }
     else
     {
         nYear=StringToInt(GetStringLeft(sDate, nPos));
         sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

         nPos=FindSubString(sDate,"#");
         nMonth=StringToInt(GetStringLeft(sDate, nPos));
         sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

         nPos=FindSubString(sDate,"#");
         nDay=StringToInt(GetStringLeft(sDate, nPos));
         sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

         nPos=FindSubString(sDate,"#");
         nHour=StringToInt(GetStringLeft(sDate, nPos));
         sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

         nPos=FindSubString(sDate,"#");
         nMini=StringToInt(GetStringLeft(sDate, nPos));
         sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

         nPos=FindSubString(sDate,"#");
         nSec=StringToInt(GetStringLeft(sDate, nPos));
     }
     int Gy, Gm, Gd, Gh, Gmi, Gs;
     int nMin;

     nMin=0;


     nMin += nAdvYr * 525600;
     nMin += nAdvMn * 30 * 1440;
     nMin += nAdvDy * 1440;
     nMin += nAdvHr * 60;
     nMin += nAdvM;

     while( nMin > 217727)
     {
         Gy++;
         nMin -= 217728;
     }
     while( nMin > 18143)
     {
         Gm++;
         nMin -= 18144;
     }
     while( nMin > 647)
     {
         Gd++;
         nMin -= 648;
     }
     while( nMin > 26)
     {
         Gh++;
         nMin -= 27;
     }
     Gmi=nMin;
     nYear=nYear+Gy;
     nMonth=nMonth+Gm;
     nDay=nDay+Gd;
     nHour=nHour+Gh;
     nMin=nMini+Gmi;
     nSec=nSec+nAdvS;
     while(nSec>60)
     {
         nSec -=60;
         nMin++;
     }
     while(nMin > 60)
     {
         nHour++;
         nMin = nMin-60;
     }
     while(nHour > 24)
     {
         nDay++;
         nHour = nHour-24;
     }
     while(nDay>28)
     {
         nMonth++;
         nDay = nDay -28;
     }
     while(nMonth>12)
     {
         nMonth = nMonth - 12;
         nYear++;
     }
     //if (GetIsPC(oPC))
     //{
       SetPFCampaignString(DATETIMEDB, sVar,
         IntToString(nYear)+"#"+
         IntToString(nMonth)+"#"+
         IntToString(nDay)+"#"+
         IntToString(nHour)+"#"+
         IntToString(nMin)+"#"+
         IntToString(nSec)+"#", oPC);
     /*}
     else
     {
       SetPFCampaignString(DATETIMEDB, GetResRef(oPC) + GetTag(oPC),
         IntToString(nYear)+"#"+
         IntToString(nMonth)+"#"+
         IntToString(nDay)+"#"+
         IntToString(nHour)+"#"+
         IntToString(nMin)+"#"+
         IntToString(nSec)+"#", oPC);
     } */
}

////////////////////////////////////////////////////////////////////////////////
void IncrementDateString(object oPC, string sVar, int nAdvYr=0, int nAdvMn=0, int nAdvDy=0, int nAdvHr=0, int nAdvM=0, int nAdvS=0)
{
     int nDay, nMonth, nYear, nHour, nMin, nSec, nPos;
     string sDate;

     //if(GetIsPC(oPC))
     //{
     sDate=GetPFCampaignString(DATETIMEDB, sVar, oPC);
     /*}
     else
     {
     sDate=GetPFCampaignString( DATETIMEDB, GetResRef(oPC) + GetTag(oPC), oPC);
     } */

     nPos=FindSubString(sDate,"#");
     if(nPos==-1)
     {
         nYear=GetCalendarYear()+nAdvYr;
         nMonth=GetCalendarMonth()+nAdvMn;
         nDay=GetCalendarDay()+nAdvDy;
         nHour=GetTimeHour()+nAdvHr;
         nMin=GetTimeMinute()+nAdvM;
         nSec=GetTimeSecond()+nAdvS;
     }
     else
     {
     nYear=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMonth=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nDay=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nHour=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMin=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nSec=StringToInt(GetStringLeft(sDate, nPos));
     }
     nYear=nYear+nAdvYr;
     nMonth=nMonth+nAdvMn;
     nDay=nDay+nAdvDy;
     nHour=nHour+nAdvHr;
     nMin=nMin+nAdvM;
     nSec=nSec+nAdvS;
     if(nSec>60)
     {
         nSec -=60;
         nMin++;
     }
     if(nMin > 60)
     {
         nHour++;
         nMin = nMin-60;
     }
     if(nHour > 24)
     {
         nDay++;
         nHour = nHour-24;
     }
     if(nDay>28)
     {
         nMonth++;
         nDay = nDay -28;
     }
     if(nMonth>12)
     {
         nMonth = nMonth - 12;
         nYear++;
     }
     //if (GetIsPC(oPC))
     //{
       SetPFCampaignString(DATETIMEDB, sVar,
         IntToString(nYear)+"#"+
         IntToString(nMonth)+"#"+
         IntToString(nDay)+"#"+
         IntToString(nHour)+"#"+
         IntToString(nMin)+"#"+
         IntToString(nSec)+"#", oPC);
     /*}
     else
     {
     SetPFCampaignString( DATETIMEDB, GetResRef(oPC) + GetTag(oPC),
         IntToString(nYear)+"#"+
         IntToString(nMonth)+"#"+
         IntToString(nDay)+"#"+
         IntToString(nHour)+"#"+
         IntToString(nMin)+"#"+
         IntToString(nSec)+"#", oPC);
     } */
}

////////////////////////////////////////////////////////////////////////////////
void SetDateString(object oPC, string sVar, int nAdvYr=0, int nAdvMn=0, int nAdvDy=0, int nAdvHr=0, int nAdvM=0, int nAdvS=0)
 {
     int nDay, nMonth, nYear, nHour, nMin, nSec;

     nYear=GetCalendarYear()+nAdvYr;
     nMonth=GetCalendarMonth()+nAdvMn;
     nDay=GetCalendarDay()+nAdvDy;
     nHour=GetTimeHour()+nAdvHr;
     nMin=GetTimeMinute()+nAdvM;
     nSec=GetTimeSecond()+nAdvS;

     while(nSec>60)
     {
         nSec -=60;
         nMin++;
     }
     while(nMin > 60)
     {
         nHour++;
         nMin = nMin-60;
     }
     while(nHour > 24)
     {
         nDay++;
         nHour = nHour-24;
     }
     while(nDay>28)
     {
         nMonth++;
         nDay = nDay -28;
     }
     while(nMonth>12)
     {
         nMonth = nMonth - 12;
         nYear++;
     }
     //if (GetIsPC(oPC))
     //{
      SetPFCampaignString(DATETIMEDB, sVar,
         IntToString(nYear)+"#"+
         IntToString(nMonth)+"#"+
         IntToString(nDay)+"#"+
         IntToString(nHour)+"#"+
         IntToString(nMin)+"#"+
         IntToString(nSec)+"#", oPC);
     /*}
     else
     {
     SetPFCampaignString(DATETIMEDB, GetResRef(oPC) + GetTag(oPC),
         IntToString(nYear)+"#"+
         IntToString(nMonth)+"#"+
         IntToString(nDay)+"#"+
         IntToString(nHour)+"#"+
         IntToString(nMin)+"#"+
         IntToString(nSec)+"#", oPC);
      }*/
}

////////////////////////////////////////////////////////////////////////////////
string ConvertDateString(object oPC, string sVar)
{
     int nPos;
     string nDay, nMonth, nYear, nHour, nMin, nSec;
     string sDate;

     //if(GetIsPC(oPC))
     //{
     sDate=GetPFCampaignString(DATETIMEDB, sVar, oPC);
     /*}
     else
     {
     sDate=GetPFCampaignString( DATETIMEDB, GetResRef(oPC) + GetTag(oPC), oPC);
     } */

     nPos=FindSubString(sDate,"#");
     if(nPos==-1) return "now";
     nYear=GetStringLeft(sDate, nPos);
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMonth=GetStringLeft(sDate, nPos);
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nDay=GetStringLeft(sDate, nPos);
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nHour=GetStringLeft(sDate, nPos);
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);
     if(StringToInt(nHour) > 24)
     {
         nDay = IntToString(StringToInt(nDay)+1);
         nHour = IntToString(StringToInt(nHour)-24);
     }

     nPos=FindSubString(sDate,"#");
     nMin=GetStringLeft(sDate, nPos);
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nSec=GetStringLeft(sDate, nPos);

     return nHour+":"+nMin+":"+nSec+" "+nMonth+"/"+nDay+"/"+nYear;
}

////////////////////////////////////////////////////////////////////////////////
int CheckDateStringExpired(object oPC, string sVar)
{
     int nDay, nMonth, nYear, nHour, nMin, nSec, nPos;
     string sDate;

     //if(GetIsPC(oPC))
     //{
     sDate=GetPFCampaignString(DATETIMEDB, sVar, oPC);
     /*}
     else
     {
     sDate=GetPFCampaignString( DATETIMEDB, GetResRef(oPC) + GetTag(oPC), oPC);
     } */

     nPos=FindSubString(sDate,"#");
     if(nPos==-1) return TRUE;
     nYear=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMonth=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nDay=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nHour=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMin=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nSec=StringToInt(GetStringLeft(sDate, nPos));

     if(DateExpired(nDay, nMonth, nYear, nHour, nMin, nSec))
     {
         return TRUE;
     }
     return FALSE;
}

////////////////////////////////////////////////////////////////////////////////
int DateExpired(int nDay, int nMonth, int nYear, int nHour=0, int nMin=0, int nSec=0)
{
     int nCurYear, nCurMon, nCurDay, nCurHour, nCurMin, nCurSec;

     nCurYear=GetCalendarYear();
     if(nCurYear > nYear)
         return TRUE;
     nCurMon=GetCalendarMonth();
     if(nCurYear >= nYear && nCurMon > nMonth)
         return TRUE;
     nCurDay=GetCalendarDay();
     if(nCurYear >= nYear && nCurMon >= nMonth && nCurDay > nDay)
         return TRUE;
     nCurHour=GetTimeHour();
     if(nCurYear >= nYear && nCurMon >= nMonth && nCurDay >= nDay && nCurHour > nHour)
         return TRUE;
     nCurMin=GetTimeMinute();
     if(nCurYear >= nYear && nCurMon >= nMonth && nCurDay >= nDay && nCurHour >= nHour && nCurMin > nMin)
         return TRUE;
     nCurSec=GetTimeSecond();
     if(nCurYear >= nYear && nCurMon >= nMonth && nCurDay >= nDay && nCurHour >= nHour && nCurMin >= nMin && nCurSec > nSec)
         return TRUE;

     if(nSec>60)
     {
         return TRUE;
     }
     if(nMin > 60)
     {
         return TRUE;
     }
     if(nHour > 24)
     {
         return TRUE;
     }
     if(nDay>28)
     {
         return TRUE;
     }
     if(nMonth>12)
     {
         return TRUE;
     }

     return FALSE;
}

////////////////////////////////////////////////////////////////////////////////
int GetDateYear(object oPC, string sVar)
{
     int nDay, nMonth, nYear, nHour, nMin, nSec, nPos;
     string sDate;

     //if(GetIsPC(oPC))
     //{
     sDate=GetPFCampaignString(DATETIMEDB, sVar, oPC);
     /*(}
     else
     {
     sDate=GetPFCampaignString( DATETIMEDB, GetResRef(oPC) + GetTag(oPC), oPC);
     }  */

     nPos=FindSubString(sDate,"#");
     if(nPos==-1) return TRUE;
     nYear=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMonth=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nDay=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nHour=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMin=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nSec=StringToInt(GetStringLeft(sDate, nPos));

     return nYear;
}

////////////////////////////////////////////////////////////////////////////////
int GetDateMonth(object oPC, string sVar)
{
     int nDay, nMonth, nYear, nHour, nMin, nSec, nPos;
     string sDate;

     //if(GetIsPC(oPC))
     //{
     sDate=GetPFCampaignString(DATETIMEDB, sVar, oPC);
     /*}
     else
     {
     sDate=GetPFCampaignString( DATETIMEDB, GetResRef(oPC) + GetTag(oPC), oPC);
     } */

     nPos=FindSubString(sDate,"#");
     if(nPos==-1) return TRUE;
     nYear=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMonth=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nDay=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nHour=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMin=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nSec=StringToInt(GetStringLeft(sDate, nPos));

     return nMonth;
}

////////////////////////////////////////////////////////////////////////////////
int GetDateDay(object oPC, string sVar)
{
     int nDay, nMonth, nYear, nHour, nMin, nSec, nPos;
     string sDate;

     //if(GetIsPC(oPC))
     //{
     sDate=GetPFCampaignString(DATETIMEDB, sVar, oPC);
     /*}
     else
     {
     sDate=GetPFCampaignString( DATETIMEDB, GetResRef(oPC) + GetTag(oPC), oPC);
     } */

     nPos=FindSubString(sDate,"#");
     if(nPos==-1) return TRUE;
     nYear=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMonth=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nDay=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nHour=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMin=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nSec=StringToInt(GetStringLeft(sDate, nPos));

     return nDay;
}

////////////////////////////////////////////////////////////////////////////////
int GetDateHour(object oPC, string sVar)
{
     int nDay, nMonth, nYear, nHour, nMin, nSec, nPos;
     string sDate;

     //if(GetIsPC(oPC))
     //{
     sDate=GetPFCampaignString(DATETIMEDB, sVar, oPC);
     /*}
     else
     {
     sDate=GetPFCampaignString( DATETIMEDB, GetResRef(oPC) + GetTag(oPC), oPC);
     } */

     nPos=FindSubString(sDate,"#");
     if(nPos==-1) return TRUE;
     nYear=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMonth=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nDay=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nHour=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMin=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nSec=StringToInt(GetStringLeft(sDate, nPos));

     return nHour;
}

////////////////////////////////////////////////////////////////////////////////
int GetDateMinute(object oPC, string sVar)
{
     int nDay, nMonth, nYear, nHour, nMin, nSec, nPos;
     string sDate;

     //if(GetIsPC(oPC))
     //{
     sDate=GetPFCampaignString(DATETIMEDB, sVar, oPC);
     /*}
     else
     {
     sDate=GetPFCampaignString( DATETIMEDB, GetResRef(oPC) + GetTag(oPC), oPC);
     } */

     nPos=FindSubString(sDate,"#");
     if(nPos==-1) return TRUE;
     nYear=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMonth=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nDay=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nHour=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMin=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nSec=StringToInt(GetStringLeft(sDate, nPos));

     return nMin;
}

////////////////////////////////////////////////////////////////////////////////
int GetDateSecond(object oPC, string sVar)
{
     int nDay, nMonth, nYear, nHour, nMin, nSec, nPos;
     string sDate;

     //if(GetIsPC(oPC))
     //{
     sDate=GetPFCampaignString(DATETIMEDB, sVar, oPC);
     /*}
     else
     {
     sDate=GetPFCampaignString( DATETIMEDB, GetResRef(oPC) + GetTag(oPC), oPC);
     } */

     nPos=FindSubString(sDate,"#");
     if(nPos==-1) return TRUE;
     nYear=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMonth=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nDay=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nHour=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nMin=StringToInt(GetStringLeft(sDate, nPos));
     sDate=GetStringRight(sDate,GetStringLength(sDate)-nPos-1);

     nPos=FindSubString(sDate,"#");
     nSec=StringToInt(GetStringLeft(sDate, nPos));

     return nSec;
}

////////////////////////////////////////////////////////////////////////////////
int SecondsSinceBegin()
{
  object oMod=GetModule();
  float fStartHour=IntToFloat(GetLocalInt(oMod,"HourStart"));
  float fStartDay=IntToFloat(GetLocalInt(oMod,"DayStart"));
  float fStartMonth=IntToFloat(GetLocalInt(oMod,"MonthStart"));
  float fStartYear=IntToFloat(GetLocalInt(oMod,"YearStart"));
  float fCurDay=IntToFloat(GetCalendarDay());
  float fCurMonth=IntToFloat(GetCalendarMonth());
  float fCurYear=IntToFloat(GetCalendarYear());
  float fCurHour=IntToFloat(GetTimeHour());
  float fCurMin=IntToFloat(GetTimeMinute());
  float fCurSec=IntToFloat(GetTimeSecond());

  float fElapsed=0.000;

  if(fCurYear==fStartYear)
  {
    if(fCurMonth==fStartMonth)
    {
      if(fCurDay==fStartDay)
      {
        fElapsed += (fCurHour-fStartHour);
      }
      else
      {
        if(fCurHour>fStartHour)
        {
          fElapsed += 24.0 * (fCurDay-fStartDay);
          fElapsed += fCurHour-fStartHour;
        }
        else
        {
          fElapsed += 24.0 * (fCurDay-fStartDay-1.0);
          fElapsed += 24.0 - fStartHour + fCurHour;
        }
      }
    }
    else
    {
      if(fCurDay>fStartDay)
      {
        fElapsed += 28.0 * 24.0 * (fCurMonth - fStartMonth);
        fElapsed += 24.0 * (fCurDay-fStartDay);
      }
      else
      {
        fElapsed += 28.0 * 24.0 * (fCurMonth - fStartMonth - 1.0);
        fElapsed += 24.0 * (28.0 - fStartDay + fCurDay);
      }
      if(fCurHour > fStartHour)
        fElapsed += fCurHour-fStartHour+2.0;
      else
        fElapsed += -24.0 + fStartHour + fCurHour;
    }
  }
  else
  {
    if(fCurMonth>fStartMonth)
    {
      fElapsed += 12.0 * 28.0 * 24.0 * (fCurYear - fStartYear);
      fElapsed += 28.0 * 24.0 * (fCurMonth-fStartMonth);
    }
    else
    {
      fElapsed += 12.0 * 28.0 * 24.0 * (fCurYear - fStartYear - 1.0);
      fElapsed += 28.0 * 24.0 * (12.0 - fStartMonth + fCurMonth);
    }
    if(fCurDay> fStartDay)
      fElapsed += 24.0 * (fCurDay-fStartDay);
    else
      fElapsed += 24.0 * (28.0 - fStartDay + fCurDay);
    if(fCurHour > fStartHour)
      fElapsed += fCurHour-fStartHour+2.0;
    else
      fElapsed += -24.0 + fStartHour + fCurHour;
  }

  fElapsed = IntToFloat(nConv)*fElapsed;
  fElapsed+=fCurMin*60.0;
  fElapsed+=fCurSec;
  return FloatToInt(fElapsed);
}


