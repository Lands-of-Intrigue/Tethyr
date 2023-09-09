//::///////////////////////////////////////////////
//:: Name       Weekly XP Cap System v1.04
//:: FileName   ex_i0_xpcap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Tracks and maintains a weekly XP cap for each PC based on their level.

----Implementation:  -----------------------------------------------------------

    1) Place XPCap_CheckDate(); in OnModuleLoad and OnHeartbeat
    2) Place XPCap_EnterSetVariables(); in OnClientEnter
    3) Place XPCap_DBUpdate(oPC); in OnClientLeave, OnAreaExit
    4) Place the following in any scripts that award XP for non-rp situations
        (e.g. Combat).

        nXP = XPCap_AdjustXPAward(oPC, nAward);

        Already placed in the script pwfxp (combat XP).
        Adjust variables accordingly.

    Updates
    v1.01 - 5/5/06
    * Changed GetCampaignPlayersID to GetName
    * Removed PC Object from DB calls (GamespyID is unique)

    v1.02 - 5/7/06
    * Changed XP cap databases and variable to use just one database file:
        XP_CAP_DB

    v1.04 - 5/7/06
    * Fixed an issue with XP Cap calculation
    * Placed omitted breaks in switch cases
    * Changed calls for sServerThisWeek to local calls.
*/
//:://////////////////////////////////////////////
//:: Created By:    Ythaniel
//:: Created On:    2/28/06
//:://////////////////////////////////////////////
#include "ex_i0_date_time"
#include "ex_i0_mod_funcs"

//XP Cap DB
const string XP_CAP_DB = "XP_CAP_DB";

//Variable name name for storage of Cummulative Cap XP
const string CUMM_CAP_XP = "CummCapXP";

//Database "DATE_TIME_DB" variable used for storing the server's XP Cap Week.
const string XP_CAP_DATE = "CapDate";

//Variable prefix for where the last week in which the PC's earned cap XP
// is stored.
const string PC_LAST_WEEK = "PCLastWeek";

//Message for when the PC's have reached their cap for the week.
// Keep this all in one line.
const string XP_CAP_REACHED
    = "You have reached your weekly non-roleplaying XP cap. You will not gain anymore XP until next week unless it is awarded by a DM.";

const int XP_DEBUG = TRUE;

//Cap Percentages
const float LEVEL1_CAP_PCT = 0.275f;
const float LEVEL2_CAP_PCT = 0.25f;
const float LEVEL3_CAP_PCT = 0.225f;
const float LEVEL4_CAP_PCT = 0.2f;
const float LEVEL5_CAP_PCT = 0.175f;
const float LEVEL6_CAP_PCT = 0.15f;
const float LEVEL7_CAP_PCT = 0.125f;
const float LEVEL8_CAP_PCT = 0.1f;
const float LEVEL9_CAP_PCT = 0.075f;
const float LEVEL10_CAP_PCT = 0.05f;

////////////////////////////////////////////////////////////////////////////////
///  FUNCTIONS   ///////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//Get the weekly XP allowance based on a percent of the total XP needed for the
// PC to level up
int GetXPCap(object oPC);

//Analyzes the provided XP award to see if it exceeds the weekly XP cap. If not
// it adds this amount to the PC's cummulative cap xp, otherwise, it adjusts
// both the award and the cummulative cap xp accordingly.
//Place wherever XP is awarded by the module.
// NOTE: Only adjust local variables on PC.
int XPCap_AdjustXPAward(object oPC, int nAward);

//Initiates local variables for the PC for tracking cap XP
//Place in OnClientEnter
void XPCap_EnterSetVariables();

//Updates XP Cap databases for persistence.
//Place in OnClientExit, AreaExit, and OnRest
void XPCap_DBUpdate(object oPC);

//Checks to see if the weekly cap date has expired and resets it if so.
//Put in OnHeartbeat and OnModuleLoad
void XPCap_CheckDate();

