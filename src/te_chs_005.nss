//::///////////////////////////////////////////////
//:: Summon Creature Series
//:: NW_S0_Summon
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Carries out the summoning of the appropriate
    creature for the Summon Monster Series of spells
    1 to 9
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "te_functions"
void main()
{
    //Declare major variables
    object oPC = GetPCSpeaker();
    object oSummon = CreateObject(OBJECT_TYPE_CREATURE, "te_summons090", GetLocation(oPC),TRUE);
    AddHenchman(oPC, oSummon);
    SetLocalInt(oPC,"te_tok_005",TRUE);
}
