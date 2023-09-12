//::////////////////////////////////////////////////////////////////////////////
//:: Excelsior Resting System
//:: Name: ex_o0_onrest
//:: Copyright (c) 2001 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    The generic resting system.

    Allows PC's to rest in certain Areas as determined by the Area Features;
    Artifical and Exterior implies a town or other civilization; No Rest
    Artifical and Interior implies a room, house or structure; No Rest
      Resting inside a room, house or structure is circumvented by the use
      of resting beds.
    Area Local Integers can be set to not allow resting.

    PC's cannot rest if there are hostile creatures near, a member of a party is
    also resting, or the expiration time has not been reach.  PC's can rest in a
    bed once every 4 hours or once every 8 hours in the wild.

    Resting Beds can be set up with the following;
    Change the Tag on the Bed by adding the following {Tag}_BRXX, this applies a
    quality number to the bed, presently the quality of rest numbers are 01, 03,
    05, 08 and 12.
    Add the script "ex_bedrest_ou" to the OnUsed event.
    Add the conversation "ex_bedrest_conv" to the Conversation event.

    A special trigger has been added to allow rangers to receive an extra quality
    of rest if they rest at a ranger station/post.

    A script has been added to the Druids Grove to allow them to receive an extra
    quality of rest if the druids rest in the druidical grove.

    The include files are;
    "ex_inc_onrest" holds extra functions for the resting system.
    "ex_inc_date_time" is a persistent time file.
    "ex_text_onrest" are strings used for sending messages to PC's.

    Updates;
    Rest Exploit: Ard 02/17/06
    Save PC: Ard 04/06/06

*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Ardimus
//:: Created On: 30 Oct 2005
//::////////////////////////////////////////////////////////////////////////////
#include "ex_i0_mod_funcs"
#include "ex_i0_onrest"
#include "ex_i0_date_time"
#include "ex_i2_onrest"
#include "ex_i0_xpcap"
#include "pf_facade"

////////////////////////////////////////////////////////////////////////////////
//  F U N C T I O N S
////////////////////////////////////////////////////////////////////////////////

// Set the next available Resting Period.
void SetNextRestPeriod(object oPC);

// Perform the start resting function
void StartRest(object oPC);

// Perform the finished resting functions
void EndRest(object oPC);

// Remove the blindness resting effect
void REffect(object oPC);

// Set HitPoints after a resting period
void SetHitPoints(object oPC, int nRecoveryHP);

////////////////////////////////////////////////////////////////////////////////
// I M P L E M E N T A T I O N
////////////////////////////////////////////////////////////////////////////////
void REffect(object oPC)
{
  effect eRestEffect = GetFirstEffect(oPC);
  //Search for negative effects
  while(GetIsEffectValid(eRestEffect))
  {
    int nEffectBlind = GetEffectType(eRestEffect);
    if(nEffectBlind == EFFECT_TYPE_BLINDNESS)
    {
      RemoveEffect(oPC, eRestEffect);
    }
    eRestEffect = GetNextEffect(oPC);
  }
}

////////////////////////////////////////////////////////////////////////////////
void SetHitPoints(object oPC, int nRecoveryHP)
{
  int nStartRestHP = GetLocalInt(oPC, "nStartRestHP");
  int nCurrentHP = GetCurrentHitPoints(oPC); // After rest HP.

  if (nCurrentHP > (nStartRestHP + nRecoveryHP))
  {
    effect eDamage = EffectDamage(nCurrentHP - (nStartRestHP + nRecoveryHP));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, ExtraordinaryEffect(eDamage), oPC);
    FloatingTextStringOnCreature(REST_POORLY, oPC, FALSE);
  }
}

////////////////////////////////////////////////////////////////////////////////
void SetNextRestPeriod(object oPC)
{
  if(GetLocalInt(oPC, "RESTING_BED"))
  {
    SetDateString(oPC, "REST_BED", 0, 0, 0, 4, 0, 0);
    SetDateString(oPC, "REST_ROUGH", 0, 0, 0, 4, 0, 0);
    return;
  }

  SetDateString(oPC, "REST_BED", 0, 0, 0, 4, 0, 0);
  SetDateString(oPC, "REST_ROUGH", 0, 0, 0, 8, 0, 0);
  return;

}

