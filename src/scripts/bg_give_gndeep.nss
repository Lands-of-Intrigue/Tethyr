//::///////////////////////////////////////////////
//:: FileName BG 1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: 10/20/17
//:://////////////////////////////////////////////
#include "NWNX_Creature"
#include "NWNX_Creature"

void main()
{
    object oPC = GetPCSpeaker();
    int iCL = GetHitDice(oPC);
    int iFeat = 1452;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    SetLocalInt(oItem, "PC_ECL",2);
    SetSubRace(oPC, "Deep Gnome");
    //int iSTR = GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE);
    //int iDEX = GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE);
    int iWIS = GetAbilityScore(oPC, ABILITY_WISDOM, TRUE);
    int iCON = GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE);
    int iCHA = GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE);
    int iDEX = GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE);
    NWNX_Creature_AddFeatByLevel(oPC,iFeat,1);
    NWNX_Creature_AddFeatByLevel(oPC,228,1);
    NWNX_Creature_AddFeatByLevel(oPC,227,1);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectSpellResistanceIncrease(11+iCL)),oPC);

    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_DEXTERITY, iDEX +2);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CONSTITUTION, iCON -4);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_WISDOM, iWIS +2);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CHARISMA, iCHA -4);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"46",1);
    NWNX_Creature_SetSkillRank(oPC,SKILL_HIDE,GetSkillRank(SKILL_HIDE,oPC,TRUE)+2);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",1);
    ActionStartConversation(oPC,"bg_class",TRUE);
}
