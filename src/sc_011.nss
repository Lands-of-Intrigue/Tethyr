//::///////////////////////////////////////////////
//:: FileName sc_011
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8
//:://////////////////////////////////////////////
/* siobhan: I think this is not fully written - maybe can delete?
int StartingConditional()
{

    // Make sure the player has rolled above 25 on Diplomacy
    if(GetSkillRank("SKILL_PERSUADE", oPC) + d20(1) >= 25){
        int iCha = GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicCHA");
            SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicCHA", iCha+5);
                if (
                    (iCha < 1000 && iCha + 5 >= 1000) ||
                    (iCha < 2000 && iCha + 5 >= 2000) ||
                    (iCha < 4000 && iCha + 5 >= 4000) ||
                     (iCha < 8000 && iCha + 5 >= 8000))
                    {
                    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CHARISMA, NWNX_Creature_GetRawAbilityScore(oPC, ABILITY_CHARISMA)+1);
                    }

        return TRUE;
       }
    return FALSE;
}
*/
