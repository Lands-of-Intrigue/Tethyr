#include "nwnx_damage"
#include "nwnx_creature"
#include "te_functions"
#include "x2_inc_itemprop"
#include "inc_sqlite_time"
#include "nw_i0_spells"
// sets oPC's current hitpoints to value of nHP - [FILE: _inc_util]
void SetHitPoints(object oPC, int nHP);
void Mythic(object oTarget, struct NWNX_Damage_DamageEventData data);

void SetHitPoints(object oPC, int nHP)
{
    if(!GetIsObjectValid(oPC))
        return;

    // non-NWNX solution
    int nMaxHP      = GetMaxHitPoints(oPC);
    int nCurrentHP  = GetCurrentHitPoints(oPC);
    int nChange     = nHP - nCurrentHP;

    if (nHP<1)
    {
        // kill the PC. They logged out near death so they would be dead by now anyway
        nChange = nMaxHP+10;
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nChange, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY), oPC);
    }
    else if (nChange == 0)
        return; // don't need to do anything
    else if (nChange < 0)
    {
        // we need to damage oPC
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(abs(nChange), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY), oPC);
    }
    else
    {
        // we need to heal oPC
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(abs(nChange)), oPC);
        if(nMaxHP<nHP)
        {
            // We need to give additional temporary hitpoints to the oPC
            nChange = nHP - nMaxHP;
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectTemporaryHitpoints(abs(nChange)), oPC);
        }
    }
}

void Mythic(object oTarget, struct NWNX_Damage_DamageEventData data)
{
    // CON Mythic XP on damage take
    if (GetIsPC(oTarget))
    {
        int iCon = GetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"MythicCON");
        SetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"MythicCON", iCon+1);
        if (
        iCon + 1 == 1000 ||
        iCon + 1 == 2000 ||
        iCon + 1 == 3000 ||
        iCon + 1 == 4000 ||
        iCon + 1 == 8000 )
        {
            NWNX_Creature_SetRawAbilityScore(oTarget, ABILITY_CONSTITUTION, NWNX_Creature_GetRawAbilityScore(oTarget, ABILITY_CONSTITUTION)+1);
        }
    }
    if (GetIsPC(data.oDamager))
    {
        int iRight = GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, data.oDamager));
        if (
            iRight == BASE_ITEM_HEAVYCROSSBOW ||
            iRight == BASE_ITEM_LIGHTCROSSBOW ||
            iRight == BASE_ITEM_SLING ||
            iRight == BASE_ITEM_SHORTBOW ||
            iRight == BASE_ITEM_LONGBOW ||
            iRight == BASE_ITEM_GRENADE)
        {

            int iDex = GetLocalInt(GetItemPossessedBy(data.oDamager,"PC_Data_Object"),"MythicDEX");
            SetLocalInt(GetItemPossessedBy(data.oDamager,"PC_Data_Object"),"MythicDEX", iDex+1);
            if (
            iDex + 1 == 1000 ||
            iDex + 1 == 2000 ||
            iDex + 1 == 3000 ||
            iDex + 1 == 4000 ||
            iDex + 1 == 8000 )
            {
                NWNX_Creature_SetRawAbilityScore(data.oDamager, ABILITY_DEXTERITY, NWNX_Creature_GetRawAbilityScore(data.oDamager, ABILITY_DEXTERITY)+1);
            }
        }
        else
        {
            int iStr = GetLocalInt(GetItemPossessedBy(data.oDamager,"PC_Data_Object"),"MythicSTR");
            SetLocalInt(GetItemPossessedBy(data.oDamager,"PC_Data_Object"),"MythicSTR", iStr+1);
            if (
            iStr + 1 == 1000 ||
            iStr + 1 == 2000 ||
            iStr + 1 == 3000 ||
            iStr + 1 == 4000 ||
            iStr + 1 == 8000 )
            {
                NWNX_Creature_SetRawAbilityScore(data.oDamager, ABILITY_STRENGTH, NWNX_Creature_GetRawAbilityScore(data.oDamager, ABILITY_STRENGTH)+1);
            }
        }
    }
}

