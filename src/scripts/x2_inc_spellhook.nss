//::///////////////////////////////////////////////
//::HSpellook Include File
//:: x2_inc_spellhook
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

    This file acts as a hub for all code that
    is hooked into the nwn spellscripts'

    If you want to implement material components
    into spells or add restrictions to certain
    spells, this is the place to do it.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-06-04
//:: Updated On: 2003-10-25
//:://////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified Date: January 15th-16th, 2008
//:://////////////////////////////////////////////
/*
    Modified to insure no shapeshifting spells are castable upon
    mounted targets.  This prevents problems that can occur due
    to dismounting after shape shifting, or other issues that can
    occur due to preserved appearances getting out of synch.

    This can additional check can be disabled by setting the variable
    X3_NO_SHAPESHIFT_SPELL_CHECK to 1 on the module object.  If this
    variable is set then this script will function as it did prior to
    this modification.

*/

//#include "x2_inc_itemprop" - Inherited from x2_inc_craft
#include "x2_inc_craft"
#include "x3_inc_horse"
#include "te_functions"
#include "sp_wild_func"
#include "nwnx_creature"


const int X2_EVENT_CONCENTRATION_BROKEN = 12400;

// Deadmagic zone
// this function will check if the caster is in a Deadmagic zone and
// to what degree the deadmagic affects the caster Shadow weave practitioners
// and Mystran specialty priests will be immune
int X2DeadmagicZone();

// Wildmagic zone
// This function will check for any wild magic effects and send calls to the
// wild magic tables based on that.
void X2WildMagicZone();

//Mythic XP Hookin for Wisdom and Intelligence.
//Gives 1 Mythic XP in a stat based on arcane
void X2MythicXP();

// Use Magic Device Check.
// Returns TRUE if the Spell is allowed to be cast, either because the
// character is allowed to cast it or he has won the required UMD check
// Only active on spell scroll
int X2UseMagicDeviceCheck();


// This function holds all functions that are supposed to run before the actual
// spellscript gets run. If this functions returns FALSE, the spell is aborted
// and the spellscript will not run
int X2PreSpellCastCode();


// check if the spell is prohibited from being cast on items
// returns FALSE if the spell was cast on an item but is prevented
// from being cast there by its corresponding entry in des_crft_spells
// oItem - pass GetSpellTargetObject in here
int X2CastOnItemWasAllowed(object oItem);

// Sequencer Item Property Handling
// Returns TRUE (and charges the sequencer item) if the spell
// ... was cast on an item AND
// ... the item has the sequencer property
// ... the spell was non hostile
// ... the spell was not cast from an item
// in any other case, FALSE is returned an the normal spellscript will be run
// oItem - pass GetSpellTargetObject in here
int X2GetSpellCastOnSequencerItem(object oItem);

int X2RunUserDefinedSpellScript();


void X2WildMagicZone()
{
   object oTarget = GetSpellTargetObject();
   int nSpell = GetSpellId();
   object oCaster = OBJECT_SELF;
   object oArea = GetArea(oCaster);
   int nWildChance = GetCampaignInt("Wildmagic",GetTag(oArea));
   if(nWildChance > 1 && ( (GetLevelByClass(CLASS_TYPE_DRUID, oCaster) >= 3) || (GetLevelByClass(CLASS_TYPE_RANGER, oCaster) >= 5) ))
   {
        SendMessageToPC(oCaster, "The weave has become strange and foreign here, magic may have additional unintended effects.");
   }
   if (GetLevelByClass(56, oCaster )>= 1)
   {
        SetCampaignInt("Wildmagic",GetTag(oArea), nWildChance - d8(1));
   }
   else if (GetLevelByClass(49, oCaster) >= 1 && d100(1) > 50)
   {
        SetCampaignInt("Wildmagic",GetTag(oArea), nWildChance + d8(1));
   }

   if(GetCampaignInt("Wildmagic",GetTag(oArea)) < 0)   {SetCampaignInt("Deadmagic",GetTag(oArea),0);}
   if(GetCampaignInt("Wildmagic",GetTag(oArea)) > 100) {SetCampaignInt("Deadmagic",GetTag(oArea),100);}

   if (d100(1) < nWildChance)
        WildMagicEffects(oCaster, oTarget);
}

