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

#include "ex_i0_date_time"
#include "x2_inc_itemprop"
#include "so_inc_weather"
#include "loi_functions"
#include "te_afflic_func"
#include "nwnx_creature"

string REST_IN_SHIFTS = "You cannot rest while another party member is resting, sleep in shifts.";
string NOT_TIRED = " is not tired enough.";
string TOO_SOON = "Its too soon for you to be able to rest yet; please wait ";
string NO_REST_TOWN = "You are unable to rest safely in this area. To rest, find an inn-room or other suitable location.";
string BUY_A_ROOM = "You need to buy a room at the Inn or find some other accommodations.";
string BED_REST_LATER = " You can rest in a comfortable bed at ";
string WILD_REST_LATER = " or you can rest in the wilds at ";
string BED_REST_ONLY = " You can rest in a comfortable bed ";
string NO_REST_HERE = "You cannot rest here.";
string REST_MONSTERS = "You cannot rest, there are monsters nearby!";
string REST_POORLY = "Your rest was poor or uncomfortable, you did not recover completely.";


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

  //SendMessageToPC(oPC,"Debug: Current HP - "+IntToString(nCurrentHP)+" Starting HP - "+IntToString(nStartRestHP)+" Recovery HP - "+IntToString(nRecoveryHP));
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
    // resting in a bed is set to be very quick for playtest quality of life
    SetDateString(oPC, "REST_BED", 0, 0, 0, 0, 0, 1);

    SetDateString(oPC, "REST_ROUGH", 0, 0, 0, 2, 0, 0);
    return;
  }

  // set to be very quick for playtest quality of life
  SetDateString(oPC, "REST_BED", 0, 0, 0, 0, 0, 1);

  SetDateString(oPC, "REST_ROUGH", 0, 0, 0, 4, 0, 0);
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
      //SendMessageToPC(oPC,"Debug - Start Rest/Bed TRUE Not cancelled, playing animation, applying blindness.");
      PlayVoiceChat(VOICE_CHAT_REST, oPC);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, 120.0);
      //AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM16,1.0,120.0));
    }
  }
  else if(GetLocalInt(oPC, "HAS_BEDROLL"))
  {
    // Sleep effects with a bedroll
    if ((GetLastRestEventType() != REST_EVENTTYPE_REST_CANCELLED))
    {
      object oRestbedroll = CreateObject (OBJECT_TYPE_PLACEABLE, "plc_bedrolls", GetLocation (oPC), FALSE);
      //SendMessageToPC(oPC,"Debug - Start Rest/Bedroll TRUE Not cancelled, playing animation, applying blindness.");
      SetLocalObject (oPC, "o_PL_Bedrollrest", oRestbedroll);
      PlayVoiceChat(VOICE_CHAT_REST, oPC);
      //AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM16,1.0,120.0));
    }
  }
  else
  {
    // Sleep effects without a bedroll
    if ((GetLastRestEventType() != REST_EVENTTYPE_REST_CANCELLED))
    {
      //SendMessageToPC(oPC,"Debug - Start Rest/Bedroll FALSE Not cancelled, playing animation, applying blindness.");
      //AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM16,1.0,120.0));
      PlayVoiceChat(VOICE_CHAT_REST, oPC);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////
void EndRest(object oPC)
{
  //SendMessageToPC(oPC,"Debug - End Rest triggered.");
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

  object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
  int nShoon = GetLocalInt(oItem,"ShoonAfflic");

  SetLocalInt(oItem,"nEndure",0);

  if(GetPCAffliction(oPC) == 1 || GetPCAffliction(oPC) == 2 || GetPCAffliction(oPC) == 3 || GetPCAffliction(oPC) == 4 || GetPCAffliction(oPC) == 5 || GetPCAffliction(oPC) == 7 || GetPCAffliction(oPC) == 8)
  {
    SetLocalInt(oItem,"ShoonAfflic",0);
    nShoon = 0;
  }

  if(GetLocalInt(oItem,"nFatigue") == TRUE)
  {
    SetLocalInt(oItem,"nFatigue",FALSE);
  }

  if(GetLocalInt(oItem,"nExhaust") == TRUE)
  {
    SetLocalInt(oItem,"nExhaust",FALSE);
  }

    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC) > 1 && GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) < 1)
    {
        SetLocalInt(oItem,"ShoonAfflic",0);
        nShoon = 0;
        object oPalItem = GetFirstItemInInventory(oPC);
        int nItemCount = 0;
        int nPiety = GetLocalInt(oItem,"nPiety");
        int nPietyFall = 0;

        while (GetIsObjectValid(oPalItem) == TRUE)
        {
            if(GetGoldPieceValue(oPalItem) >= 2000)
            {
                nItemCount = nItemCount+1;
            }
            oPalItem = GetNextItemInInventory(oPC);
        }

        if(nItemCount >= 11)
        {
            SendMessageToPC(oPC,"You are in possession of more magical items than your vows permit. You must donate or discard any excess items beyond the 10 you are allowed as a paladin.");
            nPietyFall = nPietyFall + 10;
        }

        if(GetGold(oPC) >= 10000)
        {
            SendMessageToPC(oPC,"You are in possession of more gold than your vows permit. You must bank your gold at an instition that will collect your tithes.");
            nPietyFall = nPietyFall + 10;
        }

        SetLocalInt(oItem,"nPiety",nPiety-nPietyFall);
        SendMessageToPC(oPC,"Your piety has fallen to "+IntToString(nPiety-nPietyFall)+" out of 100.");
        if(GetLocalInt(oItem,"nPiety") < 0)     {SetLocalInt(oItem,"nPiety",0);}
        if(GetLocalInt(oItem,"nPiety") > 100)   {SetLocalInt(oItem,"nPiety",100);}
    }

    if(nShoon == 1)
    {
        if(GetHitDice(oPC) >= 5)
        {
            effect eBad = GetFirstEffect(oPC);
            //Search for negative effects
            while(GetIsEffectValid(eBad))
            {
                if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
                    GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                    GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                    GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                    GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
                    {
                        RemoveEffect(oPC, eBad);
                    }
                eBad = GetNextEffect(oPC);
            }
            AddJournalQuestEntry("te_shoondisease",4,oPC);
            SetLocalInt(oItem,"ShoonAfflic",0);
            Affliction_Items(oPC, 2);
            SetPCAffliction(oPC, 2);
            SetLocalInt(oItem,"iUndead",0);
            SendMessageToPC(oPC, DARKRED+"Something twists inside your stomach and you feel a gnawing hunger that cannot be satiated by mere food...");
            AdjustAlignment(oPC,ALIGNMENT_CHAOTIC,1,FALSE);
            AdjustAlignment(oPC,ALIGNMENT_EVIL,1,FALSE);
            NWNX_Creature_AddFeat(oPC, 1413);
        }
        else
        {
            SetLocalInt(oItem,"ShoonAfflic",0);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(TRUE,TRUE),oPC);
            SendMessageToPC(oPC,"You have succumbed to the disease and died.");
        }
    }
    else if(nShoon == 2)
    {
        SetLocalInt(oItem,"ShoonAfflic",1);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,d4(1))),oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_EVIL_HELP),oPC);
        SendMessageToPC(oPC,DARKRED+"You feel very close to death. Whatever afflicts you is taking its toll. You doubt whether you may survive another night...");
        AddJournalQuestEntry("te_shoondisease",3,oPC,FALSE,FALSE,TRUE);
    }
    else if(nShoon >= 3)
    {
        SetLocalInt(oItem,"ShoonAfflic",2);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,d4(1))),oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_EVIL_HELP),oPC);
        SendMessageToPC(oPC,DARKRED+"As you wake up, it seems you are wasting away. Moving is a chore and you feel incredibly weak.");
        AddJournalQuestEntry("te_shoondisease",2,oPC,FALSE,FALSE,TRUE);
    }


  if(GetLocalInt(oItem,"LichTransform") == 1)
  {
    SetLocalInt(oItem,"LichTransform",0);
    Affliction_Items(oPC,7);
    SetPCAffliction(oPC,7);
    SetLocalInt(oItem,"iUndead",1);
    NWNX_Creature_AddFeat(oPC,1475);
    NWNX_Creature_AddFeat(oPC,1476);
    NWNX_Creature_AddFeat(oPC,1477);
    NWNX_Creature_AddFeat(oPC,1478);
  }

}

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
  object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
  //
  if(GetIsObjectValid(oPC) && bREST_BED == TRUE &&
     GetLocalInt(oPC, "RESTING_BED") == TRUE)
  {
    return FALSE;
  }
  else if(GetIsObjectValid(oPC) && (GetLocalInt(oItem,"nFatigue") == TRUE || GetLocalInt(oItem,"nExhaust") == TRUE))
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
    //AssignCommand (oCreature, ActionAttack());
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

