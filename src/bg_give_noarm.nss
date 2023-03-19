#include "nwnx_creature"

void main()
{
    object oPC = GetPCSpeaker();

    NWNX_Creature_AddFeatByLevel(oPC, 2000, 1);//One-Armed
    //Set Arm to be nonexistent. I set the non-models to be all model number 200.

    SetCreatureBodyPart(CREATURE_PART_LEFT_BICEP, 200, oPC);
    SetCreatureBodyPart(CREATURE_PART_LEFT_FOREARM, 200, oPC);
    SetCreatureBodyPart(CREATURE_PART_LEFT_HAND, 200, oPC);

    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",8);
}
