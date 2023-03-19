//::///////////////////////////////////////////////
//:: DM Tool 3 Instant Feat
//:: x3_dm_tool03
//:: Copyright (c) 2007 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is a blank feat script for use with the
    10 DM instant feats provided in NWN v1.69.

    Look up feats.2da, spells.2da and iprp_feats.2da

*/
//:://////////////////////////////////////////////
//:: Created By: Brian Chung
//:: Created On: 2007-12-05
//:://////////////////////////////////////////////
#include "loi_functions"
#include "te_afflic_func"
void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nAffliction = GetPCAffliction(oTarget);

        if (nAffliction == 0)
        {
            Affliction_Items(oTarget, 5);
            SetPCAffliction(oTarget, 5);
            SetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"iUndead",1);
            SendMessageToPC(oPC, "This person is now a Revenant.");
        }
        if (nAffliction == 5)
        {
            Affliction_Items(oTarget, 0);
            SetPCAffliction(oTarget, 0);
            SetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"iUndead",0);
            SendMessageToPC(oPC, "This person is now normal.");
        }

}
