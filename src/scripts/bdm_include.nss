//::///////////////////////////////////////////////
//:: Name:      Bedlamson's Dynamic Merchant System
//:: FileName:  bdm_include
//:: Copyright (c) 2003 Stephen Spann
//::///////////////////////////////////////////////
//:: Created By: Bedlamson
//:: Created On: 1/23/2003
//::///////////////////////////////////////////////
//:: Time Functions:   from CS Event Scheduler
//::                   by Craig Smith (Galap)
//:: Token Functions:  from NWNSS by Palor
//::///////////////////////////////////////////////

int nDebug = 0;
int CheckAlignment(string sAlignment, object oPC);
int CheckClass (string sClass, object oPC);
int CheckRace (string sRace, object oPC);
int CheckGender (string sGender, object oPC);
int CheckSubrace(string sSubrace, object oPC);
void BDM_SetNPCStores();
void BDM_ModuleItemAcquired();
void BDM_ModuleItemUnacquired();

//  Time Functions by
int cs_time_GetSecondsSinceEpoch(struct cs_time time);
struct cs_time cs_time_GetEpochTime();
struct cs_time cs_time_GetCurrentTime();
string cs_time_TimeToString(struct cs_time time);
struct cs_time cs_time_StringToTime(string strtime);


//  If you are using the ALFA subrace system, and you want a
//  merchant to restrict a cache to a subrace, discriminate
//  against a subrace, or favor a subrace, delete the first
//  CheckSubrace() code (lines 44-47), and uncomment the
//  second one by deleting lines 51 and 99. You will also
//  need to uncomment the following line so it turns red:
//
//  #include "subraces"
//
//  If you have custom ALFA subraces in your module, you need
//  to create additional case statements to account for them.
//  The case number becomes the 'xx' value in the parameters
//  listed in the 'bdm__readme' script.
//
//  Delete this function to enable ALFA subraces, it is only
//  here so that scripts will compile correctly without the
//  ALFA scripts.
int CheckSubrace(string sSubrace, object oPC)
{
return FALSE;
}

/*  DELETE THIS LINE TO ENABLE THE ALFA SUBRACES

int CheckSubrace(string sSubrace, object oPC)
{
int nSubrace = StringToInt(sSubrace);
int nPlayerSubrace = GetLocalInt(oPC, SUBRACE_FIELD);
switch (nSubrace)
    {
    case 0:
        break;
    case 1:
        break;
    case 2:
        if (nPlayerSubrace == SUBRACE_DWARF_GOLD) return TRUE;
        break;
    case 3:
        if (nPlayerSubrace == SUBRACE_DWARF_GRAY) return TRUE;
        break;
    case 4:
        if (nPlayerSubrace == SUBRACE_DWARF_SHIELD) return TRUE;
        break;
    case 5:
        if (nPlayerSubrace == SUBRACE_ELF_DARK) return TRUE;
        break;
    case 6:
        if (nPlayerSubrace == SUBRACE_ELF_MOON) return TRUE;
        break;
    case 7:
        if (nPlayerSubrace == SUBRACE_ELF_SUN) return TRUE;
        break;
    case 8:
        if (nPlayerSubrace == SUBRACE_ELF_WILD) return TRUE;
        break;
    case 9:
        if (nPlayerSubrace == SUBRACE_ELF_WOOD) return TRUE;
        break;
    case 10:
        if (nPlayerSubrace == SUBRACE_GNOME_DEEP) return TRUE;
        break;
    case 11:
        if (nPlayerSubrace == SUBRACE_GNOME_ROCK) return TRUE;
        break;
    case 12:
        if (nPlayerSubrace == SUBRACE_HALFELF) return TRUE;
        break;
    case 13:
        if (nPlayerSubrace == SUBRACE_HALFORC) return TRUE;
        break;
    case 14:
        if (nPlayerSubrace == SUBRACE_HALFLING_GHOSTWISE) return TRUE;
        break;
    case 15:
        if (nPlayerSubrace == SUBRACE_HALFLING_LIGHTFOOT) return TRUE;
        break;
    case 16:
        if (nPlayerSubrace == SUBRACE_HALFLING_STRONGHEART) return TRUE;
        break;
    case 17:
        if (nPlayerSubrace == SUBRACE_HUMAN) return TRUE;
        break;
    case 18:
        if (nPlayerSubrace == SUBRACE_HALFDROW) return TRUE;
        break;
    }
}
*///DELETE THIS LINE TOO, IF YOU WANT.


//  If you are not using the ALFA subrace system, and you want
//  a merchant to restrict a cache to a subrace, discriminate
//  against a subrace, or favor a subrace, you need to set up
//  additional case statements to the function below, with
//  the conditional for sPlayerSubrace is changed to exactly
//  what the player enters in the Subrace field during character
//  creation, and the conditional for nPlayer race is set to the
//  appropriate base race of the subrace. Case 8 is an example
//  of how to enable discrimination, favoritism, and restriction
//  of moon elves. The case number becomes the 'xx' value in the
//  parameters listed in the 'bdm__readme' script.

