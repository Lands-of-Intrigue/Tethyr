//:://////////////////////////////////////////////////
//:: X0_I0_SECRET
//:: Copyright (c) 2002 Floodgate Entertainment
//:://////////////////////////////////////////////////
/*
Shared functions for secret/hidden items. Based on work
by Bioware's Robert Babiak for the secret doors.

The modifications I've made are to use a trigger instead of
an invisible item with an OnHeartbeat. This method is
considerably less CPU-intensive and more flexible in determining
the shape of the area in which the secret item can be detected.
The trade-off is that you have to create one additional waypoint
to specify where the item should appear.

Process:
- Create a trigger marking off the area where the secret
  item can be detected. There are several varieties already
  pre-created in the blueprints for different items.

- edit the properties of the trigger as follows:
  o Set the tag to something unique;
  o On the "Scripts" tab, for "On Enter", pick "x0_o2_sec_<item type>"
  o On the "Advanced" tab, put an integer into the "Key Tag"
    field: this will be the DC for detection;

- create a waypoint named "LOC_<tag of trigger>" and place it
  where you want the item to appear. Note that some items (like
  the trap door) have their orientation reversed; test to make sure
  the item appears with the desired orientation.

- if you are creating a secret transport object like a door or
  portal, create a waypoint named "DST_<tag of trigger>" and
  place it where you want the user to appear after use. Associates
  will be brought along for the ride even within the same area.

- both the secret item and the detection trigger will be sent a
  user-defined event with the value EVENT_SECRET_REVEALED. To
  cause a reset, you can simply choose the 'x0_o2_sec_reset' script
  as the user-defined event handler for the detection trigger, or
  you can put something else in if you want to do something fancy.

- you can get a reference to the revealed secret item by using
  "GetSecretItemRevealed(<trigger object>)".

 */
//:://////////////////////////////////////////////////
//:: Created By: Naomi Novik
//:: Created On: 10/06/2002
//:://////////////////////////////////////////////////

#include "x0_i0_common"
#include "x0_i0_match"

#include "te_functions"

/**********************************************************************
 * CONSTANTS
 **********************************************************************/

// Variable that indicates whether this item is revealed or not
const string sRevealedVarname = "SECRET_IS_REVEALED";

// Variable that indicates whether this item is open/closed
const string sOpenVarname = "IS_OPEN";

// Variable that holds the tag of the item this detection item reveals
const string sSecretItemVarname = "SECRET_OBJECT";

// Variable that holds the detection trigger of this secret item
const string sDetectTriggerVarname = "SECRET_TRIGGER";

// Prefix on player to indicate whether they have found this
// item before. If they have, don't make them search again.
const string sFoundPrefix = "SECRET_FOUND_";

// Prefix for the waypoint marking the destination of a secret door
const string sDestinationPrefix = "dst_";

// Prefix for the waypoint marking where the secret item should appear
const string sLocationPrefix = "loc_";


// User-defined event that the item generates when found (can be used
// to cause a reset) -- this goes to both the item itself and to
// the detection trigger.
const int EVENT_SECRET_REVEALED = 2801;
const int EVENT_SECRET_DETECTED = 2802;

/**********************************************************************
 * FUNCTION PROTOTYPES
 **********************************************************************/


void CopyAllSecretVariables(object oTargetA, object oTargetB);

void CopySecretVariable(object oTargetA, object oTargetB, string sVarName, int iVarIsInt = 0);

// Returns whether the associated secret item is currently revealed;
// should be called from the detect trigger, not the item itself.
// (If you have the item itself, it is definitely revealed!)
int GetIsSecretItemRevealed(object oDetectTrigger=OBJECT_SELF);

// Returns the associated secret item
object GetSecretItemRevealed(object oDetectTrigger=OBJECT_SELF);

// Returns whether the secret item is currently open --
// should be called from the secret item itself after
// being revealed.
int GetIsSecretItemOpen(object oSecretItem=OBJECT_SELF);

// Set whether the secret item is open or not
void SetIsSecretItemOpen(object oSecretItem=OBJECT_SELF, int bValue=TRUE);