int X2DeadmagicZone()
{
    object oCaster = OBJECT_SELF;
    object oArea = GetArea(oCaster);
    int nSpellFailure = GetCampaignInt("Deadmagic",GetTag(oArea));

    //  checking if the caster notises the damage to the weave
    if(nSpellFailure > 1 && (GetHasFeat(1586, oCaster)))
    {
       SendMessageToPC(oCaster, "You can sense serious distortions in the local Weave. Spells cast in this area are prone to failure.");
        if (nSpellFailure < 33) { SendMessageToPC(oCaster, "After further inspection, the weave is minorly damaged here."); }
        else if (nSpellFailure < 66) { SendMessageToPC(oCaster, "After further inspection, the weave is damaged to a significant degree here."); }
        else { SendMessageToPC(oCaster, "After further inspection, the weave here is extremely damaged, and will be difficult to repair"); }
    }

    // Mearly casting the spell will strenthen or weaken the weave.
    if (GetLevelByClass(48 , oCaster)  >=1)
    {
    SetCampaignInt("Deadmagic",GetTag(oArea), nSpellFailure + (TE_GetCasterLevel(oCaster, GetLastSpellCastClass())/4));
    }
    else if (GetHasFeat(1300, oCaster))
    {
        SetCampaignInt("Deadmagic",GetTag(oArea), nSpellFailure + (TE_GetCasterLevel(oCaster, GetLastSpellCastClass())/8));
    }
    else if(GetLevelByClass(56, oCaster)  >= 1)
    {
        SetCampaignInt("Deadmagic",GetTag(oArea), nSpellFailure - (TE_GetCasterLevel(oCaster, GetLastSpellCastClass())/4));
        //SetLocalInt(oArea, "Deadmagic", nSpellFailure - TE_GetCasterLevel(oCaster, GetLastSpellCastClass()));
    }
    else if(GetHasFeat(DEITY_Mystra, oCaster) && ( GetLevelByClass(CLASS_TYPE_CLERIC, oCaster)  >= 1 || GetLevelByClass(CLASS_TYPE_PALADIN, oCaster) >= 1))
    {
        SetCampaignInt("Deadmagic",GetTag(oArea), nSpellFailure - (TE_GetCasterLevel(oCaster, GetLastSpellCastClass())/6));
        //SetLocalInt(oArea, "Deadmagic", nSpellFailure - TE_GetCasterLevel(oCaster, GetLastSpellCastClass()));
    }
    else if(GetHasFeat(DEITY_Azuth, oCaster) && GetLevelByClass(CLASS_TYPE_PALADIN, oCaster) >= 1)
    {
        SetCampaignInt("Deadmagic",GetTag(oArea), nSpellFailure - ( TE_GetCasterLevel(oCaster, GetLastSpellCastClass()) / 8 ));
        //SetLocalInt(oArea, "Deadmagic", nSpellFailure - ( TE_GetCasterLevel(oCaster, GetLastSpellCastClass()) / 2 ));
    }
    else
    {
        SetCampaignInt("Deadmagic",GetTag(oArea),nSpellFailure - 1);
        //SetLocalInt(oArea, "Deadmagic", nSpellFailure - 1);
    }

    // making shure that Deadmagic is no less then 0 (full strength of the weave) or greater than 100 (100% spell falliure)
    if(GetCampaignInt("Deadmagic",GetTag(oArea)) < 0)   {SetCampaignInt("Deadmagic",GetTag(oArea),0);}
    if(GetCampaignInt("Deadmagic",GetTag(oArea)) > 100) {SetCampaignInt("Deadmagic",GetTag(oArea),100);}

    // roll for spell failliure
    if(d100() < nSpellFailure)
    {
        // check if caster has reason to ignore thise spell failliure if caster is shadow weave practitioner or Mystran cleric then they ignore it

    if(GetHasFeat(1300, oCaster)==TRUE ||
      (GetHasFeat(DEITY_Mystra, oCaster)==TRUE && ( GetLevelByClass(CLASS_TYPE_CLERIC, oCaster)  >= 1 || GetLevelByClass(CLASS_TYPE_PALADIN, oCaster) >= 1))
          )

        {
          return TRUE;
        }
        else
        {
            SendMessageToPC(oCaster, "The spell effect fails inexplicably. In order to learn more, you need to improve your knowledge of spellcraft.");
            return FALSE;
        }
    }
    return TRUE;
}