int CheckRace(string sRace, object oPC)
{
int nRace = StringToInt(sRace);
int nPlayerRace = GetRacialType(oPC);
string sPlayerSubrace = GetSubRace(oPC);
switch (nRace)
    {
    case 1:
        if (nPlayerRace == RACIAL_TYPE_DWARF) return TRUE;
        break;
    case 2:
        if (nPlayerRace == RACIAL_TYPE_ELF) return TRUE;
        break;
    case 3:
        if (nPlayerRace == RACIAL_TYPE_GNOME) return TRUE;
        break;
    case 4:
        if (nPlayerRace == RACIAL_TYPE_HALFELF) return TRUE;
        break;
    case 5:
        if (nPlayerRace == RACIAL_TYPE_HALFLING) return TRUE;
        break;
    case 6:
        if (nPlayerRace == RACIAL_TYPE_HALFORC) return TRUE;
        break;
    case 7:
        if (nPlayerRace == RACIAL_TYPE_HUMAN) return TRUE;
        break;
    case 8:
        if (sPlayerSubrace == "Moon Elf" && nPlayerRace == RACIAL_TYPE_ELF) return TRUE;
        break;
    }
return FALSE;
}

int CheckAlignment(string sAlignment, object oPC)
{
int nAlign = StringToInt(sAlignment);
//if (nDebug) SendMessageToPC(oPC, "Alignment Case = " + IntToString(nAlign));
int nGoodEvil = GetAlignmentGoodEvil(oPC);
int nLawChaos = GetAlignmentLawChaos(oPC);
//if (nDebug) SendMessageToPC(oPC, "Good/Evil: " + IntToString(nGoodEvil) + " Law/Chaos: " + IntToString(nLawChaos));
switch (nAlign)
    {
    case 1:
        if (nLawChaos == ALIGNMENT_CHAOTIC) return TRUE;
        break;
    case 2:
        if (nGoodEvil == ALIGNMENT_EVIL) return TRUE;
        break;
    case 3:
        if (nGoodEvil == ALIGNMENT_GOOD) return TRUE;
        break;
    case 4:
        if (nLawChaos == ALIGNMENT_LAWFUL) return TRUE;
        break;
    case 5:
        if (nGoodEvil ==  ALIGNMENT_NEUTRAL) return TRUE;
        break;
    case 6:
        if (nLawChaos ==  ALIGNMENT_NEUTRAL) return TRUE;
        break;
    case 7:
        if (nLawChaos ==  ALIGNMENT_CHAOTIC && nGoodEvil == ALIGNMENT_EVIL) return TRUE;
        break;
    case 8:
        if (nLawChaos ==  ALIGNMENT_CHAOTIC && nGoodEvil == ALIGNMENT_GOOD) return TRUE;
        break;
    case 9:
        if (nLawChaos ==  ALIGNMENT_CHAOTIC && nGoodEvil == ALIGNMENT_NEUTRAL) return TRUE;
        break;
    case 10:
        if (nLawChaos ==  ALIGNMENT_LAWFUL && nGoodEvil == ALIGNMENT_EVIL) return TRUE;
        break;
    case 11:
        if (nLawChaos ==  ALIGNMENT_LAWFUL && nGoodEvil == ALIGNMENT_GOOD) return TRUE;
        break;
    case 12:
        if (nLawChaos ==  ALIGNMENT_LAWFUL && nGoodEvil == ALIGNMENT_NEUTRAL) return TRUE;
        break;
    case 13:
        if (nLawChaos ==  ALIGNMENT_NEUTRAL && nGoodEvil == ALIGNMENT_EVIL) return TRUE;
        break;
    case 14:
        if (nLawChaos ==  ALIGNMENT_NEUTRAL && nGoodEvil == ALIGNMENT_GOOD) return TRUE;
        break;
    case 15:
        if (nLawChaos ==  ALIGNMENT_NEUTRAL && nGoodEvil == ALIGNMENT_NEUTRAL) return TRUE;
        break;
    }
return FALSE;
}

int CheckClass(string sClass, object oPC)
{
int nClass = StringToInt(sClass);
int nPlayerClass;
int nNth;
for (nNth = 1; nNth <= 3; nNth++)
    {
    nPlayerClass = GetClassByPosition(nNth, oPC);
    switch (nClass)
        {
        case 1:
            if (nPlayerClass == CLASS_TYPE_BARBARIAN) return TRUE; else break;
        case 2:
            if (nPlayerClass == CLASS_TYPE_BARD) return TRUE; else break;
        case 3:
            if (nPlayerClass == CLASS_TYPE_CLERIC) return TRUE; else break;
        case 4:
            if (nPlayerClass == CLASS_TYPE_DRUID) return TRUE; else break;
        case 5:
            if (nPlayerClass == CLASS_TYPE_FIGHTER) return TRUE; else break;
        case 6:
            if (nPlayerClass == CLASS_TYPE_MONK) return TRUE; else break;
        case 7:
            if (nPlayerClass == CLASS_TYPE_PALADIN) return TRUE; else break;
        case 8:
            if (nPlayerClass == CLASS_TYPE_RANGER) return TRUE; else break;
        case 9:
            if (nPlayerClass == CLASS_TYPE_ROGUE) return TRUE; else break;
        case 10:
            if (nPlayerClass == CLASS_TYPE_SORCERER) return TRUE; else break;
        case 11:
            if (nPlayerClass == CLASS_TYPE_WIZARD) return TRUE; else break;
        }
    }
return FALSE;
}

