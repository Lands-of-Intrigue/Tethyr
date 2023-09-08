
#include "te_afflic_func"
#include "nwnx_creature"
void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    if (GetPCAffliction(oPC) == 8 && GetLocalInt(oItem,"Blood") >= 10 )
    {
        NWNX_Creature_SetAlignmentGoodEvil(oPC,0);
        NWNX_Creature_SetAlignmentLawChaos(oPC,0);
        SetLocalInt(oItem,"Blood",0);
        Affliction_Items(oPC, 3);
        SetPCAffliction(oPC, 3);
        SetLocalInt(oItem,"iUndead",1);

        NWNX_Creature_AddFeat(oPC, 1414);
        NWNX_Creature_AddFeat(oPC, 1415);
        NWNX_Creature_AddFeat(oPC, 1422);
        NWNX_Creature_AddFeat(oPC, 1423);
        NWNX_Creature_AddFeat(oPC, 1424);
    }

}
