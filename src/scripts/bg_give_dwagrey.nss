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
    int iFeat = BACKGROUND_GREY_DWARF;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    SetLocalInt(oItem, "PC_ECL",2);
    SetSubRace(oPC, "Grey Dwarf");
    int iCHA = GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE);
    NWNX_Creature_AddFeatByLevel(oPC,iFeat,1);
    NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CHARISMA, iCHA -0);
    NWNX_Creature_SetSkillRank(oPC,SKILL_MOVE_SILENTLY,GetSkillRank(SKILL_MOVE_SILENTLY,oPC,TRUE)+4);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_POISON)),oPC);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectImmunity(IMMUNITY_TYPE_PARALYSIS)),oPC);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",1);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"64",1);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"46",1);
    ActionStartConversation(oPC,"bg_class",TRUE);
}