int CheckGender(string sGender, object oPC)
{
int nPlayerGender = GetGender(oPC);
if (sGender == "M" && nPlayerGender == GENDER_MALE) return TRUE;
if (sGender == "F" && nPlayerGender == GENDER_FEMALE) return TRUE;
return FALSE;
}

int GetItemTime(object oItem)
{
string sTime = GetLocalString(oItem, "TIME");
struct cs_time ItemTime = cs_time_StringToTime(sTime);
struct cs_time CurrentTime = cs_time_GetCurrentTime();
int nItemTime = cs_time_GetSecondsSinceEpoch(ItemTime);
int nCurrentTime = cs_time_GetSecondsSinceEpoch(CurrentTime);
int nTimeElapsed = nCurrentTime - nItemTime;
return nTimeElapsed;
}

void BDM_SetNPCStores()
{
// Find the nearest store and set it as the
// main store for the NPC
object oMainStore = GetNearestObject(OBJECT_TYPE_STORE);
SetLocalObject(OBJECT_SELF, "STORE", oMainStore);

// Find and set the parameters to the NPC
// If the store's tag doesn't begin with 'M_'
// then look for a waypoint.
string sParams = GetStringUpperCase(GetTag(oMainStore));
if (GetStringLeft(sParams, 2) != "M_")
    {
    object oWaypoint = GetNearestObject(OBJECT_TYPE_WAYPOINT, oMainStore);
    int nNth = 1;
    while (oWaypoint != OBJECT_INVALID)
        {
        sParams = GetStringUpperCase(GetName(oWaypoint));
        if (GetStringLeft(sParams, 2) == "M_") break;
        nNth++;
        oWaypoint = GetNearestObject(OBJECT_TYPE_WAYPOINT, oMainStore, nNth);
        }
    }
SetLocalString(OBJECT_SELF, "PARAMS", sParams);
SetLocalString(oMainStore, "PARAMS", sParams);

// Find if there are any caches for dynamic
// inventories, then set them to the NPC merchant.
int nPosition = FindSubString(sParams, "NC");
int nValidCaches = StringToInt(GetSubString(sParams, nPosition + 2, 2));
int nNth;
for (nNth = 1; nNth <= nValidCaches; nNth++)
    {
    object oCache = GetNearestObject(OBJECT_TYPE_STORE, oMainStore, nNth);
    if (GetStringLeft(GetTag(oCache), 2) == "C_")
        {
        SetLocalObject(oMainStore, "CACHE_" + IntToString(nNth), oCache);
        }
    }
}

void BDM_ModuleItemAcquired()
{
// Get the item that was acquired.
object oItemAcquired = GetModuleItemAcquired();

// If the item is being stolen, destroy the temporary
// store it was stolen from to avoid a PC being able
// to steal a store's entire inventory.
if (GetLocalInt(oItemAcquired, "STOLEN"))
    {
    object oAcquiredFrom = GetLocalObject(oItemAcquired, "STEALSTORE");
    DestroyObject(oAcquiredFrom);
    DeleteLocalInt(oItemAcquired, "STOLEN");
    DeleteLocalObject(oItemAcquired, "STEALSTORE");
    }
}

void BDM_ModuleItemUnacquired()
{
// Get the item that was lost.
object oItemLost = GetModuleItemLost();

// Delete the dynamic item variable in case the item
// is being sold back to a store with a dynamic
// inventory.
DeleteLocalInt(oItemLost, "DYNAMIC");

// Set the time that the item was lost.  This will
// be used to determine how long it has been in a
// store's inventory.
struct cs_time CurrentTime = cs_time_GetCurrentTime();
string sCurrentTime = cs_time_TimeToString(CurrentTime);
SetLocalString(oItemLost, "TIME", sCurrentTime);
}


/*##
# NWN Spawn System v2.4.4c
# Author: Palor <palor@truefear.net>
# Description:
#  Complete Spawn System, one script.
#
##*/

int GetValue(object oObject, string sParam, string sName);
void GetDiceValue(object oObject, string sName, string sNumDice, string sDice);

