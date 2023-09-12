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
#include "loi_functions"
#include "nw_i0_spells"
void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oTarget;
    object oData;
    int nPiety;

    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
        oTarget = GetItemActivatedTarget();
        oData = GetItemPossessedBy(oTarget,"PC_Data_Object");
        nPiety = GetLocalInt(oData,"nPiety");
        SetLocalInt(oData,"nPiety",nPiety-10);

        if(GetLocalInt(oData,"nPiety") >= 100)
        {
            SetLocalInt(oData,"nPiety",100);
        }
        else if(GetLocalInt(oData,"nPiety") <= 0)
        {
            SetLocalInt(oData,"nPiety",0);
        }
    }
}