void main()
{
    struct NWNX_Damage_DamageEventData data;

    //Get all the data of the damage event
    data = NWNX_Damage_GetDamageEventData();

    object oDamager = data.oDamager;
    object oTarget = OBJECT_SELF;
    object oItem;
    int nDice = d20(1);

    if(GetLocalInt(oDamager,"nDivineSacrifice") == TRUE)
    {
        data.iBase = data.iBase + d6(5);
        SetLocalInt(oDamager,"nDivineSacrifice",FALSE);
    }

    int     iGhostWeapon   = 0;
    int     iSilverWeapon  = 0;
    int     iAdamantWeapon = 0;
    int     iGhostArmor    = 0;
    int     nGoodWeap      = 0;
    int     nEvilWeap      = 0;
    int     nLawWeap       = 0;
    int     nChaosWeap     = 0;
    int     nColdWeap      = 0;
    int     nDisruption    = 0;
    int     nSunblade      = 0;

    //Attacker Data
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oDamager);
    int    iWeapon = GetIsObjectValid(oWeapon);

    object oGloves = GetItemInSlot(INVENTORY_SLOT_ARMS,oDamager);
    int    iGloves = GetIsObjectValid(oGloves);
    int    iGloveType = 256;

    if(iGloves == TRUE)
    {
        iGloveType = GetBaseItemType(oGloves);
    }

    //Target Data
    int nGoodDR       = GetLocalInt(oTarget,"GoodDR");
    int nEvilDR       = GetLocalInt(oTarget,"EvilDR");
    int nLawDR        = GetLocalInt(oTarget,"LawDR");
    int nChaosDR      = GetLocalInt(oTarget,"ChaosDR");
    int nSilverDR     = GetLocalInt(oTarget,"SilverDR");
    int nColdDR       = GetLocalInt(oTarget,"ColdIronDR");
    int nAdamantineDR = GetLocalInt(oTarget,"AdamantineDR");

    //PC Creature specific DR
    if( GetIsObjectValid(GetItemPossessedBy(oTarget,"te_item_8043")) == TRUE ||
        NWNX_Creature_GetKnowsFeat(oTarget,BACKGROUND_NAT_LYCAN) == TRUE ||
        GetIsObjectValid(GetItemPossessedBy(oTarget,"te_item_8009")) == TRUE)
    {
        //SendMessageToPC(oTarget,"Debug: Receiving 10 DR from racial benefits.");
        nSilverDR += 10;
    }

    if(GetLevelByClass(CLASS_TYPE_WARLOCK,oTarget) == TRUE ||
       NWNX_Creature_GetKnowsFeat(oTarget,1186) == TRUE ||
       NWNX_Creature_GetKnowsFeat(oTarget,1187) == TRUE ||
       NWNX_Creature_GetKnowsFeat(oTarget,1458) == TRUE)
    {
        nColdDR += 5;
    }

    object oArmor  = GetItemInSlot(INVENTORY_SLOT_CHEST,oTarget);
    int    iArmor  = GetIsObjectValid(oArmor);

    object oShield = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget);
    int    iShield = GetIsObjectValid(oShield);

    object oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK,oTarget);
    int    iCloak = GetIsObjectValid(oCloak);

    object oAmulet = GetItemInSlot(INVENTORY_SLOT_NECK,oTarget);
    int    iAmulet = GetIsObjectValid(oAmulet);

    object oBracer = GetItemInSlot(INVENTORY_SLOT_ARMS,oTarget);
    int    iBracer = GetIsObjectValid(oBracer);
    int    iBraceType = 256;

    int nMaterial = GetLocalInt(oArmor, "Material");
    int nNetAC = GetItemACValue(oArmor);
    int nBonus = IPGetWeaponEnhancementBonus(oArmor, ITEM_PROPERTY_AC_BONUS);
    int nArmor = nNetAC - nBonus;

    if(nMaterial == 4)
    {
        if(nArmor == 4|| nArmor == 5)
        {
             nAdamantineDR += 2;
        }
        else
        {
            nAdamantineDR += 3;
        }
    }

    if(iBracer == TRUE)
    {
        iBraceType = GetBaseItemType(oBracer);
    }

    if(iArmor == TRUE)
    {
        if(GetLocalInt(oArmor,"GhostTouch") == 1) {iGhostArmor = iGhostArmor+1;}
    }

    if(iCloak == TRUE)
    {
        nGoodDR   += GetLocalInt(oCloak,"GoodDR");
        nEvilDR   += GetLocalInt(oCloak,"EvilDR");
        nLawDR    += GetLocalInt(oCloak,"LawDR");
        nChaosDR  += GetLocalInt(oCloak,"ChaosDR");
        nSilverDR += GetLocalInt(oCloak,"SilverDR");
        nColdDR   += GetLocalInt(oCloak,"ColdIronDR");
    }

    if(iAmulet == TRUE)
    {
        nGoodDR   += GetLocalInt(oAmulet,"GoodDR");
        nEvilDR   += GetLocalInt(oAmulet,"EvilDR");
        nLawDR    += GetLocalInt(oAmulet,"LawDR");
        nChaosDR  += GetLocalInt(oAmulet,"ChaosDR");
        nSilverDR += GetLocalInt(oAmulet,"SilverDR");
        nColdDR   += GetLocalInt(oCloak,"ColdIronDR");
    }

    if(iBracer == TRUE && iGloveType == BASE_ITEM_BRACER)
    {
        if(GetLocalInt(oArmor,"GhostTouch") == 1) {iGhostArmor = iGhostArmor+1;}
    }

    if(iShield == TRUE && MatchShield(oShield) == TRUE)
    {
        if(GetLocalInt(oArmor,"GhostTouch") == 1) {iGhostArmor = iGhostArmor+1;}
    }

    if(iWeapon == FALSE && iGloves == TRUE && iGloveType == BASE_ITEM_GLOVES)
    {
        //SendMessageToPC(oDamager,"DEBUG: Using gloves as main weapon.");
        if(GetLocalInt(oGloves,"GhostTouch") == 1) {iGhostWeapon  = 1;}
        if(GetLocalInt(oGloves,"Silvered") == 1)   {iSilverWeapon = 1;}
        if(GetLocalInt(oGloves,"Material") == 4)   {iAdamantWeapon = 1;}
        if(GetLocalInt(oGloves,"Good") == 1)       {nGoodWeap = 1;}
        if(GetLocalInt(oGloves,"Evil") == 1)       {nEvilWeap = 1;}
        if(GetLocalInt(oGloves,"Law") == 1)        {nLawWeap = 1;}
        if(GetLocalInt(oGloves,"Chaos") == 1)      {nChaosWeap = 1;}
        if(GetLocalInt(oGloves,"ColdIron") == 1)   {nColdWeap = 1;}
        if(GetLocalInt(oGloves,"Disruption") == 1) {nDisruption = 1;}
    }
    else if (iWeapon == TRUE)
    {
        //SendMessageToPC(oDamager,"DEBUG: Using an equipped weapon as main weapon.");
        if(GetLocalInt(oWeapon,"GhostTouch") == 1)  {iGhostWeapon = 1;}
        if(GetLocalInt(oWeapon,"Silvered") == 1)    {iSilverWeapon = 1;}
        if(GetLocalInt(oWeapon,"Material") == 4)    {iAdamantWeapon = 1;}
        if(GetLocalInt(oWeapon,"Vorpal") == 11)     {iGhostWeapon = 1; iSilverWeapon = 1;}
        if(GetLocalInt(oWeapon,"Good") == 1)        {nGoodWeap = 1;}
        if(GetLocalInt(oWeapon,"Evil") == 1)        {nEvilWeap = 1;}
        if(GetLocalInt(oWeapon,"Law") == 1)         {nLawWeap = 1;}
        if(GetLocalInt(oWeapon,"Chaos") == 1)       {nChaosWeap = 1;}
        if(GetLocalInt(oWeapon,"ColdIron") == 1)    {nColdWeap = 1;}
        if(GetLocalInt(oWeapon,"Disruption") == 1)  {nDisruption = 1;}
        if(GetLocalInt(oWeapon,"Sunblade") == 1)    {nSunblade = 1;}
    }

    if(iWeapon == FALSE && iGloves == FALSE)
    {
        //Natural Lycan // Vampire Check
        if(GetIsObjectValid(GetItemPossessedBy(oDamager,"te_item_8043")) == TRUE || NWNX_Creature_GetKnowsFeat(oDamager,BACKGROUND_NAT_LYCAN) == TRUE)
        {
            iSilverWeapon = 1;
        }
        /*
        if(GetItemPossessedBy(oDamager,"te_item_8043") != OBJECT_INVALID)
        {
            if(GetIsUndead(oTarget) != TRUE && GetRacialType(oTarget) != RACIAL_TYPE_CONSTRUCT)
            {
                if(GetLocalInt(oDamager,"nSlamTime") < NWNX_Time_GetTimeStamp())
                {
                    SetLocalInt(oDamager,"nSlamTime",NWNX_Time_GetTimeStamp()+6);
                    int nVampSave = 10+ (GetHitDice(oDamager)/2) + GetAbilityModifier(ABILITY_CHARISMA,oDamager);
                    if(FortitudeSave(oTarget,nVampSave,SAVING_THROW_TYPE_NEGATIVE,oDamager) == 0)
                    {
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectTemporaryHitpoints(10),oDamager);
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectNegativeLevel(2),oTarget);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY), oTarget);
                        SendMessageToPC(oDamager,"You feel the energy draining from your victim.");
                        SendMessageToPC(oTarget,"You feel your energy being drained.");
                        if(GetIsPC(oTarget) == TRUE && GetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"ShoonAfflic") == 0 && GetPCAffliction(oTarget) != 2)
                        {
                            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_EVIL_HELP),oTarget);
                            SetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"ShoonAfflic",3);
                            SendMessageToPC(oTarget,"You feel a darkness worm its way into you...");
                        }
                    }
                }
            }
        }
        */
    }

    if(nDice == 20)
    {
        oItem = OBJECT_INVALID;
    }
    else if (nDice <= 1 && nDice > 5)
    {
        oItem = GetItemInSlot(INVENTORY_SLOT_CHEST,oTarget);
    }
    else if (nDice <= 5 && nDice > 10)
    {
        oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget);
    }
    else if (nDice <= 10 && nDice > 12)
    {
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget);
    }
    else if (nDice <= 12 && nDice > 13)
    {
        oItem = GetItemInSlot(INVENTORY_SLOT_HEAD,oTarget);
    }
    else if (nDice <= 13 && nDice > 14)
    {
        oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS,oTarget);
    }
    else if (nDice <= 15 && nDice > 17)
    {
        oItem = GetItemInSlot(INVENTORY_SLOT_BELT,oTarget);
    }
    else if (nDice <= 17 && nDice > 19)
    {
        oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK,oTarget);
    }

    if(GetLocalInt(oDamager,"MonkStyle") == 1)
    {
        data.iFire = data.iFire + d4(1);
    }

    if(GetLocalInt(oDamager,"MonkStyle") == 3)
    {
        data.iNegative = data.iNegative + d6(1);
    }

    if(GetLocalInt(oDamager,"MonkStyle") == 4 || GetLocalInt(oDamager,"MonkStyle") == 5)
    {
        data.iMagical = data.iMagical + d4(1);
    }
    //SendMessageToPC(oDamager, "iBludgeoning: " + IntToString(data.iBludgeoning));
    //SendMessageToPC(oDamager, "iPierce: " + IntToString(data.iPierce));
    //SendMessageToPC(oDamager, "iSlash: " + IntToString(data.iSlash));
    //SendMessageToPC(oDamager, "iMagical: " + IntToString(data.iMagical));
   // SendMessageToPC(oDamager, "iAcid: " + IntToString(data.iAcid));
   // SendMessageToPC(oDamager, "iCold: " + IntToString(data.iCold));
   // SendMessageToPC(oDamager, "iDivine: " + IntToString(data.iDivine));
   // SendMessageToPC(oDamager, "iElectrical: " + IntToString(data.iElectrical));
   // SendMessageToPC(oDamager, "iFire: " + IntToString(data.iFire));
   // SendMessageToPC(oDamager, "iNegative: " + IntToString(data.iNegative));
   // SendMessageToPC(oDamager, "iPositive: " + IntToString(data.iPositive));
   // SendMessageToPC(oDamager, "iSonic: " + IntToString(data.iSonic));
   // SendMessageToPC(oDamager, "iBase: " + IntToString(data.iBase));

    //Special Damage Reduction Stuff
    int nStoneskinDR = GetLocalInt(oTarget,"nStoneskinDR");
    int nStoneskinTime = GetLocalInt(oTarget,"nStoneskinTime");
    int nProtArrowDR = GetLocalInt(oTarget,"nProtArrowDR");
    int nProtArrowTime = GetLocalInt(oTarget,"nProtArrowTime");
    int nTimeNow = SQLite_GetTimeStamp();

    if(nStoneskinDR > 0)
    {
        if(nTimeNow >= nStoneskinTime)
        {
            SetLocalInt(oTarget,"nStoneskinDR",0);
            RemoveEffectsFromSpell(oTarget, SPELL_STONESKIN);
            RemoveEffectsFromSpell(oTarget, SPELL_GREATER_STONESKIN);
        }
        else
        {
            if(data.iBase  >-1)
            {
                if(iAdamantWeapon  != 1)
                {
                    int nStoneSkinRed = 10;
                    if(data.iBase < 10)
                    {
                        nStoneSkinRed = data.iBase;
                    }

                    if(nStoneskinDR < 10)
                    {
                        nStoneSkinRed = nStoneskinDR;
                    }

                    data.iBase = data.iBase - nStoneSkinRed;
                    int nNewStoneSkinDR = nStoneskinDR-nStoneSkinRed;
                    if(nNewStoneSkinDR <= 0)
                    {
                        nNewStoneSkinDR = 0;
                        RemoveEffectsFromSpell(oTarget, SPELL_STONESKIN);
                        RemoveEffectsFromSpell(oTarget, SPELL_GREATER_STONESKIN);
                    }
                    SetLocalInt(oTarget,"nStoneskinDR",nNewStoneSkinDR);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(353),oTarget);
                    SendMessageToPC(oTarget,"Stoneskin Damage Reduction Absorbs "+IntToString(nStoneSkinRed)+" damage ("+IntToString(nNewStoneSkinDR)+" points remaining)");
                    SendMessageToPC(oDamager,"Damage Reduction Absorbs "+IntToString(nStoneSkinRed)+" damage");
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(354),oTarget);
                    SendMessageToPC(oTarget,"Stoneskin Damage Reduction Absorbs 0 Damage ("+IntToString(nStoneskinDR)+" points remaining)");
                    SendMessageToPC(oDamager,"Damage Reduction Absorbs 0 Damage");
                }
            }
        }
    }

    if(nProtArrowDR > 0 && GetWeaponRanged(oWeapon) == TRUE)
    {
        if(nTimeNow >= nProtArrowTime)
        {
            SetLocalInt(oTarget,"nProtArrowTime",0);
            RemoveEffectsFromSpell(oTarget, 998);
        }
        else
        {
            if(data.iBase  >-1)
            {
                if(GetItemHasItemProperty(oWeapon,ITEM_PROPERTY_ENHANCEMENT_BONUS) != TRUE)
                {
                    int nProtArrowRed = 10;
                    if(data.iBase < 10)
                    {
                        nProtArrowRed = data.iBase;
                    }

                    if(nProtArrowDR < 10)
                    {
                        nProtArrowRed = nProtArrowDR;
                    }
                    data.iBase = data.iBase - nProtArrowRed;
                    int nNewProtArrowDR = nProtArrowDR-nProtArrowRed;
                    if(nNewProtArrowDR <= 0)
                    {
                        nNewProtArrowDR = 0;
                        RemoveEffectsFromSpell(oTarget, 998);
                    }
                    SetLocalInt(oTarget,"nProtArrowDR",nNewProtArrowDR);
                    SendMessageToPC(oTarget,"Protection from Arrows Damage Reduction Absorbs "+IntToString(nProtArrowRed)+" damage ("+IntToString(nNewProtArrowDR)+" points remaining)");
                    SendMessageToPC(oDamager,"Damage Reduction Absorbs "+IntToString(nProtArrowRed)+" damage");
                }
                else
                {
                    SendMessageToPC(oTarget,"Protection from Arrows Damage Reduction Absorbs 0 Damage ("+IntToString(nProtArrowDR)+" points remaining)");
                    SendMessageToPC(oDamager,"Damage Reduction Absorbs 0 Damage");
                }
            }
        }
    }





    if(GetSubString(GetResRef(oTarget),0,10) == "te_fm_quas")
    {
        nGoodDR = 5;
    }

    //Set -1 to hide from the combat log.
    //Set 0 to have them report as 0.
    //Set positive numbers to change the damage values as we see fit.
    ////////////////////////////////////////////////////////////////////////////
    //Mythic
    Mythic(oTarget, data);


    ////////////////////////////////////////////////////////////////////////////
    //Trolls
    if(GetResRef(oTarget) == "te_mons6h" || GetAppearanceType(oTarget) == 2504 || GetTag(oTarget) == "te_hydra" || GetResRef(oTarget) == "te_mons6hb")
    {
        if(data.iBludgeoning > -1){data.iBludgeoning = -1;}
        if(data.iPierce > -1)     {data.iPierce      = -1;}
        if(data.iSlash > -1)      {data.iSlash       = -1;}
        if(data.iMagical > -1)    {data.iMagical     = -1;}
        if(data.iCold > -1)       {data.iCold        = -1;}
        if(data.iDivine > -1)     {data.iDivine      = -1;}
        if(data.iElectrical > -1) {data.iElectrical  = -1;}
        if(data.iNegative > -1)   {data.iNegative    = -1;}
        if(data.iPositive > -1)   {data.iPositive    = -1;}
        if(data.iSonic > -1)      {data.iSonic       = -1;}
        data.iBase = 0;
    }

    ////////////////////////////////////////////////////////////////////////////
    //Golems
    if(GetTag(oTarget) == "te_gol_flesh")
    {
        if(data.iElectrical > 0)
        {
            if(GetHasEffect(EFFECT_TYPE_SLOW,oTarget) == TRUE)
            {
                RemoveEffect(oTarget,EffectSlow());
            }

            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(data.iElectrical/3),oTarget);

            if(GetCurrentHitPoints(oTarget) == GetMaxHitPoints(oTarget))
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectTemporaryHitpoints(data.iElectrical/3),oTarget);
            }
            data.iElectrical = 0;
        }
        if(data.iFire > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSlow(),oTarget,RoundsToSeconds(d6(2)));
        }
        if(data.iCold > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSlow(),oTarget,RoundsToSeconds(d6(2)));
        }
    }

    if(GetTag(oTarget) == "te_gol_iron")
    {
        if(data.iElectrical > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSlow(),oTarget,RoundsToSeconds(d6(2)));
        }
        if(data.iFire > 0)
        {
            if(GetHasEffect(EFFECT_TYPE_SLOW,oTarget) == TRUE)
            {
                RemoveEffect(oTarget,EffectSlow());
            }

            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(data.iFire/3),oTarget);

            if(GetCurrentHitPoints(oTarget) == GetMaxHitPoints(oTarget))
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectTemporaryHitpoints(data.iFire/3),oTarget);
            }
            data.iFire = 0;
        }
    }

    if(GetTag(oTarget) == "te_gol_clay")
    {
        if(data.iAcid > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(data.iAcid/3),oTarget);
            if(GetCurrentHitPoints(oTarget) == GetMaxHitPoints(oTarget))
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectTemporaryHitpoints(data.iAcid/3),oTarget);
            }
            data.iAcid = 0;
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    //Elementals
    if(GetTag(oTarget) == "te_f_elemental")
    {
        if(data.iFire > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(data.iFire),oTarget);
            data.iFire = 0;
        }
    }

    if(GetTag(oTarget) == "te_c_elemental")
    {
        if(data.iCold > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(data.iCold),oTarget);
            data.iCold = 0;
        }
    }

    if(GetTag(oTarget) == "te_l_elemental")
    {
        if(data.iElectrical > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(data.iElectrical),oTarget);
            data.iElectrical = 0;
        }
    }

    if(GetTag(oTarget) == "te_a_elemental")
    {
        if(data.iAcid > 0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(data.iAcid),oTarget);
            data.iAcid = 0;
        }
    }

    //Disruption
    if(nSunblade  == 1 && GetIsUndead(oTarget) == TRUE)
    {
        if(data.iBludgeoning >=1)   {data.iBludgeoning = data.iBludgeoning*2;}
        if(data.iPierce >=1)        {data.iPierce      = data.iPierce*2;}
        if(data.iSlash >=1)         {data.iSlash       = data.iSlash*2;}
        if(data.iMagical >=1)       {data.iMagical     = data.iMagical*2;}
        if(data.iCold >=1)          {data.iCold        = data.iCold*2;}
        if(data.iDivine >=1)        {data.iDivine      = data.iDivine*2;}
        if(data.iElectrical >=1)    {data.iElectrical  = data.iElectrical*2;}
        if(data.iNegative >=1)      {data.iNegative    = data.iNegative*2;}
        if(data.iPositive >=1)      {data.iPositive    = data.iPositive*2;}
        if(data.iSonic >=1)         {data.iSonic       = data.iSonic*2;}
        if(data.iFire  =1)          {data.iFire        = data.iFire*2;}
        if(data.iAcid >=1)          {data.iAcid        = data.iAcid*2;}
        if(data.iBase  >=1)         {data.iBase        = data.iBase*2;}
    }

    ////////////////////////////////////////////////////////////////////////////
    //Noncorporeal
    if(GetLocalInt(oTarget,"X2_L_IS_INCORPOREAL") == 1)
    {
        if(iGhostWeapon != 1 )
        {
            if(d2(1) == 1)
            {
                SendMessageToPC(oDamager,"Your attack passes through the creature with no effect!");
                if(data.iBludgeoning > -1){data.iBludgeoning = 0;}
                if(data.iPierce > -1)     {data.iPierce      = 0;}
                if(data.iSlash > -1)      {data.iSlash       = 0;}
                if(data.iMagical > -1)    {data.iMagical     = 0;}
                if(data.iCold > -1)       {data.iCold        = 0;}
                if(data.iDivine > -1)     {data.iDivine      = 0;}
                if(data.iElectrical > -1) {data.iElectrical  = 0;}
                if(data.iNegative > -1)   {data.iNegative    = 0;}
                if(data.iPositive > -1)   {data.iPositive    = 0;}
                if(data.iSonic > -1)      {data.iSonic       = 0;}
                if(data.iFire > -1)       {data.iFire        = 0;}
                if(data.iAcid > -1)       {data.iAcid        = 0;}
                if(data.iBase  >-1)       {data.iBase        = 0;}
            }
        }
    }

    if(GetLocalInt(oDamager,"X2_L_IS_INCORPOREAL") == 1 )
    {
        if(iGhostArmor == 1)
        {
            if(d2(1) == 1)
            {
                SendMessageToPC(oDamager,"You manage to stop the creature's attack with your ghost touched armor!");
                if(data.iBludgeoning > -1){data.iBludgeoning = 0;}
                if(data.iPierce > -1)     {data.iPierce      = 0;}
                if(data.iSlash > -1)      {data.iSlash       = 0;}
                if(data.iMagical > -1)    {data.iMagical     = 0;}
                if(data.iCold > -1)       {data.iCold        = 0;}
                if(data.iDivine > -1)     {data.iDivine      = 0;}
                if(data.iElectrical > -1) {data.iElectrical  = 0;}
                if(data.iNegative > -1)   {data.iNegative    = 0;}
                if(data.iPositive > -1)   {data.iPositive    = 0;}
                if(data.iSonic > -1)      {data.iSonic       = 0;}
                if(data.iFire > -1)       {data.iFire        = 0;}
                if(data.iAcid > -1)       {data.iAcid        = 0;}
                if(data.iBase  >-1)       {data.iBase        = 0;}
            }
        }
    }

    //Disruption
    if(nDisruption == 1 && GetIsUndead(oTarget) == TRUE && data.iBase > 0)
    {
        if(WillSave(oTarget,14,SAVING_THROW_TYPE_DIVINE,oDamager)==0)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(1937),oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(TRUE,TRUE),oTarget);
        }
    }

    /* Removed and made irrelevant by DR shift change to mimic Evil/Good/Law/Chaos 11/02/19
    if( (GetItemPossessedBy(oTarget,"te_item_8043") != OBJECT_INVALID)|| (GetHasFeat(BACKGROUND_NAT_LYCAN,oTarget)) || GetRacialType(oTarget) == RACIAL_TYPE_SHAPECHANGER)
    {
       SendMessageToPC(oDamager,"DEBUG: You are attacking a special case.");
       SendMessageToPC(oTarget,"DEBUG: You are a special case.");
       if(iSilverWeapon == 0 && GetHasFeat(BACKGROUND_NAT_LYCAN,oDamager) != TRUE && GetRacialType(oDamager) != RACIAL_TYPE_SHAPECHANGER)
        {
            data.iBludgeoning = data.iBludgeoning - 10;
            data.iPierce = data.iPierce - 10;
            data.iSlash = data.iSlash - 10;
            data.iBase = data.iBase - 10;
            SendMessageToPC(oDamager,"You cannot damage your target with your currently equipped weapon!");
            SendMessageToPC(oTarget,"DEBUG: You are a special case and are receiving Silver DR 10.");
        }
    }
    */
    if(data.iBludgeoning > 0)
    {
        if(nAdamantineDR > 0 && iAdamantWeapon  != 1)
        {
            data.iBludgeoning = data.iBludgeoning - nAdamantineDR;
        }
        if((nGoodDR > 1)&&(nEvilWeap != 1))
        {
            data.iBludgeoning = data.iBludgeoning - nGoodDR;
        }
        if((nEvilDR > 1)&&(nGoodWeap != 1))
        {
            data.iBludgeoning = data.iBludgeoning - nEvilDR;
        }
        if((nLawDR > 1)&&(nChaosWeap != 1))
        {
            data.iBludgeoning = data.iBludgeoning - nLawDR;
        }
        if((nChaosDR > 1)&&(nLawWeap != 1))
        {
            data.iBludgeoning = data.iBludgeoning - nChaosDR;
        }
        if((nSilverDR > 1) &&(iSilverWeapon != 1))
        {
            data.iBludgeoning = data.iBludgeoning - nSilverDR;
        }
        if((nColdDR > 1) &&(nColdWeap != 1))
        {
            data.iBludgeoning = data.iBludgeoning - nColdDR;
        }
    }
    else if(data.iPierce > 0)
    {
        if(nAdamantineDR > 0 && iAdamantWeapon  != 1)
        {
            data.iPierce = data.iPierce - nAdamantineDR;
        }
        if((nGoodDR > 1)&&(nEvilWeap != 1))
        {
            data.iPierce = data.iPierce - nGoodDR;
        }
        if((nEvilDR > 1)&&(nGoodWeap != 1))
        {
            data.iPierce = data.iPierce - nEvilDR;
        }
        if((nLawDR > 1)&&(nChaosWeap != 1))
        {
            data.iPierce = data.iPierce - nLawDR;
        }
        if((nChaosDR > 1)&&(nLawWeap != 1))
        {
            data.iPierce = data.iPierce - nChaosDR;
        }
        if((nSilverDR > 1) &&(iSilverWeapon != 1))
        {
            data.iPierce = data.iPierce - nSilverDR;
        }
        if((nColdDR > 1) &&(nColdWeap != 1))
        {
            data.iPierce = data.iPierce - nColdDR;
        }
    }
    else if(data.iSlash > 0)
    {
        if(nMaterial == 4 && iAdamantWeapon  != 1)
        {
            if(nArmor == 4 || nArmor == 5)
            {data.iSlash = data.iSlash - 2; }
            if(nArmor > 5)
            {data.iSlash = data.iSlash - 3; }
        }

        if((nGoodDR > 1)&&(nEvilWeap != 1))
        {
            data.iSlash = data.iSlash - nGoodDR;
        }
        if((nEvilDR > 1)&&(nGoodWeap != 1))
        {
            data.iSlash = data.iSlash - nEvilDR;
        }
        if((nLawDR > 1)&&(nChaosWeap != 1))
        {
            data.iSlash = data.iSlash - nLawDR;
        }
        if((nChaosDR > 1)&&(nLawWeap != 1))
        {
            data.iSlash = data.iSlash - nChaosDR;
        }
        if((nSilverDR > 1) &&(iSilverWeapon != 1))
        {
            data.iSlash = data.iSlash - nSilverDR;
        }
        if((nColdDR > 1) &&(nColdWeap != 1))
        {
            data.iSlash = data.iSlash - nColdDR;
        }
    }
    else if(data.iMagical > 0){}
    else if(data.iAcid > 0)
    {
        int nAcidSave1 = FortitudeSave(oTarget,5+data.iAcid,SAVING_THROW_TYPE_ACID);
        if(nAcidSave1 == 0)
        {
            data.iAcid += d6(1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_ACID_S),oTarget);
        }
        if(data.iAcid > 5)
        {
            int nAcidSave2 = FortitudeSave(oTarget,5+data.iAcid,SAVING_THROW_TYPE_ACID);
            if(nAcidSave2 == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_CONSTITUTION,1),oTarget,RoundsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_ACID_S),oTarget);
            }

            int nAcidSave3 = FortitudeSave(oTarget,5+data.iAcid,SAVING_THROW_TYPE_ACID);
            if(nAcidSave3 == 0 && oItem != OBJECT_INVALID)
            {
                SetLocalInt(oItem,"Decay",GetLocalInt(oItem,"Decay")+1);
                SendMessageToPC(oTarget,GetName(oItem)+" seems to have been damaged by this attack.");
                if(GetLocalInt(oItem,"Decay") > 20)
                {
                    DestroyObject(oItem);
                    SendMessageToPC(oTarget,"You gasp in horror as your item disintegrates before your eyes.");
                }
            }
        }
        if(data.iAcid > 10)
        {

        }
    }
    else if(data.iCold > 0)
    {
        int nColdSave1 = FortitudeSave(oTarget,5+data.iCold,SAVING_THROW_TYPE_COLD);
        if(nColdSave1 == 0)
        {
            data.iCold += d6(1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_FROST_S),oTarget);
        }
        if(data.iCold > 5)
        {
            int nColdSave2 = FortitudeSave(oTarget,5+data.iCold,SAVING_THROW_TYPE_COLD);
            if(nColdSave2 == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_DEXTERITY,1),oTarget,RoundsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_FROST_S),oTarget);
            }
        }
        if(data.iCold > 10)
        {
            int nColdSave3 = FortitudeSave(oTarget,5+data.iCold,SAVING_THROW_TYPE_COLD);
            if(nColdSave3 == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSlow(),oTarget,RoundsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_FROST_S),oTarget);
            }
        }
    }
    else if(data.iElectrical > 0)
    {
        int nElecSave1 = ReflexSave(oTarget,5+data.iElectrical,SAVING_THROW_TYPE_ELECTRICITY);
        if(nElecSave1 == 0)
        {
            data.iElectrical += d6(1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_LIGHTNING_S),oTarget);
        }
        if(data.iElectrical > 5)
        {
            int nElecSave2 = ReflexSave(oTarget,5+data.iElectrical,SAVING_THROW_TYPE_ELECTRICITY);
            if(nElecSave2 == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectStunned(),oTarget,RoundsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_LIGHTNING_S),oTarget);
            }
        }
        if(data.iElectrical > 10)
        {
            int nElecSave3 = ReflexSave(oTarget,5+data.iElectrical,SAVING_THROW_TYPE_ELECTRICITY);
            if(nElecSave3 == 0 && (nArmor >= 4 && nMaterial != 3))
            {
                data.iElectrical += d6(1);
                SendMessageToPC(oTarget,"Electrical energy seems to conduct through your armor.");
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_LIGHTNING_S),oTarget);
            }
        }
    }
    else if(data.iFire > 0)
    {
        if(GetLevelByClass(49,oTarget) >= 1)
        {
            if(GetIsPC(oTarget) == TRUE)
            {
                SetLocalInt(GetItemPossessedBy(oTarget, "PC_Data_Object"),"nMana",(GetLocalInt(GetItemPossessedBy(oTarget, "PC_Data_Object"),"nMana")+1));
                if(GetLevelByClass(49,oTarget) >= 8)
                {
                    data.iFire -= 10;
                }
            }
        }

        int nFireSave1 = ReflexSave(oTarget,5+data.iFire,SAVING_THROW_TYPE_FIRE);
        if(nFireSave1 == 0)
        {
            data.iFire += d6(1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_FLAME_S),oTarget);
        }
        if(data.iFire > 5)
        {
            int nFireSave2 = ReflexSave(oTarget,5+data.iFire,SAVING_THROW_TYPE_FIRE);
            if(nFireSave2 == 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectBlindness(),oTarget,RoundsToSeconds(1));
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_FLAME_S),oTarget);
            }
        }
        if(data.iFire > 10)
        {
            int nFireSave3 = ReflexSave(oTarget,5+data.iFire,SAVING_THROW_TYPE_FIRE);
            if(nFireSave3 == 0 && nArmor < 4 )
            {
                data.iFire += d6(1);
                SendMessageToPC(oTarget,"Flames leap onto you briefly catching you on fire.");
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_FLAME_S),oTarget);
            }
        }
    }
    else if(data.iSonic > 0)
    {
        int nSonicSave = FortitudeSave(oTarget,data.iSonic+5, SAVING_THROW_TYPE_SONIC);
        if(nSonicSave == 0)
        {
            SendMessageToPC(oTarget,"The sound pains your ears and the world around you is silent for a time.");
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDeaf(),oTarget,TurnsToSeconds(1));

        }
    }
    else if(data.iDivine > 0)
    {
        if (GetIsUndead(oTarget) == 1)
        {
            if( (GetPCAffliction(oTarget) == 3) || (GetPCAffliction(oTarget) == 4) || (GetPCAffliction(oTarget) == 8) )
            {
                data.iDivine = (data.iDivine*2);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_HOLY_AID),oTarget);
            }
            else if (GetPCAffliction(oTarget) == 4)
            {
                data.iDivine = (data.iDivine*3);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_HOLY_AID),oTarget);
            }
        }
        else if (NWNX_Creature_GetKnowsFeat(oTarget,BACKGROUND_GREY_DWARF) == TRUE || NWNX_Creature_GetKnowsFeat(oTarget,BACKGROUND_DARK_ELF) == TRUE)
        {
            if(GetHasFeat(1407,oTarget) == FALSE)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectBlindness(),oTarget,RoundsToSeconds(1));
                SendMessageToPC(oTarget,"The light blinds you...");
            }
        }
    }
    else if(data.iNegative > 0)
    {
        if (GetIsUndead(oTarget) == 1)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectTemporaryHitpoints(data.iNegative/2),oTarget,TurnsToSeconds(10));
            data.iNegative = 0;
        }
        else
        {
            if(data.iNegative >= 15)
            {
                int nNegSave1 = FortitudeSave(oTarget,5+data.iNegative,SAVING_THROW_TYPE_DEATH);
                if(nNegSave1 == 0)
                {
                    if(GetIsPC(oTarget) == TRUE && GetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"ShoonAfflic") == 0 && GetPCAffliction(oTarget) != 2)
                    {
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_EVIL_HELP),oTarget);
                        SetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"ShoonAfflic",3);
                        SendMessageToPC(oTarget,"You feel a darkness worm its way into you...");
                        AddJournalQuestEntry("te_shoondisease",1,oTarget);
                    }
                }
            }
        }
    }
    else if(data.iPositive > 0){}
    else if(data.iBase > 0)
    {
        if(nAdamantineDR > 0 && iAdamantWeapon  != 1)
        {
            data.iBase = data.iBase - nAdamantineDR;
            SendMessageToPC(oTarget,"Adamantine Damage Reduction Absorbs "+IntToString(nAdamantineDR)+" damage");
            SendMessageToPC(oDamager,"Damage Reduction Absorbs "+IntToString(nAdamantineDR)+" damage");
        }

        if((nGoodDR > 1)&&(nEvilWeap != 1))
        {
            data.iBase = data.iBase - nGoodDR;
            SendMessageToPC(oTarget,"Good-Aligned Damage Reduction Absorbs "+IntToString(nGoodDR)+" damage");
            SendMessageToPC(oDamager,"Damage Reduction Absorbs "+IntToString(nGoodDR)+" damage");
        }
        if((nEvilDR > 1)&&(nGoodWeap != 1))
        {
            data.iBase = data.iBase - nEvilDR;
            SendMessageToPC(oTarget,"Evil-Aligned Damage Reduction Absorbs "+IntToString(nEvilDR)+" damage");
            SendMessageToPC(oDamager,"Damage Reduction Absorbs "+IntToString(nEvilDR)+" damage");
        }
        if((nLawDR > 1)&&(nChaosWeap != 1))
        {
            data.iBase = data.iBase - nLawDR;
            SendMessageToPC(oTarget,"Law-Aligned Damage Reduction Absorbs "+IntToString(nLawDR)+" damage");
            SendMessageToPC(oDamager,"Damage Reduction Absorbs "+IntToString(nLawDR)+" damage");
        }
        if((nChaosDR > 1)&&(nLawWeap != 1))
        {
            data.iBase = data.iBase - nChaosDR;
            SendMessageToPC(oTarget,"Chaos-Aligned Damage Reduction Absorbs "+IntToString(nChaosDR)+" damage");
            SendMessageToPC(oDamager,"Damage Reduction Absorbs "+IntToString(nChaosDR)+" damage");
        }
        if((nSilverDR > 1) &&(iSilverWeapon != 1))
        {
            data.iBase = data.iBase - nSilverDR;
            SendMessageToPC(oTarget,"Silver Damage Reduction Absorbs "+IntToString(nSilverDR)+" damage");
            SendMessageToPC(oDamager,"Damage Reduction Absorbs "+IntToString(nSilverDR)+" damage");
        }
        if((nColdDR > 1) &&(nColdWeap != 1))
        {
            data.iBase = data.iBase - nColdDR;
            SendMessageToPC(oTarget,"Cold Iron Damage Reduction Absorbs "+IntToString(nColdDR)+" damage");
            SendMessageToPC(oDamager,"Damage Reduction Absorbs "+IntToString(nColdDR)+" damage");
        }
    }

    if(GetObjectType(oDamager) == OBJECT_TYPE_CREATURE && GetIsDead(oTarget) != TRUE)
    {
        int nTotal = (data.iBludgeoning + data.iPierce + data.iSlash + data.iMagical + data.iCold + data.iDivine + data.iElectrical + data.iNegative + data.iPositive + data.iSonic + data.iBase);
        int nThresh = 25 + (GetHitDice(oTarget)*2) ;
        if(nTotal > nThresh)
        {
            if(GetLocalInt(oDamager,"SUBDUAL") == 0)
            {
                SendMessageToPC(oTarget,"Massive Damage!");
                SendMessageToPC(oDamager,"Massive Damage!");
                if(FortitudeSave(oTarget,20,SAVING_THROW_TYPE_DEATH) == 0)
                {
                    DelayCommand(0.2,SetHitPoints(oTarget,(GetMaxHitPoints(oTarget) - GetCurrentHitPoints(oTarget) - nTotal)));
                    SendMessageToPC(oTarget,"You succumb to the effects of Massive Damage. You are knocked out and bleeding!");
                }
                else
                {
                    SendMessageToPC(oTarget,"You resist the effects of Massive Damage.");
                }
            }
        }
    }

    if(GetLocalInt(oDamager,"SUBDUAL") == 1)
    {
        data.iBase = data.iBase/10;
    }

    if(data.iBludgeoning < 0){data.iBludgeoning = -1;}
    if(data.iPierce < 0)     {data.iPierce      = -1;}
    if(data.iSlash < 0)      {data.iSlash       = -1;}
    if(data.iMagical < 0)    {data.iMagical     = -1;}
    if(data.iCold < 0)       {data.iCold        = -1;}
    if(data.iDivine < 0)     {data.iDivine      = -1;}
    if(data.iElectrical < 0) {data.iElectrical  = -1;}
    if(data.iNegative < 0)   {data.iNegative    = -1;}
    if(data.iPositive < 0)   {data.iPositive    = -1;}
    if(data.iSonic < 0)      {data.iSonic       = -1;}


    Mythic(oTarget, data);
    //Push Results to Combat Log/Effects
    NWNX_Damage_SetDamageEventData(data);

}


