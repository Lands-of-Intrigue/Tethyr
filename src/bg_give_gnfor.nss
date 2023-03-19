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
    int iFeat = 1453;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    SetLocalInt(oItem, "PC_ECL",1);
    SetSubRace(oPC, "Forest Gnome");
    NWNX_Creature_AddFeatByLevel(oPC,iFeat,1);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"8",1);
    NWNX_Creature_SetSkillRank(oPC,SKILL_HIDE,GetSkillRank(SKILL_HIDE,oPC,TRUE)+4);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",1);
    ActionStartConversation(oPC,"bg_class",TRUE);
}
