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
void main()
{
    int    nEvent = GetUserDefinedItemEventNumber(); // Which event triggered this
    object oPC;                                      // The player character using the item
    object oItem;                                    // The item being used
    object oSpellOrigin;                             // The origin of the spell
    object oSpellTarget;                             // The target of the spell
    int    iSpell;                                   // The Spell ID number
    int nPalLevel;
    int nBardLevel;
    int nEldLevel;
    int nInt;

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
                nPalLevel = GetLevelByClass(53,oPC);
                nInt = GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);

                if(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC) == OBJECT_INVALID)
                {
                    if (nPalLevel >= 1)
                    {
                        SendMessageToPC(oPC, "The ghostly ringing of the bladesong courses through the length of your sword.");
                        // Your code goes here
                        // If the spell is cast again, any previous enhancement boni are kept
                        if(GetLocalInt(oItem,"Masterwork") == 1)
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(2), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE);
                        }
                        else
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(1), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE);
                        }

                        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nInt), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE);

                        if(nPalLevel >= 2)
                        {
                            if(GetLocalInt(oItem,"Masterwork") == 1)
                            {
                                IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_2d4), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            }
                            else
                            {
                                IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_1d4), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            }
                        }
                        if(nPalLevel >= 3)
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_CONCENTRATION, 10), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        if(nPalLevel >= 5)
                        {

                            if(GetLocalInt(oItem,"Masterwork") == 1)
                            {
                                IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            }
                            else
                            {
                                IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_16), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            }

                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectModifyAttacks(1),oPC,7.0f);
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
