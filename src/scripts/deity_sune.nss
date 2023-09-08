//::///////////////////////////////////////////////
//:: FileName BG 1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: 10/20/17
//:://////////////////////////////////////////////
#include "te_functions"
#include "NWNX_Creature"

void main()
{
    object oPC = GetPCSpeaker();
    int iFeat = DEITY_Sune;
    NWNX_Creature_AddFeat(oPC,iFeat);
        SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",4);
        ActionStartConversation(oPC,"bg_language",TRUE);

}

