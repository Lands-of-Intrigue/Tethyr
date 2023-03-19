//::///////////////////////////////////////////////
//:: Example Item Event Script
//:: x2_it_example
//:: Modified by DM Spectre, Latest edit by DM Djinn 6/25/18
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "nw_i0_spells"
#include "x2_i0_spells"

int DNDAlignment(object oPC);


void main()
{
    int    nEvent = GetUserDefinedItemEventNumber(); // Which event triggered this
    object oPC;                                      // The player character using the item
    object oItem;                                    // The item being used
    object oSpellOrigin;                             // The origin of the spell
    object oSpellTarget;                             // The target of the spell
    int    iSpell;                                   // The Spell ID number
    int    iStr;
    int    iCon;
    int    iDex;
    int    iWis;
    int    iInt;
    int    iCha;
    int    iWeapType;
    int    iClericLvl;
    int    iAlign;
    object oDataObject;
    int    nPiety;

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
                iClericLvl = GetLevelByClass(CLASS_TYPE_CLERIC,oPC);
                iStr = GetAbilityScore(oPC,ABILITY_STRENGTH,TRUE);
                iCon = GetAbilityScore(oPC,ABILITY_CONSTITUTION,TRUE);
                oItem = GetPCItemLastEquipped();        // The item that was equipped
                iDex = GetAbilityScore(oPC,ABILITY_DEXTERITY,TRUE);
                iWis = GetAbilityScore(oPC,ABILITY_WISDOM,TRUE);
                iInt = GetAbilityScore(oPC,ABILITY_INTELLIGENCE,TRUE);
                iCha = GetAbilityScore(oPC,ABILITY_CHARISMA,TRUE);
                iWeapType = GetBaseItemType(oItem);
                iAlign = DNDAlignment(oPC);

                oDataObject = GetItemPossessedBy(oPC,"PC_Data_Object");
                nPiety = GetLocalInt(oDataObject,"nPiety");

                if(iClericLvl >= 1 && nPiety >= 50)
                {
                    if((GetLocalInt(oItem,"Masterwork") == 1)||(GetHasFeat(DEITY_Shar,oPC) && iStr >=14 && iWeapType == BASE_ITEM_LIGHTMACE && (iAlign == 7)))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    else
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(1), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    // LG-0, NG-1, CG -2, LN-3, TN-4, CN-5, LE-6, NE-7, CE-8
                    //Akadi-Con 12, Heavy Flail, 2,4,5,8
                    if(GetHasFeat(DEITY_Akadi,oPC) && iCon >=12 && iWeapType == BASE_ITEM_HEAVYFLAIL && (iAlign == 2|| iAlign == 4||iAlign == 5||iAlign == 8))
                    {
                         IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Auril-Con 13, Battleaxe, 7
                    else if(GetHasFeat(DEITY_Auril,oPC) && iCon >=13 && iWeapType == BASE_ITEM_BATTLEAXE && (iAlign == 7))
                    {
                         IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_COLD,3), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                         IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_1d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                         IPSafeAddItemProperty(oItem, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,10), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Azuth-Int 13, Quarterstaff, 3
                    else if(GetHasFeat(DEITY_Azuth,oPC) && iInt >=13 && iWeapType == BASE_ITEM_QUARTERSTAFF && (iAlign == 3))
                    {
                         IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_LORE,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                         IPSafeAddItemProperty(oItem, ItemPropertyCastSpell(IP_CONST_CASTSPELL_SHIELD_5,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Beshaba-N/A, Whip, 8
                    else if(GetHasFeat(DEITY_Beshaba,oPC) && iWeapType == BASE_ITEM_WHIP && (iAlign == 8))
                    {
                         IPSafeAddItemProperty(oItem, ItemPropertyFreeAction(), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Cyric-Str 13, Longsword, 7,8
                    else if(GetHasFeat(DEITY_Cyric,oPC) && iStr >=13 && iWeapType == BASE_ITEM_LONGSWORD && (iAlign == 7||iAlign == 8))
                    {
                         IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,iClericLvl/2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);

                         if(iClericLvl <=4)
                         {}
                         else if(iClericLvl >= 5 && iClericLvl <10)
                         {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusFeat(IP_CONST_FEAT_SNEAK_ATTACK_1D6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                         }
                         else
                         {
                            IPSafeAddItemProperty(oItem, ItemPropertyBonusFeat(IP_CONST_FEAT_SNEAK_ATTACK_2D6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                         }
                    }
                    //Deneir-Int 15, Dagger, 1
                    else if(GetHasFeat(DEITY_Deneir,oPC) && iInt >=15 && iWeapType == BASE_ITEM_DAGGER && (iAlign == 1))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_LORE,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Finder-Cha 15, Bsword, 5,8
                    else if(GetHasFeat(DEITY_Finder_Wyvernspur,oPC) && iCha >=15 && iWeapType == BASE_ITEM_BASTARDSWORD && (iAlign == 5||iAlign == 8))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CHARM_PERSON_10,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Garagos-Str 13, Con 11, Longsword, 5,8
                    else if(GetHasFeat(DEITY_Garagos,oPC) && iStr >=13 && iCon >=11 && iWeapType == BASE_ITEM_LONGSWORD && (iAlign == 5||iAlign == 8))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Gargauth-Int 16, Dagger, 6
                    else if(GetHasFeat(DEITY_Gargauth,oPC) && iInt >=16 && iWeapType == BASE_ITEM_DAGGER && (iAlign == 6))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CHARM_MONSTER_10,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Gond-Dex 14, Int 14, Warhammer, 1,3,4,5
                    else if(GetHasFeat(DEITY_Gond,oPC) && iDex >=14 && iInt >=14 && iWeapType == BASE_ITEM_WARHAMMER && (iAlign == 1||iAlign == 3||iAlign == 4||iAlign == 5))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CHARM_MONSTER_10,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_USE_MAGIC_DEVICE,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_DISABLE_TRAP,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,iClericLvl/3), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Grumbar-Str 12, Warhammer, 0,1,2
                    else if(GetHasFeat(DEITY_Grumbar,oPC) && iStr >=12 && iWeapType == BASE_ITEM_WARHAMMER && (iAlign == 0||iAlign == 1||iAlign == 2))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1d6+(iClericLvl/3)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Gwaeron-Str 13, Dex 13, Con 14, Greatsword, 0,1,2
                    else if(GetHasFeat(DEITY_Gwaeron_Windstrom,oPC) && iCon >=14 && iDex >=13 && iWeapType == BASE_ITEM_GREATSWORD && (iAlign == 0|1|2))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_HIDE,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_SPOT,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_LISTEN,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Helm-Str 14, Bsword, 3
                    else if(GetHasFeat(DEITY_Helm,oPC) && iStr >=14 && iWeapType == BASE_ITEM_BASTARDSWORD && (iAlign == 3))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_BACKSTAB), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_1d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Hoar-Dex 10, Spear, 3
                    else if(GetHasFeat(DEITY_Hoar,oPC) && iDex >=10 && iWeapType == BASE_ITEM_SHORTSPEAR && (iAlign == 3))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_2d4), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,10), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Ibrandul-Con 11, Club/Greatclub, 5
                    else if(GetHasFeat(DEITY_Ibrandul,oPC) && iCon >=11 && iWeapType == BASE_ITEM_CLUB && (iAlign == 5))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyBonusFeat(ITEM_PROPERTY_DARKVISION), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(iClericLvl/3), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyDecreaseAbility(IP_CONST_ABILITY_CHA,(iClericLvl/3)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Ilmater-Con 14, Gloves?, 0
                     else if(GetHasFeat(DEITY_Ilmater,oPC) && iCon >=14 && iWeapType == BASE_ITEM_GLOVES && (iAlign == 0))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyCastSpell(IP_CONST_CASTSPELL_REMOVE_FEAR_2,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Istisha-Str 12, Warhammer, 2,4,5
                     else if(GetHasFeat(DEITY_Ishtisha,oPC) && iStr >=12 && iWeapType == BASE_ITEM_WARHAMMER && (iAlign == 2||iAlign == 4||iAlign == 5))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertySpellImmunitySpecific(SPELL_DROWN), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Kelemvor-Con 12, Bsword, ???
                    else if(GetHasFeat(DEITY_Kelemvor,oPC) && iCon >=12 && iWeapType == BASE_ITEM_BASTARDSWORD && (iAlign == 3||iAlign == 6))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_DEATH,4), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,IP_CONST_DAMAGEBONUS_1d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Kossuth-Con 12, Flail, 3,4,6
                    else if(GetHasFeat(DEITY_Kossuth,oPC) && iCon >=12 && iWeapType == BASE_ITEM_LIGHTFLAIL && (iAlign == 3||iAlign == 4||iAlign == 6))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(DAMAGE_TYPE_FIRE,DAMAGE_BONUS_1d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Lathander-Cha 12, Heavy Mace, 1
                    else if(GetHasFeat(DEITY_Lathander,oPC) && iCha >=12 && (iAlign == 1))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(DAMAGE_TYPE_DIVINE,DAMAGE_BONUS_1d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Leira-Dex 11, Int 12, Dagger, 5,8
                    else if(GetHasFeat(DEITY_Leira,oPC) && iDex >=11 && iWeapType == BASE_ITEM_DAGGER && (iAlign == 5||iAlign == 8))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyCastSpell(IP_CONST_CASTSPELL_SHADES_11,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectInvisibility(INVISIBILITY_TYPE_NORMAL),oPC,TurnsToSeconds(iClericLvl));
                    }
                    //Lliira-Cha 13, Throwing Stars, 2
                    else if(GetHasFeat(DEITY_Lliira,oPC) && iCha >=13 && iWeapType == BASE_ITEM_SHURIKEN && (iAlign == 2))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyCastSpell(IP_CONST_CASTSPELL_REMOVE_FEAR_2,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_PERFORM,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Loviatar-Con 15, Whip, 6
                    else if(GetHasFeat(DEITY_Loviatar,oPC) && iCon >=15 && iWeapType == BASE_ITEM_WHIP && (iAlign == 6))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_CASTSPELL_INFLICT_LIGHT_WOUNDS_5,(iClericLvl)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Lurue-Cha 12, Spear, 2
                    else if(GetHasFeat(DEITY_Lurue,oPC) && iCha >=12 && iWeapType == BASE_ITEM_SHORTSPEAR && (iAlign == 2))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_POISON), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Malar-Str 13, Claw Bracer, 8
                    else if(GetHasFeat(DEITY_Lurue,oPC) && iCha >=12 && iWeapType == BASE_ITEM_BRACER && (iAlign == 8))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING,IP_CONST_DAMAGEBONUS_1d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Mask-Dex 14, Longsword, 7
                    else if(GetHasFeat(DEITY_Mask,oPC) && iDex >=14 && iWeapType == BASE_ITEM_LONGSWORD && (iAlign == 7))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_HIDE,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_MOVE_SILENTLY,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_PICK_POCKET,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_SET_TRAP,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Milil-Int 13, Cha 14, Rapier, 1
                    else if(GetHasFeat(DEITY_Milil,oPC) && iInt >=13 && iCha >=14 && iWeapType == BASE_ITEM_RAPIER && (iAlign == 1))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CHARM_PERSON_10,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_PERFORM,(iClericLvl)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Mystra-Int 14, Throwing Stars, 3,5,1
                    else if(GetHasFeat(DEITY_Mystra,oPC) && iInt >=14 && iWeapType == BASE_ITEM_SHURIKEN && (iAlign == 3||iAlign == 5||iAlign == 1))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_SPELLCRAFT,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_1d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Nobanion-Str 11, Cha 11, Heavy Pick, 0
                    else if(GetHasFeat(DEITY_Nobanion,oPC) && iStr >=11 && iCha >=11 && iWeapType == BASE_ITEM_LIGHTHAMMER && (iAlign == 3||iAlign == 5||iAlign == 1))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Oghma-Int 12, Longsword, 4
                    else if(GetHasFeat(DEITY_Oghma,oPC) && iInt >=12 && iWeapType == BASE_ITEM_LONGSWORD && (iAlign == 4))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_LORE,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,IP_CONST_DAMAGEBONUS_1d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Red Knight-Int 13, Cha 10, Longsword, 3
                    else if(GetHasFeat(DEITY_Red_Knight,oPC) && iInt >=13 && iCha >=10 && iWeapType == BASE_ITEM_LONGSWORD && (iAlign == 3))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_SPOT,(iClericLvl)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_LISTEN,(iClericLvl)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Savras-Int 11, Dagger, 3
                    else if(GetHasFeat(DEITY_Savras,oPC) && iInt >=11 && iWeapType == BASE_ITEM_DAGGER && (iAlign == 3))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_BACKSTAB), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSeeInvisible(),oPC,TurnsToSeconds(5));
                    }
                    //Selune-Int 11, Heavy Mace, 2
                    else if(GetHasFeat(DEITY_Selune,oPC) && iInt >=11 && (iAlign == 2))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyEnhancementBonus(2), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_ELECTRICAL,IP_CONST_DAMAGEBONUS_1d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Shar-Str 14, Light Mace, 7
                    else if(GetHasFeat(DEITY_Shar,oPC) && iStr >=14 && iWeapType == BASE_ITEM_LIGHTMACE && (iAlign == 7))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,(IP_CONST_DAMAGEBONUS_1d6)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC))), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC))), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC))), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Sharess-Dex 10, Cha 13, Claw Bracer, 2,5
                    else if(GetHasFeat(DEITY_Sharess,oPC) && iDex >=10 && iCha >=13 && iWeapType == BASE_ITEM_BRACER && (iAlign == 2||iAlign == 5))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyCastSpell(IP_CONST_CASTSPELL_CHARM_MONSTER_10,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyAbilityBonus(ABILITY_DEXTERITY,1), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyAbilityBonus(ABILITY_CHARISMA,1), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Shaundakul-Str 13, Con 11, 2,5
                    else if(GetHasFeat(DEITY_Sharess,oPC) && iStr >=13 && iCon >=11 && iWeapType == BASE_ITEM_GREATSWORD && (iAlign == 2||iAlign == 5))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyCastSpell(IP_CONST_CASTSPELL_GUST_OF_WIND_10,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Siamorphe-Int 9, Cha 12, Light Mace, 3
                    else if(GetHasFeat(DEITY_Siamorphe,oPC) && iInt >=9 && iCha >=12 && iWeapType == BASE_ITEM_LIGHTMACE && (iAlign == 3))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyCastSpell(IP_CONST_CASTSPELL_REMOVE_FEAR_2,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(iClericLvl/3), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Sune-Cha 16, Whip, 2
                    else if(GetHasFeat(DEITY_Sune,oPC) && iCha >=16 && iWeapType == BASE_ITEM_WHIP && (iAlign == 2))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEBONUS_1d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyAbilityBonus(ABILITY_CHARISMA,(iClericLvl/6)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Talona-Con 14, Bandaged Gloves, 8
                    else if(GetHasFeat(DEITY_Talona,oPC) && iCon >=14 && iWeapType == BASE_ITEM_GLOVES && (iAlign == 8))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_POISON,(iClericLvl/3)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyOnHitCastSpell(IP_CONST_CASTSPELL_POISON_5,(iClericLvl)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Talos-Str 13, Spear, 8
                    else if(GetHasFeat(DEITY_Talos,oPC) && iStr >=13 && iWeapType == BASE_ITEM_SHORTSPEAR && (iAlign == 8))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_ELECTRICAL,(iClericLvl/3)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,10), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Tempus-Str 14, Battleaxe, 2,5,8
                    else if(GetHasFeat(DEITY_Tempus,oPC) && iStr >=14 && iWeapType == BASE_ITEM_BATTLEAXE && (iAlign == 2||iAlign == 5||iAlign == 8))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertySkillBonus(SKILL_DISCIPLINE,(iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Torm-Con 12, G.Sword, 0
                    else if(GetHasFeat(DEITY_Torm,oPC) && iCon >=12 && iWeapType == BASE_ITEM_GREATSWORD && (iAlign == 0))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,(IP_CONST_DAMAGEBONUS_1d6)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(iClericLvl/3), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Tymora-Dex 14, Throwing Stars, 2
                    else if(GetHasFeat(DEITY_Tymora,oPC) && iDex >=14 && iWeapType == BASE_ITEM_SHURIKEN && (iAlign == 2))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,(iClericLvl/3)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,(iClericLvl/3)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,(iClericLvl/3)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Tyr-Str 9, Longsword, 0
                    else if(GetHasFeat(DEITY_Tyr,oPC) && iStr >=9 && iWeapType == BASE_ITEM_LONGSWORD && (iAlign == 0))
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSeeInvisible(),oPC,TurnsToSeconds(iClericLvl));
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_DIVINE,(IP_CONST_DAMAGEBONUS_1d6)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Umberlee-Con 15, Spear, 8
                    else if(GetHasFeat(DEITY_Umberlee,oPC) && iCon >=15 && iWeapType == BASE_ITEM_SHORTSPEAR && (iAlign == 8))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING,(IP_CONST_DAMAGEBONUS_1d6)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Valkur-Str 14, Cha 12, Scimitar, 2
                    else if(GetHasFeat(DEITY_Valkur,oPC) && iStr >=14 && iCha >=12 && iWeapType == BASE_ITEM_SCIMITAR && (iAlign == 2))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,IP_CONST_DAMAGEBONUS_1d6), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Velsharoon-Int 11, Quarterstaff, 6,7,8
                    else if(GetHasFeat(DEITY_Velsharoon,oPC) && iInt >=11 && iWeapType == BASE_ITEM_QUARTERSTAFF && (iAlign == 6||iAlign == 7||iAlign == 8))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyVampiricRegeneration((iClericLvl/2)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                    }
                    //Xvim-Str 12, Scimitar, 6 +2 AB vs Chaotic +2 Damage vs Chaotic
                    else if(GetHasFeat(DEITY_Xvim,oPC) && iStr >=12 && iWeapType == BASE_ITEM_MORNINGSTAR && (iAlign == 6))
                    {
                        IPSafeAddItemProperty(oItem, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,(IP_CONST_DAMAGEBONUS_1d6)), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE,(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC))), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX,(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC))), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);
                        IPSafeAddItemProperty(oItem, ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC))), 0.0, X2_IP_ADDPROP_POLICY_KEEP_EXISTING,TRUE);

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


int DNDAlignment(object oPC)
{
  int i;
  if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_GOOD) {
    switch(GetAlignmentLawChaos(oPC)) {
      case ALIGNMENT_LAWFUL:    i=0;                             break;
      case ALIGNMENT_NEUTRAL:   i=1;                             break;
      case ALIGNMENT_CHAOTIC:   i=2;                             break;
    }
  }
  if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_NEUTRAL) {
    switch(GetAlignmentLawChaos(oPC)) {
      case ALIGNMENT_LAWFUL:    i=3;                             break;
      case ALIGNMENT_NEUTRAL:   i=4;                             break;
      case ALIGNMENT_CHAOTIC:   i=5;                             break;
    }
  } else if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_EVIL) {
    switch(GetAlignmentLawChaos(oPC)) {
      case ALIGNMENT_LAWFUL:    i=6;                             break;
      case ALIGNMENT_NEUTRAL:   i=7;                             break;
      case ALIGNMENT_CHAOTIC:   i=8;                             break;
    }
  }
  return i;
}