////////////////////////////////////////////////////////////////////////////////
// MAIN FUNCTIONS
////////////////////////////////////////////////////////////////////////////////
//Get the weekly XP allowance based on a percent of the total XP needed for the
// PC to level up
int GetXPCap(object oPC)
{
    SpawnScriptDebugger();
    int nLevel = GetHitDice(oPC);
    float fCapPct = 1.0f;
    switch(nLevel)
    {
        case 1: fCapPct = LEVEL1_CAP_PCT; break;
        case 2: fCapPct = LEVEL2_CAP_PCT; break;
        case 3: fCapPct = LEVEL3_CAP_PCT; break;
        case 4: fCapPct = LEVEL4_CAP_PCT; break;
        case 5: fCapPct = LEVEL5_CAP_PCT; break;
        case 6: fCapPct = LEVEL6_CAP_PCT; break;
        case 7: fCapPct = LEVEL7_CAP_PCT; break;
        case 8: fCapPct = LEVEL8_CAP_PCT; break;
        case 9: fCapPct = LEVEL9_CAP_PCT; break;
        case 10: fCapPct = LEVEL10_CAP_PCT; break;
    }

    // Multiply the amount of XP between levels (current level times 1000) by
    //   the cap percentage to return the XP cap.
    float fLevel = IntToFloat(nLevel * 1000);
    float fCap =  fLevel * fCapPct;

    return FloatToInt(fCap);
}

