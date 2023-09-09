//::///////////////////////////////////////////////
//:: FileName BG 1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: 10/20/17
//:://////////////////////////////////////////////
#include "NWNX_Creature"
#include "nwnx_creature"

void main()
{
    object oPC = GetPCSpeaker();
    int iFeat = BACKGROUND_AASIMAR;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    SetLocalInt(oItem, "iPCSubrace", 10);
    SetLocalInt(oItem, "PC_ECL",1);
    SetSubRace(oPC, "Aasimar");

    int iCL = GetHitDice(oPC);
    int iSTR = GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE);
    int iDEX = GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE);
    int iCON = GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE);
    int iINT = GetAbilityScore(oPC, ABILITY_INTELLIGENCE, TRUE);
    int iWIS = GetAbilityScore(oPC, ABILITY_WISDOM, TRUE);
    int iCHA = GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE);
    int iAC = GetAC(oPC);
    int iWill = GetWillSavingThrow(oPC);
    int iFort = GetFortitudeSavingThrow(oPC);
    int iRefl = GetReflexSavingThrow(oPC);
    int iSpot = GetSkillRank(SKILL_SPOT, oPC, TRUE);
    int iHide = GetSkillRank(SKILL_HIDE, oPC, TRUE);
    int iBluff = GetSkillRank(SKILL_BLUFF, oPC, TRUE);
    int iListen = GetSkillRank(SKILL_LISTEN, oPC, TRUE);

    NWNX_Creature_AddFeatByLevel(oPC,iFeat,1);
    NWNX_Creature_AddFeatByLevel(oPC,228,1);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_WISDOM, iWIS +2);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CHARISMA, iCHA +2);
    NWNX_Creature_SetSkillRank(oPC, SKILL_SPOT, iSpot +2);
    NWNX_Creature_SetSkillRank(oPC, SKILL_LISTEN, iListen+2);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",1);
    ActionStartConversation(oPC,"bg_class",TRUE);
}
