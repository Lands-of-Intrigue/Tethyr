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
    int iFeat = BACKGROUND_NAT_LYCAN;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    SetLocalInt(oItem, "PC_ECL",3);
    SetSubRace(oPC, "Natural Lycanthrope");
    if(GetRacialType(oPC) == RACIAL_TYPE_ELF)
    {
        SetSubRace(oPC,"Lythari");
    }

    int iWIS = GetAbilityScore(oPC, ABILITY_WISDOM, TRUE);
    NWNX_Creature_AddFeatByLevel(oPC,iFeat,1);
    NWNX_Creature_AddFeatByLevel(oPC,1175,1);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_WISDOM, iWIS + 2);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",1);
    ActionStartConversation(oPC,"bg_class",TRUE);
}
