#include "NWNX_Creature"
void main()
{
    object oPC = GetPCSpeaker();
    NWNX_Creature_AddFeatByLevel(oPC,1616,GetHitDice(oPC));
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MBreaker",GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MBreaker")+1);
}
