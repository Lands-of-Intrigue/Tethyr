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
#include "nw_i0_spells"
#include "x2_i0_spells"
#include "nwnx_item"
void main()
{
    int    nEvent = GetUserDefinedItemEventNumber(); // Which event triggered this
    object oPC;                                      // The player character using the item
    object oItem;                                    // The item being used
    object oSpellOrigin;                             // The origin of the spell
    object oSpellTarget;                             // The target of the spell
    int    iSpell;                                   // The Spell ID number
    int nPalLevel;
    int nAssLevel;
    int nSorcLevel;
    int nLevel;

    object oPalItem;
    int nItemCount;
    object oArmor;

    // Set the return value for the item event script
    // * X2_EXECUTE_SCRIPT_CONTINUE - continue calling script after executed script is done
    // * X2_EXECUTE_SCRIPT_END - end calling script after executed script is done
    int nResult = X2_EXECUTE_SCRIPT_END;


    switch (nEvent)
        {
            case X2_ITEM_EVENT_EQUIP:
                // * This code runs when the item is equipped
                // * Note that this event fires for PCs only

                oPC   = GetPCItemLastEquippedBy();      // The player who equipped the item
                oItem = GetPCItemLastEquipped();        // The item that was equipped

                nPalLevel = GetLevelByClass(CLASS_TYPE_MONK,oPC);
                oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);

                nPalLevel = GetLevelByClass(CLASS_TYPE_MONK,oPC);
                nAssLevel = GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC);
                nSorcLevel = GetLevelByClass(CLASS_TYPE_WIZARD,oPC);
                nLevel = nPalLevel+nAssLevel+nSorcLevel;
                if ((nPalLevel >= 3) == TRUE)
                {

                    oPalItem = GetFirstItemInInventory(oPC);
                    nItemCount = 0;
                    while (GetIsObjectValid(oPalItem) == TRUE)
                    {
                        if(GetGoldPieceValue(oPalItem) >= 2000)
                        {
                            nItemCount = nItemCount+1;
                        }
                        oPalItem = GetNextItemInInventory(oPC);
                    }

                    if(nItemCount >= 10)
                    {
                        SendMessageToPC(oPC, "You have broken your vow of poverty and receive no benefits from equipping this weapon.");
                        return;
                    }
                    else if(NWNX_Item_GetBaseArmorClass(oArmor) >= 1)
                    {
                        SendMessageToPC(oPC, "You are wearing armor and receive no benefits from equipping this weapon.");
                        return;
                    }
                    else
                    {

                        SendMessageToPC(oPC, "You feel the power of ki flow through this weapon as you hold it.");
                        // Your code goes here
                        // If the spell is cast again, any previous enhancement boni are kept
                     if(nPalLevel <=4)
                        {
                        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(1), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        }
                     else if (nPalLevel >=5)
                        {
                        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(1), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEBONUS_1d4), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        }
                  }
                }
                break;

            case X2_ITEM_EVENT_UNEQUIP:
                // * This code runs when the item is unequipped
                // * Note that this event fires for PCs only

                oPC    = GetPCItemLastUnequippedBy();   // The player who unequipped the item
                oItem  = GetPCItemLastUnequipped();     // The item that was unequipped

                // Your code goes here
                IPRemoveAllItemProperties(oItem,DURATION_TYPE_PERMANENT);
                break;


        }
    // Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}