int GetValue(object oObject, string sParam, string sName)
{
int iSwitchValue = 0;
int iIsMinutes = 0;
int iIsHours = 0;
if (FindSubString(sName, sParam) > 0)
    {
    if (sParam == "HA" ||   // Haggle All
        sParam == "HD" ||   // Haggle Down
        sParam == "HU" ||   // Haggle Up
        sParam == "HB" ||   // Haggle Buy
        sParam == "HS" ||   // Haggle Sell
        sParam == "HC" ||   // Haggle Cumulative
        sParam == "FG" ||   // Favors Gender
        sParam == "FL" ||   // Favoritism Linked
        sParam == "FB" ||   // Favors Buy
        sParam == "FE" ||   // Favors Sell
        sParam == "FU" ||   // Favoritism Unlimited
        sParam == "PG" ||   // Prejudice Gender
        sParam == "PL" ||   // Prejudice Linked
        sParam == "PB" ||   // Prejudice Buy
        sParam == "PE" ||   // Prejudice Sell
        sParam == "PU" ||   // Prejudice Unlimited
        sParam == "ST" ||   // Stealing
        sParam == "SA" ||   // Steal All
        sParam == "RH" ||   // Reaction Hostile
        sParam == "UQ" ||   // Unique Items
        sParam == "IR" ||   // Items Remain
        sParam == "LG" ||   // Limit to Gender
        sParam == "LL" ||   // Limits Linked
        sParam == "TL")     // Timer Linked
        {
        iSwitchValue = 1;
        }
    else
        {
        int iNumberPos = FindSubString(sName, sParam);
        if (sParam == "TM" || sParam == "CL")
            {
            if (GetSubString(sName, (iNumberPos + 4), 1) == "M")
                {
                iIsMinutes = 1;
                }
            else if (GetSubString(sName, (iNumberPos + 4), 1) == "H")
                {
                iIsHours = 1;
                }
            }

        int iNumberLength = GetStringLength(sName) - iNumberPos;
        string sParamValue = GetSubString(sName, (iNumberPos + 2), 2);
        iSwitchValue = StringToInt(sParamValue);
        if (iIsMinutes == 1)
            {
            iSwitchValue = iSwitchValue * 60;
            }
        else if (iIsHours == 1)
            {
            iSwitchValue = (iSwitchValue * 60) * 60;
            }
        if (GetSubString(sName, (iNumberPos + 4), 1) == "R")
            {
            int iMaxRand = StringToInt(GetSubString(
                                   sName, (iNumberPos + 5), 2));
            if (GetSubString(sName, (iNumberPos + 7), 1) == "M")
                {
                iIsMinutes = 1;
                iMaxRand = iMaxRand * 60;
                }
            else if (GetSubString(sName, (iNumberPos + 7), 1) == "H")
                {
                iMaxRand = (iMaxRand * 60) * 60;
                }
            iSwitchValue = iSwitchValue + Random(iMaxRand - iSwitchValue);
            }
        }
    }
return iSwitchValue;
}

//============================================================================
//
// Name: General utility functions
// File: cs_utility
// Author: Craig Smith (Galap) <craig@smith.dropbear.id.au>
//
//----------------------------------------------------------------------------
// This software is distributed in the hope that it will be useful. It is
// provided "as is" WITHOUT WARRANTY OF ANY KIND, either expressed or implied,
// including, but not limited to, the implied warranties of merchantability
// and fitness for a particular purpose. You may redistribute or modify this
// software for your own purposes so long as all original credit information
// remains intact.
//----------------------------------------------------------------------------
//
// Introduction
// ------------
// A collection of generally useful functions that don't belong to any
// particular cs_* subsystem or script.
//
// This script contains the following sets of functions:
//
// * cs_time_XXXX   Functions for manipulating times
// * cs_util_XXXX   Other general functions
//
//============================================================================

// Uncomment this directive to compile without errors for testing.
//# include "cs_dbg"

//============================================================================
//
// Function Prototypes
//
//============================================================================

// Return the number of seconds that have elapsed since the calendar epoch,
// accounting for wildcards on any time or date field.
//
// time         The cs_time struct to be converted
//
// returns      The number of seconds since the epoch
int cs_time_GetSecondsSinceEpoch(struct cs_time time);

// Return the time of the epoch, i.e. 0, as a struct cs_time.
//
// returns      The epoch time
//
struct cs_time cs_time_GetEpochTime();

// Return the current time formatted into a struct cs_time.
//
// returns      The current time
struct cs_time cs_time_GetCurrentTime();

// Convert a struct cs_time into a string. The string will comprise the
// fields in the struct separated by colons, with "cs_time" prefixed.
//
// time         The cs_time struct to be converted
//
// returns      A string representation of the time
string cs_time_TimeToString(struct cs_time time);

// Convert a properly formatted string into a cs_time struct. Use the
// cs_IsValidTime() function to determine whether the string has been
// correctly converted.
//
// strtime      The string to be converted
//
// returns      A cs_time struct of the time represented by the string
struct cs_time cs_time_StringToTime(string strtime);

// Determine whether a specific time structure is valid.
//
// time         The time structure to test for validity
//
// returns      TRUE if the time structure is valid, FALSE otherwise
int cs_time_GetIsValidTime(struct cs_time time);

// Compare the specified time with the start time to determine if the
// specified time falls after.
//
// time         The time to be compared
// start        The time to be compared against
//
// returns      TRUE if the time is greater than the start time
int cs_time_GetIsTimeAfter(struct cs_time time, struct cs_time start);