////////////////////////////////////////////////////////////////////////////////
void StartRest(object oPC)
{
  effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
  effect eBlind =  EffectBlindness();
  effect eLink = EffectLinkEffects(eVis, eBlind);

  SetLocalInt(oPC, "RESTING", 1);


  if (GetLocalInt(oPC, "RESTING_BED") == TRUE)
  {
    // Rest effects for the Inn
    if ((GetLastRestEventType() != REST_EVENTTYPE_REST_CANCELLED))
    {
      PlayVoiceChat(VOICE_CHAT_REST, oPC);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, 120.0);
    }
  }
  else if(GetLocalInt(oPC, "HAS_BEDROLL"))
  {
    // Sleep effects with a bedroll
    if ((GetLastRestEventType() != REST_EVENTTYPE_REST_CANCELLED))
    {
      object oRestbedroll = CreateObject (OBJECT_TYPE_PLACEABLE, "plc_bedrolls", GetLocation (oPC), FALSE);
      SetLocalObject (oPC, "o_PL_Bedrollrest", oRestbedroll);
      PlayVoiceChat(VOICE_CHAT_REST, oPC);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, 120.0);
    }
  }
  else
  {
    // Sleep effects without a bedroll
    if ((GetLastRestEventType() != REST_EVENTTYPE_REST_CANCELLED))
    {
      PlayVoiceChat(VOICE_CHAT_REST, oPC);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, 120.0);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////
void EndRest(object oPC)
{
  int nRestQuality = GetLocalInt(oPC, "RESTING_QUALITY");
  SetLocalInt(oPC, "RESTING", 0);

  if (!GetLocalInt(oPC, "RESTING_BED") &&
       GetLocalInt(oPC, "HAS_BEDROLL"))
  {
    DestroyObject(GetLocalObject (oPC, "o_PL_Bedrollrest"), 0.0f);
    DeleteLocalObject(oPC, "o_PL_Bedrollrest");
  }
  // Heal recovery health based on quality of resting.
  int nRecoveryHP = GetRestingQuality(oPC);

  SetHitPoints(oPC, nRecoveryHP);

  REffect(oPC);

  SetNextRestPeriod(oPC);

  SetLocalInt(oPC, "HAS_BEDROLL", FALSE);
  SetLocalInt(oPC, "RESTING_BED", FALSE);
  SetLocalInt(oPC, "RESTING_QUALITY_BED", 1);

}

////////////////////////////////////////////////////////////////////////////////
void main ()
{
  object oPC = GetLastPCRested();

//XP Cap DB write - Yth 5/7/06
  XPCap_DBUpdate(oPC);

  string sID = GetCampaignPlayersID(oPC);
  object oBedRoll = GetItemPossessedBy(oPC, "Bedroll");
  if (oBedRoll != OBJECT_INVALID)
  {
    SetLocalInt(oPC, "HAS_BEDROLL", TRUE);
  }

  int nRestEvent = GetLastRestEventType();
  if(nRestEvent == REST_EVENTTYPE_REST_STARTED)
  {
    if (NoRestZone(oPC))
    {
      AssignCommand (oPC, ClearAllActions());
      return;
    }
    else if (CheckNextRestingTime(oPC))
    {
      AssignCommand (oPC, ClearAllActions());
      return;
    }
    else if (PartyMemberResting(oPC))
    {
      AssignCommand (oPC, ClearAllActions());
      return;
    }
    else if (MonsterNear(oPC))
    {
      AssignCommand (oPC, ClearAllActions());
      return;
    }
    else
    {
      // Set Rest System Exploit variables
      SetPFCampaignInt("REST_SYSTEM", "START", GetCurrentHitPoints(oPC), oPC);
      // Continue with normal rest system
      SetLocalInt(oPC, "nStartRestHP", GetCurrentHitPoints(oPC));
      StartRest(oPC);
    }
  }
  else if(nRestEvent == REST_EVENTTYPE_REST_CANCELLED)
  {
    if (!GetLocalInt(oPC, "RESTING_BED") &&
         GetLocalInt(oPC, "HAS_BEDROLL"))
    {
      DestroyObject (GetLocalObject (oPC, "o_PL_Bedrollrest"), 0.0f);
      DeleteLocalObject (oPC, "o_PL_Bedrollrest");
    }
    // Set Rest System Exploit variables
    SetPFCampaignInt("REST_SYSTEM", "START", FALSE, oPC);
    // No healing
    REffect(oPC);
    SetLocalInt(oPC, "RESTING_BED", FALSE);
    // Save Current PC
    ExportSingleCharacter(oPC);
  }
  else if(nRestEvent == REST_EVENTTYPE_REST_FINISHED)
  {
    if (nRestEvent != REST_EVENTTYPE_REST_CANCELLED)
    {
      // Set Rest System Exploit variables
      SetPFCampaignInt("REST_SYSTEM", "START", FALSE, oPC);
      EndRest(oPC);
      // Save Current PC
      ExportSingleCharacter(oPC);
    }
  }
  else
  {
    if (!GetLocalInt(oPC, "RESTING_BED") &&
         GetLocalInt(oPC, "HAS_BEDROLL"))
    {
      DestroyObject(GetLocalObject (oPC, "o_PL_Bedrollrest"), 0.0f);
      DeleteLocalObject(oPC, "o_PL_Bedrollrest");
    }
    // Set Rest System Exploit variables
    SetPFCampaignInt("REST_SYSTEM", "START", FALSE, oPC);
    // No healing
    REffect(oPC);
    SetLocalInt(oPC, "RESTING_BED", FALSE);
    // Save Current PC
    ExportSingleCharacter(oPC);
  }
}


