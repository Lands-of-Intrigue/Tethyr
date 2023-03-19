//::///////////////////////////////////////////////
//:: FileName sc_011
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8
//:://////////////////////////////////////////////
#include "nwnx_creature"
int StartingConditional()
{

    object oPC = GetPCSpeaker();
    if (GetLocalInt(oPC, "RUMOR_TIMER") == 0){
    // Make sure the player has rolled above 25 on Diplomacy
        if(GetSkillRank(SKILL_PERSUADE, oPC) + d20(1) >= 25){
            int iCha = GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicCHA");
                SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicCHA", iCha+5);
                    if (
                        (iCha < 1000 && iCha + 5 >= 1000) ||
                        (iCha < 2000 && iCha + 5 >= 2000) ||
                        (iCha < 4000 && iCha + 5 >= 4000) ||
                        (iCha < 8000 && iCha + 5 >= 8000))
                            {
                            NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CHARISMA, NWNX_Creature_GetRawAbilityScore(oPC, (ABILITY_CHARISMA)+1));
                            }
                        SendMessageToPC(oPC, "Rumor Successful, Mythic CHA increased [DEBUGMESSAGE]");
                        SetLocalInt(oPC, "RESEARCH_TIMER", 1);
                        DelayCommand(43200.0, DeleteLocalInt(oPC,"RESEARCH_TIMER" ));
                        return TRUE;
                        }
        else
        {
        SetLocalInt(oPC, "RESEARCH_TIMER", 1);
        DelayCommand(43200.0, DeleteLocalInt(oPC,"RESEARCH_TIMER" ));
        return FALSE;
        }
    }
 SendMessageToPC(oPC, "You are unable to ask for rumors right now");
 return FALSE;
 }
