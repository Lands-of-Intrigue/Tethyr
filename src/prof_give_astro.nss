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
    int iLore = GetSkillRank(SKILL_LORE, oPC, TRUE);
    int iSpellcraft = GetSkillRank(SKILL_SPELLCRAFT, oPC, TRUE);
    int iFeat = PROFICIENCY_ASTROLOGY;
    int iProfRem = GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Prof");
    NWNX_Creature_AddFeatByLevel(oPC,iFeat,1);
    NWNX_Creature_SetSkillRank(oPC, SKILL_LORE, iLore +2);
    NWNX_Creature_SetSkillRank(oPC, SKILL_SPELLCRAFT, iSpellcraft +2);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Prof",iProfRem-1);
}
