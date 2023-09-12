//::///////////////////////////////////////////////
//:: Example XP2 OnItemEquipped
//:: x2_mod_def_equ
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnEquip Event
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified On: April 15th, 2008
//:: Added Support for Mounted Archery Feat penalties
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "x2_inc_intweapon"
#include "x3_inc_horse"
#include "x2_inc_itemprop"
#include "nwnx_item"

void main()
{

    object oItem = GetPCItemLastEquipped();
    object oPC   = GetPCItemLastEquippedBy();
    object oArmor;
    effect eVisual = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eChangingarmor = EffectCutsceneImmobilize();
    effect eArmorpen;
    float fTime;
    int nType = GetBaseItemType(oItem);
    int nNetAC;
    int nBonus;
    int nBaseAC;
    int nArmorCatagory;
    int nMaterial;
    object oDataObject = GetItemPossessedBy(oPC,"PC_Data_Object");
    int nPiety = GetLocalInt(oDataObject,"nPiety");
    ////////////////////////////////ATTUNEMENT CHECKS////////////////////////////////////////////////////////
    int nAttunementSlotsUsed = 0;
    int nMaxAttunement = 3;
    if (GetLevelByClass(57, oPC) >= 20)
    { nMaxAttunement = 6; }
    else if (GetLevelByClass(57, oPC) >= 15)
    { nMaxAttunement = 5; }
    else if (GetLevelByClass(57, oPC) >= 10)
    { nMaxAttunement = 4; }
    int nSlot = 0;
    object oEquipped;
    while (nSlot <18)
    {
    oEquipped = GetItemInSlot(nSlot, oPC);
    if ((GetLocalInt(oEquipped, "AccessoryCap") > 3) || (GetLocalInt(oEquipped, "WeaponCap") > 3) || (GetLocalInt(oEquipped, "ArmorCap") > 3)) {nAttunementSlotsUsed++;}
    if (nAttunementSlotsUsed > nMaxAttunement) {DelayCommand(0.1f, AssignCommand(oPC, ActionUnequipItem(oItem))); return; }
    nSlot++;
    }
    ////////////////////////////////ONE-ARM CHECKS//////////////////////////////////////////////////////////
    if (GetHasFeat(2000, oPC))
    {
        if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC) ) )
        {
            DelayCommand(0.1f, AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC))));
            SendMessageToPC(oPC, "You cannot have any items in your left hand.");
        }
        if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC) ) )
        {
            DelayCommand(0.1f, AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC))));
            SendMessageToPC(oPC, "You cannot use a left ring.");
        }
    }

    ////////////////////////////////////////////////////////////////////////////////
    //All of these next 5 values can be altered to fit the tastes of the builder.
    //I chose these numbers for play balance, but if you go by the book, it should
    //take a player more like 40 rounds to don the heavier armors, and that's
    //with help!  =D
    //
    //The following values determine the number of rounds required to don armor:
    //Remember, 1 round always = 6 seconds, regardless of module time settings.
    ////////////////////////////////////////////////////////////////////////////////
    int nLightarmor = 1;
    int nMedarmor = 2;
    int nHevarmor = 4;
    //These are the values (in percent) that movement is decreased by the wearer:
    int nMedpenalty = 5;
    int nHevpenalty = 10;
    ////////////////////////////////////*CODE*//////////////////////////////////////
    if(!GetIsDM(oPC) || GetHitDice(oPC) != 1 || !GetHasEffect(EFFECT_TYPE_POLYMORPH,oPC))
    {
        if(GetLocalInt(oItem,"HolyAvenger") == 1)
        {
            if(GetLevelByClass(CLASS_TYPE_BLACKCOAT,oPC) >1 || GetLevelByClass(CLASS_TYPE_PALADIN,oPC) > 1 || GetLevelByClass(CLASS_TYPE_DIVINECHAMPION,oPC) >1)
            {
                if(nPiety >= 80)
                {
                    SendMessageToPC(oPC, "You feel the power of your deity surge through the weapon as you unsheath it.");
                    IPSafeAddItemProperty(oItem, ItemPropertyVisualEffect(ITEM_VISUAL_HOLY), 0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,TRUE,TRUE );
                }
                else if(nPiety < 80 && nPiety >= 40)
                {
                    IPRemoveMatchingItemProperties(oItem, ITEM_PROPERTY_VISUALEFFECT,DURATION_TYPE_PERMANENT,-1);
                    SendMessageToPC(oPC, "The power of your deity is with you, though not as strongly as before. Your deeds are not in accordance with your vows.");
                }
                else
                {
                    SendMessageToPC(oPC,"This weapon seems to resist your attempts to equip it. Your deeds are not in accordance with your vows.");
                    AssignCommand(oPC, ActionUnequipItem(oItem));
                }
            }
            else
            {
                SendMessageToPC(oPC,"This weapon seems to resist your attempts to equip it.");
                AssignCommand(oPC, ActionUnequipItem(oItem));
            }
        }


        switch(nType)
        {
            case BASE_ITEM_ARMOR:
            if(GetLocalInt(oPC, "X2_L_CRAFT_MODIFY_MODE") == TRUE) // Kick out of the script if the PC is using the armor appearance
            {
                return;                                            // mode for customizing armor in HotU
            }
            oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
            nBaseAC = NWNX_Item_GetBaseArmorClass(oArmor);
            nMaterial = GetLocalInt(oArmor, "Material");

            if(nBaseAC > 0 && nBaseAC < 4)
            {
                nArmorCatagory = 1;
            }
            else if(nBaseAC > 3 && nBaseAC < 6)
            {
                nArmorCatagory = 2;
            }
            else if(nBaseAC > 5)
            {
                nArmorCatagory = 3;
            }

            if(GetLevelByClass(CLASS_TYPE_DRUID,oPC) >= 1 && GetLevelByClass(CLASS_TYPE_BLIGHTER,oPC) < 1)
            {
                if(nMaterial >= 1 && nMaterial <= 4)
                {
                    if(GetHasFeat(1354,oPC) != TRUE && GetLocalInt(oItem,"Ankheg") != 1 && GetLocalInt(oItem,"Ironwood") != 1)
                    {
                        SetLocalInt(oDataObject,"nPiety",nPiety-25);
                        SendMessageToPC(oPC,"Wearing metal armor causes druids to become distant from their vows...");
                    }
                }
            }

            if(nMaterial == 3)
            {
                nArmorCatagory = nArmorCatagory - 1;
            }

            switch(nArmorCatagory)
            {
                default:
                    FloatingTextStringOnCreature("Wearing clothes.", oPC, TRUE); //Tell the PC.
                    break;

                case 1:
                    fTime = RoundsToSeconds(nLightarmor);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChangingarmor, oPC, fTime);  //Freeze the PC.
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisual, oPC, fTime);   //Play an effect.
                    AssignCommand(oPC, DelayCommand(2.0, ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, fTime-2.0))));
                    FloatingTextStringOnCreature("*Donning this armor will take "+IntToString(nLightarmor)+" rounds*", oPC, TRUE); //Tell the PC how long it will take.
                    DelayCommand(fTime, FloatingTextStringOnCreature("*Donned light armor*", oPC, TRUE));  //Finished donning.
                    break;

                case 2:
                    fTime = RoundsToSeconds(nMedarmor);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChangingarmor, oPC, fTime);  //Freeze the PC.
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisual, oPC, fTime);  //Play an effect.
                    AssignCommand(oPC, DelayCommand(2.0, ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, fTime-2.0))));
                    FloatingTextStringOnCreature("*Donning this armor will take "+IntToString(nMedarmor)+" rounds*", oPC, TRUE); //Tell the PC how long it will take.
                    if(GetRacialType(oPC) != RACIAL_TYPE_DWARF)
                    {
                        eArmorpen = EffectMovementSpeedDecrease(nMedpenalty);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eArmorpen), oPC);
                    }
                    DelayCommand(fTime, FloatingTextStringOnCreature("*Donned medium armor*", oPC, TRUE));  //Finished donning.
                    break;

                case 3:
                    fTime = RoundsToSeconds(nHevarmor);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChangingarmor, oPC, fTime);   //Freeze the PC.
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVisual, oPC, fTime);   //Play an effect.
                    AssignCommand(oPC, DelayCommand(2.0, ActionDoCommand(ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, fTime-2.0))));
                    FloatingTextStringOnCreature("*Donning this armor will take "+IntToString(nHevarmor)+" rounds*", oPC, TRUE); //Tell the PC how long it will take.
                    if(GetRacialType(oPC) != RACIAL_TYPE_DWARF)
                    {
                        eArmorpen = EffectMovementSpeedDecrease(nHevpenalty);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eArmorpen), oPC);
                    }
                    DelayCommand(fTime, FloatingTextStringOnCreature("*Donned heavy armor*", oPC, TRUE)); //Finished donning.
                    break;
            }
            break;

            ////////////////////////////////////////////////////////////////////////////////
            // You can even take this whole system a bit farther by having effects occur when
            // players equip shields/helms, such as freezing them to don, etc. I removed all
            // my custom effects for the purposes of this public script, but left the switches
            // just to give creative DM/builders ideas. For instance you could make players
            // pause a few seconds to put on a helm, or equip a shield.
            ////////////////////////////////////////////////////////////////////////////////
            case BASE_ITEM_HELMET:
            //FloatingTextStringOnCreature("*Equipping helm*", oPC, TRUE);   //Debug
            break;

            case BASE_ITEM_SMALLSHIELD:
            //FloatingTextStringOnCreature("*Equipping small shield*", oPC, TRUE); //Debug
            break;

            case BASE_ITEM_LARGESHIELD:
            //FloatingTextStringOnCreature("*Equipping large shield*", oPC, TRUE); //Debug
            break;

            case BASE_ITEM_TOWERSHIELD:
            //FloatingTextStringOnCreature("*Equipping shield*", oPC, TRUE); //Debug
            break;
        }
    }





    // -------------------------------------------------------------------------
    // Intelligent Weapon System
    // -------------------------------------------------------------------------
    if (IPGetIsIntelligentWeapon(oItem))
    {
        IWSetIntelligentWeaponEquipped(oPC,oItem);
        // prevent players from reequipping their weapon in
        if (IWGetIsInIntelligentWeaponConversation(oPC))
        {
                object oConv =   GetLocalObject(oPC,"X2_O_INTWEAPON_SPIRIT");
                IWEndIntelligentWeaponConversation(oConv, oPC);
        }
        else
        {
            //------------------------------------------------------------------
            // Trigger Drain Health Event
            //------------------------------------------------------------------
            if (GetLocalInt(oPC,"X2_L_ENSERRIC_ASKED_Q3")==1)
            {
                ExecuteScript ("x2_ens_dodrain",oPC);
            }
            else
            {
                IWPlayRandomEquipComment(oPC,oItem);
            }
        }
    }

    // -------------------------------------------------------------------------
    // Mounted benefits control
    // -------------------------------------------------------------------------
    if (GetWeaponRanged(oItem))
    {
        SetLocalInt(oPC,"bX3_M_ARCHERY",TRUE);
        HORSE_SupportAdjustMountedArcheryPenalty(oPC);
    }

    // -------------------------------------------------------------------------
    // Black Powder Gun Hak weapon and ammunition testing
    // -------------------------------------------------------------------------
       object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
       object oAmmunition = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
       int nBulletSlot = INVENTORY_SLOT_BULLETS;
       int nGunTest;            // is this a gun?
       int nGunBulletTest;      // is this ammunition for a gun?
       int nGunWasLoaded;       // is this gun loaded already?
       int nAmmoLoaded;         // is appropriate ammo loaded?
       int nNPCBullet;          // only NPCs can load this ammo
       int nWeaponType = GetBaseItemType(oWeapon);

       // get remaining variables defining guns and ammunition
          nGunTest = GetLocalInt(oWeapon, "nGun");
          nGunBulletTest = GetLocalInt(oAmmunition, "nGunBullet");
          nGunWasLoaded = GetLocalInt(oWeapon, "nLoadStatus");
          nAmmoLoaded = GetIsObjectValid(oAmmunition);
          nNPCBullet = GetLocalInt(oAmmunition, "nNPCBullet");

       // make sure that weapon and ammunition match

        if (nNPCBullet == 1)
        {
          AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(nBulletSlot, oPC)));
          AssignCommand(oPC, ActionUnequipItem(oWeapon));
          SendMessageToPC(oPC, "Those bullets don't fit your weapon.");
        }

        else if ((nGunTest != 1) && (nGunWasLoaded == 0) && (nGunBulletTest == 1))
        {
          AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(nBulletSlot, oPC)));
          SendMessageToPC(oPC, "You don't have a firearm ready.");
        }

        else if ((nGunTest == 1) && (nGunWasLoaded == 0) && (nAmmoLoaded == FALSE))
        {
          SendMessageToPC(oPC, "Your gun isn't loaded.");
        }

        else if ((nGunTest == 1) && (nGunWasLoaded == 0) && (nGunBulletTest != 1))
        {
          AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(nBulletSlot, oPC)));
          AssignCommand(oPC, ActionUnequipItem(oWeapon));
          SendMessageToPC(oPC, "Your gun won't fire that ammunition.");
        }

        else if ((nGunTest != 1) && (nGunWasLoaded == 1) && (nGunBulletTest == 1))
        {
          SetLocalInt(oWeapon, "nLoadStatus", 0);
          AssignCommand(oPC, ActionEquipMostDamagingMelee());
        }

        else if ((nGunTest == 1) && (nGunWasLoaded == 1) && (nGunBulletTest != 1))
        {
          SetLocalInt(oWeapon, "nLoadStatus", 0);
          AssignCommand(oPC, ActionEquipMostDamagingMelee());
        }

        else SetLocalInt(oWeapon, "nLoadStatus", 1);

    // -------------------------------------------------------------------------
    // End of Black Powder Guns code
    // -------------------------------------------------------------------------


    // -------------------------------------------------------------------------
    // Generic Item Script Execution Code
    // If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
    // it will execute a script that has the same name as the item's tag
    // inside this script you can manage scripts for all events by checking against
    // GetUserDefinedItemEventNumber(). See x2_it_example.nss
    // -------------------------------------------------------------------------

    if(GetLevelByClass(53, oPC) >= 1)
    {
        if(GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC)) == "te_bladesong" && GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC) != OBJECT_INVALID)
        {
            IPRemoveAllItemProperties(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC),DURATION_TYPE_PERMANENT);
        }
    }
    if(GetLevelByClass(58, oPC) >= 7)
    {
        object oRightHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
        if(oRightHand != OBJECT_INVALID)
        {
            itemproperty iHit = ItemPropertyOnHitCastSpell(146, 1);
            itemproperty iConcentrationDecrease = TagItemProperty(iHit, "MageBreaker");
            IPSafeAddItemProperty(oRightHand, iConcentrationDecrease);
        }
    }

    if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
    {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_EQUIP);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
            return;
        }
    }

}
