//::///////////////////////////////////////////////
//:: FileName sc_011
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8
//:://////////////////////////////////////////////
#include "loi_mythicxp"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nRumorDay = GetLocalInt(oPC, "nRumorLast");
    int nDay = GetCalendarDay();
    int nRoll = d20(1);
    int nMod = GetSkillRank(SKILL_PERSUADE, oPC);
    int nDC = 25;

    if (nRumorDay == nDay)
    {
        SendMessageToPC(oPC, "You are unable to ask for rumors right now. Try asking again another day.");
        return FALSE;
    }

    if(nRoll + nMod >= nDC)
    {
        SendMessageToPC(oPC, IntToString(nRoll) + " + " + IntToString(nMod) + " = " + IntToString(nRoll + nMod) + ". Persuasion check succeeded.");
        TickMythicXp(oPC, ABILITY_CHARISMA, 5);
        SetLocalInt(oPC, "nRumorLast", nDay);
        return TRUE;
    }

    else
    {
        SendMessageToPC(oPC, IntToString(nRoll) + " + " + IntToString(nMod) + " = " + IntToString(nRoll + nMod) + ". Persuasion check failed.");
        SetLocalInt(oPC, "nRumorLast", nDay);
        return FALSE;
    }
    
 }

