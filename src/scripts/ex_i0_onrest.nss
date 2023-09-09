//::////////////////////////////////////////////////////////////////////////////
//:: Various scripts used for the Excelsior REst System
//:: Name: ex_i0_onrest
//:: Copyright (c) 2001 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    The generic resting system
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Ardimus
//:: Created On: 30 Oct 2005
//::////////////////////////////////////////////////////////////////////////////
#include "ex_i2_onrest"
#include "ex_i0_date_time"

////////////////////////////////////////////////////////////////////////////////
//  F U N C T I O N S
////////////////////////////////////////////////////////////////////////////////

// Forces PC in a Party to sleep in shifts
int PartyMemberResting(object oPC);

// Check Time to next Rest
int CheckNextRestingTime(object oPC);

// If hostile creatures or monsters are nearby
// returns true and stops the resting function
int MonsterNear(object oPC);

// Rest Zone is the determined by area type, it prevents PC's from resting in
// town or without a bed in an interior area.
int NoRestZone(object oPC);

// Determines the quality of resting by different variables
int GetRestingQuality(object oPC);

////////////////////////////////////////////////////////////////////////////////
// I M P L E M E N T A T I O N
////////////////////////////////////////////////////////////////////////////////
int PartyMemberResting (object oPC)
{
  object oPM = GetFirstFactionMember(oPC);
  while(GetIsObjectValid(oPM))
  {
    if(GetLocalInt(oPM, "RESTING") && oPM != oPC)
    {
      AssignCommand(oPC, ClearAllActions());
      SendMessageToPC(oPC, REST_IN_SHIFTS);
      return TRUE;
    }
    oPM=GetNextFactionMember(oPC);
  }
  return FALSE;
}

////////////////////////////////////////////////////////////////////////////////
int CheckNextRestingTime(object oPC)
{
  int bREST_BED = CheckDateStringExpired(oPC, "REST_BED");
  int bREST_ROUGH = CheckDateStringExpired(oPC, "REST_ROUGH");
  object oArea = GetArea(oPC);
  int nAreaNatural = GetIsAreaNatural(oArea);
  int nAreaInterior = GetIsAreaInterior(oArea);
  string sRestedText = GetName(oPC) + NOT_TIRED;
  //
  if(GetIsObjectValid(oPC) && bREST_BED == TRUE &&
     GetLocalInt(oPC, "RESTING_BED") == TRUE)
  {
    return FALSE;
  }
  else if(GetIsObjectValid(oPC) && bREST_BED == TRUE && bREST_ROUGH == FALSE)
  {
    AssignCommand(oPC, ClearAllActions());
    sRestedText += BED_REST_ONLY;
    sRestedText += WILD_REST_LATER;
    sRestedText = sRestedText + ConvertDateString(oPC, "REST_ROUGH");
    FloatingTextStringOnCreature(sRestedText, oPC, FALSE);
    return TRUE;
  }
  else if(GetIsObjectValid(oPC) && bREST_BED == FALSE && bREST_ROUGH == FALSE)
  {
    AssignCommand(oPC, ClearAllActions());
    sRestedText += BED_REST_LATER;
    sRestedText = sRestedText + ConvertDateString(oPC, "REST_BED");
    sRestedText += WILD_REST_LATER;
    sRestedText = sRestedText + ConvertDateString(oPC, "REST_ROUGH");
    FloatingTextStringOnCreature(sRestedText, oPC, FALSE);
    return TRUE;
  }
  else
  {
    return FALSE;
  }
}

////////////////////////////////////////////////////////////////////////////////
int MonsterNear(object oPC)
{
  object oCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
  int iHostileRange = 30;

  // nearest creature check proximity, hostility.
  if((GetDistanceToObject(oCreature) <= IntToFloat(iHostileRange)) &&
      GetIsReactionTypeHostile(oCreature))
  {
    AssignCommand (oPC, ClearAllActions());
    FloatingTextStringOnCreature(REST_MONSTERS, oPC, FALSE);
    return TRUE;
  }
  return FALSE;
}

////////////////////////////////////////////////////////////////////////////////
int NoRestZone(object oPC)
{
  object oArea = GetArea(oPC);
  int nAreaNatural = GetIsAreaNatural(oArea);
  int nAreaInterior = GetIsAreaInterior(oArea);
  int nAreaAboveGround = GetIsAreaAboveGround(oArea);
  // Checks for No Resting in Area
  // Allows resting if PC has choosen a bed.
  // Towns are artifical exterior aboveground areas.
  if(nAreaNatural != AREA_NATURAL && !nAreaInterior)
  {
    FloatingTextStringOnCreature(NO_REST_TOWN, oPC, FALSE);
    return TRUE;
  }
  // Rooms and houses are artifical interior aboveground areas.
  else if(nAreaNatural != AREA_NATURAL && nAreaInterior == TRUE &&
          GetLocalInt(oPC, "RESTING_BED") == FALSE)
  {
    FloatingTextStringOnCreature(BUY_A_ROOM, oPC, FALSE);
    return TRUE;
  }
  else if(GetLocalInt(oArea, "NO_RESTING") &&
          GetLocalInt(oPC, "RESTING_BED") == FALSE)
  {
    FloatingTextStringOnCreature(NO_REST_HERE, oPC, FALSE);
    return TRUE;
  }
  else
  return FALSE;
}

////////////////////////////////////////////////////////////////////////////////
int GetRestingQuality(object oPC)
{
  int nRestQualityBed = GetLocalInt(oPC, "RESTING_QUALITY_BED");
  int nDruid = GetLevelByClass(CLASS_TYPE_DRUID, oPC);
  int nRanger = GetLevelByClass(CLASS_TYPE_RANGER, oPC);
  int nCONAbility =  GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
  int bBedRoll = GetLocalInt(oPC, "HAS_BEDROLL");
  object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
  int nArmor = GetWeight(oArmor);
  int bArmor = FALSE;
  if(nArmor > 300)
  {
    bArmor = TRUE;
  }
  object oArea = GetArea(oPC);
  int nAreaNatural = GetIsAreaNatural(oArea);
  int nDruidGrove = GetLocalInt(oPC, "DRUID_GROVE");
  int nRangerStation = GetLocalInt(oPC, "RANGER_STATION");
  //  Check for qualtiy of resting
  if(nRestQualityBed == 12)
    {
      return 12 + nCONAbility;
    }
  if((nRestQualityBed == 8) ||
     (nDruidGrove && nDruid > 0) ||
     (nRangerStation && nRanger > 0))
    {
      return 8 + nCONAbility;
    }
  if((nRestQualityBed == 5) ||
    ((nAreaNatural == AREA_NATURAL) && nDruid > 0 && bBedRoll) ||
    ((nAreaNatural == AREA_NATURAL) && nRanger > 0 && bBedRoll))
    {
      return 5;
    }
  if( (nRestQualityBed == 3) ||
    ((nAreaNatural == AREA_NATURAL) && nDruid > 0 && !bBedRoll) ||
    ((nAreaNatural == AREA_NATURAL) && nRanger > 0 && !bBedRoll) ||
    ((nAreaNatural == AREA_NATURAL) && bBedRoll && !bArmor))
    {
    return 3;
    }
  return 1; // Default
}

