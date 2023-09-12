//::///////////////////////////////////////////////
//:: FileName BG 1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: GetHitDice(oPC)/20/17
//:://////////////////////////////////////////////
#include "NWNX_Creature"

void main()
{
    object oPC = GetPCSpeaker();
    int iFeat = PROFICIENCY_DECIPHER;
    int iProfRem = GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Prof");
    NWNX_Creature_AddFeatByLevel(oPC,iFeat,GetHitDice(oPC));
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Prof",iProfRem-1);
}