int ArmorTest(object oPC)
{
  object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
  int nNetAC = GetItemACValue(oArmor);
  int nBonus = IPGetWeaponEnhancementBonus(oArmor, ITEM_PROPERTY_AC_BONUS);
  int nArmor = nNetAC - nBonus;
  int nEndurance = GetHasFeat(1411,oPC);

  if(nArmor >= 2 && !nEndurance)
  {
    SendMessageToPC(oPC,"You are unable to rest while wearing armor.");
    return TRUE;
  }
  else if(nArmor >= 4 && nEndurance)
  {
    SendMessageToPC(oPC,"You are unable to rest while wearing armor.");
    return TRUE;
  }
  else
  return FALSE;

}

int StatusTest(object oPC)
{
  effect eRestEffect = GetFirstEffect(oPC);
  int nReturn = FALSE;
  //Search for negative effects
  while(GetIsEffectValid(eRestEffect) == TRUE)
  {
    int nEffectBlind = GetEffectType(eRestEffect);
    if(nEffectBlind == EFFECT_TYPE_DISEASE)
    {
        SendMessageToPC(oPC,"You are unable to rest while diseased.");
        nReturn = TRUE;
    }
    if(nEffectBlind == EFFECT_TYPE_POISON)
    {
        SendMessageToPC(oPC,"You are unable to rest while poisoned.");
        nReturn = TRUE;
    }
    if(nEffectBlind == EFFECT_TYPE_POLYMORPH)
    {
        SendMessageToPC(oPC,"You are unable to rest while polymorphed.");
        nReturn = TRUE;
    }
    eRestEffect = GetNextEffect(oPC);
  }
    return nReturn;
}

