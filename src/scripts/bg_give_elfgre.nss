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
    int iFeat = BACKGROUND_GREEN_ELF;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    SetLocalInt(oItem, "PC_ECL",0);
    SetSubRace(oPC, "Green Elf");
    int iCON = GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE);
    int iINT = GetAbilityScore(oPC, ABILITY_INTELLIGENCE, TRUE);
    NWNX_Creature_AddFeatByLevel(oPC,iFeat,1);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CONSTITUTION, iCON +4); //-2 Racial Modifier applied afterwards
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_INTELLIGENCE, iINT -2);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",1);
    ActionStartConversation(oPC,"bg_class",TRUE);
    }
