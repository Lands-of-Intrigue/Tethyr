//::///////////////////////////////////////////////
//:: Example Item Event Script
//:: x2_it_example
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is an example of how to use the
    new default module events for NWN to
    have all code concerning one item in
    a single file.

    Note that this system only works if
    the following scripts are set in your
    module events

    OnEquip      - x2_mod_def_equ
    OnUnEquip    - x2_mod_def_unequ
    OnAcquire    - x2_mod_def_aqu
    OnUnAcqucire - x2_mod_def_unaqu
    OnActivate   - x2_mod_def_act
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-10
//:: Modified By: Grimlar
//:: Modified On: March 2004
//:://////////////////////////////////////////////

#include "x2_inc_switches"

void main()
{
    int    nEvent = GetUserDefinedItemEventNumber(); // Which event triggered this
    object oPC;                                      // The player character using the item
    object oItem;                                    // The item being used
    object oSpellOrigin;                             // The origin of the spell
    object oSpellTarget;                             // The target of the spell
    int    iSpell;                                   // The Spell ID number

    // Set the return value for the item event script
    // * X2_EXECUTE_SCRIPT_CONTINUE - continue calling script after executed script is done
    // * X2_EXECUTE_SCRIPT_END - end calling script after executed script is done
    int nResult = X2_EXECUTE_SCRIPT_END;

    switch (nEvent)
    {
        case X2_ITEM_EVENT_ACTIVATE:
            // * This code runs when the Unique Power property of the item is used or the item
            // * is activated. Note that this event fires for PCs only

            oPC   = GetItemActivator();             // The player who activated the item
            oItem = GetItemActivated();             // The item that was activated

            // Your code goes here

            if(GetTag(oItem) == "te_item_8397" && (GetLevelByClass(CLASS_TYPE_DRUID,oPC) > 11 || (GetLevelByClass(CLASS_TYPE_CLERIC,oPC) > 11 && (GetHasFeat(FEAT_SUN_DOMAIN_POWER,oPC) == TRUE || GetHasFeat(FEAT_FIRE_DOMAIN_POWER,oPC) == TRUE ))))
            {
                DestroyObject(oItem);
                object oCreate = CreateItemOnObject("te_item_8386",oPC,1);
                SetIdentified(oCreate,1);
                SendMessageToPC(oPC,"You feel your power concentrate into the acorn and seethe with magical potential...");
            }
            else
            {
                SendMessageToPC(oPC,"You are unable to channel your druidic power into this acorn...");
            }


            break;
    }

    // Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}