// Detection function for a secret item.
// Uses the specified skill (defaults to SKILL_SEARCH; use any of the
// SKILL_ constants here) and uses the key tag of the trigger as the DC
// of the detection check.
// Returns TRUE if player detects, FALSE otherwise.
int DetectSecretItem(object oPC, object oDetectTrigger=OBJECT_SELF, int nSkillType=SKILL_SEARCH);

// Detection function for a secret item - [FILE: x0_i0_secret]
// oCreature detects or knows of oSecret
// oSecret can be a secret door, or a hidden AID object
// bAnnounce - determines whether the voice chat is played
int SecretGetCreatureDetects(object oCreature, object oSecret=OBJECT_SELF, int bAnnounce=TRUE);

// Detection function that reveals an item only to members of the specified
// class. Compares the PC's level in the class plus a small modifier against
// the value of the key tag of the trigger.
int DetectSecretItemByClass(object oPC, object oDetectTrigger=OBJECT_SELF, int nClassType=CLASS_TYPE_RANGER);

// Reveal function for a secret item. When called, this item
// creates the secret item from blueprint in the location of the
// item waypoint. Any item blueprint resref can be used here.
// Some common items are the ones in the placeables palette listed
// under "Secret Items".
void RevealSecretItem(string sResRef, object oDetectTrigger=OBJECT_SELF);

// Reset function for a secret item. When called, this destroys the
// item and resets the invisible detection object going again. This WILL
// cause any treasure and locks/traps on the door to regenerate.
void ResetSecretItem(object oDetectTrigger=OBJECT_SELF);

// Use a secret transport to transport a PC and associates
void UseSecretTransport(object oPC, object oDetectTrigger=OBJECT_SELF);

// -----------------------------------------------------------------------------
// added by henesua

// Prepares a secret door based on local variables on trigger [File: x0_i0_secret]
// intention: allow a builder to specify whether secret door is locked, requires a key etc...
void InitializeSecretDoor(object oSecretTrigger=OBJECT_SELF);

/**********************************************************************
 * FUNCTION DEFINITIONS
 **********************************************************************/

void CopyAllSecretVariables(object oTargetA, object oTargetB)
{
    CopySecretVariable(oTargetA, oTargetB, "SECRET", 1);
    CopySecretVariable(oTargetA, oTargetB, "SECRET_NATURE", 1);
    CopySecretVariable(oTargetA, oTargetB, "SECRET_SKILL");
    CopySecretVariable(oTargetA, oTargetB, "SECRET_SKILL_INDEX", 1);
    CopySecretVariable(oTargetA, oTargetB, "SECRET_SKILL_DC", 1);
    CopySecretVariable(oTargetA, oTargetB, "SECRET_LOCK", 1);
    CopySecretVariable(oTargetA, oTargetB, "SECRET_LOCK_DC", 1);
    CopySecretVariable(oTargetA, oTargetB, "SECRET_LOCK_KEY");
    CopySecretVariable(oTargetA, oTargetB, "SECRET_LOCK_KEY_REQUIRED",1);
    CopySecretVariable(oTargetA, oTargetB, "SECRET_DISCOVERY_MESSAGE");
    CopySecretVariable(oTargetA, oTargetB, "SECRET_PLACEABLE");
    CopySecretVariable(oTargetA, oTargetB, "SECRET_DOOR");
    CopySecretVariable(oTargetA, oTargetB, "SECRET_DOOR_PAIRED");
}

void CopySecretVariable(object oTargetA, object oTargetB, string sVarName, int iVarIsInt = 0)
{
    if (iVarIsInt)
    {
        int iTemp = GetLocalInt(oTargetA, sVarName);

        if (iTemp != 0)
        {
            SetLocalInt(oTargetB, sVarName, iTemp);
        }
    }
    else
    {
        string sTemp = GetLocalString(oTargetA, sVarName);

        if (sTemp != "")
        {
            SetLocalString(oTargetB, sVarName, sTemp);
        }
    }
}

// Determine if the secret item is revealed
int GetIsSecretItemRevealed(object oDetectTrigger=OBJECT_SELF)
{
    return GetLocalInt(oDetectTrigger, sRevealedVarname);
}

