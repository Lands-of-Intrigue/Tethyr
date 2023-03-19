//:://////////////////////////////////////////////////
//:: Tethyr's Leadership Tool
//:: TE_EXAMINE
//:: Copyright (c) 2015 Function(D20)
//:///////////////////////////////////////////////////
//:///////////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: October 8, 2019
//:///////////////////////////////////////////////////
#include "nwnx_time"

void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    int nTimeLast = GetLocalInt(oItem,"nLeadLast");
    int nTimeNow = NWNX_Time_GetTimeStamp();
    int nRP = GetLocalInt(oPC,"nXPReward"); //1 on 0 off
    int nPRP = GetLocalInt(oTarget,"nXPReward");
    int nTimePC = GetLocalInt(oTarget,"nLeadLast");

    int nD20 = d20(1);
    int nLeaderRoll = nD20+GetHitDice(oPC) + GetAbilityModifier(ABILITY_CHARISMA,oPC);

    if(GetIsPC(oTarget) == FALSE)
    {
        SendMessageToPC(oPC,"You must target a valid, friendly, player character.");
        return;
    }

    if(nTimeNow < nTimeLast+60)
    {
        SendMessageToPC(oPC,"You have imparted your leadership bonus too recently.");
        return;
    }

    if(nTimeNow < nTimePC+360)
    {
        SendMessageToPC(oPC,"This PC has benefited from a leadership bonus too recently for your lesson to be meaningful.");
        return;
    }

    if(GetIsReactionTypeHostile(oTarget,oPC) == TRUE)
    {
        SendMessageToPC(oPC,"Your pupil is hostile...");
        return;
    }

    if(nRP != 1)
    {
        SendMessageToPC(oPC,"You may not impart a leadership bonus silently. Your bonus requires instruction to impart.");
        return;
    }

    if(nPRP != 1)
    {
        SendMessageToPC(oPC,"Your chosen pupil does not appear to be engaged in your teachings...");
        return;
    }

    if(oTarget == oPC)
    {
        SendMessageToPC(oPC,"You gain a slight headache...");
        return;
    }

    //Cannot be used on self.
    SendMessageToPC(oPC,"Leadership Check: "+IntToString(nLeaderRoll));
    if(nLeaderRoll >= 10+GetHitDice(oTarget))
    {
        SendMessageToPC(oPC,"You seem to successfully impart some of your knowledge.");
    }
    else
    {
        SendMessageToPC(oPC,"You are not successful in imparting your knowledge.");
        return;
    }

    SetLocalInt(oItem,"nLeadLast",nTimeNow);
    int nBonus = 10 + GetHitDice(oPC) + GetAbilityModifier(ABILITY_CHARISMA,oPC) - GetHitDice(oTarget);
    if(nBonus < 0){nBonus = 0;}
    SetLocalInt(oTarget,"nLead",nBonus);
    SetLocalInt(oTarget,"nLeadLast",nTimeNow);
}
