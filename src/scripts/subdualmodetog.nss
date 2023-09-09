//::///////////////////////////////////////////////
//:: Subdual Damage 1.6
//:: subdual_clenter
//:: Copyright (c) 2018 CarfaxAbbey.net
//:://////////////////////////////////////////////
/*
    Allows for PC subdual in PvP combat.
    Non-Lethal Damage
*/
//:://////////////////////////////////////////////
//:: Revised By: Diavlen (hatter@carfaxabbey.net)
//:: Created On: August 11, 2006
//:: Revised: March 30, 2018
//:://////////////////////////////////////////////
#include "subdual_inc"
#include "x2_inc_switches"

void main() {
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;

    // * This code runs when the item has the OnHitCastSpell: Unique power property
    // * and it hits a target(weapon) or is being hit (armor)
    // * Note that this event fires for non PC creatures as well.
    if (nEvent ==X2_ITEM_EVENT_ONHITCAST)
    {
        oItem  =  GetSpellCastItem();                  // The item casting triggering this spellscript
        object oSpellOrigin = OBJECT_SELF ;
        object oSpellTarget = GetSpellTargetObject();
        oPC = OBJECT_SELF;

    }

    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    else if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
        int nMode   =   GetLocalInt(oPC,"SUBDUAL");
        if(nMode==SUBDUAL_MODE_SUBDUAL) {
            SetLocalInt(oPC,"SUBDUAL",SUBDUAL_MODE_FULL_DAMAGE);
            FloatingTextStringOnCreature("**Doing full damage**",oPC,FALSE);
            subDEBUG(GetName(oPC) + " is Doing Full Damage");
        } else {
            SetLocalInt(oPC,"SUBDUAL",SUBDUAL_MODE_SUBDUAL);
            FloatingTextStringOnCreature("**Doing subdual damage**",oPC,FALSE);
            subDEBUG(GetName(oPC) + " is Doing Subdual Damage");
        }
    }

    // * This code runs when the item is equipped
    // * Note that this event fires PCs only
    else if (nEvent ==X2_ITEM_EVENT_EQUIP)
    {

        oPC = GetPCItemLastEquippedBy();
        oItem = GetPCItemLastEquipped();

    }

    // * This code runs when the item is unequipped
    // * Note that this event fires PCs only
    else if (nEvent ==X2_ITEM_EVENT_UNEQUIP)
    {

        oPC    = GetPCItemLastUnequippedBy();
        oItem  = GetPCItemLastUnequipped();

    }
    // * This code runs when the item is acquired
    // * Note that this event fires PCs only
    else if (nEvent == X2_ITEM_EVENT_ACQUIRE)
    {

        oPC = GetModuleItemAcquiredBy();
        oItem  = GetModuleItemAcquired();
    }

    // * This code runs when the item is unaquire d
    // * Note that this event fires PCs only
    else if (nEvent == X2_ITEM_EVENT_UNACQUIRE)
    {

        oPC = GetModuleItemLostBy();
        oItem  = GetModuleItemLost();
    }

    //* This code runs when a PC or DM casts a spell from one of the
    //* standard spellbooks on the item
    else if (nEvent == X2_ITEM_EVENT_SPELLCAST_AT)
    {

        oPC = GetModuleItemLostBy();
        oItem  = GetModuleItemLost();
    }
}
