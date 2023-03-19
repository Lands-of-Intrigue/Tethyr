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
#include "te_functions"

void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oTarget;
    object oFire;
    object oPCData;

    int nDamage = d6(2);

    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
        oTarget = GetItemActivatedTarget();

        if(GetLocalInt(oItem,"Wet") < 100)
        {
            if(GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
            {
                if(GetTag(oTarget) == "te_pl_fire")
                {
                    SendMessageToPC(oPC,"Your bucket is not full!");
                    SetLocalInt(oItem,"Wet",0);
                    return;
                }
                else if(GetTag(oTarget) == "te_csi_clean")
                {
                    SendMessageToPC(oPC,"You fill your bucket with water.");
                    SetLocalInt(oItem,"Wet",100);
                    return;
                }
            }
        }
        else
        {
            if(GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
            {
                if(GetTag(oTarget) == "te_pl_fire")
                {
                    SetLocalInt(oTarget,"Wet",100);
                    SetLocalInt(oItem,"Wet",0);
                    SendMessageToPC(oPC,"You splash water from the bucket onto the flames!");
                    return;
                }
                else if(GetTag(oTarget) == "te_csi_clean")
                {
                    SetLocalInt(oItem,"Wet",100);
                    SendMessageToPC(oPC,"Your bucket is already full!");
                    return;
                }
            }
        }

    }
}
