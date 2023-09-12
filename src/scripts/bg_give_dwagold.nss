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
    int iFeat = BACKGROUND_GOLD_DWARF;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    SetLocalInt(oItem, "PC_ECL",0);
    SetSubRace(oPC, "Gold Dwarf");
    int iDEX = GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE);
    int iCHA = GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE);

    NWNX_Creature_AddFeatByLevel(oPC,iFeat,1);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CHARISMA, iCHA +4);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_DEXTERITY, iDEX -2);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",1);
    ActionStartConversation(oPC,"bg_class",TRUE);
}