// Returns the associated secret item
object GetSecretItemRevealed(object oDetectTrigger=OBJECT_SELF)
{
    if (!GetIsSecretItemRevealed(oDetectTrigger))
        return OBJECT_INVALID;

    return  GetLocalObject(oDetectTrigger, sSecretItemVarname);
}


// Returns whether the secret item is currently open --
// should be called from the secret item itself after
// being revealed.
int GetIsSecretItemOpen(object oSecretItem=OBJECT_SELF)
{
    return GetLocalInt(oSecretItem, sOpenVarname);
}

// Set whether the secret item is open or not
void SetIsSecretItemOpen(object oSecretItem=OBJECT_SELF, int bValue=TRUE)
{
    SetLocalInt(oSecretItem, sOpenVarname, bValue);
}


// Private function (not prototyped to keep invisible in comments section)
// just to avoid a bit of duplicate code in the Detect... functions.
int QuickDetectSecret(object oPC, object oDetectTrigger)
{
    // If the item's visible, it's easy to detect, but the player
    // who just sees it as a benefit of someone else's detection
    // may not be able to find it again.
    if (GetIsSecretItemRevealed(oDetectTrigger)) {return TRUE;}

    // If the PC has found it once, they don't have to try again
    if( GetLocalInt(oPC, sFoundPrefix+ObjectToString(oDetectTrigger)) )
    {
        return TRUE;
    }
    return FALSE;
}


// Detection function for a secret item.
// Uses the specified skill (defaults to SKILL_SEARCH; use any of the
// SKILL_ constants here) and uses the key tag of the trigger as the DC
// of the detection check.
// Returns TRUE if player detects, FALSE otherwise.
int DetectSecretItem(object oPC,
                     object oDetectTrigger=OBJECT_SELF,
                     int nSkillType=SKILL_SEARCH)
{
    if( !GetIsObjectValid(oPC) || !GetIsObjectValid(oDetectTrigger) ){ return FALSE; }

    if( QuickDetectSecret(oPC,oDetectTrigger) ){ return TRUE; }

    int nDC     = StringToInt(GetLockKeyTag(oDetectTrigger));
    int nSkill  = GetSkillRank(nSkillType, oPC);
    int nMod    = d20();

    //DBG_msg("Diff: " + IntToString(nDC));

    if (nSkill + nMod > nDC) {
        // Mark the PC as having found it
        //SetLocalInt(oPC, sFoundPrefix + GetTag(oDetectTrigger), TRUE);
        SetLocalInt(oPC, sFoundPrefix+ObjectToString(oDetectTrigger), TRUE);
        //DBG_msg("Found it");
        return TRUE;
    }

    return FALSE;
}

