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
        int nD20 = 0, nCount = 0;

        while (nCount < 10)
        {
            nD20 = d20(1);
            if(nD20 > 18)                       {CreateItemOnObject("te_treatment",oPC,1);}
            else if(nD20 <= 18 && nD20 > 16)    {CreateItemOnObject("te_item_9001",oPC,1);}
            else if(nD20 <= 16 && nD20 > 13)    {CreateItemOnObject("it_mpotion021",oPC,1);}
            else if(nD20 <= 13 && nD20 > 8)     {CreateItemOnObject("it_mpotion002",oPC,1);}
            else if(nD20 <= 8 && nD20 > 5)      {CreateItemOnObject("te_salve",oPC,1);}
            else if(nD20 <= 5 && nD20 > 0)      {CreateItemOnObject("bandages",oPC,1);}

            nCount += 1;
        }
    }
}

