//::///////////////////////////////////////////////
//:: DM Tool 2 Instant Feat
//:: x3_dm_tool02
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
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nAffliction = GetPCAffliction(oTarget);

    if (nAffliction == 0)
    {
        SendMessageToPC(oPC, "This person is normal.");}
    if (nAffliction == 1)
    {
        SendMessageToPC(oPC, "This person is a werewolf.");}
    if (nAffliction == 2)
    {
        SendMessageToPC(oPC, "This person is a vampire thrall.");}
    if (nAffliction == 3)
    {
        SendMessageToPC(oPC, "This person is vampire.");}
    if (nAffliction == 4)
    {
        SendMessageToPC(oPC, "This person is vampire drider.");}
    if (nAffliction == 7)
    {
        SendMessageToPC(oPC, "This person is lich.");}
    if (nAffliction == 8)
    {
        SendMessageToPC(oPC, "This person is vampiric mist.");}
}