// Compare the specified time with the start time to determine if the
// specified time falls before.
//
// time         The time to be compared
// start        The time to be compared against
//
// returns      TRUE if the time is less than or equal to the start time
int cs_time_GetIsTimeBefore(struct cs_time time, struct cs_time start);

// Compare the specified time with the start time and the end time to
// determine if the specified time falls between.
//
// time         The time to be compared
// start        The time at which the compare period begins
// end          The time at which the compare period ends
//
// returns      TRUE if the time is greater than or equal to the start
//              time and less than the end time, otherwise FALSE
int cs_time_GetIsTimeBetween(struct cs_time time, struct cs_time start, struct cs_time end);

// Determine whether the specified value exists in a set. A set in this case
// is a formatted string containing distinct elements separated by colons.
// Values to be added to the set may not contain colons or bad things will
// happen.
//
// set          The current set of values
// value        The value for which to search
//
// returns      TRUE if the value is in the set, otherwise FALSE
int cs_util_GetIsInSet(string set, string value);

// Add a value to a set if it is not already in the set. A set in this case
// is a formatted string containing distinct elements separated by colons.
// Values to be added to the set may not contain colons or bad things will
// happen.
//
// set          The current set of values
// value        The value to add to the set
//
// returns      The new value of the set
string cs_util_AddToSet(string set, string value);

// Remove a value from a set if it exists within the set. A set in this case
// is a formatted string containing distinct elements separated by colons.
// Values to be remove from the set may not contain colons or bad things will
// happen.
//
// set          The current set of values
// value        The value to remove from the set
//
// returns      The new value of the set
string cs_util_RemoveFromSet(string set, string value);

// Retrieve a string from a set. A set in this case is a formatted string
// containing distinct elements separated by colons. The value indices
// start at 1 for the first value in the set.
//
// set          The current set of values
// value        The index of the value to retrieve from the set
//
// returns      The value from the set, or "" if the specified index does
//              not correspond to a value in the set
string cs_util_GetValueFromSet(string set, int index);

// Invoke a specific user-defined event on every object that matches a
// specified tag.
//
// tag          The tag that identifies target objects
// eventNum     The event number with which to signal target objects
void cs_util_InvokeEventByTag(string tag, int eventNum);

// When invoked by a creature, displays the current action being performed
// by the creature.
void cs_util_PrintCurrentAction();

//============================================================================
//
// Data Types and Constants
//
//============================================================================

// A structure that represents a single point in time. The valid field is
// necessary since there does not appear to be an equivalent to a null
// value for structs so a valid struct must always be returned from
// functions, even if the data in the struct is not valid.
//
struct cs_time
{
    // The valid field is used for error checking returned structs. It is
    // not part of the data for a time.
    int valid;

    // Self explantary fields
    int second;
    int minute;
    int hour;
    int day;
    int month;
    int year;
};

// When this value is specified instead of a specific time field, the field
// is treated as a wildcard that matches every possible value for that field.
int CS_TIME_ANY = -1;

// The prefix string for time conversions.
string cs_time_conversionPrefix = "cs_time";

// Constants for manipulating dates as a number of seconds since the
// beginning of the calendar epoch, i.e. year 0. Given the standard start
// date in NWN of 1372DR, game-time dates since 0DR all fit into a single
// 32bit signed int, which is very convenient for comparisons. The DR
// suffix is short for Dale Reckoning, the name of the calendar defined
// for the Forgotten Realms and used by NWN.
//
// The number of minutes per game hour may be changed in the Module Properties
// dialog in the Aurora Toolset. Be aware that if you change the number of
// minutes per hour to anything higher than 4, the date functions in this
// file will cease to function for the default calendar (i.e. 1372DR).
// Earlier dates may work if you wish to run a module set in an earlier
// time, or if you are building your own world history and can use any
// calendar settings you please. If you set the minutes per hour property
// to 4, the date functions will still work, but you don't have a lot of
// leeway for the default calendar. Advance by a few years from 1372DR
// and the total seconds since 0DR will overflow a signed 32bit int and
// you will be sad. Set the minutes per hour property to a value of 5 or
// more and you will certainly be sad anyway.
//
int cs_time_secondsPerMinute = 60;
int cs_time_hoursPerDay = 24;
int cs_time_daysPerMonth = 28;
int cs_time_monthsPerYear = 12;
int cs_time_secondsPerHour = FloatToInt(HoursToSeconds(1));
int cs_time_secondsPerDay = cs_time_hoursPerDay * cs_time_secondsPerHour;
int cs_time_secondsPerMonth = cs_time_daysPerMonth * cs_time_secondsPerDay;
int cs_time_secondsPerYear = cs_time_monthsPerYear * cs_time_secondsPerMonth;

