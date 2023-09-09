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
    int iFeat = 1448;
    NWNX_Creature_AddFeat(oPC,iFeat);
        SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",1);


    //Chultan
    //SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"27",1);

    ActionStartConversation(oPC,"bg_class",TRUE);
}