int WeatherTest(object oPC)
{
    object oArea = GetArea(oPC);
    object oWeatherCache=GetModule();

    int nTent = FALSE;
    int nQuality;
    object oTent;
    location lLoc = GetLocation(oPC);
    object oTest = GetFirstObjectInShape(SHAPE_SPHERE,10.0f,lLoc,FALSE,OBJECT_TYPE_PLACEABLE);

    while (GetIsObjectValid(oTest) == TRUE)
    {
        if(GetTag(oTest) == "Tent")
        {
            oTent = oTest;
            nTent = TRUE;
            //SendMessageToPC(oPC,"Debug: Resting near a tent.");
            break;
        }
        oTest = GetNextObjectInShape(SHAPE_SPHERE,10.0f,lLoc,FALSE,OBJECT_TYPE_PLACEABLE);
    }

    float fTemperature=GetLocalFloat(oWeatherCache,WEATHER_LOCAL_GROUND_TEMPERATURE)+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_TEMPERATURE));
    float fWind=GetLocalFloat(oWeatherCache,WEATHER_GLOBAL_WIND)*(100.0+IntToFloat(GetLocalInt(oArea,WEATHER_AREA_WIND_MODIFIER)))/100.0;
    float fRain =  GetLocalFloat(oWeatherCache,WEATHER_LOCAL_RAIN);

    if(GetHasFeat(1439,oPC))
    {
        return FALSE;
    }

    if(GetIsUndead(oPC) == TRUE)
    {
        return FALSE;
    }

    if(GetLocalInt(GetItemInSlot(INVENTORY_SLOT_NECK,oPC),"Adaptation") == 5)
    {
        return FALSE;
    }

    if(nTent == TRUE && GetIsAreaAboveGround(oArea) && !GetIsAreaInterior(oArea))
    {
        nQuality = GetLocalInt(oTent,"Quality");
        if(nQuality == 0)
        {
            if(fTemperature >= 40.0)        {SendMessageToPC(oPC,"It is too hot for you to comfortably rest."); return TRUE;}
            else if(fTemperature <= -6.0)   {SendMessageToPC(oPC,"It is too cold for you to comfortably rest.");return TRUE;}
            else if(fWind >= 40.0)          {SendMessageToPC(oPC,"It is too windy for you to comfortably rest.");return TRUE;}
            else if(fRain >= 25.0)          {SendMessageToPC(oPC,"It is too rainy for you to comfortably rest.");return TRUE;}
        }
        else if(nQuality == 1)
        {
            if(fTemperature >= 40.0)        {SendMessageToPC(oPC,"It is too hot for you to comfortably rest."); return TRUE;}
            else if(fTemperature <= -10.0)  {SendMessageToPC(oPC,"It is too cold for you to comfortably rest.");return TRUE;}
            else if(fWind >= 50.0)          {SendMessageToPC(oPC,"It is too windy for you to comfortably rest.");return TRUE;}
            else if(fRain >= 50.0)          {SendMessageToPC(oPC,"It is too rainy for you to comfortably rest.");return TRUE;}
        }
        else if(nQuality == 2)
        {
            if(fTemperature >= 40.0)        {SendMessageToPC(oPC,"It is too hot for you to comfortably rest."); return TRUE;}
            else if(fTemperature <= -20.0)  {SendMessageToPC(oPC,"It is too cold for you to comfortably rest.");return TRUE;}
            else if(fWind >= 60.0)          {SendMessageToPC(oPC,"It is too windy for you to comfortably rest.");return TRUE;}
            else if(fRain >= 100.0)         {SendMessageToPC(oPC,"It is too rainy for you to comfortably rest.");return TRUE;}
        }
    }
    else if (GetIsAreaInterior(oArea) && GetIsAreaAboveGround(oArea))
    {
        return FALSE;
    }
    else if (GetIsAreaInterior(oArea) && !GetIsAreaAboveGround(oArea))
    {
        if(fTemperature >= 35.0)            {SendMessageToPC(oPC,"It is too hot for you to comfortably rest."); return TRUE;}
        else if(fTemperature <= 0.0)        {SendMessageToPC(oPC,"It is too cold for you to comfortably rest.");return TRUE;}
    }
    else
    {
        if(fTemperature >= 35.0)            {SendMessageToPC(oPC,"It is too hot for you to comfortably rest."); return TRUE;}
        else if(fTemperature <= 0.0)        {SendMessageToPC(oPC,"It is too cold for you to comfortably rest.");return TRUE;}
        else if(fWind >= 5.0)               {SendMessageToPC(oPC,"It is too windy for you to comfortably rest.");return TRUE;}
        else if(fRain > 0.0)                {SendMessageToPC(oPC,"It is too rainy for you to comfortably rest.");return TRUE;}
    }

    return FALSE;
}
////////////////////////////////////////////////////////////////////////////////
int GetRestingQuality(object oPC)
{
  int nRestQualityBed = GetLocalInt(oPC, "RESTING_QUALITY_BED");
  int nDruid = GetLevelByClass(CLASS_TYPE_DRUID, oPC);
  int nRanger = GetLevelByClass(CLASS_TYPE_RANGER, oPC);
  int nCONAbility =  GetAbilityModifier(ABILITY_CONSTITUTION, oPC)+ GetHitDice(oPC);
  int bBedRoll = GetLocalInt(oPC, "HAS_BEDROLL");

    int nMaxHP = GetMaxHitPoints(oPC);
  /*
  int nArmor = GetWeight(oArmor);
  int bArmor = FALSE;
  if(nArmor > 300)
  {
    bArmor = TRUE;
  }
  */
  object oArea = GetArea(oPC);
  int nAreaNatural = GetIsAreaNatural(oArea);
  int nDruidGrove = GetLocalInt(oPC, "DRUID_GROVE");

  if(nAreaNatural == AREA_NATURAL && (nDruid > 0 || nRanger > 0 || GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC) > 0 || GetHasFeat(1430,oPC) == TRUE ))
  {
        return d6(5) + nCONAbility;
  }
  else if(nRestQualityBed == 12)
  {
        return d6(5) + nCONAbility;
  }
  else if(nRestQualityBed == 8)
  {
        return d6(4) + nCONAbility;
  }
  else if(nRestQualityBed == 6)
  {
        return d6(3) + nCONAbility;
  }
  else if(nRestQualityBed == 3 || (nAreaNatural == AREA_NATURAL && bBedRoll))
  {
        return d6(2) + nCONAbility;
  }
  else if(nAreaNatural == AREA_NATURAL && !bBedRoll)
  {
        return d6(1) + nCONAbility;
  }

  //SendMessageToPC(oPC,"Rest Debug: Else case. Value 1.");
  return 1;
  /*
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
  */

}

