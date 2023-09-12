//::////////////////////////////////////////////////////////////////////////////
//::
//:: Name: General Function Include for the Module
//:: FileName: ex_i0_mod_funcs
//::
//::////////////////////////////////////////////////////////////////////////////
/*
    Used to set a few constants as well as a central
    include for various regularly called functions.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Author : Ardimus
//:: Created On : 30 Oct 2005
//::////////////////////////////////////////////////////////////////////////////
#include "pf_facade"
#include "ex_i2_oncltenter"

////////////////////////////////////////////////////////////////////////////////
//  G L O B A L    C O N S T A N T S
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  Constant Global Strings
const string  MOD_CAMPAIGN_DATABASE      = "EXCELSIOR_MODULE_DB";
const string  MOD_PLAYER_DATABASE        = "EXCELSIOR_PLAYER_DB";
const string  PLAYER_REGISTRATION        = "PLAYER_REGISTRATION";

// Added text color
const string COLOR_BLUE         = "<cf??>";
const string COLOR_DARK_BLUE    = "<c f?>";
const string COLOR_GRAY         = "<c?·";
const string COLOR_GREEN        = "<c ? >";
const string COLOR_LIGHT_BLUE   = "<c·?>";
const string COLOR_LIGHT_GRAY   = "<c???>";
const string COLOR_LIGHT_ORANGE = "<c?·>";
const string COLOR_LIGHT_PURPLE = "<c??>";
const string COLOR_ORANGE       = "<c?f >";
const string COLOR_PURPLE       = "<c?w?>";
const string COLOR_RED          = "<c?  >";
const string COLOR_WHITE        = "<c???>";
const string COLOR_YELLOW       = "<c?? >";
const string COLOR_NONE         = COLOR_WHITE;
const string COLOR_END          = "</c>";

////////////////////////////////////////////////////////////////////////////////
//  Constant Global Objects
object  MOD_SELF = GetModule();

////////////////////////////////////////////////////////////////////////////////
//  Constant Global Integers
//
// New weight constants from weight.2da
const int IP_CONST_WEIGHTINCREASE_1_LBS  = 6;
const int IP_CONST_WEIGHTINCREASE_2_LBS  = 7;
const int IP_CONST_WEIGHTINCREASE_3_LBS  = 8;
const int IP_CONST_WEIGHTINCREASE_4_LBS  = 9;
// Spell Constants from spells.2da
const int SPELL_OPEN_CLOSE               = 1501;
const int SPELL_DYE                      = 1502;
const int SPELL_PRESDITIGITATION         = 1503;
const int SPELL_BLUE_FLAME               = 1504;
const int SPELL_GREEN_SMOKE              = 1505;
const int SPELL_MAGIC_SPARKS             = 1506;
const int SPELL_ETHEREAL_MUSIC           = 1507;
const int SPELL_RED_FOG                  = 1508;
const int SPELL_MEND                     = 1509;
const int SPELL_RUSTING_GRASP            = 1510;
const int SPELL_ARCANE_EYE               = 1511;
const int SPELL_AUGURY                   = 1512;
const int SPELL_AWAKE                    = 1513;
const int SPELL_COURAGE                  = 1514;
const int SPELL_DETECT_CHAOS             = 1515;
const int SPELL_DETECT_EVIL              = 1516;
const int SPELL_DETECT_GOOD              = 1517;
const int SPELL_DETECT_LAW               = 1518;
const int SPELL_DETECT_MAGIC             = 1519;
const int SPELL_DETECT_SPELL             = 1520;
const int SPELL_EARTHEN_GRASP            = 1521;
const int SPELL_CREATE_HOLY_SYNBOL       = 1522;
const int SPELL_INSIGHT                  = 1523;
const int SPELL_LISHT_LOAD               = 1524;
const int SPELL_MAKE_WHOLE               = 1525;
const int SPELL_MISDIRECTION             = 1526;
const int SPELL_STONE_FIST               = 1527;
const int SPELL_WEIGHTY_CHEST            = 1528;
// Registration constants
const int REGISTRATION_UNKNOWN = 0;
const int REGISTRATION_OPEN    = 1;
const int REGISTRATION_ACTIVE  = 2;
const int REGISTRATION_CLOSED  = 3;
const int REGISTRATION_BANNED  = 4;
// Curretn PC status
const int CURRENT_PC_FALSE     = 0;
const int CURRENT_PC_TRUE      = 1;

////////////////////////////////////////////////////////////////////////////////
//  F U N C T I O N S
////////////////////////////////////////////////////////////////////////////////
// Gets the players sID string, a combination of PC name and Game Spy ID.
// See ex_i0_mod_funcs.
string GetCampaignPlayersID(object oPC);

////////////////////////////////////////////////////////////////////////////////
// Gets the players sID string, a combination of PC name and Game Spy ID.
// See ex_i0_mod_funcs.
string GetCampaignPlayersName(object oPC);

////////////////////////////////////////////////////////////////////////////////
// Set the players sID string, a combination of PC name and Game Spy ID.
// Added to OnClientEnter, See ex_i0_mod_funcs.
void SetCampaignPlayersID(object oPC);

////////////////////////////////////////////////////////////////////////////////
// Set the players sID string, a combination of PC name and Game Spy ID.
// Added to OnClientEnter, See ex_i0_mod_funcs.
void SetCampaignPlayersName(object oPC);

////////////////////////////////////////////////////////////////////////////////
// Checks to see if Players PC is Registered or not
// See ex_i0_mod_funcs.
int GetIsPCNotRegistered(object oPC);

////////////////////////////////////////////////////////////////////////////////
// Checks to see if Player has been banned
// See ex_i0_mod_funcs.
int GetIsPCBanned(object oPC);

// Removes all effects on a PC.
void RemoveAllPCEffects(object oPC);

// Makes an NPC/PC face an object, this is a modified version of the
// command in the Stageplay Interpreter from Red Gollem.
void FaceObject(object oTarget, object oPC = OBJECT_SELF);

// Variant of 'SendMessageToAllPCs' to send a message to only players in a
// pre-specified area.
void SendMessageToAllPCsInArea(string sMessage, object oArea);

//  This Function parses a String for Flags and to returns the information
//  imbedded in an objects or items Name or Tag.
//  - sName is the string retrieved.
//  - sFlag in the Flag string that holds the integer information
//  - nDefault is the value that returned if no value (nDigits) is speicified.
int GetParseFlagValue(string sName, string sFlag, int nDefault);

////////////////////////////////////////////////////////////////////////////////
// Searches for and returns the Nth substring (value nSubstring) in a string
//   separated by sSeparator ("_" by default).  Substring count starts with 0.
// Returns "" when no substring is found.
// * sString - The string to search.
// * nSubstring - The Nth Substring within sString to return.
// * sSeparator - The string used to parse out substrings.
string GetParsedSubstring(string sString, int nSubstring, string sSeparator="_");

////////////////////////////////////////////////////////////////////////////////
// I M P L E M E N T A T I O N
////////////////////////////////////////////////////////////////////////////////
string GetCampaignPlayersID(object oPC)
{
   string sIDRet = GetPFCampaignString(MOD_PLAYER_DATABASE, "PLAYER_sID", oPC);
   return sIDRet;
}

////////////////////////////////////////////////////////////////////////////////
string GetCampaignPlayersName(object oPC)
{
   string sIDRet = GetPFCampaignString(MOD_PLAYER_DATABASE, "PLAYER_NAME", oPC);
   return sIDRet;
}

////////////////////////////////////////////////////////////////////////////////
void SetCampaignPlayersID(object oPC)
{
   string sID = GetPCPublicCDKey(oPC) + GetName(oPC);
   SetPFCampaignString(MOD_PLAYER_DATABASE, "PLAYER_sID", sID, oPC);
}

////////////////////////////////////////////////////////////////////////////////
void SetCampaignPlayersName(object oPC)
{
   string sName = GetName(oPC);
   SetPFCampaignString(MOD_PLAYER_DATABASE, "PLAYER_NAME", sName, oPC);
}

////////////////////////////////////////////////////////////////////////////////
int GetIsPCNotRegistered(object oPC)
{
  string sPC = GetName(oPC);
  string sPCPlayer = GetPCPlayerName(oPC);
  string sID = GetCampaignPlayersID(oPC);

  // Set varible for Players Current PC.
  string CURRENT_PC = "CPC_"+sPCPlayer;

  // Get Players Current PC.
  string sCurrentPC = GetPFCampaignString(MOD_CAMPAIGN_DATABASE, CURRENT_PC, MOD_SELF);
  //SendMessageToPC(oPC, "Current PC is "+sCurrentPC);

  // See if this Player has ever been on Excelsior before
  int nExcelsior = GetPFCampaignInt(MOD_CAMPAIGN_DATABASE, sPCPlayer, MOD_SELF);
  //SendMessageToPC(oPC, "First time is "+IntToString(nExcelsior));

  // Get the Registration on the Players current PC(?).
  int nCheckPCRegistration = GetPFCampaignInt(PLAYER_REGISTRATION, sID, oPC);


  // Now check if the Player has been on Excelsior before
  // If TRUE, then check Players Current PC.
  if(nExcelsior)
  {
    // If they have, then they must have made a previous PC.
    // Check the regstration on the current PC.
    // If returning PC is saved PC return TRUE
    if(sCurrentPC == sPC)
    {
      // If for some reason, the Current PC has no registration, something has
      // gone wrong in the program. We will set the registration again and
      // return FALSE and let them play that PC.
      if (nCheckPCRegistration == REGISTRATION_UNKNOWN)
      {
        SetPFCampaignInt(PLAYER_REGISTRATION, sID, REGISTRATION_OPEN, oPC);
        return FALSE;
      }
      // New PC that hasn't completed the first start area or an active PC.
      else if (nCheckPCRegistration == REGISTRATION_OPEN ||
               nCheckPCRegistration == REGISTRATION_ACTIVE)
      {
        // Current PC is registered, good to play, so return FALSE.
        return FALSE;
      }
      else if (nCheckPCRegistration == REGISTRATION_CLOSED)
      {
        // Something happened in the Fugue or death scripts. PC is dead but
        // program still thinks it's active, so change current PC to NONE and
        // return TRUE to boot Player and make a new PC.
        SetPFCampaignString(MOD_CAMPAIGN_DATABASE, CURRENT_PC, "NONE", MOD_SELF);
        // Set Message to tell player what's gone wrong.
        SetLocalString(MOD_SELF, "BOOT_MESSAGE", NOT_REGISTERED);
        return TRUE;
      }
      else
      {
        // If we are here, player is trying to log in with a different PC
        // other than their current PC.
        // Set Message to tell player what's gone wrong.
        SetLocalString(MOD_SELF, "BOOT_MESSAGE", NOT_CURRENT_PC);
        return TRUE;
      }
    }
    // If they have been on Excelsior, but PC has died and player is currently
    // making a new PC. Set New PC as Current PC and set the registration.
    // Note: On Fugue Exit or Suicide, current PC is set to "NONE".
    else if(sCurrentPC == "NONE")
    {
      // This is for making a New PC.
      if (nCheckPCRegistration == REGISTRATION_UNKNOWN)
      {
        // Set registration as open and set Current PC.
        // No Message, no Boot, so return FALSE.
        SetPFCampaignInt(PLAYER_REGISTRATION, sID, REGISTRATION_OPEN, oPC);
        SetPFCampaignString(MOD_CAMPAIGN_DATABASE, CURRENT_PC, sPC, MOD_SELF);
        return FALSE;
      }
      else
      {
        // Again we should not be here, but just incase, send a message to the
        // Player, reset the Player and variables.
        SetPFCampaignString(MOD_CAMPAIGN_DATABASE, CURRENT_PC, "NONE", MOD_SELF);
        // Set Message to tell player what's gone wrong.
        SetLocalString(MOD_SELF, "BOOT_MESSAGE", NOT_REGISTERED);
        return TRUE;
      }
    }
    // If we are here, player is trying to log in with a different PC
    // other than their current PC.
    // Set Message to tell player what's gone wrong.
    SetLocalString(MOD_SELF, "BOOT_MESSAGE", NOT_CURRENT_PC);
    return TRUE;
  }
  // If we are here, then the player has never been on Excelsior before.
  // So just run through the registration just in case something's gone wrong
  // again and then reset all the varibles.
  if (nCheckPCRegistration == REGISTRATION_UNKNOWN)
  {
    SetPFCampaignInt(MOD_CAMPAIGN_DATABASE, sPCPlayer, TRUE, MOD_SELF);
    SetPFCampaignString(MOD_CAMPAIGN_DATABASE, CURRENT_PC, sPC, MOD_SELF);
    SetPFCampaignInt(PLAYER_REGISTRATION, sID, REGISTRATION_OPEN, oPC);
    return FALSE;
  }
  else if (nCheckPCRegistration == REGISTRATION_OPEN ||
           nCheckPCRegistration == REGISTRATION_ACTIVE)
  {
    SetPFCampaignInt(MOD_CAMPAIGN_DATABASE, sPCPlayer, TRUE, MOD_SELF);
    SetPFCampaignString(MOD_CAMPAIGN_DATABASE, CURRENT_PC, sPC, MOD_SELF);
    return FALSE;
  }
  // PC is dead or has commited suicide, so Boot PC.
  else if (nCheckPCRegistration == REGISTRATION_CLOSED)
  {
    SetPFCampaignString(MOD_CAMPAIGN_DATABASE, CURRENT_PC, "NONE", MOD_SELF);
    // Set Message to tell player what's gone wrong.
    SetLocalString(MOD_SELF, "BOOT_MESSAGE", NOT_REGISTERED);
    return TRUE;
  }
  // If something else is going on, Boot the PC.
  else
  {
    SetLocalString(MOD_SELF, "BOOT_MESSAGE", NOT_REGISTERED);
    return TRUE;
  }
}

////////////////////////////////////////////////////////////////////////////////
int GetIsPCBanned(object oPC)
{
  //string sIP = GetPCIPAddress(oPC);
  string sKey = GetPCPublicCDKey(oPC);
  //int nIPBanned = GetPFCampaignInt(PLAYER_REGISTRATION, sIP, oPC);
  int nKeyBanned = GetPFCampaignInt(PLAYER_REGISTRATION, sKey, oPC);
  if(nKeyBanned == REGISTRATION_BANNED)
  {
    return TRUE;
  }
  //if(nIPBanned == REGISTRATION_BANNED)
  //{
  //  return TRUE;
  //}
  return FALSE;
}

////////////////////////////////////////////////////////////////////////////////
void RemoveAllPCEffects(object oPC)
{
  int iMaxHP = GetMaxHitPoints(oPC);
  int iCurrentHP = GetCurrentHitPoints(oPC);
  int iNewHP;
  effect eEffect = GetFirstEffect(oPC);
  while (GetIsEffectValid(eEffect))
  {
    RemoveEffect(oPC, eEffect);
    eEffect = GetNextEffect(oPC);
  }
  if (iCurrentHP>iMaxHP)
  {
    iNewHP = iCurrentHP - iMaxHP;
    effect eResetHP = EffectDamage(iNewHP, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eResetHP, oPC);
  }
}

////////////////////////////////////////////////////////////////////////////////
void FaceObject(object oTarget, object oPC = OBJECT_SELF)
{
  AssignCommand(oPC, SetFacing(VectorToAngle(GetPosition(oTarget) - GetPosition(oPC))));
}

////////////////////////////////////////////////////////////////////////////////
void SendMessageToAllPCsInArea(string sMessage, object oArea)
{
  object oPC = GetFirstPC();
  object oPCArea = GetArea(oPC);
  while(GetIsObjectValid(oPC) && (oPCArea == oArea))
  {
    SendMessageToPC(oPC, sMessage);
    oPC = GetNextPC();
  }
}

////////////////////////////////////////////////////////////////////////////////
int GetParseFlagValue(string sName, string sFlag, int nDefault)
{
    int nRetValue;
    int nPos;

    nPos = FindSubString(sName, sFlag);
    if (nPos >= 0)
    {
        // Trim Flag
        sName = GetStringRight(sName, GetStringLength(sName) - (nPos + GetStringLength(sFlag)));
        nPos = FindSubString(sName, "_");
        if (nPos >= 0)
        {
            sName = GetStringLeft(sName, nPos);
        }

        // Retreive Flag
        if (TestStringAgainstPattern("*n", GetStringLeft(sName, 1)) == FALSE)
        {
            // Retreive Boolean
            nRetValue = TRUE;
        }
        else
        {
            // Retreive Value
            nRetValue = StringToInt(sName);
        }
    }
    else
    {
        nRetValue = nDefault;
    }

    // Return Value
    return nRetValue;
}

////////////////////////////////////////////////////////////////////////////////
string GetParsedSubstring(string sString, int nSubstring, string sSeparator="_")
{
    int nPos;
    string sSegment = "";
    int nStrLength;

    int nIndex;  //loop until we get to the specified substring
    for(nIndex=0; nIndex <= nSubstring; nIndex++)
    {
        //Find the position of the first occurence of sSeparator in sString from
        //  the left
        nPos = FindSubString(sString, sSeparator);

        //if we find sSeparator
        if(nPos >= 0)
        {
            //The segment will be the left end of sString
            // - use nPos so as not to include the seperator
            sSegment = GetStringLeft(sString, nPos);

            //Quit the loop if this is nSubstring
            if(nIndex == nSubstring) break;
        }
        else { break; }  //Quit the for loop if sSeparator not found

        //truncate sString to find the next occurance of sSeparator
        nStrLength = GetStringLength(sString);
        // - use nPos + 1 to include the separator
        sString = GetStringRight(sString, nStrLength - nPos + 1);
    }

    return sSegment;
}