void X2MythicXP()
{
    if(GetIsPC(OBJECT_SELF))
    {
    object oPC = OBJECT_SELF;
        if(GetLastSpellCastClass() == 56)
        {
           if (d2(1) == 1)
           {
                int iInt = GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicINT");
                SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicINT", iInt+1);
                if (
                iInt + 1 == 1000 ||
                iInt + 1 == 2000 ||
                iInt + 1 == 4000 ||
                iInt + 1 == 8000 )
                {
                NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_INTELLIGENCE, NWNX_Creature_GetRawAbilityScore(oPC, ABILITY_INTELLIGENCE)+1);
                }
           }
           else
           {
                int iWis = GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicWIS");
                SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicWIS", iWis+1);
                if (
                iWis + 1 == 1000 ||
                iWis + 1 == 2000 ||
                iWis + 1 == 4000 ||
                iWis + 1 == 8000 )
                {
                NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_WISDOM, NWNX_Creature_GetRawAbilityScore(oPC, ABILITY_WISDOM)+1);
                }
           }
        }
        else if(TE_ArcaneCasterClass(GetLastSpellCastClass()))
        {
                int iInt = GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicINT");
                SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicINT", iInt+1);
                if (
                iInt + 1 == 1000 ||
                iInt + 1 == 2000 ||
                iInt + 1 == 4000 ||
                iInt + 1 == 8000 )
                {
                NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_INTELLIGENCE, NWNX_Creature_GetRawAbilityScore(oPC, ABILITY_INTELLIGENCE)+1);
                }
        }
        else
        {
                int iWis = GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicWIS");
                SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicWIS", iWis+1);
                if (
                iWis + 1 == 1000 ||
                iWis + 1 == 2000 ||
                iWis + 1 == 4000 ||
                iWis + 1 == 8000 )
                {
                NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_WISDOM, NWNX_Creature_GetRawAbilityScore(oPC, ABILITY_WISDOM)+1);
                }
        }
    }
}

int X2UseMagicDeviceCheck()
{
    int nRet = ExecuteScriptAndReturnInt("x2_pc_umdcheck",OBJECT_SELF);
    return nRet;
}

//------------------------------------------------------------------------------
// GZ: This is a filter I added to prevent spells from firing their original spell
// script when they were cast on items and do not have special coding for that
// case. If you add spells that can be cast on items you need to put them into
// des_crft_spells.2da
//------------------------------------------------------------------------------
int X2CastOnItemWasAllowed(object oItem)
{
    int bAllow = (Get2DAString(X2_CI_CRAFTING_SP_2DA,"CastOnItems",GetSpellId()) == "1");
    if (!bAllow)
    {
        FloatingTextStrRefOnCreature(83453, OBJECT_SELF); // not cast spell on item
    }
    return bAllow;

}

//------------------------------------------------------------------------------
// Execute a user overridden spell script.
//------------------------------------------------------------------------------
int X2RunUserDefinedSpellScript()
{
    // See x2_inc_switches for details on this code
    string sScript =  GetModuleOverrideSpellscript();
    if (sScript != "")
    {
        ExecuteScript(sScript,OBJECT_SELF);
        if (GetModuleOverrideSpellScriptFinished() == TRUE)
        {
            return FALSE;
        }
    }
    return TRUE;
}