//----------------------------------------------------------------------------
int cs_time_GetSecondsSinceEpoch(struct cs_time time)
{
    // Deal with wildcard fields by setting the time field to the corresponding
    // current time/date value to force a match.
    if (time.year < 0)
    {
        time.year = GetCalendarYear();
    }
    if (time.month < 0)
    {
        time.month = GetCalendarMonth();
    }
    if (time.day < 0)
    {
        time.day = GetCalendarDay();
    }
    if (time.hour < 0)
    {
        time.hour = GetTimeHour();
    }
    if (time.minute < 0)
    {
        time.minute = GetTimeMinute();
    }
    if (time.second < 0)
    {
        time.second = GetTimeSecond();
    }
    int seconds = (time.year * cs_time_secondsPerYear) +
                  (time.month * cs_time_secondsPerMonth) +
                  (time.day * cs_time_secondsPerDay) +
                  (time.hour * cs_time_secondsPerHour) +
                  (time.minute * cs_time_secondsPerMinute) +
                   time.second;
    //cs_dbg_PrintString(
    //    CS_DBG_INFO,
    //    "cs_time_SecondsSinceEpoch: " +
    //    IntToString(seconds)
    //);
    return seconds;
}

//----------------------------------------------------------------------------
struct cs_time cs_time_GetEpochTime()
{
    struct cs_time time;

    time.valid = TRUE;

    // Populate the time fields. I know this is a bit silly but I'm a
    // completist.
    time.second = 0;
    time.minute = 0;
    time.hour = 0;
    time.day = 0;
    time.month = 0;
    time.year = 0;

    //cs_dbg_PrintString(
    //    CS_DBG_INFO,
    //    "cs_time_GetEpochTime: " +
    //    cs_time_TimeToString(time)
    //);
    return time;
}
//----------------------------------------------------------------------------
struct cs_time cs_time_GetCurrentTime()
{
    struct cs_time time;

    time.valid = TRUE;

    // Populate the time fields
    time.second = GetTimeSecond();
    time.minute = GetTimeMinute();
    time.hour = GetTimeHour();
    time.day = GetCalendarDay();
    time.month = GetCalendarMonth();
    time.year = GetCalendarYear();

    //cs_dbg_PrintString(
    //    CS_DBG_INFO,
    //    "cs_time_GetCurrentTime: " +
    //    cs_time_TimeToString(time)
    //);
    return time;
}

//----------------------------------------------------------------------------
string cs_time_TimeToString(struct cs_time time)
{
    string strtime = cs_time_conversionPrefix + ":" +
                  IntToString(time.year) + ":" +
                  IntToString(time.month) + ":" +
                  IntToString(time.day) + ":" +
                  IntToString(time.hour) + ":" +
                  IntToString(time.minute) + ":" +
                  IntToString(time.second);
    return strtime;
}

//----------------------------------------------------------------------------
struct cs_time cs_time_StringToTime(string strtime)
{
    //cs_dbg_Enter("cs_time_StringToTime: " + strtime);

    struct cs_time time;
    time.valid = FALSE;

    // Make sure that we have a formatted cs_time as a string
    int pos = FindSubString(strtime, ":");
    if (GetStringLeft(strtime, pos) == cs_time_conversionPrefix)
    {
        time.valid = TRUE;

        // Remove the "cs_time" prefix from the string
        strtime = GetStringRight(strtime, GetStringLength(strtime) - pos - 1);

        // Extract the year and then remove it from the string
        pos = FindSubString(strtime, ":");
        time.year = StringToInt(GetStringLeft(strtime, pos));
        strtime = GetStringRight(strtime, GetStringLength(strtime) - pos - 1);

        // Extract the month and then remove it from the string
        pos = FindSubString(strtime, ":");
        time.month = StringToInt(GetStringLeft(strtime, pos));
        strtime = GetStringRight(strtime, GetStringLength(strtime) - pos - 1);

        // Extract the day and then remove it from the string
        pos = FindSubString(strtime, ":");
        time.day = StringToInt(GetStringLeft(strtime, pos));
        strtime = GetStringRight(strtime, GetStringLength(strtime) - pos - 1);

        // Extract the hour and then remove it from the string
        pos = FindSubString(strtime, ":");
        time.hour = StringToInt(GetStringLeft(strtime, pos));
        strtime = GetStringRight(strtime, GetStringLength(strtime) - pos - 1);

        // Extract the minute and then remove it from the string
        pos = FindSubString(strtime, ":");
        time.minute = StringToInt(GetStringLeft(strtime, pos));

        // Whatever we have left must be the seconds
        time.second = StringToInt(
            GetStringRight(strtime, GetStringLength(strtime) - pos - 1)
        );
    }

    //cs_dbg_Exit("cs_time_StringToTime: " + IntToString(time.valid));
    return time;
}

//----------------------------------------------------------------------------
int cs_time_GetIsValidTime(struct cs_time time)
{
    int valid = time.valid == TRUE;
    //cs_dbg_PrintString(
    //    CS_DBG_INFO,
    //    "cs_time_IsValidTime: " +
    //    IntToString(valid)
    //);
    return valid;
}