////////////////////////////////////////////////////////////////////////////////
//Analyzes the provided XP award to see if it exceeds the weekly XP cap. If not
// it adds this amount to the PC's cummulative cap xp, otherwise, it adjusts
// both the award and the cummulative cap xp accordingly.
//Place wherever XP is awarded by the module.
// NOTE: Only adjusts local variables on PC.
int XPCap_AdjustXPAward(object oPC, int nAward)
{
    if(nAward == 0) {return 0;}

    string sName = GetName(oPC);
    int nCummCapXP = GetLocalInt(oPC, CUMM_CAP_XP + sName);
    string sPCLastWeek = GetLocalString(oPC, PC_LAST_WEEK + sName);
    //Always specified by the last day of that week.
    string sServerThisWeek = GetLocalString(GetModule(), XP_CAP_DATE);

    if(sPCLastWeek == sServerThisWeek)
    {
        int nXPCap = GetXPCap(oPC);
        int nCapRoom = nXPCap - nCummCapXP;

        //Check to see if the PCs have already exceeded their cap or are
        //  just now exceeding their cap.
        if(nAward >= nCapRoom)
        {
            int nAdjustment = nAward - nCapRoom; //will never be less than 0
            nAward = nAward - nAdjustment;

            if(XP_DEBUG) SendMessageToPC(oPC, "Adjustment to XP: "
                                            + IntToString(nAdjustment));

            //Inform the PC that they have reached their weekly cap
            SendMessageToPC(oPC, XP_CAP_REACHED);
        }

        SetLocalInt(oPC, CUMM_CAP_XP + sName, nCummCapXP + nAward);
        return nAward;
    }
    else  //if we're just starting a new cap week
    {
        //Update the player's XP cap week to this week
        SetLocalString(oPC, PC_LAST_WEEK + sName, sServerThisWeek);
        SetLocalInt(oPC, CUMM_CAP_XP + sName, nCummCapXP + nAward);
        return nAward;
    }
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//Initiates local variables for the PC for tracking cap XP
//Place in OnClientEnter
void XPCap_EnterSetVariables()
{
    object oPC = GetEnteringObject();
    int nCapXP;

    //SpawnScriptDebugger();

    if(GetIsPC(oPC) && !GetIsDM(oPC))
    {
        string sName = GetName(oPC);
        string sPCLastWeek = GetPFCampaignString(XP_CAP_DB, PC_LAST_WEEK + sName);
        //Always specified by the last day of that week.
        string sServerThisWeek = GetLocalString(GetModule(), XP_CAP_DATE);

        //SendMessageToPC(oPC, "PC last week: " + sPCLastWeek + ". " + "Server week: " + sServerThisWeek + ".");
        if(sPCLastWeek == sServerThisWeek)
        {
            //SendMessageToPC(oPC, "PC Week matches server week.");
            nCapXP = GetPFCampaignInt(XP_CAP_DB, CUMM_CAP_XP + sName);
            //int nCurrentXP = GetXP(oPC);

            SetLocalInt(oPC, CUMM_CAP_XP + sName, nCapXP);
            SetLocalString(oPC, PC_LAST_WEEK + sName, sPCLastWeek);
        }
        else  //Reset the player's cummulative cap XP to 0.
        {
            //Update the player's XP cap week to this week
            SetPFCampaignString(XP_CAP_DB, PC_LAST_WEEK + sName, sServerThisWeek);

            //Used for expediting combat related Cap scripts
            SetLocalString(oPC, PC_LAST_WEEK + sName, sServerThisWeek);
            SetLocalInt(oPC, CUMM_CAP_XP + sName, 0);
        }
    }

    if(XP_DEBUG)
    {
        SendMessageToPC(oPC, "XP Cap: Setting local variables from database.");
        SendMessageToPC(oPC, "You have " + IntToString(nCapXP) + " of "
                             + IntToString(GetXPCap(oPC)) + " Cap XP.");
        SendMessageToPC(oPC, "Cap Week Ends: "
                             + ConvertDateString(GetModule(), XP_CAP_DATE) + ".");
    }

}

////////////////////////////////////////////////////////////////////////////////
//Updates XP Cap databases for persistence.
//Place in OnClientLeave, AreaExit
void XPCap_DBUpdate(object oPC)
{
    int nCummCapXP;

    if(GetIsPC(oPC) && !GetIsDM(oPC))
    {
        string sName = GetName(oPC);
        string sPCLastWeek = GetLocalString(oPC, PC_LAST_WEEK + sName);
        //Always specified by the last day of that week.
        string sServerThisWeek = GetLocalString(GetModule(), XP_CAP_DATE);

        //SendMessageToPC(oPC, "PC last week: " + sPCLastWeek + ". " + "Server week: " + sServerThisWeek + ".");
        if(sPCLastWeek == sServerThisWeek)
        {
            nCummCapXP = GetLocalInt(oPC, CUMM_CAP_XP + sName);
            SetPFCampaignInt(XP_CAP_DB, CUMM_CAP_XP + sName, nCummCapXP);
            //SetPFCampaignString(PC_LAST_WEEK, sName, sPCLastWeek, oPC);
        }
        else   //Reset the player's cummulative cap XP to 0.
        {
            //Update the player's XP cap week to this week
            SetPFCampaignString(XP_CAP_DB, PC_LAST_WEEK + sName, sServerThisWeek);

            //Used for expediting combat related Cap scripts
            SetLocalString(oPC, PC_LAST_WEEK + sName, sServerThisWeek);
            SetPFCampaignInt(XP_CAP_DB, CUMM_CAP_XP + sName, 0);
        }
    }

    if(XP_DEBUG)
    {
        SendMessageToPC(oPC, "XP Cap: Updating Cap XP Database.");
        SendMessageToPC(oPC, "You have " + IntToString(nCummCapXP) + " of "
                             + IntToString(GetXPCap(oPC)) + " Cap XP.");
        SendMessageToPC(oPC, "Cap Week Ends: "
                             + ConvertDateString(GetModule(), XP_CAP_DATE) + ".");
    }
}

////////////////////////////////////////////////////////////////////////////////
//Checks to see if the weekly cap date has expired and resets it if so.
//Put in OnHeartbeat and OnModuleLoad
void XPCap_CheckDate()
{
    object oModule = GetModule();
    if(CheckDateStringExpired(oModule, XP_CAP_DATE))
    {
        SetDateString(oModule, XP_CAP_DATE, 0, 0, 7);

        string sDate = GetPFCampaignString(DATETIMEDB, XP_CAP_DATE, oModule);
        SetLocalString(oModule, XP_CAP_DATE, sDate);

        WriteTimestampedLogEntry("XP Cap reset for "
                                 + ConvertDateString(oModule, XP_CAP_DATE));

        if(XP_DEBUG)
            SendMessageToAllDMs("XP Cap System: Resetting XP Cap Week.  New XP"
                                + " Cap week ends: "
                                + ConvertDateString(oModule, XP_CAP_DATE));
    }
}

