//::///////////////////////////////////////////////
//:: Name: AID Global Include (constants)
//:: FileName: aid_inc_global
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
  global include for AID feedback and integration with existing systems

  2/23/2007 - Renaming all scripts, constants and varnames to reflect the name
    change to AID. - TV
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright (Talan Va'lash, SongOfTheWeave) 3/8/2006
//:: Modified: 2/23/2007
//:: Modified: The Magus (2011 dec 29) adjusted colors and constants
//:://////////////////////////////////////////////

#include "te_functions"

///////////
// META  //
///////////
/*
    These are constants that The Magus tends to use to configure scripts.
    Adjust them to suit your own pruposes.
*/

// const int DEBUG = FALSE;         // used by developer during testing to have more verbose feedback
// const int MULTIPLAYER = TRUE;    // used by developer to identify module for multiplayer or singleplayer play


///////////////////////
// AID Core Feedback //
///////////////////////

/* This section defines core AID feedback.
 * It is not intended to be modified by the module builder.
 */
const string sBadCommand = "Your actions produce no result.";
const string sTest = "Testing";
//const string sGetBurnt = "The flames burn your hand.";
const string sWarmBrazier = "The brazier still feels warm to the touch.";
const string sNoDescription = "You find nothing of interest.";
const string sNoRead = "You find no writing on this object.";
const string sNotClose1 = "You find no ";
const string sNotClose2 = " nearby.";
const string sNoDrink = "You cannot drink from a ";
const string sTaken = "You take the ";
const string sTooFarToPush1 = "You cannot push the ";
const string sTooFarToPush2 = " from this far away.";
const string sNoPush1 = "The ";
const string sNoPush2 = " is firmly set in place.";
const string sNoPushWall1 = "You cannot push the ";
const string sNoPushWall2 = " in that direction. The path is blocked.";
const string sDMSet1 = "You have set the ";
const string sDMSet2 = " description on the ";
const string sDMSet3 = " integer on the ";
const string sDMDestroy = " will be destroyed.";
const string sLookAround1 = "On quick inspection you see ";

const string sLookAroundA = "a ";
const string sLookAroundAn = "an ";
const string COMMA = ", ";
const string HYPEN = " - ";
const string COLON = ": ";
const string sLookAroundNothing = "You see nothing worth further inspection.";
const string sLookAroundPeriod = ".";
const string sDMDumpOpening1 = "AID variables on ";
const string sDebugMode1 = "DebugMode on.";
const string sDebugMode2 = "DebugMode off.";

//////////////////////
//AID Core Constants//
//////////////////////
/* Do not adjust these unless you are sure you want to. They have a sizable
 * impact on playability and ease of use.
 */

// DISTANCES
/** MAX_DISTANCE - Defines the maximum distance from the speaker that an object
 * can be addressed with an AID action. Note that some actions are limited to
 * shorter distances. This eliminates the silly situation where one may
 * end up running to an object on the opposite end of the area that may not even
 * be visible from their location. */
const float MAX_DISTANCE = 15.0;
/** MAX_DISTANCE_LOOK - Defines the maximum distance from the speaker for an
 * object to be listed when using the *look around* command. */
const float MAX_DISTANCE_LOOK       = 15.0;
const float MAX_DISTANCE_EXAMINE    = 4.0;
const float MAX_DISTANCE_TOUCH      = 2.0;

// COLORS
/*  These are the colors used in the AID responses. They may be adjusted to
    taste though be aware that the toolset script editor does not play nice with
    certain characters, as such a number of colors will generate compile errors.
 */
/* // moving to v2_inc_color
const string COLOR_ACTION       = LIGHTBLUE; //"<c#ßþ>"; // "<c¯>";
const string COLOR_OBJECT       = GREEN; // "<c0¡0>"; //"<c¯æ>";
const string COLOR_DESCRIPTION  = LIME; // "<c¡Òd>";
const string COLOR_MESSAGE      = LIGHTGREY; // "<c¥¥¥>"; // "<cŠŠŠ>";
const string COLOR_WHITE        = WHITE; //"<cððð>";
const string COLOR_DUMPHEADER   = "<c©>";
const string COLOR_VARNAME      = "<c†>";
*/
//constant var names. Do not modify.
const string AID_TRIGGERING_OBJECT = "aid_eventtriggering";
const string AID_USER_DEFINED_GLOBAL_ACTION_QUANTITY = "aid_usdef_global_quantity";
const string AID_USER_DEFINED_LOCAL_ACTION_QUANTITY = "aid_usdef_local_quantity";
const string AID_USER_DEFINED_GLOBAL_ACTION_PREFIX = "aid_usdef_global_";
const string AID_USER_DEFINED_LOCAL_ACTION_PREFIX = "aid_usdef_local_";

//:://////////////////////////////////////////////
//:: Prefab Effects
//:://////////////////////////////////////////////
/*
   7/23/2006 - Commenting these all out as they're unused at this time - TV
   7/25/2006 - uncommented ones that are used
*/
//:://////////////////////////////////////////////

//////////////////////////
//Instant damage effects//
//////////////////////////

//Physical//
/*
effect e2D6BludgeoningDamage = EffectDamage(d6(2), DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);      //2d6 Bludgeoning damage
effect e2D6SlashingDamage = EffectDamage(d6(2), DAMAGE_TYPE_SLASHING, DAMAGE_POWER_NORMAL);      //2d6 slashing damage
effect e2D6PiercingDamage = EffectDamage(d6(2), DAMAGE_TYPE_PIERCING, DAMAGE_POWER_NORMAL);      //2d6 piercing damage
//Elemental//
*/
//oh, I am using this one
effect e2D6FireDamage = EffectDamage(d6(2), DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL);      //2d6 fire damage
effect e2D3FireDamage = EffectDamage(d3(2), DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL);      //2d3 fire damage

/*
effect e2D6ElecDamage = EffectDamage(d6(2), DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_NORMAL);      //2d6 electrical damage
effect e2D6AcidDamage = EffectDamage(d6(2), DAMAGE_TYPE_ACID, DAMAGE_POWER_NORMAL);      //2d6 acid damage
effect e2D6ColdDamage = EffectDamage(d6(2), DAMAGE_TYPE_COLD, DAMAGE_POWER_NORMAL);      //2d6 cold damage
effect e2D6SonicDamage = EffectDamage(d6(2), DAMAGE_TYPE_SONIC, DAMAGE_POWER_NORMAL);      //2d6 sonic damage
effect e2D6DivineDamage = EffectDamage(d6(2), DAMAGE_TYPE_DIVINE, DAMAGE_POWER_NORMAL);      //2d6 divine damage
effect e2D6MagicalDamage = EffectDamage(d6(2), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);      //2d6 magical damage
effect e2D6NegativeDamage = EffectDamage(d6(2), DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_NORMAL);      //2d6 negative damage
effect e2D6PositiveDamage = EffectDamage(d6(2), DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL);      //2d6 positive damage
*/