int SecretGetCreatureDetects(object oCreature, object oSecret=OBJECT_SELF, int bAnnounce=TRUE)
{
    string sSecretID    = ObjectToString(oSecret);

    if(     GetLocalInt(oCreature, sFoundPrefix+sSecretID)
        ||  GetIsSecretItemRevealed(oSecret)
      )
        return TRUE;
    int bNatureReq  = GetLocalInt(oSecret, "SECRET_NATURE");
    int nSkill      = GetLocalInt(oSecret, "SECRET_SKILL_INDEX");
    int nDC         = GetLocalInt(oSecret, "SECRET_SKILL_DC");
    if(!nDC)
        nDC         = 10;

    if( bNatureReq )
    {
        /*
        if(CreatureGetHasWildcraft(oCreature))
        {
            nDC -= 5;
            if(nDC<1)
                nDC=1;
        }
        */
    }

    if(!nSkill)
    {
        string sSkill   = GetStringLowerCase(GetLocalString(oSecret, "SECRET_SKILL"));
        if(FindSubString(sSkill, "sear")!=-1)
            nSkill  = SKILL_SEARCH;
        else if(FindSubString(sSkill, "list")!=-1)
            nSkill  = SKILL_LISTEN;
        else if(FindSubString(sSkill, "lore")!=-1)
            nSkill  = SKILL_LORE;
        else if(FindSubString(sSkill, "spell")!=-1)
            nSkill  = SKILL_SPELLCRAFT;
        else
            nSkill  = SKILL_SPOT;

        SetLocalInt(oSecret, "SECRET_SKILL_INDEX", nSkill);
    }

    if(nSkill==SKILL_SPOT && GetHasEffect(EFFECT_TYPE_BLINDNESS,oCreature))
        return FALSE;
    else if(    nSkill==SKILL_LISTEN
            && (GetHasEffect(EFFECT_TYPE_DEAF,oCreature)||GetHasEffect(EFFECT_TYPE_SILENCE,oCreature))
           )
        return FALSE;

    if(H_DoSkillCheck(oCreature, nSkill, nDC))
    {
        SetLocalInt(oCreature, sFoundPrefix+sSecretID, TRUE);
        string sMsg = GetLocalString(oSecret, "SECRET_DISCOVERY_MESSAGE");

        if (!GetIsPC(oCreature))
        {
            object oMaster = GetMaster(oCreature);
            if( GetIsObjectValid(oMaster) )
            {
                if(bAnnounce&&GetObjectHeard(oMaster,oCreature))
                    // say something to draw attention
                    AssignCommand(oCreature, PlayVoiceChat(VOICE_CHAT_SEARCH));

                int nAssType = GetAssociateType(oCreature);
                if(     nAssType==ASSOCIATE_TYPE_FAMILIAR
                    ||  nAssType==ASSOCIATE_TYPE_ANIMALCOMPANION
                  )
                    // Mark the Master as having found it
                    SetLocalInt(oMaster, sFoundPrefix+sSecretID, TRUE);
            }
        }
        else if( bAnnounce&&!GetStealthMode(oCreature) )
            AssignCommand(oCreature, PlayVoiceChat(VOICE_CHAT_LOOKHERE) );

        if(sMsg!="")
        {
            SendMessageToPC(oCreature,DoColorize("("+GetName(oSecret)+") "+sMsg,TRUE));
        }
        return TRUE;
    }

    return FALSE;
}


// Detection function that reveals an item only to members of the specified
// class. Compares the PC's level in the class plus a small modifier against
// the value of the key tag of the trigger.
int DetectSecretItemByClass(object oPC,
                            object oDetectTrigger=OBJECT_SELF,
                            int nClassType=CLASS_TYPE_RANGER)
{
    if (!GetIsObjectValid(oPC) || !GetIsObjectValid(oDetectTrigger)) {
        return FALSE;
    }

    if (QuickDetectSecret(oPC, oDetectTrigger)) {return TRUE;}

    int nDetectDifficulty = StringToInt(GetLockKeyTag(oDetectTrigger));
    int nMod = d4();
    int nLevel = GetLevelByClass(nClassType, oPC);

    //DBG_msg("Diff: " + IntToString(nDetectDifficulty));

    if (nLevel + nMod > nDetectDifficulty) {
        // Mark the PC as having found it
        SetLocalInt(oPC, sFoundPrefix+ObjectToString(oDetectTrigger), TRUE);
        //DBG_msg("Found it");
        return TRUE;
    }

    return FALSE;
}


// Reveal function for a secret item. When called, this item
// creates the secret item from blueprint in the location of the
// item waypoint. Search for "SECRET_" under Constants
// to see some common blueprints, although any item blueprint can be used here.
void RevealSecretItem(string sResRef, object oDetectTrigger=OBJECT_SELF)
{
    if (!GetIsObjectValid(oDetectTrigger)) {return;}

    // Don't reveal twice
    if (GetIsSecretItemRevealed(oDetectTrigger)) {return;}

    // Get the location where the item will appear
    string sWaypointTag = sLocationPrefix + GetTag(oDetectTrigger);
    object oWaypoint = GetNearestObjectByTag(sWaypointTag);

    // Manually look for fallback since GetNearestObjectByTag doesn't find anything outside the area.
    if ( ! GetIsObjectValid(oWaypoint) )
        oWaypoint = GetObjectByTag(sWaypointTag);

    if ( ! GetIsObjectValid(oWaypoint) )
        return;

    location lLoc = GetLocation(oWaypoint);

    // Create the object and do use the appear animation
    object oSecretItem = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc, TRUE);
    if (GetIsObjectValid(oSecretItem))
    {
        // Mark it as revealed
        SetLocalInt(oDetectTrigger, sRevealedVarname, TRUE);

        // Store it on the detection item and vice versa
        SetLocalObject(oDetectTrigger, sSecretItemVarname, oSecretItem);
        SetLocalObject(oSecretItem, sDetectTriggerVarname, oDetectTrigger);

        // Signal the item and the trigger both
        SignalEvent(oDetectTrigger, EventUserDefined(EVENT_SECRET_REVEALED));
        SignalEvent(oSecretItem, EventUserDefined(EVENT_SECRET_REVEALED));
    }

}

