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

        while (nCount < 2)
        {
            nD20 = Random(32);
if(nD20 ==1) {CreateItemOnObject("te_trika",oPC,1);}
else if(nD20 ==2) {CreateItemOnObject("haunspeir",oPC,1);}
else if(nD20 ==3) {CreateItemOnObject("jhuild",oPC,1);}
else if(nD20 ==4) {CreateItemOnObject("kammarth",oPC,1);}
else if(nD20 ==5) {CreateItemOnObject("katakuda",oPC,1);}
else if(nD20 ==6) {CreateItemOnObject("mordaynvapor",oPC,1);}
else if(nD20 ==7) {CreateItemOnObject("rawhaunspeir",oPC,1);}
else if(nD20 ==8) {CreateItemOnObject("rawjhuild",oPC,1);}
else if(nD20 ==9) {CreateItemOnObject("rawkammarth",oPC,1);}
else if(nD20 ==10) {CreateItemOnObject("rawkatakuda",oPC,1);}
else if(nD20 ==11) {CreateItemOnObject("rawrhul",oPC,1);}
else if(nD20 ==12) {CreateItemOnObject("rawsezaradroot",oPC,1);}
else if(nD20 ==13) {CreateItemOnObject("rhul",oPC,1);}
else if(nD20 ==14) {CreateItemOnObject("sezaradroot",oPC,1);}
else if(nD20 ==15) {CreateItemOnObject("ziran",oPC,1);}
else if(nD20 ==16) {CreateItemOnObject("te_item_8314",oPC,1);}
else if(nD20 ==17) {CreateItemOnObject("te_item_8382",oPC,1);}
else if(nD20 ==18) {CreateItemOnObject("te_item_8315",oPC,1);}
else if(nD20 ==19) {CreateItemOnObject("te_item_8390",oPC,1);}
else if(nD20 ==20) {CreateItemOnObject("te_item_8214",oPC,1);}
else if(nD20 ==21) {CreateItemOnObject("te_item_8216",oPC,1);}
else if(nD20 ==22) {CreateItemOnObject("te_item_0009",oPC,1);}
else if(nD20 ==23) {CreateItemOnObject("te_item_8215",oPC,1);}
else if(nD20 ==24) {CreateItemOnObject("te_cestys",oPC,1);}
else if(nD20 ==25) {CreateItemOnObject("te_item_5017b",oPC,1);}
else if(nD20 ==26) {CreateItemOnObject("te_item_5004",oPC,1);}
else if(nD20 ==27) {CreateItemOnObject("te_jambiya",oPC,1);}
else if(nD20 ==28) {CreateItemOnObject("te_jikholnar",oPC,1);}
else if(nD20 ==29) {CreateItemOnObject("te_kholnar",oPC,1);}
else if(nD20 ==30) {CreateItemOnObject("it_comp_diadust",oPC,1);}
else if(nD20 ==31) {CreateItemOnObject("it_comp_ivory",oPC,1);}
else if(nD20 ==32) {CreateItemOnObject("it_comp_gemcut",oPC,1);}

            nCount += 1;
        }
    }
}