//----------------------------------------------------------------------------
int cs_time_GetIsTimeAfter(struct cs_time time, struct cs_time start)
{
    int timeElapsed = cs_time_GetSecondsSinceEpoch(time);
    int startElapsed = cs_time_GetSecondsSinceEpoch(start);

    int value = timeElapsed > startElapsed;
    //cs_dbg_PrintString(
    //    CS_DBG_INFO,
    //    "cs_time_IsTimeAfter: " + IntToString(value) + " (" +
    //    IntToString(timeElapsed) + ">" + IntToString(startElapsed) + ")"
    //);
    return value;
}

//----------------------------------------------------------------------------
int cs_time_GetIsTimeBefore(struct cs_time time, struct cs_time start)
{
    int timeElapsed = cs_time_GetSecondsSinceEpoch(time);
    int startElapsed = cs_time_GetSecondsSinceEpoch(start);

    int value = timeElapsed <= startElapsed;
    //cs_dbg_PrintString(
    //    CS_DBG_INFO,
    //    "cs_time_IsTimeBefore: " + IntToString(value) + " (" +
    //    IntToString(timeElapsed) + "<=" + IntToString(startElapsed) + ")"
    //);
    return value;
}

//----------------------------------------------------------------------------
int cs_time_GetIsTimeBetween(
    struct cs_time time,
    struct cs_time start,
    struct cs_time end)
{
    int timeElapsed = cs_time_GetSecondsSinceEpoch(time);
    int startElapsed = cs_time_GetSecondsSinceEpoch(start);
    int endElapsed = cs_time_GetSecondsSinceEpoch(end);

    int value = (timeElapsed == endElapsed) ||
                ((timeElapsed > startElapsed) && (timeElapsed <= endElapsed));
    //cs_dbg_PrintString(
    //    CS_DBG_INFO,
    //    "cs_time_IsTimeBetween: " + IntToString(value) +
    //    " (" + IntToString(timeElapsed) + "==" + IntToString(endElapsed) + " || (" +
    //    IntToString(timeElapsed) + ">" + IntToString(startElapsed) + " && " +
    //    IntToString(timeElapsed) + "<=" + IntToString(endElapsed) + "))"
    //);
    return value;
}

//----------------------------------------------------------------------------
int cs_util_GetIsInSet(string set, string value)
{
    int result = FALSE;

    // Append the value to the set, but only if it is not already in the
    // set. The set is either "", or always begins and ends with colons.
    // This allows a search for the value bounded by colons, ensuring that
    // values that are substrings of longer values don't cause false positives
    // in the search. Of course, should a value have a colon in it all bets
    // are off.
    if (FindSubString(set, ":" + value + ":") >= 0)
    {
        // The value is in the set
        result = TRUE;;
    }

    //cs_dbg_PrintString(
    //    CS_DBG_INFO,
    //    "cs_util_IsInSet: " +
    //    IntToString(result)
    //);
    return result;
}

//----------------------------------------------------------------------------
string cs_util_AddToSet(string set, string value)
{
    //cs_dbg_Enter("cs_util_AddToSet: " + value);

    // Append the value to the set, but only if it is not already in the
    // set. The set is either "", or always begins and ends with colons.
    // This allows a search for the value bounded by colons, ensuring that
    // values that are substrings of longer values don't cause false positives
    // in the search. Of course, should a value have a colon in it all bets
    // are off.
    if (!cs_util_GetIsInSet(set, value))
    {
        // The value is not in the set so append it to the end
        set = set + (set == "" ? ":" : "") + value + ":";
    }

    //cs_dbg_Exit("cs_util_AddToSet");
    return set;
}

//----------------------------------------------------------------------------
string cs_util_RemoveFromSet(string set, string value)
{
    //cs_dbg_Enter("cs_util_RemoveFromSet: " + value);

    // Find the value if it exists in the set. The set is either "", or
    // always begins and ends with colons. This allows a search for the
    // value bounded by colons, ensuring that values that are substrings
    // of longer values don't cause false positives in the search.
    int pos = FindSubString(set, ":" + value + ":");
    if (pos >= 0)
    {
        // Extract the portion of the set before the value to be
        // removed, removing the trailing colon.
        string before = GetStringLeft(set, pos);

        // Extract the portion of the set after the value to be
        // removed, removing the leading colon.
        string after = GetStringRight(
            set,
            GetStringLength(set) - pos - GetStringLength(":" + value + ":")
        );

        // Concatenate the before and after portions to form the new set
        if ((before == "") && (after == ""))
        {
            // There was only one value and we've now removed it so clear
            // the set
            set = "";
        }
        else
        {
            // Put the set back together
            set = before + ":" + after;
        }
    }

    //cs_dbg_Exit("cs_util_RemoveFromSet");
    return set;
}