// Reset function for a secret item. When called, this destroys the
// item and resets the invisible detection object going again. This WILL
// cause any treasure and such to regenerate.
void ResetSecretItem(object oDetectTrigger=OBJECT_SELF)
{
    // Don't reset if it's not revealed
    if (!GetIsSecretItemRevealed(oDetectTrigger)) {return;}

    // Destroy it with a fancy effect
    object oSecretItem = GetLocalObject(oDetectTrigger, sSecretItemVarname);
    if (GetIsObjectValid(oSecretItem))
    {
        effect eDisappear = EffectDisappear();
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDisappear, oSecretItem);
        DestroyObject(oSecretItem);
    }

    // Mark it as not revealed
    SetLocalInt(oDetectTrigger, sRevealedVarname, FALSE);

    // Clear the variable on the trigger
    DeleteLocalObject(oDetectTrigger, sSecretItemVarname);
}

// Use a secret transport to transport a PC and associates.
// This can actually also be used for regular portals and trapdoors,
// as long as the destination waypoint instead uses the tag of
// the portal/trapdoor.
void UseSecretTransport(object oPC, object oSecretItem=OBJECT_SELF)
{
    // Get the tag of the detection trigger. If it doesn't exist,
    // use the item itself. (This is mainly for convenience so we
    // can reuse this script for regular trap doors, etc.)
    object oTrigger = GetLocalObject(oSecretItem, sDetectTriggerVarname);
    string sTag;
    if (GetIsObjectValid(oTrigger)) {
        sTag = GetTag(oTrigger);
    } else {
        sTag = GetTag(oSecretItem);
    }

    // Get the destination waypoint
    string sDestTag = sDestinationPrefix + sTag;
    object oWaypoint = GetWaypointByTag(sDestTag);
    /*
    object oWaypoint = GetNearestObjectByTag(sDestTag);

    // Manually look for fallback since GetNearestObjectByTag
    // doesn't find anything outside the area.
    if ( ! GetIsObjectValid(oWaypoint) )
        oWaypoint = GetObjectByTag(sDestTag);
    */


    // Transport away
    if (GetIsObjectValid(oWaypoint))
    {
        string sSnd = GetLocalString(oSecretItem, "DOOR_SOUND");
        if(sSnd!="")
            AssignCommand(oPC, PlaySound(sSnd));
        int nVFX    = GetLocalInt(oSecretItem, "DOOR_VFX");
        if(nVFX)
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(nVFX), GetLocation(oPC));
        TransportToWaypoint(oPC, oWaypoint);
    }
}


// -----------------------------------------------------------------------------
// added by henesua

void InitializeSecretDoor(object oDetectTrigger=OBJECT_SELF)
{
    object oDoor    = GetLocalObject(oDetectTrigger, sSecretItemVarname);

    if(GetLocalInt(oDoor, "INITIALIZED")){return;}

    if(GetLocalInt(oDetectTrigger, "SECRET_LOCK"))
    {
        SetLocked(oDoor, TRUE);
        int nLockDC     = GetLocalInt(oDetectTrigger, "SECRET_LOCK_DC");
        if(!nLockDC)nLockDC=15;
        SetLockLockDC(oDoor,nLockDC);
        SetLockKeyTag(oDoor, GetLocalString(oDetectTrigger, "SECRET_LOCK_KEY"));
        SetLockKeyRequired(oDoor, GetLocalInt(oDetectTrigger, "SECRET_LOCK_KEY_REQUIRED"));
    }


    SetLocalInt(oDoor, "INITIALIZED", TRUE);
}


/*  void main() {} /* */
