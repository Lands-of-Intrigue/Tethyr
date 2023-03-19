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
    int nFigLevel;
    int nRanLevel;
    int nMonLevel;

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
                nFigLevel = GetLevelByClass(CLASS_TYPE_FIGHTER,oPC);
                nRanLevel = GetLevelByClass(CLASS_TYPE_PALADIN,oPC);
                nMonLevel = GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC);

                if (nMonLevel >= 1)
                {
                    SendMessageToPC(oPC, "Your training as a Cavalier grants you circumstance modifiers to your skills.");
                    // Your code goes here
                    // If the spell is cast again, any previous enhancement boni are kept

                   IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_DISCIPLINE, 4), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_RIDE, 4), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   if (GetHasFeat(1349))
                   {
                        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   }
                   if (GetHasFeat(1346))
                   {
                        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   }
                   if (GetHasFeat(1331))
                   {
                        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
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
