//::///////////////////////////////////////////////
//:: Example Item Event Script
//:: x2_it_example
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is an example on how to use the
    new default module events for NWN to
    have all code concerning one item in
    a single file.

    Note that this system only works, if
    the following events set on your module

    OnEquip      - x2_mod_def_equ
    OnUnEquip    - x2_mod_def_unequ
    OnAcquire    - x2_mod_def_aqu
    OnUnAcqucire - x2_mod_def_unaqu
    OnActivate   - x2_mod_def_act

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-10
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "nw_i0_spells"
void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oTarget;
    int nAffliction = GetPCAffliction(oTarget);
    int nDamage = d6(2);

    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    {
        oPC   = GetItemActivator();
        oTarget = GetItemActivatedTarget();
        oItem = GetItemPossessedBy(oTarget,"PC_Data_Object");

        SetLocalInt(oItem,"nPiety",0);
        SendMessageToPC(oTarget,"A sudden vacancy in your heart tells you that your gods have abandoned you due to your deeds.");
        AdjustAlignment(oTarget,ALIGNMENT_CHAOTIC,25,FALSE);
        SendMessageToPC(oPC,"The Paladin has had their piety lowered to zero.");
    }
}