////////////////////////////////////////////////////////////////////////////////
void main ()
{
  object oPC = GetLastPCRested();

  //XP Cap DB write - Yth 5/7/06
  // XPCap_DBUpdate(oPC);

  //string sID = GetCampaignPlayersID(oPC);
  object oBedRoll = GetItemPossessedBy(oPC, "Bedroll");
  if (oBedRoll != OBJECT_INVALID)
  {
    SetLocalInt(oPC, "HAS_BEDROLL", TRUE);
  }

  int nRestEvent = GetLastRestEventType();
  if(nRestEvent == REST_EVENTTYPE_REST_STARTED)
  {
    if (CheckNextRestingTime(oPC))
    {
      //SendMessageToPC(oPC,"Debug - Failure: Rest Time has not passed.");
      AssignCommand (oPC, ClearAllActions());
      return;
    }
    else if (NoRestZone(oPC))
    {
      //SendMessageToPC(oPC,"Debug - Failure: No rest zone.");
      AssignCommand (oPC, ClearAllActions());
      return;
    }
    else if (PartyMemberResting(oPC))
    {
      //SendMessageToPC(oPC,"Debug - Failure: Party members cannot rest at the same time.");
      AssignCommand (oPC, ClearAllActions());
      return;
    }
    else if (MonsterNear(oPC))
    {
      //SendMessageToPC(oPC,"Debug - Failure: Monsters nearby.");
      AssignCommand (oPC, ClearAllActions());
      return;
    }
    else if (ArmorTest(oPC))
    {
      //SendMessageToPC(oPC,"Debug - Failure: Wearing armor.");
      AssignCommand (oPC, ClearAllActions());
      return;
    }
    else if (StatusTest(oPC))
    {
      //SendMessageToPC(oPC,"Debug - Failure: Diseased/Poisoned.");
      AssignCommand (oPC, ClearAllActions());
      return;
    }
    else if (WeatherTest(oPC))
    {
      //SendMessageToPC(oPC,"Debug - Failure: Bad weather.");
      AssignCommand (oPC, ClearAllActions());
      return;
    }
    else
    {
      // Set Rest System Exploit variables
      SetPFCampaignInt("REST_SYSTEM", "START", GetCurrentHitPoints(oPC), oPC);
      // Continue with normal rest system
      SetLocalInt(oPC, "nStartRestHP", GetCurrentHitPoints(oPC));

      //SendMessageToPC(oPC,"Debug: Starting Rest - All checks passed.");
      //SendMessageToPC(oPC,"nStartRestHP - "+IntToString(GetLocalInt(oPC,"nStartRestHP")));
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
    //SendMessageToPC(oPC,"Debug: Unsuccessful Rest - Cancelled.");
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
      //SendMessageToPC(oPC,"Debug: Successful Rest - Finished + Healing.");

      if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Prof") >= 1)
      {
        AssignCommand(oPC,ActionStartConversation(oPC,"te_prof_lvl",TRUE,FALSE));
      }

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

    SendMessageToPC(oPC,"Debug: Successful Rest.");
    // Set Rest System Exploit variables
    SetPFCampaignInt("REST_SYSTEM", "START", FALSE, oPC);
    // No healing
    REffect(oPC);
    SetLocalInt(oPC, "RESTING_BED", FALSE);
    // Save Current PC
    ExportSingleCharacter(oPC);
  }
}

