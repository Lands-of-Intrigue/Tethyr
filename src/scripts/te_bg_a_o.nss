#include "nwnx_creature"

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",7);
    int iCHA = GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE);
    int iCON = GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE);
    int iDEX = GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE);
    int iINT = GetAbilityScore(oPC, ABILITY_INTELLIGENCE, TRUE);
    int iSTR = GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE);
    int iWIS = GetAbilityScore(oPC, ABILITY_WISDOM, TRUE);

    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_STRENGTH, iSTR-2);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CONSTITUTION, iCON-2);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_DEXTERITY, iDEX-2);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_INTELLIGENCE, iINT+2);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CHARISMA, iCHA+2);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_WISDOM, iWIS+2);

    ActionStartConversation(oPC, "bg_disfig", TRUE);
}
