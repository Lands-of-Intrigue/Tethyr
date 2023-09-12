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
    int iFeat = BACKGROUND_COPPER_ELF;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    SetLocalInt(oItem, "PC_ECL",0);
    SetSubRace(oPC, "Copper Elf");
    int iSTR = GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE);
    //int iCON = GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE);
    int iINT = GetAbilityScore(oPC, ABILITY_INTELLIGENCE, TRUE);
    int iCHA = GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE);
    NWNX_Creature_AddFeatByLevel(oPC,iFeat,1);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_STRENGTH, iSTR +2);
    //NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CONSTITUTION, iCON +4);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_INTELLIGENCE, iINT -2);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CHARISMA, iCHA -2);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",1);
    ActionStartConversation(oPC,"bg_class",TRUE);
}
