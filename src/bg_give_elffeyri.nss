//::///////////////////////////////////////////////
//:: FileName BG 1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: 10/20/17
//:://////////////////////////////////////////////
#include "NWNX_Creature"

void main()
{
    object oPC = GetPCSpeaker();
    int iFeat = 1458;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    SetLocalInt(oItem, "PC_ECL",3);
    SetSubRace(oPC, "Fey'ri");
    int iDEX = GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE);
    int iCON = GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE);
    int iINT = GetAbilityScore(oPC, ABILITY_INTELLIGENCE, TRUE);
    int iCHA = GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE);
    NWNX_Creature_AddFeatByLevel(oPC,iFeat,1);
    NWNX_Creature_AddFeatByLevel(oPC,228,1);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_DEXTERITY, iDEX +2);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CONSTITUTION, iCON -2);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_INTELLIGENCE, iINT +2);
    NWNX_Creature_SetSkillRank(oPC,SKILL_BLUFF,GetSkillRank(SKILL_BLUFF,oPC,TRUE)+2);
    NWNX_Creature_SetSkillRank(oPC,SKILL_HIDE,GetSkillRank(SKILL_HIDE,oPC,TRUE)+2);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",1);
    ActionStartConversation(oPC,"bg_class",TRUE);
}