//------------------------------------------------------------------------------
// Created Brent Knowles, Georg Zoeller 2003-07-31
// Returns TRUE (and charges the sequencer item) if the spell
// ... was cast on an item AND
// ... the item has the sequencer property
// ... the spell was non hostile
// ... the spell was not cast from an item
// in any other case, FALSE is returned an the normal spellscript will be run
//------------------------------------------------------------------------------
int X2GetSpellCastOnSequencerItem(object oItem)
{

    if (!GetIsObjectValid(oItem))
    {
        return FALSE;
    }

    int nMaxSeqSpells = IPGetItemSequencerProperty(oItem); // get number of maximum spells that can be stored
    if (nMaxSeqSpells <1)
    {
        return FALSE;
    }

    if (GetIsObjectValid(GetSpellCastItem())) // spell cast from item?
    {
        // we allow scrolls
        int nBt = GetBaseItemType(GetSpellCastItem());
        if ( nBt !=BASE_ITEM_SPELLSCROLL && nBt != 105)
        {
            FloatingTextStrRefOnCreature(83373, OBJECT_SELF);
            return TRUE; // wasted!
        }
    }

    // Check if the spell is marked as hostile in spells.2da
    int nHostile = StringToInt(Get2DAString("spells","HostileSetting",GetSpellId()));
    if(nHostile ==1)
    {
        FloatingTextStrRefOnCreature(83885,OBJECT_SELF);
        return TRUE; // no hostile spells on sequencers, sorry ya munchkins :)
    }

    int nNumberOfTriggers = GetLocalInt(oItem, "X2_L_NUMTRIGGERS");
    // is there still space left on the sequencer?
    if (nNumberOfTriggers < nMaxSeqSpells)
    {
        // success visual and store spell-id on item.
        effect eVisual = EffectVisualEffect(VFX_IMP_BREACH);
        nNumberOfTriggers++;
        //NOTE: I add +1 to the SpellId to spell 0 can be used to trap failure
        int nSID = GetSpellId()+1;
        SetLocalInt(oItem, "X2_L_SPELLTRIGGER" + IntToString(nNumberOfTriggers), nSID);
        SetLocalInt(oItem, "X2_L_NUMTRIGGERS", nNumberOfTriggers);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, OBJECT_SELF);
        FloatingTextStrRefOnCreature(83884, OBJECT_SELF);
    }
    else
    {
        FloatingTextStrRefOnCreature(83859,OBJECT_SELF);
    }

    return TRUE; // in any case, spell is used up from here, so do not fire regular spellscript
}

//------------------------------------------------------------------------------
// * This is our little concentration system for black blade of disaster
// * if the mage tries to cast any kind of spell, the blade is signaled an event to die
//------------------------------------------------------------------------------
void X2BreakConcentrationSpells()
{
    // * At the moment we got only one concentration spell, black blade of disaster

    object oAssoc = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    if (GetIsObjectValid(oAssoc) && GetIsPC(OBJECT_SELF)) // only applies to PCS
    {
        if(GetTag(oAssoc) == "x2_s_bblade") // black blade of disaster
        {
            if (GetLocalInt(OBJECT_SELF,"X2_L_CREATURE_NEEDS_CONCENTRATION"))
            {
                SignalEvent(oAssoc,EventUserDefined(X2_EVENT_CONCENTRATION_BROKEN));
            }
        }
    }
}

//------------------------------------------------------------------------------
// being hit by any kind of negative effect affecting the caster's ability to concentrate
// will cause a break condition for concentration spells
//------------------------------------------------------------------------------
int X2GetBreakConcentrationCondition(object oPlayer)
{
     effect e1 = GetFirstEffect(oPlayer);
     int nType;
     int bRet = FALSE;
     while (GetIsEffectValid(e1) && !bRet)
     {
        nType = GetEffectType(e1);

        if (nType == EFFECT_TYPE_STUNNED || nType == EFFECT_TYPE_PARALYZE ||
            nType == EFFECT_TYPE_SLEEP || nType == EFFECT_TYPE_FRIGHTENED ||
            nType == EFFECT_TYPE_PETRIFY || nType == EFFECT_TYPE_CONFUSED ||
            nType == EFFECT_TYPE_DOMINATED || nType == EFFECT_TYPE_POLYMORPH)
         {
           bRet = TRUE;
         }
                    e1 = GetNextEffect(oPlayer);
     }
    return bRet;
}

void X2DoBreakConcentrationCheck()
{
    object oMaster = GetMaster();
    if (GetLocalInt(OBJECT_SELF,"X2_L_CREATURE_NEEDS_CONCENTRATION"))
    {
         if (GetIsObjectValid(oMaster))
         {
            int nAction = GetCurrentAction(oMaster);
            // master doing anything that requires attention and breaks concentration
            if (nAction == ACTION_DISABLETRAP || nAction == ACTION_TAUNT ||
                nAction == ACTION_PICKPOCKET || nAction ==ACTION_ATTACKOBJECT ||
                nAction == ACTION_COUNTERSPELL || nAction == ACTION_FLAGTRAP ||
                nAction == ACTION_CASTSPELL || nAction == ACTION_ITEMCASTSPELL)
            {
                SignalEvent(OBJECT_SELF,EventUserDefined(X2_EVENT_CONCENTRATION_BROKEN));
            }
            else if (X2GetBreakConcentrationCondition(oMaster))
            {
                SignalEvent(OBJECT_SELF,EventUserDefined(X2_EVENT_CONCENTRATION_BROKEN));
            }
         }
    }
}


