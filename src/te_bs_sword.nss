//::///////////////////////////////////////////////
//:: Sword Style
//:: TE_bs_sword.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: David Novotny
//:: Modified On: May 29, 2016
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetSpellTargetObject();
    SendMessageToPC(oPC, "You must acquire a mithril sword to properly use your bladesong.");
}
