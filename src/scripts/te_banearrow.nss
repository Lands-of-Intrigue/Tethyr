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
    int nAssLevel;

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
                nAssLevel = GetLevelByClass(CLASS_TYPE_RANGER,oPC);

                if (nAssLevel >=5)
                {
                    SendMessageToPC(oPC, "You feel the power of your deity surge through your bow.");
                    // Your code goes here
                    // If the spell is cast again, any previous enhancement boni are kept
                  if (GetHasFeat(285, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(268, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(269, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(270, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_BEAST,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_BEAST,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(271, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_CONSTRUCT,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_CONSTRUCT,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(272, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(273, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(274, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_MONSTROUS,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_MONSTROUS,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(275, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(276, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(277, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_ELEMENTAL,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ELEMENTAL,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(278, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_FEY,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_FEY,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(279, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_GIANT,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GIANT,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(280, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_MAGICAL_BEAST,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_MAGICAL_BEAST,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(281, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(284, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
                  if (GetHasFeat(286, oPC) == TRUE)
                   {IPSafeAddItemProperty(oItem, ItemPropertyAttackBonusVsRace(IP_CONST_RACIALTYPE_VERMIN,2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                   IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_VERMIN,IP_CONST_DAMAGETYPE_PIERCING,IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);}
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
