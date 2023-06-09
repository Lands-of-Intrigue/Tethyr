//::///////////////////////////////////////////////
//:: DM Tool 10 Instant Feat
//:: x3_dm_tool10
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

void main()
{
    object oUser = OBJECT_SELF;
    object oPC = GetSpellTargetObject();

    DM_CreatePCBody(oPC,GetLocation(oUser));

}
