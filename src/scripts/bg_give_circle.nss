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
    int iFeat = BACKGROUND_CIRCLE_BORN;
    NWNX_Creature_AddFeatByLevel(oPC,iFeat,1);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",3);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"8",1);
ActionStartConversation(oPC,"bg_deity",TRUE);
}
