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
    object oDataObject;


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
                nPalLevel = GetLevelByClass(CLASS_TYPE_PALADIN,oPC);
                oDataObject = GetItemPossessedBy(oPC,"PC_Data_Object");


                if(GetLocalInt(oDataObject,"nPiety") >= 80)
                {
                    if (nPalLevel >= 1 )
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyImmunityToSpellLevel(nPalLevel/3), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                        IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                    }

                }

                /*
                if(GetLocalInt(oDataObject,"nPiety") >= 80)
                {
                    if (nPalLevel >= 1 )
                    {
                        SendMessageToPC(oPC, "You feel the power of your deity surge through the sword as you unsheath it.");
                        // Your code goes here
                        // If the spell is cast again, any previous enhancement boni are kept

                        if(nPalLevel <=2)
                        {}
                        else if ((nPalLevel >=3)&&(nPalLevel < 6))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(1), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                        else if ((nPalLevel >=6)&&(nPalLevel < 9))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                        else if ((nPalLevel >=9)&&(nPalLevel < 12))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(3), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                        else if ((nPalLevel >=12)&&(nPalLevel < 15))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(4), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DISPEL_MAGIC,nPalLevel),0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                        else if (nPalLevel >=15)
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(5), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DISPEL_MAGIC,nPalLevel),0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }

                        if ((nPalLevel >= 2)&&(nPalLevel < 4))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_12), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 4)&&(nPalLevel < 6))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_14), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 6)&&(nPalLevel < 8))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_16), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 8)&&(nPalLevel < 10))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_18), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 10)&&(nPalLevel < 12))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 12)&&(nPalLevel < 14))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_22), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if ((nPalLevel >= 14)&&(nPalLevel < 16))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_24), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if ((nPalLevel >= 18)&&(nPalLevel < 18))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_26), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if((nPalLevel >= 20)&&(nPalLevel < 22))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_28), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if ((nPalLevel >= 22)&&(nPalLevel < 24))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_30), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if ((nPalLevel >= 24)&&(nPalLevel < 26))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_32), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }

                    }
                    else if (GetHasFeat(BACKGROUND_CRUSADER, oPC))
                    {
                        if(nPalLevel <=2)
                        {}
                        else if (nPalLevel >=3)
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,1), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,1), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,1), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_12), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                    }
                }
                else if(GetLocalInt(oDataObject,"nPiety") < 80 && GetLocalInt(oDataObject,"nPiety") >= 40)
                {
                    nPalLevel = nPalLevel - 3;
                    if (nPalLevel >= 1 )
                    {
                        SendMessageToPC(oPC, "The power of your deity is with you, though not as strongly as before. Your deeds are not in accordance with your vows.");
                        // Your code goes here
                        // If the spell is cast again, any previous enhancement boni are kept

                        if(nPalLevel <=2)
                        {}
                        else if ((nPalLevel >=3)&&(nPalLevel < 6))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(1), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                        else if ((nPalLevel >=6)&&(nPalLevel < 9))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                        else if ((nPalLevel >=9)&&(nPalLevel < 12))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(3), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                        else if ((nPalLevel >=12)&&(nPalLevel < 15))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(4), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DISPEL_MAGIC,nPalLevel),0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                        else if (nPalLevel >=15)
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(5), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DISPEL_MAGIC,nPalLevel),0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }

                        if ((nPalLevel >= 2)&&(nPalLevel < 4))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_12), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 4)&&(nPalLevel < 6))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_14), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 6)&&(nPalLevel < 8))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_16), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 8)&&(nPalLevel < 10))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_18), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 10)&&(nPalLevel < 12))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 12)&&(nPalLevel < 14))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_22), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if ((nPalLevel >= 14)&&(nPalLevel < 16))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_24), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if ((nPalLevel >= 18)&&(nPalLevel < 18))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_26), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if((nPalLevel >= 20)&&(nPalLevel < 22))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_28), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if ((nPalLevel >= 22)&&(nPalLevel < 24))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_30), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if ((nPalLevel >= 24)&&(nPalLevel < 26))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_32), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }

                    }
                    else if (GetHasFeat(BACKGROUND_CRUSADER, oPC))
                    {
                        if(nPalLevel <=2)
                        {}
                        else if (nPalLevel >=3)
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,1), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,1), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,1), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_12), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                    }
                }
                else if (GetLocalInt(oDataObject,"nPiety") < 40 && GetLocalInt(oDataObject,"nPiety") >= 10)
                {
                    nPalLevel = nPalLevel -6;
                    if (nPalLevel >= 1 )
                    {
                        SendMessageToPC(oPC, "The power of your deity is with you, though not nearly as strongly as before. Your deeds are not in accordance with your vows and you must seek out an attonement.");
                        // Your code goes here
                        // If the spell is cast again, any previous enhancement boni are kept

                        if(nPalLevel <=2)
                        {}
                        else if ((nPalLevel >=3)&&(nPalLevel < 6))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(1), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                        else if ((nPalLevel >=6)&&(nPalLevel < 9))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                        else if ((nPalLevel >=9)&&(nPalLevel < 12))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(3), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                        else if ((nPalLevel >=12)&&(nPalLevel < 15))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(4), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DISPEL_MAGIC,nPalLevel),0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                        else if (nPalLevel >=15)
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(5), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                            IPSafeAddItemProperty(oItem, ItemPropertyDamageBonusVsAlign(IP_CONST_ALIGNMENTGROUP_EVIL,IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DISPEL_MAGIC,nPalLevel),0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }

                        if ((nPalLevel >= 2)&&(nPalLevel < 4))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_12), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 4)&&(nPalLevel < 6))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_14), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 6)&&(nPalLevel < 8))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_16), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 8)&&(nPalLevel < 10))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_18), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 10)&&(nPalLevel < 12))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_20), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                        }
                        else if ((nPalLevel >= 12)&&(nPalLevel < 14))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_22), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if ((nPalLevel >= 14)&&(nPalLevel < 16))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_24), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if ((nPalLevel >= 18)&&(nPalLevel < 18))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_26), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if((nPalLevel >= 20)&&(nPalLevel < 22))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_28), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if ((nPalLevel >= 22)&&(nPalLevel < 24))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_30), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }
                        else if ((nPalLevel >= 24)&&(nPalLevel < 26))
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_32), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);

                        }

                    }
                    else if (GetHasFeat(BACKGROUND_CRUSADER, oPC))
                    {
                        if(nPalLevel <=2)
                        {}
                        else if (nPalLevel >=3)
                        {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,1), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,1), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,1), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_12), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
                            IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                            IPSafeAddItemProperty(oItem, ItemPropertyLight(IP_CONST_LIGHTBRIGHTNESS_DIM, IP_CONST_LIGHTCOLOR_WHITE), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, TRUE, TRUE);
                        }
                    }
                }
                else
                {
                    SendMessageToPC(oPC,"This sword does not seem to respond to you at all.");
                }
                */

                break;

            case X2_ITEM_EVENT_UNEQUIP:
                // * This code runs when the item is unequipped
                // * Note that this event fires for PCs only

                oPC    = GetPCItemLastUnequippedBy();   // The player who unequipped the item
                oItem  = GetPCItemLastUnequipped();     // The item that was unequipped

                // Your code goes here
                //IPRemoveAllItemProperties(oItem,DURATION_TYPE_PERMANENT);
                break;


        }
    // Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}
