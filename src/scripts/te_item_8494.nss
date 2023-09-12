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

    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
        oTarget = GetItemActivatedTarget();
        int nD20 = 0;
        int nCount = 0;

        while (nCount < 6)
        {
            nD20 = Random(15);
            if(nD20 == 1) {CreateItemOnObject("te_salve",oPC,1);}
            else if(nD20 ==2) {CreateItemOnObject("ceb_crtpickaxe",oPC,1);}
            else if(nD20 ==3) {CreateItemOnObject("ceb_crtcottonpic",oPC,1);}
            else if(nD20 ==4) {CreateItemOnObject("ceb_crtwoodaxe",oPC,1);}
            else if(nD20 ==5) {CreateItemOnObject("te_item_0010",oPC,1);}
            else if(nD20 ==6) {CreateItemOnObject("te_cebcraft020",oPC,1);}
            else if(nD20 ==7) {CreateItemOnObject("ceb_crbag",oPC,1);}
            else if(nD20 ==8) {CreateItemOnObject("ceb_crreshides",oPC,1);}
            else if(nD20 ==9) {CreateItemOnObject("te_item_0007",oPC,1);}
            else if(nD20 ==10) {CreateItemOnObject("te_cebcraft013",oPC,1);}
            else if(nD20 ==11) {CreateItemOnObject("te_cebcraft026",oPC,1);}
            else if(nD20 ==12) {CreateItemOnObject("te_cebcraft027",oPC,1);}
            else if(nD20 ==13) {CreateItemOnObject("te_item_0009",oPC,1);}
            else if(nD20 ==14) {CreateItemOnObject("te_rep_sewing",oPC,1);}
            else if(nD20 ==15) {CreateItemOnObject("te_rep_hammer",oPC,1);}

            nCount += 1;
        }
    }
}

