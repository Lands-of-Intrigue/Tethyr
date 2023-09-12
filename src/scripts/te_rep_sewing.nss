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
#include "te_functions"
#include "x2_inc_itemprop"

void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oTarget;
    int nDecay;
    int nGPValue;
    int nGPCost;
    int nXPCost;
    int nProf;


    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
        oTarget = GetItemActivatedTarget();

        if(GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
        {
            nDecay = GetLocalInt(oTarget,"Decay");
            string nType = GetItemTypeGeneralName(oItem);
            int nNetAC = GetItemACValue(oTarget);
            int nBonus = IPGetWeaponEnhancementBonus(oTarget, ITEM_PROPERTY_AC_BONUS);
            int nBaseAC = nNetAC - nBonus;
            if(nDecay > 0)
            {
                if((nType == "Armor" && nBaseAC < 4) || nType == "Cloak" || nType == "Ranged" || nType == "Bracer" || nType == "Boots" || nType == "Belt")
                {
                    nGPValue = GetLocalInt(oTarget, "Value");
                    nGPCost = FloatToInt(IntToFloat(nGPValue)*0.05);
                    if(GetGold(oPC) > nGPCost)
                    {
                        if(nGPValue > 2000)
                        {
                            SetXP(oPC,GetXP(oPC)-nGPCost);
                        }
                        TakeGoldFromCreature(nGPCost,oPC,TRUE);
                        SetLocalInt(oTarget,"Decay",nDecay-1);
                    }
                    else
                    {
                        SendMessageToPC(oPC,"You do not have enough gold to repair this item.");
                        SetItemCharges(oItem,GetItemCharges(oItem)+1);
                    }
                }
                else
                {
                    SendMessageToPC(oPC,"This is not a valid target for this item.");
                    SetItemCharges(oItem,GetItemCharges(oItem)+1);
                }

            }
            else
            {
                SendMessageToPC(oPC,"This item is not deteriorated.");
                SetItemCharges(oItem,GetItemCharges(oItem)+1);
            }

        }
        else
        {
            SendMessageToPC(oPC,"This is not a valid target for this item.");
            SetItemCharges(oItem,GetItemCharges(oItem)+1);
        }

    }
}