//------------------------------------------------------------------------------
// This function will return TRUE if the spell that is cast is a shape shifting
// spell.
//------------------------------------------------------------------------------
int X3ShapeShiftSpell(object oTarget)
{ // PURPOSE: Return TRUE if a shape shifting spell was cast at oTarget
    int nSpellID=GetSpellId();
    string sUp=GetStringUpperCase(Get2DAString("x3restrict","SHAPESHIFT", nSpellID));
    if (sUp=="YES") return TRUE;
    return FALSE;
} // X3ShapeShiftSpell()


//------------------------------------------------------------------------------
// if FALSE is returned by this function, the spell will not be cast
// the order in which the functions are called here DOES MATTER, changing it
// WILL break the crafting subsystems
//------------------------------------------------------------------------------
int X2PreSpellCastCode()
{
   object oTarget = GetSpellTargetObject();

   int nContinue;


    //check deadmagic
    if (X2DeadmagicZone() == FALSE)
    {
        return FALSE;
    }
    X2WildMagicZone();
    X2MythicXP();
   //---------------------------------------------------------------------------
   // This small addition will check to see if the target is mounted and the
   // spell is therefor one that should not be permitted.
   //---------------------------------------------------------------------------
   if (!GetLocalInt(GetModule(),"X3_NO_SHAPESHIFT_SPELL_CHECK"))
   { // do check for abort due to being mounted check
       if (HorseGetIsMounted(oTarget)&&X3ShapeShiftSpell(oTarget))
       { // shape shifting not allowed while mounted
           if(GetIsPC(oTarget))
           {
               FloatingTextStrRefOnCreature(111982,oTarget,FALSE);
           }
           return FALSE;
       } // shape shifting not allowed while mounted
   } // do check for abort due to being mounted check


   //---------------------------------------------------------------------------
   // This stuff is only interesting for player characters we assume that use
   // magic device always works and NPCs don't use the crafting feats or
   // sequencers anyway. Thus, any NON PC spellcaster always exits this script
   // with TRUE (unless they are DM possessed or in the Wild Magic Area in
   // Chapter 2 of Hordes of the Underdark.
   //---------------------------------------------------------------------------
   if (!GetIsPC(OBJECT_SELF))
   {
       if( !GetIsDMPossessed(OBJECT_SELF) && !GetLocalInt(GetArea(OBJECT_SELF), "X2_L_WILD_MAGIC"))
       {
            return TRUE;
       }
   }

   //---------------------------------------------------------------------------
   // Break any spell require maintaining concentration (only black blade of
   // disaster)
   // /*REM*/ X2BreakConcentrationSpells();
   //---------------------------------------------------------------------------

   //---------------------------------------------------------------------------
   // Run use magic device skill check
   //---------------------------------------------------------------------------
   nContinue = X2UseMagicDeviceCheck();

   if (nContinue)
   {
       //-----------------------------------------------------------------------
       // run any user defined spellscript here
       //-----------------------------------------------------------------------
       nContinue = X2RunUserDefinedSpellScript();
   }

   //---------------------------------------------------------------------------
   // The following code is only of interest if an item was targeted
   //---------------------------------------------------------------------------
   if (GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
   {

       //-----------------------------------------------------------------------
       // Check if spell was used to trigger item creation feat
       //-----------------------------------------------------------------------
       if (nContinue) {
           nContinue = !ExecuteScriptAndReturnInt("x2_pc_craft",OBJECT_SELF);
       }

       //-----------------------------------------------------------------------
       // Check if spell was used for on a sequencer item
       //-----------------------------------------------------------------------
       if (nContinue)
       {
            nContinue = (!X2GetSpellCastOnSequencerItem(oTarget));
       }

       //-----------------------------------------------------------------------
       // * Execute item OnSpellCast At routing script if activated
       //-----------------------------------------------------------------------
       if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
       {
             SetUserDefinedItemEventNumber(X2_ITEM_EVENT_SPELLCAST_AT);
             int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oTarget),OBJECT_SELF);
             if (nRet == X2_EXECUTE_SCRIPT_END)
             {
                return FALSE;
             }
       }

       //-----------------------------------------------------------------------
       // Prevent any spell that has no special coding to handle targetting of items
       // from being cast on items. We do this because we can not predict how
       // all the hundreds spells in NWN will react when cast on items
       //-----------------------------------------------------------------------
       if (nContinue) {
           nContinue = X2CastOnItemWasAllowed(oTarget);
       }
   }

   return nContinue;
}



