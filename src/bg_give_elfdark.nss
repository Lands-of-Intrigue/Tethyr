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
    int iFeat = BACKGROUND_DARK_ELF;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    SetLocalInt(oItem, "PC_ECL",2);
    SetSubRace(oPC, "Dark Elf");
    int iCL = GetHitDice(oPC);
    int iCHA = GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE);
    int iINT = GetAbilityScore(oPC, ABILITY_INTELLIGENCE, TRUE);
    NWNX_Creature_AddFeatByLevel(oPC,iFeat,1);
    NWNX_Creature_AddFeatByLevel(oPC,228,1);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_INTELLIGENCE, iINT+2);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CHARISMA, iCHA+2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectSpellResistanceIncrease(11+iCL)),oPC);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",1);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"81",1);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"46",1);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"13",1);
ActionStartConversation(oPC,"bg_class",TRUE);
}