//----------------------------------------------------------------------------
string cs_util_GetValueFromSet(string set, int index)
{
    //cs_dbg_Enter("cs_util_GetValueFromSet: " + IntToString(index));

    // Only bother to check if there actually is something in the set
    string value = "";
    if (set != "")
    {
        int count = 0;
        int pos = 0;
        while ((pos >= 0) && (count < index))
        {
            // Chop the leftmost portion of the string up to the colon
            // just found.
            set = GetStringRight(set, GetStringLength(set) - pos - 1);

            // Find the position of the next value in the set.
            pos = FindSubString(set, ":");
            count = count + 1;
        }

        // At this point, the set string should have been reduced to the value
        // being searched for as the leftmost value, or an empty string if the
        // specified index is too high, so we chop off the right of the set
        // string after the first colon.
        pos = FindSubString(set, ":");
        value = GetStringLeft(set, pos);
    }

    //cs_dbg_Exit("cs_util_GetValueFromSet: " + value);
    return value;
}

//----------------------------------------------------------------------------
void cs_util_InvokeEventByTag(string tag, int eventNum)
{
    //cs_dbg_Enter(
    //    "cs_util_InvokeEventByTag: " +
    //    tag + ", " +
    //    IntToString(eventNum)
    //);

    // Start with the first object that matches the tag
    int currentObj = 0;
    object obj = GetObjectByTag(tag, currentObj);

    while(GetIsObjectValid(obj))
    {
        //cs_dbg_PrintString(
        //    CS_DBG_INFO,
        //    "Signalling object " +
        //    IntToString(currentObj)
        //);

        // Fire the event at the object
        SignalEvent(obj, EventUserDefined(eventNum));

        // Get the next object that matches the tag
        currentObj++;
        obj = OBJECT_INVALID;   // NWN Lexicon says to set OBJECT_INVALID
                                // before calling GetObjectByTag() to avoid
                                // a known bug when there are no more objects.
        obj = GetObjectByTag(tag, currentObj);
    }

    //cs_dbg_Exit("cs_util_InvokeEventByTag");
}

//----------------------------------------------------------------------------
// A nifty function originally written by Padmewan and shamelessly stolen :)
void cs_util_PrintCurrentAction()
{
    int act = GetCurrentAction();
    string currentAction;
    switch (act)
    {
        case ACTION_ANIMALEMPATHY:
            currentAction = ": ACTION_ANIMALEMPATHY";
            break;
        case ACTION_ATTACKOBJECT:
            currentAction = ": ACTION_ATTACKOBJECT";
            break;
        case ACTION_CASTSPELL:
            currentAction = ": ACTION_CASTSPELL";
            break;
        case ACTION_CLOSEDOOR:
            currentAction =  ": ACTION_CLOSEDOOR";
            break;
        case ACTION_COUNTERSPELL:
            currentAction =  ": ACTION_COUNTERSPELL";
            break;
        case ACTION_DIALOGOBJECT:
            currentAction =  ": ACTION_DIALOGOBJECT";
            break;
        case ACTION_DISABLETRAP:
            currentAction =  ": ACTION_DISABLETRAP";
            break;
        case ACTION_DROPITEM:
            currentAction =  ": ACTION_DROPITEM";
            break;
        case ACTION_EXAMINETRAP:
            currentAction =  ": ACTION_EXAMINETRAP";
            break;
        case ACTION_FLAGTRAP:
            currentAction =  ": ACTION_FLAGTRAP";
            break;
        case ACTION_FOLLOW:
            currentAction =  ": ACTION_FOLLOW";
            break;
        case ACTION_HEAL:
            currentAction =  ": ACTION_HEAL";
            break;
        case ACTION_INVALID:
            currentAction =  ": ACTION_INVALID";
            break;
        case ACTION_ITEMCASTSPELL:
            currentAction =  ": ACTION_ITEMCASTSPELL";
            break;
        case ACTION_LOCK:
            currentAction =  ": ACTION_LOCK";
            break;
        case ACTION_MOVETOPOINT:
            currentAction =  ": ACTION_MOVETOPOINT";
            break;
        case ACTION_OPENDOOR:
            currentAction =  ": ACTION_OPENDOOR";
            break;
        case ACTION_OPENLOCK:
            currentAction =  ": ACTION_OPENLOCK";
            break;
        case ACTION_PICKPOCKET:
            currentAction =  ": ACTION_PICKPOCKET";
            break;
        case ACTION_PICKUPITEM:
            currentAction =  ": ACTION_PICKUPITEM";
            break;
        case ACTION_RECOVERTRAP:
            currentAction =  ": ACTION_RECOVERTRAP";
            break;
        case ACTION_REST:
            currentAction =  ": ACTION_REST";
            break;
        case ACTION_SETTRAP:
            currentAction =  ": ACTION_SETTRAP";
            break;
        case ACTION_SIT:
            currentAction =  ": ACTION_SIT";
            break;
        case ACTION_TAUNT:
            currentAction =  ": ACTION_TAUNT";
            break;
        case ACTION_USEOBJECT:
            currentAction =  ": ACTION_USEOBJECT";
            break;
        case ACTION_WAIT:
            currentAction =  ": ACTION_WAIT";
            break;
        default:
            currentAction =  ": is totally messed up";
            break;
    }
    //cs_dbg_PrintString(CS_DBG_INFO, GetTag(OBJECT_SELF) + currentAction);
}
