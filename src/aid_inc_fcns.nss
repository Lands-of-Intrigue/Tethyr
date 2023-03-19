//::///////////////////////////////////////////////
//:: Name: AID function include
//:: FileName: aid_inc_fcns
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
  Moved from nwaid_actnarra to alleviate overcrowding

  11/20/2006 - Added GetObjectInArea() for use in the onEnter
  2/23/2007 - Renaming all scripts, constants and varnames to reflect the name
    change to AID. - TV
*/
//:://////////////////////////////////////////////
//:: Created: Jesse Wright 6/15/2006
//:: Modified: 2/23/2007
//:://////////////////////////////////////////////
//:: Modified: The Magus (2012 mar 8) substantial changes for AID v3
//::                                    AIDParseEmote enables hooking in with OnChat events


#include "aid_inc_global"

#include "x0_i0_secret"
#include "te_functions"

// DECLARATIONS ----------------------------------------------------------------

// Calls CopyAIDVariable to Copy all AID variables from oTargetA to oTargetB [file: aid_inc_fcns]
void CopyAllAIDVariables(object oTargetA, object oTargetB);
// Copies the local var sVarName from oTargetA to oTargetB [file: aid_inc_fcns]
// iVarIsInt - if False, the var is assumed to be a string. Pass in true if var is an int
void CopyAIDVariable(object oTargetA, object oTargetB, string sVarName, int iVarIsInt = 0);
// DM function - dumps all AID vars of given object to the DM via server msg [file: aid_inc_fcns]
void DumpAIDVariables(object oPC, object oTarget);
// Sends the AID var sVarName on oTarget to oDM if the var exists [file: aid_inc_fcns]
// iVarIsInt - if False, the var is assumed to be a string. Pass in true if var is an int
void SendAIDVariableToDM(object oDM, object oTarget, string sVarName, int VarIsInt = 0);
// Processes AID commands as emotes from within DMFI's emote parsing [file: aid_inc_fcns]
// Called by [file:] dmfi_plychat_fnc [fn:] ParseEmote()
// custom AID addition by The Magus
int AIDParseEmote(object oPC, string sSpeech);
// returns true if sVerb is a valid keyword for an aid action [file: aid_inc_fcns]
// otherwise returns false
int IsActionValid(string sVerb);
// Handles routing of all events after parsing   [file: aid_inc_fcns]
// oTargetObject - AID object oPlayer is Speaking at
// sVerb - Action oPlayer is attempting to perform on oTargetObject
int ActionFork(object oTargetObject, object oPlayer, string sVerb);
// Gathers list of nearby AID objects which the player may see [file: aid_inc_fcns]
string GetNamesOfNearbyAIDObjects(object oPC);
// Handles the emote *looks around* [file: aid_inc_fcns]
void DoLookAround(object oPC, int animate=FALSE);
void DoSearchArea(object oPC);
int DoLookMoon(object oPC);
int DoBurn(object oTarget, object oPC, int nFire=1);
int DoAcid(object oTarget, object oPC, int nAcid=1);
int DoDrink(object oTarget, object oPC);
int DoExamine(object oTarget, object oPC);
int DoPush(object oTarget, object oPC, string sVerb="push");
int DoRead(object oTarget, object oPC);
// Handles action of taking the item  [file: aid_inc_fcns]
void PCTakesItem(object oTarget, string sTakeItem);
int DoTake(object oTarget, object oPC);

int DoTouch(object oTarget, object oPC);
int DoMove(object oTarget, object oPC, string sVerb="climb");
int OnDrink(object oCaller, object oPC, int iSkip);
int OnExamine(object oCaller, object oPC, int iSkip, float fDelay);
int OnExtinguish(object oCaller, object oPC, int iSkip);
int OnLight(object oCaller, object oPC, int iSkip);
int OnPush(object oCaller, object oPC, int iSkip, string sVerb="push");
int OnRead(object oCaller, object oPC, int iSkip);
int OnSecretWord(object oCaller, object oPC);
int OnTake(object oCaller, object oPC, int iSkip);
int OnTouch(object oCaller, object oPC, int iSkip);
int OnUserDefined(object oCaller, object oPC, string sAction, int iSkip);

object SecretWord(object oPC, string sSpeech);
int SkillCheck(object oTarget, object oPC, string sEvent);

// Makes the PC move to an object and do an animation. [file: aid_inc_fcns]
// fDurationSeconds is the duration to play the animation.
void DoManipulate(object oPC, object oTarget, int iAnimation, float fDurationSeconds = 0.0);
// oSpeaker speaks sSpeech at iVolume [file: aid_inc_fcns]
void DoSpeak(object oSpeaker, string sSpeech, int iVolume = TALKVOLUME_TALK);
// Checks conditions and makes oPC move to and turns on a light source (oTarget) [file: aid_inc_fcns]
// if appropriate, gives feedback.
int DoLight(object oTarget, object oPC);
// Checks conditions and makes the oPC move to and turns off a light source [file: aid_inc_fcns]
//(oTarget) if appropriate, and gives feedback.
int DoExtinguish(object oTarget, object oPC);
// Applies a linked effect of eEffect and iVFX to oPC of DURATION_TYPE_*, iDurationType and a duration of fDuration [file: aid_inc_fcns]
// oPC excliams sPCExclaims (cry out, cuss, groan, "wtf?!")
void EffectHit(object oPC, effect eEffect, int iVFX, int iDurationType = DURATION_TYPE_INSTANT, float fDuration = 0.0, string sPCExclaims = "");
// Returns an appropriate amount of time to delay for the distance oTargetA must [file: aid_inc_fcns]
// move to arrive at oTargetB. For running target iIsRunning = TRUE, for a walking
// target use FALSE.
float FindDelay(object oTargetA, object oTargetB, int iIsRunning = TRUE);
// returns the nth instance of an object with sTag in the area of oPC [file: aid_inc_fcns]
object GetObjectInArea(string sTag, object oPC, int n=1);
// For use in nwaid onevent scripts. [file: aid_inc_fcns]
// returns the object that triggered the nwaid event
object GetTriggeringObject();
// Checks sWord against a list of ignored words. Returns TRUE on match [file: aid_inc_fcns]
// Ignored words:  a, at, from, the, to, over
int IsIgnoredWord(string sWord);
// Saving throw [file: aid_inc_fcns]
// iSaveType - 0=Fort 1=Ref 2=Will
// unused in core nwaid
int RollSave(object oPC, int iDC, int iSaveType, int iSaveSubType);

// IMPLEMENTATION --------------------------------------------------------------

//::///////////////////////////////////////////////
//:: Name: CopyAllAIDVariables
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
copies all AID variables from oTargetA to oTargetB
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 6/12/2006
//:: Last Modified: 6/12/2006
//:://////////////////////////////////////////////

void CopyAllAIDVariables(object oTargetA, object oTargetB)
{
        //Dump vars
    CopyAIDVariable(oTargetA, oTargetB, "examine");
    CopyAIDVariable(oTargetA, oTargetB, "touch");
    CopyAIDVariable(oTargetA, oTargetB, "read");
    CopyAIDVariable(oTargetA, oTargetB, "drink");
    CopyAIDVariable(oTargetA, oTargetB, "drinkeffect");
    CopyAIDVariable(oTargetA, oTargetB, "push", 1);
    CopyAIDVariable(oTargetA, oTargetB, "pull", 1);
    CopyAIDVariable(oTargetA, oTargetB, "takeitem");
    CopyAIDVariable(oTargetA, oTargetB, "taketag");
    CopyAIDVariable(oTargetA, oTargetB, "takedescription");
    CopyAIDVariable(oTargetA, oTargetB, "takename");
    CopyAIDVariable(oTargetA, oTargetB, "takemax",1);
    CopyAIDVariable(oTargetA, oTargetB, "taken",1);
    CopyAIDVariable(oTargetA, oTargetB, "takelast",1);
    CopyAIDVariable(oTargetA, oTargetB, "takerefresh",1);
    CopyAIDVariable(oTargetA, oTargetB, "secretword");
    CopyAIDVariable(oTargetA, oTargetB, "LIGHTABLE", 1);
    CopyAIDVariable(oTargetA, oTargetB, "defaultlighting", 1);
    CopyAIDVariable(oTargetA, oTargetB, "onexamine");
    CopyAIDVariable(oTargetA, oTargetB, "ontouch");
    CopyAIDVariable(oTargetA, oTargetB, "ondrink");
    CopyAIDVariable(oTargetA, oTargetB, "ontake");
    CopyAIDVariable(oTargetA, oTargetB, "onpush");
    CopyAIDVariable(oTargetA, oTargetB, "onpull");
    CopyAIDVariable(oTargetA, oTargetB, "extinguish");
    CopyAIDVariable(oTargetA, oTargetB, "light");
    CopyAIDVariable(oTargetA, oTargetB, "onsecretword");
    CopyAIDVariable(oTargetA, oTargetB, "secretwordresponse");

    if (GetLocalInt(oTargetA, "checkexamine") == 1)
    {
        CopyAIDVariable(oTargetA, oTargetB, "checkexamine", 1);
        CopyAIDVariable(oTargetA, oTargetB, "examinedc", 1);
        CopyAIDVariable(oTargetA, oTargetB, "examineskill", 1);
        CopyAIDVariable(oTargetA, oTargetB, "examinepassresponse");
        CopyAIDVariable(oTargetA, oTargetB, "examinefailresponse");
        CopyAIDVariable(oTargetA, oTargetB, "examineoneventon");
    }
    if (GetLocalInt(oTargetA, "checktouch") == 1)
    {
        CopyAIDVariable(oTargetA, oTargetB, "checktouch", 1);
        CopyAIDVariable(oTargetA, oTargetB, "touchdc", 1);
        CopyAIDVariable(oTargetA, oTargetB, "touchskill", 1);
        CopyAIDVariable(oTargetA, oTargetB, "touchpassresponse");
        CopyAIDVariable(oTargetA, oTargetB, "touchfailresponse");
        CopyAIDVariable(oTargetA, oTargetB, "touchoneventon");
    }
    if (GetLocalInt(oTargetA, "checkread") == 1)
    {
        CopyAIDVariable(oTargetA, oTargetB, "checkread", 1);
        CopyAIDVariable(oTargetA, oTargetB, "readdc", 1);
        CopyAIDVariable(oTargetA, oTargetB, "readlanguage", 1);
        CopyAIDVariable(oTargetA, oTargetB, "readskill", 1);
        CopyAIDVariable(oTargetA, oTargetB, "readpassresponse");
        CopyAIDVariable(oTargetA, oTargetB, "readfailresponse");
        CopyAIDVariable(oTargetA, oTargetB, "readoneventon");
        CopyAIDVariable(oTargetA, oTargetB, "readobjecttag", 1);
    }
    if (GetLocalInt(oTargetA, "checkdrink") == 1)
    {
        CopyAIDVariable(oTargetA, oTargetB, "checkdrink", 1);
        CopyAIDVariable(oTargetA, oTargetB, "drinkdc", 1);
        CopyAIDVariable(oTargetA, oTargetB, "drinkskill", 1);
        CopyAIDVariable(oTargetA, oTargetB, "drinkpassresponse");
        CopyAIDVariable(oTargetA, oTargetB, "drinkfailresponse");
        CopyAIDVariable(oTargetA, oTargetB, "drinkoneventon");
    }
    if (GetLocalInt(oTargetA, "checkpush") == 1)
    {
        CopyAIDVariable(oTargetA, oTargetB, "checkpush", 1);
        CopyAIDVariable(oTargetA, oTargetB, "pushdc", 1);
        CopyAIDVariable(oTargetA, oTargetB, "pushskill", 1);
        CopyAIDVariable(oTargetA, oTargetB, "pushpassresponse");
        CopyAIDVariable(oTargetA, oTargetB, "pushfailresponse");
        CopyAIDVariable(oTargetA, oTargetB, "pushoneventon");
    }
    if (GetLocalInt(oTargetA, "checkpull") == 1)
    {
        CopyAIDVariable(oTargetA, oTargetB, "checkpull", 1);
        CopyAIDVariable(oTargetA, oTargetB, "pulldc", 1);
        CopyAIDVariable(oTargetA, oTargetB, "pullskill", 1);
        CopyAIDVariable(oTargetA, oTargetB, "pullpassresponse");
        CopyAIDVariable(oTargetA, oTargetB, "pullfailresponse");
        CopyAIDVariable(oTargetA, oTargetB, "pulloneventon");
    }
    if (GetLocalInt(oTargetA, "checktake") == 1)
    {
        CopyAIDVariable(oTargetA, oTargetB, "checktake", 1);
        CopyAIDVariable(oTargetA, oTargetB, "takedc", 1);
        CopyAIDVariable(oTargetA, oTargetB, "takeskill", 1);
        CopyAIDVariable(oTargetA, oTargetB, "takepassresponse");
        CopyAIDVariable(oTargetA, oTargetB, "takefailresponse");
        CopyAIDVariable(oTargetA, oTargetB, "takeoneventon");
    }
    if (GetLocalInt(oTargetA, "checklight") == 1)
    {
        CopyAIDVariable(oTargetA, oTargetB, "checklight", 1);
        CopyAIDVariable(oTargetA, oTargetB, "lightdc", 1);
        CopyAIDVariable(oTargetA, oTargetB, "lightskill", 1);
        CopyAIDVariable(oTargetA, oTargetB, "lightpassresponse");
        CopyAIDVariable(oTargetA, oTargetB, "lightfailresponse");
        CopyAIDVariable(oTargetA, oTargetB, "lightoneventon");
    }
    if (GetLocalInt(oTargetA, "checkextinguish") == 1)
    {
        CopyAIDVariable(oTargetA, oTargetB, "checkextinguish", 1);
        CopyAIDVariable(oTargetA, oTargetB, "extinguishdc", 1);
        CopyAIDVariable(oTargetA, oTargetB, "extinguishskill", 1);
        CopyAIDVariable(oTargetA, oTargetB, "extinguishpassresponse");
        CopyAIDVariable(oTargetA, oTargetB, "extinguishfailresponse");
        CopyAIDVariable(oTargetA, oTargetB, "extinguishoneventon");
    }
}

//::///////////////////////////////////////////////
//:: Name: CopyAIDVariable
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
Copies the local var sVarName from oTargetA to oTargetB
iVarIsInt - if False, the var is assumed to be a string. Pass in true if var is an int
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 6/12/2006
//:: Last Modified: 6/12/2006
//:://////////////////////////////////////////////

void CopyAIDVariable(object oTargetA, object oTargetB, string sVarName, int iVarIsInt = 0)
{
    if (iVarIsInt)
    {
        int iTemp = GetLocalInt(oTargetA, sVarName);

        if (iTemp != 0)
        {
            SetLocalInt(oTargetB, sVarName, iTemp);
        }
    }else
    {
        string sTemp = GetLocalString(oTargetA, sVarName);

        if (sTemp != "")
        {
            SetLocalString(oTargetB, sVarName, sTemp);
        }
    }
}

//::///////////////////////////////////////////////
//:: Name: DumpAIDVariables
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
DM function - dumps all AID vars of given object to them via server mssg
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 6/4/2006
//:: Last Modified: 6/12/2006
//:://////////////////////////////////////////////

void DumpAIDVariables(object oPC, object oTarget)
{
        //send dump begin mssg to DM
    SendMessageToPC(oPC, (COLOR_VARNAME + sDMDumpOpening1 + COLOR_OBJECT + GetTag(oTarget)+ COLOR_VARNAME + COLON + COLOR_END));

        //Dump vars
    SendAIDVariableToDM(oPC, oTarget, "examine");
    SendAIDVariableToDM(oPC, oTarget, "touch");
    SendAIDVariableToDM(oPC, oTarget, "read");
    SendAIDVariableToDM(oPC, oTarget, "drink");
    SendAIDVariableToDM(oPC, oTarget, "drinkeffect");
    SendAIDVariableToDM(oPC, oTarget, "push", 1);
    SendAIDVariableToDM(oPC, oTarget, "pull", 1);
    SendAIDVariableToDM(oPC, oTarget, "takeitem");
    SendAIDVariableToDM(oPC, oTarget, "secretword");
    SendAIDVariableToDM(oPC, oTarget, "LIGHTABLE", 1);
    SendAIDVariableToDM(oPC, oTarget, "defaultlighting", 1);
    SendAIDVariableToDM(oPC, oTarget, "onexamine");
    SendAIDVariableToDM(oPC, oTarget, "ontouch");
    SendAIDVariableToDM(oPC, oTarget, "ondrink");
    SendAIDVariableToDM(oPC, oTarget, "ontake");
    SendAIDVariableToDM(oPC, oTarget, "onpush");
    SendAIDVariableToDM(oPC, oTarget, "onpull");
    SendAIDVariableToDM(oPC, oTarget, "extinguish");
    SendAIDVariableToDM(oPC, oTarget, "light");
    SendAIDVariableToDM(oPC, oTarget, "onsecretword");
    SendAIDVariableToDM(oPC, oTarget, "secretwordresponse");

    if (GetLocalInt(oTarget, "checkexamine") == 1)
    {
        SendAIDVariableToDM(oPC, oTarget, "examinedc", 1);
        SendAIDVariableToDM(oPC, oTarget, "examineskill", 1);
        SendAIDVariableToDM(oPC, oTarget, "examinepassresponse");
        SendAIDVariableToDM(oPC, oTarget, "examinefailresponse");
        SendAIDVariableToDM(oPC, oTarget, "examineoneventon");
    }
    if (GetLocalInt(oTarget, "checktouch") == 1)
    {
        SendAIDVariableToDM(oPC, oTarget, "touchdc", 1);
        SendAIDVariableToDM(oPC, oTarget, "touchskill", 1);
        SendAIDVariableToDM(oPC, oTarget, "touchpassresponse");
        SendAIDVariableToDM(oPC, oTarget, "touchfailresponse");
        SendAIDVariableToDM(oPC, oTarget, "touchoneventon");
    }
    if (GetLocalInt(oTarget, "checkread") == 1)
    {
        SendAIDVariableToDM(oPC, oTarget, "readdc", 1);
        SendAIDVariableToDM(oPC, oTarget, "readlanguage", 1);
        SendAIDVariableToDM(oPC, oTarget, "readskill", 1);
        SendAIDVariableToDM(oPC, oTarget, "readpassresponse");
        SendAIDVariableToDM(oPC, oTarget, "readfailresponse");
        SendAIDVariableToDM(oPC, oTarget, "readoneventon");
    }
    if (GetLocalInt(oTarget, "checkdrink") == 1)
    {
        SendAIDVariableToDM(oPC, oTarget, "drinkdc", 1);
        SendAIDVariableToDM(oPC, oTarget, "drinkskill", 1);
        SendAIDVariableToDM(oPC, oTarget, "drinkpassresponse");
        SendAIDVariableToDM(oPC, oTarget, "drinkfailresponse");
        SendAIDVariableToDM(oPC, oTarget, "drinkoneventon");
    }
    if (GetLocalInt(oTarget, "checkpush") == 1)
    {
        SendAIDVariableToDM(oPC, oTarget, "pushdc", 1);
        SendAIDVariableToDM(oPC, oTarget, "pushskill", 1);
        SendAIDVariableToDM(oPC, oTarget, "pushpassresponse");
        SendAIDVariableToDM(oPC, oTarget, "pushfailresponse");
        SendAIDVariableToDM(oPC, oTarget, "pushoneventon");
    }
    if (GetLocalInt(oTarget, "checkpull") == 1)
    {
        SendAIDVariableToDM(oPC, oTarget, "pulldc", 1);
        SendAIDVariableToDM(oPC, oTarget, "pullskill", 1);
        SendAIDVariableToDM(oPC, oTarget, "pullpassresponse");
        SendAIDVariableToDM(oPC, oTarget, "pullfailresponse");
        SendAIDVariableToDM(oPC, oTarget, "pulloneventon");
    }
    if (GetLocalInt(oTarget, "checktake") == 1)
    {
        SendAIDVariableToDM(oPC, oTarget, "takedc", 1);
        SendAIDVariableToDM(oPC, oTarget, "takeskill", 1);
        SendAIDVariableToDM(oPC, oTarget, "takepassresponse");
        SendAIDVariableToDM(oPC, oTarget, "takefailresponse");
        SendAIDVariableToDM(oPC, oTarget, "takeoneventon");
    }
    if (GetLocalInt(oTarget, "checklight") == 1)
    {
        SendAIDVariableToDM(oPC, oTarget, "lightdc", 1);
        SendAIDVariableToDM(oPC, oTarget, "lightskill", 1);
        SendAIDVariableToDM(oPC, oTarget, "lightpassresponse");
        SendAIDVariableToDM(oPC, oTarget, "lightfailresponse");
        SendAIDVariableToDM(oPC, oTarget, "lightoneventon");
    }
    if (GetLocalInt(oTarget, "checkextinguish") == 1)
    {
        SendAIDVariableToDM(oPC, oTarget, "extinguishdc", 1);
        SendAIDVariableToDM(oPC, oTarget, "extinguishskill", 1);
        SendAIDVariableToDM(oPC, oTarget, "extinguishpassresponse");
        SendAIDVariableToDM(oPC, oTarget, "extinguishfailresponse");
        SendAIDVariableToDM(oPC, oTarget, "extinguishoneventon");
    }

    SendMessageToPC(oPC, " ");

    //sSendToDM = COLOR_MESSAGE + "Sorry, this function is not yet complete. We value your call, please try again at a later time.";
    //SendMessageToPC(oPC, sSendToDM);
}

//::///////////////////////////////////////////////
//:: Name: SendAIDVariableToDM
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
Sends the AID var sVarName on oTarget to oDM if the var exists
iVarIsInt - if False, the var is assumed to be a string. Pass in true if var is an int
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 6/9/2006
//:: Last Modified: 6/9/2006
//:://////////////////////////////////////////////

void SendAIDVariableToDM(object oDM, object oTarget, string sVarName, int iVarIsInt = 0)
{
    if (iVarIsInt)
    {
        int iTemp = GetLocalInt(oTarget, sVarName);

        if (iTemp != 0)
        {
            SendMessageToPC(oDM, (COLOR_VARNAME + sVarName + COLOR_MESSAGE + COLON + IntToString(iTemp)));
        }
    }else
    {
        string sTemp = GetLocalString(oTarget, sVarName);

        if (sTemp != "")
        {
            SendMessageToPC(oDM, (COLOR_VARNAME + sVarName + COLOR_MESSAGE + COLON + sTemp));
        }
    }
}


//::///////////////////////////////////////////////
//:: Name: AIDParseEmote
//:://////////////////////////////////////////////
int AIDParseEmote(object oPC, string sSpeech)
{
    // Declare vars
    object oRObject; float fCloseEnough; string sNotClose, sVerb, sObject;
    object pc_area = GetArea(oPC);
    int iLocWordBreak, bFound, bFinished, nLen, bOneWord, bEnd;

    //parse string into sections and then find verb - object couplet
    int nPos0, nPos1, nPosA, nPosB;
    nLen    = GetStringLength(sSpeech);
    //find start of "emote section"
    nPos0   = FindSubString(sSpeech,"*");
    // BEGIN EMOTE SNIPPET ITERATION
    while(nPos0!=-1 && nPos0<nLen-1)
    {
        // find end of this "emote section"
        nPos1   = FindSubString(sSpeech,"*", nPos0+1);
        if(nPos1==-1)
            nPos1=nLen-1;

        // find space before word
        nPosA   = FindSubString(sSpeech," ",nPos0);

        // BEGIN SEARCH FOR VERB IN EMOTE SNIPPET
        while (nPosA<nPos1 && nPosA!=-1 && nPosB!=-1 && !bFound)
        {
            // find space after word
            nPosB   = FindSubString(sSpeech," ",nPosA+1);
            if(nPosB>(nPosA+1))
            {
                sVerb   = GetSubString(sSpeech,(nPosA+1),((nPosB)-(nPosA+1)));
                if(IsActionValid(sVerb))
                {
                    // ONE WORD EMOTE?
                    if(nPosB==nPos1)
                    {
                        bOneWord   = TRUE;
                        break;
                    }
                    else
                    {
                        // update start space for next word
                        nPosA = nPosB;
                    }
                    // BEGIN SEARCH FOR OBJECT IN EMOTE SNIPPET
                    while (nPosA<nPos1 && nPosA!=-1 && nPosB!=-1 && !bFound)
                    {
                        nPosB   = FindSubString(sSpeech," ",nPosA+1);
                        if(nPosB==-1)
                        {
                            break;
                        }
                        else if(nPosB>(nPosA+1))
                        {
                            sObject   = GetSubString(sSpeech,(nPosA+1),((nPosB)-(nPosA+1)));
                            if(!IsIgnoredWord(sObject))
                                bFound = TRUE;
                            else
                                sObject="";
                        }

                        nPosA = nPosB; // update start space for next word
                    }// END SEARCH FOR OBJECT IN EMOTE SNIPPET
                }
                else
                    sVerb = "";
            }
            // update start space for next word
            nPosA   = nPosB;
        }// END SEARCH FOR VERB IN EMOTE SNIPPET

        nPos0 = nPos1; // start of this "emote section" set at end of last section
    }// END EMOTE SNIPPET ITERATION

    // If nothing suitable is found, exit.
    if(sVerb=="" || (sObject=="" && !bOneWord))
        return FALSE;

    // USER DEFINED FUNCTIONALITY CURRENTLY DISABLED
    /* // Get # of user defined actions if any
    object oArea = GetArea(oPC);    //current area
    int iGlobalUsDefQuantity = GetLocalInt(GetModule(), AID_USER_DEFINED_GLOBAL_ACTION_QUANTITY);
    int iLocalUsDefQuantity = GetLocalInt(oArea, AID_USER_DEFINED_LOCAL_ACTION_QUANTITY);
    */

    /////////////////
    //Begin Routing//
    /////////////////
    // ** route our special "list nearby objects" command
    if( ((sVerb == "look" || sVerb == "looks") && (sObject == "around" || bOneWord))
        //|| ((sVerb == "take" || sVerb == "takes") && sObject == "look") // this requires more sophisticated parsing for "takes a look" or "takes a look around", but we'd also like "takes a look at (object)" to be the equivalent of "examines (object)"
      )
    {
        DoLookAround(oPC,!bOneWord);
        return TRUE;
    }
    else if(    ( sVerb=="search"||sVerb=="searches" )
            &&  ( bOneWord||sObject=="secret"||sObject=="area"||(sObject=="room"&&GetIsAreaInterior(GetArea(oPC))) )
           )
    {
        DoSearchArea(oPC);
        return TRUE;
    }
    else if( (sVerb=="look" || sVerb=="looks" || sVerb=="examine" || sVerb=="examines" || sVerb=="inspect" || sVerb=="inspects" || sVerb=="watch" || sVerb=="watches")
            && sObject == "moon"
           )
    {
        return DoLookMoon(oPC);
    }
    // ** route core aid actions
    else if (IsActionValid(sVerb)&&!bOneWord)
    {

        if(sObject=="self")
        {
            if (sVerb == "examine" || sVerb == "examines" || sVerb == "look" || sVerb == "looks")
                sNotClose = COLOR_MESSAGE + "Lookin' pretty good if you do say so yourself." + COLOR_END;
            else if (sVerb == "touch" || sVerb == "touches")
                sNotClose = COLOR_MESSAGE + "Hey! This is supposed to be a family game!" + COLOR_END;

            SendMessageToPC(oPC,sNotClose);
            return FALSE;
        }// end humor
        else
        {
            // look for the object
            int nNth    = 0;
            while(!GetIsObjectValid(oRObject))
            {
                oRObject = GetNearestObjectByTag(sObject, oPC, ++nNth);    //all tags must be LC
                fCloseEnough = GetDistanceBetween(oPC, oRObject);
                if( fCloseEnough>MAX_DISTANCE ||
                    GetArea(oRObject)!=pc_area
                  )
                    return FALSE;

                if(GetIsObjectValid(GetSittingCreature(oRObject)))
                    oRObject = OBJECT_INVALID;
            }
        }


        // ** if the object is not found within the maximum distance
       if(  //fCloseEnough > MAX_DISTANCE ||
            oRObject==OBJECT_INVALID
         )
        {
            /*
            if(!MULTIPLAYER)
            {
                // singleplayer games provide additional feedback
                sNotClose = COLOR_MESSAGE +sNotClose1+ COLOR_OBJECT +sObject+ COLOR_MESSAGE +sNotClose2+ COLOR_END;
                SendMessageToPC(oPC,sNotClose);
            }
            */
            return FALSE;
        } // ** End object not found within maximum distance
        else
        {
            // issues with special distances relative to Action still need to be handled
            return ( ActionFork(oRObject, oPC, sVerb) ); // Routes all commands
        }
        return FALSE;
    }
    // USER DEFINED FUNCTIONALITY CURRENTLY DISABLED
    /*  // USER DEFINED BEGIN
        // route anything else beggining with * here to check for user
        // defined keywords. 7/20/2006 - TV
    else if (iGlobalUsDefQuantity > 0 || iLocalUsDefQuantity > 0)
    {
        int i;
        // duplicated from above because working it so it's only done
        // when neccessary and not duplicating it proves difficult.
        oRObject = GetNearestObjectByTag(sObject, oPC);
        fCloseEnough = GetDistanceBetween(oPC, oRObject);

        // check if the object is close enough
        if (fCloseEnough > MAX_DISTANCE || oRObject == OBJECT_INVALID)
        {
            string sNotClose = COLOR_MESSAGE + sNotClose1 + COLOR_OBJECT + sObject + COLOR_MESSAGE + sNotClose2;
            DoSpeak(oPC, sNotClose);
        }
        // only do the events if the object is close enough and the object exists
        else
        {
            // check global usdefs
            for (i = 0; i < iGlobalUsDefQuantity; i++)
            {
                if (sVerb == GetLocalString(GetModule(), (AID_USER_DEFINED_GLOBAL_ACTION_PREFIX + IntToString(i))))
                {
                    OnUserDefined(oRObject, oPC, sVerb, SkillCheck(oRObject, oPC, sVerb));
                }
            }

            // check local usdefs
            for (i = 0; i < iLocalUsDefQuantity; i++)
            {
                if (sVerb == GetLocalString(oArea, (AID_USER_DEFINED_LOCAL_ACTION_PREFIX + IntToString(i))))
                {
                        OnUserDefined(oRObject, oPC, sVerb, SkillCheck(oRObject, oPC, sVerb));
                }
            }
        }// end else (if its close enough)
    }
    // END USER DEFINED */
    return FALSE;
}
///////////////////////////////////////////////////


//::///////////////////////////////////////////////
//:: Name: IsActionValid
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
  Returns TRUE if sVerb describes a valid AID action, otherwise, FALSE
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 6/4/2006
//:: Last Modified: 7/15/2006
//:://////////////////////////////////////////////
int IsActionValid(string sVerb)
{
    if( // first look / examination
           sVerb == "examine" || sVerb == "examines" || sVerb == "look" || sVerb == "looks" || sVerb == "watch" || sVerb == "watches"
        // careful look / examination
        || sVerb == "touch" || sVerb == "touches" || sVerb == "inspect" || sVerb == "inspects" || sVerb == "search" || sVerb == "searches"
        // read writing
        || sVerb == "read" || sVerb == "reads"
        // extinguishing a lightsource
        || sVerb == "extinguish" || sVerb == "extinguishes"
        // lighting a lightsource
        || sVerb == "light" || sVerb == "lights"
        // drinking
        || sVerb == "drink" || sVerb == "drinks"
        // taking
        || sVerb == "take" || sVerb == "takes" || sVerb == "get" || sVerb == "gets" || sVerb == "grab" || sVerb == "grabs"
        // pushing
        || sVerb == "push" || sVerb == "pushes" || sVerb == "shove" || sVerb == "shoves"
        // pulling
        || sVerb == "pull" || sVerb == "pulls"
        // move related
        || sVerb == "climb" || sVerb == "climbs"
        || sVerb == "swim" || sVerb == "swims"
        || sVerb == "squeeze" || sVerb == "squeezes"
        || sVerb == "enter" || sVerb == "enters" || sVerb == "exit" || sVerb == "exits" || sVerb == "crawl" || sVerb == "crawls"
        || sVerb == "jump" || sVerb == "jumps" || sVerb == "leap" || sVerb == "leaps"
        || sVerb == "fly" || sVerb == "flies" || sVerb == "land" || sVerb == "lands"
      )
        return TRUE;
    else
        return FALSE;
}

//::///////////////////////////////////////////////
//:: Name: ActionFork
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
  Handles routing of all events after parsing
  oTargetObject - AID object oPlayer is Speaking at
  sVerb - Action oPC is attempting to perform on oTargetObject

  Keywords:
      examine - examine(s), look(s)
      touch - touch(s), inspect(s)
      extinguish - extinguish(es)
      light - light(s)
      read - read(s)
      drink - drink(s)
      take - take(s)
      push - push(es)
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 3/8/2006
//:: Last Modified: 9/15/2006
//:://////////////////////////////////////////////
int ActionFork(object oTargetObject, object oPlayer, string sVerb)
{
    object oReturned;       // from Do into On
    int iSkillCheck;        // result of skillcheck into on
    int bSuccess, bSuccess2;

    if(     sVerb == "examine" || sVerb == "examines"
        ||  sVerb == "look" || sVerb == "looks"
        ||  sVerb == "watch" || sVerb == "watches"
       )
    {
        //sVerb = "examine";    // Allowing expanded syntax broke the skillcheck system since it goes by sVerb.
                                // Shunting sVerb to the base action verb like so will fix this. -TV 9/15/2006
        bSuccess = DoExamine(oTargetObject, oPlayer);
    }
    else if(    sVerb == "touch" || sVerb == "touches"
            ||  sVerb == "inspect" || sVerb == "inspects"
            ||  sVerb == "search" || sVerb == "searches"
           )
    {
        //sVerb = "touch";
        bSuccess = DoTouch(oTargetObject, oPlayer);
    }
    else if(    sVerb == "extinguish" || sVerb == "extinguishes")
    {
        //sVerb = "extinguish";
        bSuccess = DoExtinguish(oTargetObject, oPlayer);
    }
    else if(    sVerb == "light" || sVerb == "lights")
    {
        //sVerb = "light";
        bSuccess = DoLight(oTargetObject, oPlayer);
    }
    else if(    sVerb == "read" || sVerb == "reads")
    {
        //sVerb = "read";
        bSuccess = DoRead(oTargetObject, oPlayer);
    }
    else if(    sVerb == "drink" || sVerb == "drinks")
    {
        sVerb = "drink";
        bSuccess = DoDrink(oTargetObject, oPlayer);
        iSkillCheck = SkillCheck(oTargetObject, oPlayer, sVerb);
        bSuccess2 = OnDrink(oTargetObject, oPlayer, iSkillCheck);
        if(!bSuccess)
            bSuccess = bSuccess2;
    }
    else if(    sVerb == "take" || sVerb == "takes"
            ||  sVerb == "get" || sVerb == "gets"
            ||  sVerb == "grab" || sVerb == "grabs"
           )
        bSuccess = DoTake(oTargetObject, oPlayer);
    else if (sVerb == "push" || sVerb == "pushes" || sVerb == "shove" || sVerb == "shoves" )
        bSuccess = DoPush(oTargetObject, oPlayer);
    else if (sVerb == "pull" || sVerb == "pulls" )
        bSuccess = DoPush(oTargetObject, oPlayer, "pull");
    else if (sVerb == "fly" || sVerb == "flies" )
    {
        sVerb = "fly";
        if(GetLocalInt(oTargetObject, "fly"))
            sVerb   = "fly";
        else if(GetLocalInt(oTargetObject, "climb"))
            sVerb   = "climb";
        else if( GetLocalInt(oTargetObject, "swim") && !GetLocalInt(oTargetObject, "MOVE_SUBMERGED") )
            sVerb   = "swim";
        else if( GetLocalInt(oTargetObject, "squeeze") )
            sVerb   = "squeeze";
        else if( GetLocalInt(oTargetObject, "jump") )
            sVerb   = "jump";

        bSuccess = DoMove(oTargetObject, oPlayer, sVerb);
    }
    else if (sVerb == "climb" || sVerb == "climbs" )
        bSuccess = DoMove(oTargetObject, oPlayer, "climb");
    else if (sVerb == "swim" || sVerb == "swims" )
        bSuccess = DoMove(oTargetObject, oPlayer, "swim");
    else if( sVerb == "squeeze" || sVerb == "squeezes" )
            bSuccess = DoMove(oTargetObject, oPlayer, "squeeze");
    else if( sVerb == "jump" || sVerb == "jumps" || sVerb == "leap" || sVerb == "leaps" )
            bSuccess = DoMove(oTargetObject, oPlayer, "jump");
    else if(    sVerb == "enter" || sVerb == "enters"
            ||  sVerb == "exit" || sVerb == "exits"
           )
    {
        if(GetLocalInt(oTargetObject, "climb"))
            bSuccess = DoMove(oTargetObject, oPlayer, "climb");
        else if(GetLocalInt(oTargetObject, "swim"))
            bSuccess = DoMove(oTargetObject, oPlayer, "swim");
        else if(GetLocalInt(oTargetObject, "enter"))
            bSuccess = DoMove(oTargetObject, oPlayer, "squeeze");
        else if(GetLocalInt(oTargetObject, "jump"))
            bSuccess = DoMove(oTargetObject, oPlayer, "jump");
    }
    else if(    sVerb == "crawl" || sVerb == "crawls"
           )
    {
        if(GetLocalInt(oTargetObject, "climb"))
            bSuccess = DoMove(oTargetObject, oPlayer, "climb");
        else if(GetLocalInt(oTargetObject, "enter"))
            bSuccess = DoMove(oTargetObject, oPlayer, "squeeze");
        else if(GetLocalInt(oTargetObject, "swim"))
            bSuccess = DoMove(oTargetObject, oPlayer, "swim");
        else if(GetLocalInt(oTargetObject, "jump"))
            bSuccess = DoMove(oTargetObject, oPlayer, "jump");
    }
    else   //unrecognized command
    {
            // Remove this line because it will spam on everything the PC emotes
            // that isn't an AID command. Not that big a deal for an SP mod
            // but terribly annoying in a multiplayer setting where communication
            // is going on.
        //SpeakString(sBadCommand, TALKVOLUME_TALK);
    }
    return bSuccess;
}

//::///////////////////////////////////////////////
//:: Name: DoLookAround
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
*/
//:://////////////////////////////////////////////
//:: Created: Jesse Wright (6/2/2006)
//:: Modified: Magus    (2012 dec 26) modify delivery of area description
//:://////////////////////////////////////////////


string GetNamesOfNearbyAIDObjects(object oPC)
{
    // feedback string for DoLookAround
    // start description
    string sLookDescription= COLOR_MESSAGE + sLookAround1;

      // variables restricted to this scope
      string sObjectTag;          // tags of objects will make up the list
      string sTagLeft;            // holds the leftmost char of the tag to check if its a vowel
      string sTagRight;           // "                                         " if its an "s"
      int i = 1;                  // itterator
      int iCountObjects = 0;      // counts how many AID objects have been found
      object oObject   = GetNearestObject(OBJECT_TYPE_PLACEABLE, oPC, i);
      int bDisplay;
      while( oObject!=OBJECT_INVALID && GetDistanceBetween(oPC,oObject)<=MAX_DISTANCE_LOOK )
      {
        // determine if object has an aid description
        if( GetLocalString(oObject,"examine")!="" )
        {
          bDisplay  = FALSE;

          // line of sight to the object?
          if(LineOfSightObject(oPC, oObject))
          {
            // hidden object?
            if(GetLocalInt(oObject, "SECRET"))
            {
                if( QuickDetectSecret(oPC, oObject) )
                    bDisplay= TRUE;
                else if(    GetLocalInt(oObject,"SECRET_NATURE")
                        &&(     GetLevelByClass(CLASS_TYPE_DRUID,oPC)
                            ||(GetLevelByClass(CLASS_TYPE_RANGER,oPC)&&GetHasSpellEffect(SPELL_ONE_WITH_THE_LAND,oPC))
                          )
                       )
                {
                    SetLocalInt(oPC, sFoundPrefix+ObjectToString(oObject), TRUE);
                    bDisplay=TRUE;
                }
            }
            else
            {
                bDisplay  = TRUE;
            }
          }

          if(bDisplay)
          {
            sObjectTag  = GetTag(oObject);

            // determine whether we have already found the same tag in this "look around"
            // we do not repeat the same tag more than once
            if(FindSubString(sLookDescription, COLOR_OBJECT+sObjectTag+COLOR_MESSAGE)==-1)
            {
                sTagLeft    = GetStringLeft(sObjectTag, 1);
                sTagRight   = GetStringRight(sObjectTag, 1);

                if(iCountObjects > 0)
                    sLookDescription += COMMA;

                if (sTagLeft == "a" || sTagLeft == "e" || sTagLeft == "i" || sTagLeft == "o" || sTagLeft == "u")
                    sLookDescription += sLookAroundAn;
                else if (sTagRight == "s")
                {
                    // do nothing
                }
                else
                    sLookDescription += sLookAroundA;

                sLookDescription += COLOR_OBJECT;
                sLookDescription += sObjectTag;
                sLookDescription += COLOR_MESSAGE;
                iCountObjects++;
            }
          }
        }

        oObject = GetNearestObject(OBJECT_TYPE_PLACEABLE, oPC, ++i);
      } // end while
      sLookDescription  += sLookAroundPeriod;
      if(!iCountObjects)
        sLookDescription    = COLOR_MESSAGE+sLookAroundNothing;

    return sLookDescription;
}


void DoLookAround(object oPC, int animate=FALSE)
{
    if(GetHasEffect(EFFECT_TYPE_BLINDNESS,oPC))
    {
        DelayCommand(0.1, SendMessageToPC(oPC, RED+"You are unable to see anything in your current condition.") );
        return;
    }

    if(animate)
        AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 3.0));

    // Gather Description from trigger/subarea
    string sAreaName;
    string sAreaDesc;
    int nNth    = 1;
    object oContext    = GetNearestObject(OBJECT_TYPE_TRIGGER,oPC, nNth);
    while( oContext!=OBJECT_INVALID && nNth<13)
    {
        if(     GetResRef(oContext)=="trigger_describe"
            &&  GetIsInSubArea(oPC,oContext)
            &&  GetDescriptionCanContinue(oPC, oContext)
            &&  !GetLocalInt(oContext, "DESCRIPTION_TYPE")
          )
        {
            sAreaDesc   = GetLocalString(oContext, "DESCRIPTION");
            if(sAreaDesc!="") break;
        }
        oContext   = GetNearestObject(OBJECT_TYPE_TRIGGER,oPC, ++nNth);
    }

    // if no description from a trigger/subarea, get the area's description
    if(sAreaDesc=="")
    {
        oContext    = GetArea(oPC);
        sAreaDesc   = AreaGetDescription(oPC, oContext);
    }

    // using the above describe context for PC
    sAreaName   = GetName(oContext);
    if(sAreaName!=""&&sAreaName!="Description Title")
        DelayCommand(0.1, SendMessageToPC(oPC, COLOR_OBJECT+sAreaName) );
    if(sAreaDesc!="")
        DelayCommand(0.11, SendMessageToPC(oPC, COLOR_DESCRIPTION+"  "+sAreaDesc) );

    // Give list of AID objects
    string sListOfAIDObjects    = GetNamesOfNearbyAIDObjects(oPC);
    DelayCommand(0.12, SendMessageToPC(oPC, sListOfAIDObjects) );
}

void DoSearchArea(object oPC)
{

    AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 6.0));

    // look for secret doors
    int nNth    = 1;
    object oTrigger = GetNearestObject(OBJECT_TYPE_TRIGGER,oPC, nNth);
    while( oTrigger!=OBJECT_INVALID && GetDistanceBetween(oPC,oTrigger)<=MAX_DISTANCE_LOOK )
    {
        if(     GetIsInSubArea(oPC,oTrigger)
            &&  GetResRef(oTrigger)=="sec_door_reveal"
            &&  !GetIsSecretItemRevealed(oTrigger)
            &&  SecretGetCreatureDetects(oPC, oTrigger)
          )
        {
            SignalEvent(oTrigger, EventUserDefined(EVENT_SECRET_DETECTED));
            return;
        }
        oTrigger   = GetNearestObject(OBJECT_TYPE_TRIGGER,oPC, ++nNth);
    }

    // if no secret doors detected... look for hidden items
    // feedback string
    string sLookDescription= COLOR_MESSAGE + "After a search you discover the following hidden objects: ";

    // variables restricted to this scope
    string sObjectTag;          // tags of objects will make up the list
    string sTagLeft;            // holds the leftmost char of the tag to check if its a vowel
    string sTagRight;           // "                                         " if its an "s"
    int i = 1;                  // itterator
    int iCountObjects = 0;      // counts how many AID objects have been found

    object oObject   = GetNearestObject(OBJECT_TYPE_PLACEABLE, oPC, i);
    while( oObject!=OBJECT_INVALID && GetDistanceBetween(oPC,oObject)<=MAX_DISTANCE_LOOK )
    {
        // determine if object has an aid description
        if(     GetLocalString(oObject,"examine")!=""
            &&  LineOfSightObject(oPC, oObject)
            &&  GetLocalInt(oObject, "SECRET")
            &&  SecretGetCreatureDetects(oPC, oObject, FALSE)
          )
        {
            sObjectTag  = GetTag(oObject);

            // determine whether we have already found the same tag in this "look around"
            // we do not repeat the same tag more than once
            if(FindSubString(sLookDescription, COLOR_OBJECT+sObjectTag+COLOR_MESSAGE)==-1)
            {
                sTagLeft    = GetStringLeft(sObjectTag, 1);
                sTagRight   = GetStringRight(sObjectTag, 1);

                if(iCountObjects > 0)
                    sLookDescription += COMMA;

                if (sTagLeft == "a" || sTagLeft == "e" || sTagLeft == "i" || sTagLeft == "o" || sTagLeft == "u")
                    sLookDescription += sLookAroundAn;
                else if (sTagRight == "s")
                {
                    // do nothing
                }
                else
                    sLookDescription += sLookAroundA;

                sLookDescription += COLOR_OBJECT;
                sLookDescription += sObjectTag;
                sLookDescription += COLOR_MESSAGE;
                iCountObjects++;
            }
        }

        oObject = GetNearestObject(OBJECT_TYPE_PLACEABLE, oPC, ++i);
    } // end while


    if(!iCountObjects)
    {
        sLookDescription= COLOR_MESSAGE + "Your search turns up nothing more than what a casual look around would reveal.";
    }
    else
        sLookDescription   += sLookAroundPeriod;

    // Give feedback to DoSearchArea
    DelayCommand(0.1, SendMessageToPC(oPC, sLookDescription) );
}


//::///////////////////////////////////////////////
//:: Name: DoLookMoon
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
    Since the moon shows up as an object observed in an area
    a PC might look at or examine it
*/
//:://////////////////////////////////////////////
//:: Created: Magus    (2012 dec 26)
//:://////////////////////////////////////////////
int DoLookMoon(object oPC)
{
    if(GetHasEffect(EFFECT_TYPE_BLINDNESS,oPC))
    {
        DelayCommand(0.1, SendMessageToPC(oPC, COLOR_MESSAGE+"You are blind to the moon and apparently to much of everything else as well.") );
        return FALSE;
    }
    string sMoonDesc;
    //string sMoonDesc    = DisplayMoon(oPC, TRUE);
    if(sMoonDesc!="")
    {
        DelayCommand(0.1, SendMessageToPC(oPC, COLOR_OBJECT+"Moon") );
        DelayCommand(0.11, SendMessageToPC(oPC, COLOR_DESCRIPTION+"  "+sMoonDesc) );
        return TRUE;
    }
    else
    {
        DelayCommand(0.1, SendMessageToPC(oPC, COLOR_MESSAGE+"The moon is not visible to you.") );
        return FALSE;
    }

}

//::///////////////////////////////////////////////
//:: Name: DoBurn
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
  2/9/2007 - changed to only do 2d3 dmg rather than 2d6 - TV
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 3/18/2006
//:: Modified On: 2/9/2007
//:://////////////////////////////////////////////
int DoBurn(object oTarget, object oPC, int nFire=1)
{
    int iReturn;

  if(GetLocalInt(OBJECT_SELF,"NW_L_AMION"))
  {
    float fDelay = FindDelay(oPC, oTarget);

    object oGlove   = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    int bGloves     = GetBaseItemType(oGlove)==BASE_ITEM_GLOVES;
    int bDestroy    = TRUE;
    int bStop   = TRUE;
    if(     GetHasSpellEffect(SPELL_ENDURE_ELEMENTS, oPC)
        ||  GetHasSpellEffect(SPELL_RESIST_ELEMENTS, oPC)
        ||  GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS, oPC)
        ||  GetHasSpellEffect(SPELL_ENERGY_BUFFER, oPC)
      )
        bStop   = FALSE;
    if(bGloves && bStop)
    {
        itemproperty ip = GetFirstItemProperty(oGlove);
        int nIPType, nMaterial;
        while(GetIsItemPropertyValid(ip))
        {
            nIPType = GetItemPropertyType(ip);
            if(nIPType==ITEM_PROPERTY_MATERIAL)
            {
                nMaterial=GetItemPropertyCostTableValue(ip);
                if( nMaterial==49)
                {
                    bDestroy    = FALSE;
                }
                else if(nMaterial==31)
                {
                    nFire-=1;
                }
                else if(   (nMaterial>=1&&nMaterial<=3)
                        || (nMaterial>=5&&nMaterial<=7)
                        || (nMaterial>=9&&nMaterial<=15)
                       )
                {
                    nFire-=1;
                    bDestroy    = FALSE;
                }
            }
            else if(    nIPType==ITEM_PROPERTY_DAMAGE_RESISTANCE
                    ||  nIPType==ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE
                   )
            {
                // resist or immune to fire
                if(GetItemPropertySubType(ip)==10)
                {
                    bDestroy    = FALSE;
                    bStop       = FALSE;
                }
            }
            ip = GetNextItemProperty(oGlove);
        }
        if(bDestroy&&nFire>0)
        {
            DestroyObject(oGlove);
            DelayCommand((fDelay), SendMessageToPC(oPC, RED+"Your gloves are burned in the fire!"));
        }
        else
        {
            DelayCommand((fDelay), SendMessageToPC(oPC, PINK+"Your gloves provide some protection from the fire!"));
        }
    }

    int nDamage;
    if(nFire>0) nDamage = d4(nFire);

    DelayCommand((fDelay-0.1), DoSpeak(oTarget, "*Burns*"));

    if(nDamage)
    {
        DelayCommand(fDelay, EffectHit(oPC, EffectDamage(nDamage,DAMAGE_TYPE_FIRE), VFX_COM_HIT_FIRE, DURATION_TYPE_INSTANT, 0.0, "Ouch!"));

        if(bStop)
        {
            DoManipulate(oPC, oTarget, ANIMATION_LOOPING_GET_MID, 1.0);
            return TRUE;
        }
    }
  }

    return FALSE;
}

int DoAcid(object oTarget, object oPC, int nAcid=1)
{
    int iReturn;
    float fDelay = FindDelay(oPC, oTarget);

    object oGlove   = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    int bGloves     = GetBaseItemType(oGlove)==BASE_ITEM_GLOVES;
    int bDestroy    = TRUE;
    int bStop   = TRUE;
    if(     GetHasSpellEffect(SPELL_ENDURE_ELEMENTS, oPC)
        ||  GetHasSpellEffect(SPELL_RESIST_ELEMENTS, oPC)
        ||  GetHasSpellEffect(SPELL_PROTECTION_FROM_ELEMENTS, oPC)
        ||  GetHasSpellEffect(SPELL_ENERGY_BUFFER, oPC)
      )
        bStop   = FALSE;
    if(bGloves && bStop)
    {
        itemproperty ip = GetFirstItemProperty(oGlove);
        int nIPType, nMaterial;
        while(GetIsItemPropertyValid(ip))
        {
            nIPType = GetItemPropertyType(ip);
            if(nIPType==ITEM_PROPERTY_MATERIAL)
            {
                nMaterial=GetItemPropertyCostTableValue(ip);
                if( nMaterial==48)
                {
                    nAcid-=1;
                    bDestroy    = FALSE;
                }
                else if(    (nMaterial>=17&&nMaterial<=31)
                       )
                {
                    nAcid-=1;
                }
            }
            else if(    nIPType==ITEM_PROPERTY_DAMAGE_RESISTANCE
                    ||  nIPType==ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE
                   )
            {
                // resist or immune to acid
                if(GetItemPropertySubType(ip)==6)
                {
                    bDestroy    = FALSE;
                    bStop       = FALSE;
                }
            }
            ip = GetNextItemProperty(oGlove);
        }
        if(bDestroy&&nAcid>0)
        {
            DestroyObject(oGlove);
            DelayCommand((fDelay), SendMessageToPC(oPC, RED+"Your gloves dissolve in the acid!"));
        }
        else
        {
            DelayCommand((fDelay), SendMessageToPC(oPC, PINK+"Your gloves provide some protection from the acid!"));
        }
    }

    int nDamage;
    if(nAcid>0) nDamage = d4(nAcid);

    DelayCommand((fDelay-0.1), DoSpeak(oTarget, "*Burns and corrodes*"));

    if(nDamage)
    {
        DelayCommand(fDelay, EffectHit(oPC, EffectDamage(nDamage,DAMAGE_TYPE_ACID), VFX_COM_HIT_ACID, DURATION_TYPE_INSTANT, 0.0, "Ouch!"));

        if(bStop)
        {
            DoManipulate(oPC, oTarget, ANIMATION_LOOPING_GET_MID, 1.0);
            return TRUE;
        }
    }

    return FALSE;
}

//::///////////////////////////////////////////////
//:: Name: DoDrink
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 3/11/2006
//:: Last Modified: 6/15/2006
//:://////////////////////////////////////////////
int DoDrink(object oTarget, object oPC)
{
    float fDelay = FindDelay(oPC, oTarget);
    string sDrinkEffect = GetLocalString(oTarget, "drinkeffect");
    string sDrink = GetLocalString(oTarget, "drink");
    effect eEffect;
    int iVFX = VFX_NONE;
    int iDurationType = DURATION_TYPE_INSTANT;
    float fDuration = 0.0;

    if (sDrink != "")
    {
        DoManipulate(oPC, oTarget, ANIMATION_FIREFORGET_DRINK);

        if (sDrinkEffect == "passthrough")
        {
            return FALSE;
        }
        else if (sDrinkEffect != "")
        {
            if (sDrinkEffect == "Alcohol")
            {
                eEffect = EffectAbilityDecrease(ABILITY_INTELLIGENCE, 2);
                iVFX = VFX_IMP_DAZED_S;
                iDurationType = DURATION_TYPE_TEMPORARY;
                fDuration = TurnsToSeconds(d4(1));
            }
            else if (GetStringLeft(sDrinkEffect, 4) == "Cure")
            {
                if (sDrinkEffect == "CureLightWounds")
                {
                    eEffect = EffectHeal(d8() + 5);
                    iVFX = VFX_IMP_HEALING_S;
                }
                else if (sDrinkEffect == "CureModerateWounds")
                {
                    eEffect = EffectHeal(d8(2) + 10);
                    iVFX = VFX_IMP_HEALING_M;
                }
                else if (sDrinkEffect == "CureSeriousWounds")
                {
                    eEffect = EffectHeal(d8(3) + 15);
                    iVFX = VFX_IMP_HEALING_L;
                }
                else if (sDrinkEffect == "CureCriticalWounds")
                {
                    eEffect = EffectHeal(d8(4) + 20);
                    iVFX = VFX_IMP_HEALING_G;
                }
            }
            else if (GetStringLeft(sDrinkEffect, 6) == "Poison")
            {
                if (sDrinkEffect == "PoisonArsenic")            {   eEffect = EffectPoison(POISON_ARSENIC);       }
                else if (sDrinkEffect == "PoisonSmallSpider")   {   eEffect = EffectPoison(POISON_SMALL_SPIDER_VENOM);   }
                else if (sDrinkEffect == "PoisonHugeSpider")    {   eEffect = EffectPoison(POISON_HUGE_SPIDER_VENOM);    }
                else if (sDrinkEffect == "PoisonEttercap")      {   eEffect = EffectPoison(POISON_ETTERCAP_VENOM);      }
            }

            DelayCommand(fDelay, EffectHit(oPC, eEffect, iVFX, iDurationType, fDuration));
        }

        DoSpeak(oTarget, sDrink);
        return TRUE;
    }
    else
    {
        DoSpeak(oTarget, sBadCommand);
        return FALSE;
    }
}

//::///////////////////////////////////////////////
//:: Name: DoExamine
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
  Speaks examine string stored on object
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 3/7/2006
//:: Last Modified: 6/15/2006
//:://////////////////////////////////////////////
int DoExamine(object oTarget, object oPC)
{
    string sVerb        = "examine";
    int bSuccess        = SkillCheck(oTarget, oPC, sVerb);
    string sDesc        = GetDescription(oTarget);
    string sDescSpec    = GetLocalString(oTarget, "examine");
    int bExam           = FALSE;
    float fDelay, fDist;

    if(FindSubString(sDesc,GetStringByStrRef(6792))!=-1)
        sDesc="";
    else if(sDesc!="")
        bExam = TRUE;
    if(sDescSpec!="")
        bExam = TRUE;

    fDist = GetDistanceBetween(oTarget,oPC);
    AssignCommand(oPC, ClearAllActions());
    if(fDist>=MAX_DISTANCE_EXAMINE)
    {
        fDelay = fDist/4.0;
        DelayCommand(0.1, AssignCommand(oPC, ActionMoveToObject(oTarget, FALSE, 5.0)) );
    }

    DelayCommand(fDelay+0.1, SendMessageToPC(oPC, GREEN+GetName(oTarget)) );

    if(bExam)
    {
        if(sDesc!="")
            DelayCommand(fDelay+0.2, SendMessageToPC(oPC, COLOR_DESCRIPTION+sDesc) );
        if(sDescSpec == "passthrough")
        {
            bSuccess = OnExamine(oTarget, oPC, bSuccess, (fDelay+0.3));
        }
        else if(sDescSpec!="" && bSuccess)
        {
            DelayCommand(fDelay+0.3, SendMessageToPC(oPC, COLOR_MESSAGE+"Upon examination:") );
            DelayCommand(fDelay+0.4, SendMessageToPC(oPC, "  "+DoColorize(sDescSpec,TRUE)) );
        }
    }
    else if(bSuccess)
        DelayCommand(fDelay+0.2, SendMessageToPC(oPC, COLOR_MESSAGE+sNoDescription) );

    return bSuccess;
}

//::///////////////////////////////////////////////
//:: Name: DoPush
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 3/12/2006
//:: Last Modified: 6/15/2006
//:://////////////////////////////////////////////
int DoPush(object oTarget, object oPC, string sVerb = "push")
{
    int bSuccess;
    int iCanPush = GetLocalInt(oTarget, sVerb);
    string sTarget = GetTag(oTarget);
    object oPushed, oTest;
    if (GetDistanceBetween(oPC, oTarget) <= MAX_DISTANCE_TOUCH)
    {
        bSuccess = SkillCheck(oTarget, oPC, sVerb);
        if( iCanPush==1 && bSuccess )
        {
            float fDelay = FindDelay(oPC, oTarget);
            object oArea = GetArea(oTarget);
            float fAngle = GetFacing(oPC);

            DoManipulate(oPC, oTarget, ANIMATION_LOOPING_GET_MID, 1.0);

            string sObjResRef = GetResRef(oTarget);

            // Generate New Location
            vector vObj         = GetPosition(oTarget);
            vector vPC          = GetPosition(oPC);
            vector vObjfromPC   = vObj-vPC;
            float fDistTyp      = 2.0;
            float fDist, fElev;
            vector vNew, vTest;
            location lPushed;
            if(sVerb=="push")
            {
                vNew    = vObj + (VectorNormalize(vObjfromPC)*fDistTyp);
                oTest   = CreateObject(OBJECT_TYPE_CREATURE, "invisible",
                                        Location( oArea, vNew, VectorToAngle(vObjfromPC) ),
                                        FALSE, sTarget
                                      );
                vTest   = GetPosition(oTest);
                fDist   = GetDistanceBetween(oTest, oTarget);
                fElev   = vTest.z-vObj.z;
                lPushed = GetLocation(oTest);
            }
            else
            {
                lPushed = Location( oArea, vPC, VectorToAngle(vObjfromPC) );
            }

            if(     sVerb!="push"
                ||  (LineOfSightObject(oTest, oTarget) && fDist<=3.0 && fElev<1.0)
              )
            {
                //Create the new object at the new location
                oPushed = CreateObject(OBJECT_TYPE_PLACEABLE, sObjResRef, lPushed, FALSE, sTarget);

                // Test this addition for performance
                // copy all AID Variables to the new object so any post-pallette changes are preserved through the push
                CopyAllAIDVariables(oTarget, oPushed);
                // remove the old object
                DestroyObject(oTarget);
                //Make the PC move to new object and fiddle with it
                DelayCommand(2.0, DoManipulate(oPC, GetNearestObjectByTag(sTarget, oPC), ANIMATION_LOOPING_GET_MID, 1.0));
                bSuccess = TRUE;
            }
            else
            {
                DoSpeak(oTarget, (sNoPushWall1 + sTarget + sNoPushWall2));
                bSuccess = FALSE;
            }
            DestroyObject(oTest);
        }
        else if( iCanPush==2)
        {
            bSuccess = OnPush(oTarget, oPC, bSuccess, sVerb);
            if(!bSuccess)
                DoSpeak(oTarget, (sNoPush1 + sTarget + sNoPush2));
        }
        else
        {
            DoManipulate(oPC, oTarget, ANIMATION_LOOPING_GET_MID, 1.0);
            DoSpeak(oTarget, (sNoPush1 + sTarget + sNoPush2));
        }
    }
    else
    {
        AssignCommand(oPC, ClearAllActions());
        DelayCommand(0.1, AssignCommand(oPC, ActionMoveToObject(oTarget, FALSE)) );
        SendMessageToPC(oPC, (sTooFarToPush1 + sTarget + sTooFarToPush2));
    }
    return bSuccess;
}

//::///////////////////////////////////////////////
//:: Name: DoRead
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
  Speaks Read string stored on object, PC moves to and faces oTarget
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 3/11/2006
//:: Last Modified: 2017 march 8  (henesua) ... moved logic to _read_use
//::                                            a use event script for reading placeables
//:://////////////////////////////////////////////
int DoRead(object oTarget, object oPC)
{
    SetLocalObject(oTarget,AID_TRIGGERING_OBJECT,oPC );
    ExecuteScript("_read_use", oTarget);

    return GetLocalInt(oPC,"AID_SUCCESS");
}


void PCTakesItem(object oTarget, string sTakeItem)
{
    float fDelay = FindDelay(OBJECT_SELF, oTarget);

    string sTag         = GetLocalString(oTarget,"taketag");
    string sDescription = GetLocalString(oTarget,"takedescription");
    string sName        = GetLocalString(oTarget,"takename");


    object oItemTaken   = CreateObject(OBJECT_TYPE_ITEM,sTakeItem,GetLocation(oTarget),TRUE,sTag);
    SetDescription(oItemTaken,sDescription);
    SetName(oItemTaken,sName);


    ActionPickUpItem(oItemTaken);

    // track amount that can be taken. if "takemax" == 0 then it is unlimited
    int nTakeMax    = GetLocalInt(oTarget, "takemax");
    if(nTakeMax)
    {
        int nRefresh        = GetLocalInt(oTarget,"takerefresh");
        if(nRefresh)
        {
            int nTakeLast   = GetLocalInt(oTarget,"takelast");
            int nNow        = GetTimeCumulative();
            if((nTakeLast+nRefresh)<=nNow)
            {
                DeleteLocalInt(oTarget,"taken");
                SetLocalInt(oTarget,"takelast",nNow);
            }
        }

        int nTaken  = GetLocalInt(oTarget, "taken")+1;
        if(nTaken==nTakeMax)
        {
            // last one taken. destroy the placeable
            if(nTakeMax>1)
                FloatingTextStringOnCreature(WHITE+GetName(OBJECT_SELF)+" took the last of the "+GREEN+GetTag(oTarget)+WHITE+".", OBJECT_SELF);
            DestroyObject(oTarget, fDelay);
        }
        else if(nTaken<nTakeMax)
        {
            if(nTakeMax&&(nTakeMax-nTaken)==1)
                SendMessageToPC(OBJECT_SELF,PINK+"Only one of the "+YELLOW+GetTag(oTarget)+PINK+" remains.");

            SetLocalInt(oTarget, "taken", nTaken);
        }
    }
}

//::///////////////////////////////////////////////
//:: Name: DoTake
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 3/8/2006
//:: Last Modified 6/15/2006
//:://////////////////////////////////////////////
int DoTake(object oTarget, object oPC)
{
    string sVerb        = "take";
    int bSuccess        = SkillCheck(oTarget, oPC, sVerb);
    string sTakeItem    = GetLocalString(oTarget, "takeitem");
    string sOnTake      = GetLocalString(oTarget, "ontake");

    if (sOnTake != "")
    {
        bSuccess = OnTake(oTarget, oPC, bSuccess);
    }
    else if (sTakeItem != "")
    {
        if(bSuccess)
        {
            //DoManipulate(oPC, oTarget, ANIMATION_LOOPING_GET_LOW, 1.0);
            //DoSpeak(oTarget, (sTaken + sTarget + "."));
            //CreateItemOnObject(sTakeItem, oPC);
            if(GetDistanceBetween(oPC,oTarget)>0.8)
                AssignCommand(oPC, ActionMoveToObject(oTarget));
            AssignCommand(oPC, ActionDoCommand(PCTakesItem(oTarget, sTakeItem)) );
        }
        else
        {
            SendMessageToPC(oPC,RED+"You failed to take "+YELLOW+GetTag(oTarget)+RED+".");
        }
    }
    else
    {
        SendMessageToPC(oPC, sBadCommand);
        bSuccess = FALSE;
    }
    return bSuccess;
}

//::///////////////////////////////////////////////
//:: Name: DoTouch
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
  Speaks Touch string stored on oTarget, oPC moves to and faces oTarget
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 3/8/2006
//:: Last Modified: 6/15/2006
//:://////////////////////////////////////////////
int DoTouch(object oTarget, object oPC)
{
    string sVerb    = "touch";
    int bSuccess    = SkillCheck(oTarget, oPC, sVerb);
    int iBurn       = (GetLocalInt(oTarget, "touch_fire")||GetLocalInt(oTarget, "LIGHTABLE"));
    int iAcid       = GetLocalInt(oTarget, "touch_acid");
    string sTouch   = GetLocalString(oTarget, sVerb);

    if(iBurn)
    {
        int iYesBurn = DoBurn(oTarget, oPC, iBurn);
        if(iYesBurn&&!GetLocalInt(oTarget, "touch_fire_continue"))
            return TRUE;
    }
    if(iAcid)
    {
        int iYesBurn = DoAcid(oTarget, oPC, iAcid);
        if(iYesBurn&&!GetLocalInt(oTarget, "touch_acid_continue"))
            return TRUE;
    }


    float fDelay = FindDelay(oPC, oTarget);
    //Clear oPC's Action Que
    AssignCommand(oPC, ClearAllActions());
    //force oPC to move to oTarget
    AssignCommand(oPC, ActionMoveToObject(oTarget));
    //PC faces oTarget
    DelayCommand(fDelay, AssignCommand(oPC, SetFacingPoint(GetPosition(oTarget))));

    if (sTouch == "passthrough")
    {
        bSuccess = OnTouch(oTarget, oPC, bSuccess);
    }
    else if (sTouch != "" && bSuccess)
    {
        DelayCommand(fDelay-0.2, SendMessageToPC(oPC, COLOR_MESSAGE+"Upon closer inspection:") );
        DelayCommand( (fDelay-0.19), SendMessageToPC(oPC, DoColorize(sTouch,TRUE)) );
    }
    else
    {
        DelayCommand(fDelay-0.2, SendMessageToPC(oPC, COLOR_MESSAGE+"Upon closer inspection:") );
        DelayCommand((fDelay-0.19), SendMessageToPC(oPC, sNoDescription));
    }

    return bSuccess;
}

int DoMove(object oTarget, object oPC, string sVerb="climb")
{
    int primeMove   = GetLocalInt(oTarget, "MOVE_SKILL");
    int bSuccess    = GetLocalInt(oTarget, sVerb);
    if(bSuccess || primeMove)
    {
        object oDest    = GetLocalObject(oTarget, "MOVE_DESTINATION_OBJECT");
        // determine if this object is not shown as useable
        int bHidden     = GetLocalInt(oTarget, "MOVE_HIDDEN");
        if(!bHidden && !GetUseableFlag(oTarget))
        {
            bHidden     = TRUE;
            SetLocalInt(oTarget, "MOVE_HIDDEN", TRUE);
        }

        int nAltSkill;
        if(sVerb=="climb")
            nAltSkill   = 1;
        else if(sVerb=="swim")
            nAltSkill   = 2;
        else if(sVerb=="squeeze")
            nAltSkill   = 3;
        else if(sVerb=="jump")
            nAltSkill   = 4;

        if(sVerb=="climb" || sVerb=="swim" || sVerb=="squeeze" || sVerb=="jump")
        {
            if(GetIsPossessedFamiliar(oPC))
            {
                string sScript  = GetLocalString(oTarget, "MOVE_SCRIPT");
                if(sScript==""){sScript="_plc_moveskill";}
                if(!GetLocalInt(oTarget, GetPCPlayerName(oPC)))
                {
                    SetLocalObject(oTarget, AID_TRIGGERING_OBJECT, oPC);
                    // here is where we
                    SetLocalInt(oPC, "MOVE_SKILL_OVERRIDE", nAltSkill);
                    ExecuteScript(sScript,oTarget);
                }
                // here is where we // SetLocalInt(oPC, "MOVE_SKILL_OVERRIDE", nAltSkill);
                SetLocalObject(oTarget, AID_TRIGGERING_OBJECT, oPC);
                ExecuteScript(sScript,oTarget);
            }
            else
            {
                if(bHidden)
                    SetUseableFlag(oTarget, TRUE);

                if(!GetLocalInt(oTarget, GetPCPlayerName(oPC)))
                {
                    SetLocalObject(oTarget, AID_TRIGGERING_OBJECT, oPC);
                    // here is where we
                    SetLocalInt(oPC, "MOVE_SKILL_OVERRIDE", nAltSkill);
                    AssignCommand(oPC, ActionInteractObject(oTarget));
                }
                SetLocalObject(oTarget, AID_TRIGGERING_OBJECT, oPC);
                // here is where we
                SetLocalInt(oPC, "MOVE_SKILL_OVERRIDE", nAltSkill);
                AssignCommand(oPC, ActionInteractObject(oTarget));
                if(bHidden)
                    DelayCommand(6.0, SetUseableFlag(oTarget, FALSE));
            }
        }
    }


    return bSuccess;
}

//::///////////////////////////////////////////////
//:: Action/Object Hooks
//::///////////////////////////////////////////////
/*
  Hooks allow placement of a script on an object for a certain AID action.
  Much like the hardcoded onUse or onOpen.

  7/2/2006 - Improved to store triggering object in a local on the calling object
  so the onEvent script can get the triggering creature.

  Use GetTriggeringObject() to get the PC that triggers the event. OBJECT_SELF
  is the AID object Targetted by the event.
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 5/16/2006
//:: Last Modified: 7/2/2006
//:://////////////////////////////////////////////
int OnDrink(object oCaller, object oPC, int iSkip)
{
    if (iSkip)
    {
        string sScript = GetLocalString(oCaller, "ondrink");

        if (sScript != "")
        {
            SetLocalObject(oCaller, AID_TRIGGERING_OBJECT, oPC);
            ExecuteScript(sScript, oCaller);
            return TRUE;
        }
    }
    return FALSE;
}

int OnExamine(object oCaller, object oPC, int iSkip, float fDelay)
{
    if (iSkip)
    {
        string sScript = GetLocalString(oCaller, "onexamine");

        if (sScript != "")
        {
            SetLocalObject(oCaller, AID_TRIGGERING_OBJECT, oPC);
            DelayCommand(fDelay, ExecuteScript(sScript, oCaller));
            return TRUE;
        }
    }
    return FALSE;
}

int OnExtinguish(object oCaller, object oPC, int iSkip)
{
    if (iSkip)
    {
        string sScript = GetLocalString(oCaller, "extinguish");

        if (sScript != "")
        {
            SetLocalObject(oCaller, AID_TRIGGERING_OBJECT, oPC);
            ExecuteScript(sScript, oCaller);
            return TRUE;
        }
    }
    return FALSE;
}

int OnLight(object oCaller, object oPC, int iSkip)
{
    if (iSkip)
    {
        string sScript = GetLocalString(oCaller, "light");

        if (sScript != "")
        {
            SetLocalObject(oCaller, AID_TRIGGERING_OBJECT, oPC);
            ExecuteScript(sScript, oCaller);
            return TRUE;
        }
    }
    return FALSE;
}

int OnPush(object oCaller, object oPC, int iSkip, string sVerb="push")
{
    if (iSkip)
    {
        string sScript = GetLocalString(oCaller, "on"+sVerb );

        if (sScript != "")
        {
            SetLocalObject(oCaller, AID_TRIGGERING_OBJECT, oPC);
            DoManipulate(oPC, oCaller, ANIMATION_LOOPING_GET_MID, 1.0);
            ExecuteScript(sScript, oCaller);
            if(GetLocalInt(oCaller, "RETURNS_"+sScript))
            {
                return (GetLocalInt(oCaller, "SUCCESS"));
            }
            else
                return TRUE;
        }
    }
    return FALSE;
}

int OnRead(object oCaller, object oPC, int iSkip)
{
    if (iSkip)
    {
        string sScript = GetLocalString(oCaller, "onread");

        if (sScript != "")
        {
            SetLocalObject(oCaller, AID_TRIGGERING_OBJECT, oPC);
            ExecuteScript(sScript, oCaller);
            return TRUE;
        }
    }
    return FALSE;
}

int OnSecretWord(object oCaller, object oPC)
{
    string sScript = GetLocalString(oCaller, "onsecretword");

    if (sScript != "")
    {
        SetLocalObject(oCaller, AID_TRIGGERING_OBJECT, oPC);
        ExecuteScript(sScript, oCaller);
        return TRUE;
    }
    return FALSE;
}

int OnTake(object oCaller, object oPC, int iSkip)
{
    if (iSkip)
    {
        string sScript = GetLocalString(oCaller, "ontake");

        if (sScript != "")
        {
            SetLocalObject(oCaller, AID_TRIGGERING_OBJECT, oPC);
            ExecuteScript(sScript, oCaller);
            return TRUE;
        }
    }
    return FALSE;
}

int OnTouch(object oCaller, object oPC, int iSkip)
{
    if (iSkip)
    {
        string sScript = GetLocalString(oCaller, "ontouch");

        if (sScript != "")
        {
            SetLocalObject(oCaller, AID_TRIGGERING_OBJECT, oPC);
            ExecuteScript(sScript, oCaller);
            return TRUE;
        }
    }
    return FALSE;
}

int OnUserDefined(object oCaller, object oPC, string sAction, int iSkip)
{
    if (iSkip)
    {
        string sScript = GetLocalString(oCaller, ("on" + sAction));

        if (sScript != "")
        {
            SetLocalObject(oCaller, AID_TRIGGERING_OBJECT, oPC);
            ExecuteScript(sScript, oCaller);
            return TRUE;
        }
    }
    return FALSE;
}

//::///////////////////////////////////////////////
//:: Name: SecretWord
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 6/1/2006
//:: Last Modified: 6/1/2006
//:://////////////////////////////////////////////
object SecretWord(object oPC, string sSpeech)
{
    int i,j;                            //counters for loops

    object oReturn = OBJECT_INVALID;    //Returns a valid object if a secret word is spoken within range
    object oArea = GetArea(oPC);        //current area
    object oSWObject;                   //Object with secret word attached

        //secret words: saved on area to minimize a performance issue
    string sSecretWord = "null";

        /* Tags of objects with secret words attached. I required these to be
         * added on the area for speed of getting the attached object when
         * the secret word is spoken (otherwise would have to loop through all
         * objects within x distance + 1) */
    string sSecretWordObject;

    string sSWTest;   // temp var to test if object has matching SW var

        //debugging
    /*
    if (oArea == OBJECT_INVALID)
    {
        DoSpeak(oPC, "Area Invalid");
        return oReturn;
    }
    else
        DoSpeak(oPC, "Area Valid");
    */

    i = 0;

    while (sSecretWord != "")
    {
        sSecretWord = GetLocalString(oArea, ("secretword" + IntToString(i)));

        if(sSecretWord == sSpeech)
        {
            sSecretWordObject = GetLocalString(oArea, ("secretwordobject" + IntToString(i)));
            j = 1;

            do
            {
                oSWObject = GetNearestObjectByTag(sSecretWordObject, oPC, j);
                sSWTest = GetLocalString(oSWObject, "secretword");

                if (sSWTest == sSecretWord)
                {
                    oReturn = oSWObject;
                    j = -1;
                }

                j++;

            }while (GetDistanceBetween(oSWObject, oPC) <= MAX_DISTANCE && j >= 1);
        }

        i++;
    }
    return oReturn;
}

//::///////////////////////////////////////////////
//:: Name: SkillCheck
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
speaks passresponse on pass, failresponse on fail, and returns -1 if onevent should not be run
oTarget - Target Object
oPC - PC making the skill check
sEvent - which AID event to check on

Added handling so that each PC can only roll any one skill check once rather than
trying repeatedly until they get a good roll. - TV 10/6/2006
*/
//:://////////////////////////////////////////////
//:: Created: Jesse Wright 5/30/2006
//:: Modified: 10/6/2006
//:: Modified: The Magus 2012 aug 5 - language check for reading
//:://////////////////////////////////////////////
int SkillCheck(object oTarget, object oPC, string sEvent)
{
    int iReturn = TRUE;
    int nCheck  = GetLocalInt(oTarget, ("check"+sEvent));
    // BEGIN if skillcheck
    if ( nCheck )
    {
        int iDC     = GetLocalInt(oTarget, (sEvent + "dc"));        // Check DC
        int iSkill  = GetLocalInt(oTarget, (sEvent + "skill"));  // Which skill to check by skill index (see documentation for list)
        string sPassResponse = GetLocalString(oTarget, (sEvent + "passresponse"));  // Responses to give the PC depending on their resuslts
        string sFailResponse = GetLocalString(oTarget, (sEvent + "failresponse"));
        string sOnEventOn = GetLocalString(oTarget, (sEvent + "oneventon"));        // Do we run the event script if the PC succeeds or if they fail?
        int iResult;    // need this one in this scope too - TV 10/6/2006

              // The roll of the PCs previous check (0 if no check previously)
              // Small hole where if the PC has a negative skill modifier and
              // rolls a 0 they'll get to roll again. won't happen often going
              // to ignore it -TV 10/6/2006
        int iPreviousCheck = GetLocalInt(oTarget, GetName(oPC) + "checkbefore");

        // if the PC hasn't checked before
        if ( !iPreviousCheck )
        {
            if(sEvent=="push" || sEvent=="pull")
            {
                // push or pull is always a strength check
                // The roll is not stored, as pushing and pulling is something that can be tried again and again
                iResult = GetAbilityCheck(oPC, ABILITY_STRENGTH, iDC, TRUE);
                if(!iResult)
                {
                    // temporarily reduce strength
                    GivePCFatigue(oPC);
                }
            }
            else
            {
                if(sEvent=="touch")
                {
                    if(d20()+GetSkillRank(iSkill, oPC)>=iDC)
                        iResult = TRUE;
                    else
                        iResult = FALSE;
                }
                else
                {
                    iResult = GetIsSkillSuccessful(oPC, iSkill, iDC);   // Do the check
                }
                // Store the PC's result under their name on the object we're checking
                // offset the bool by 1 so we aren't interfered with by 0 being
                // the default value (otherwise failed previously and never checked
                // before would look identical.
                if(nCheck!=99)
                    SetLocalInt(oTarget, GetName(oPC) + "checkbefore", iResult + 1);
            }
        }
        else    // If they've checked before we'll just use the roll result we stored for them
        {
                // Downshift the stored value back to a bool (0/1) so we can use
                // it as our result.
            iResult = iPreviousCheck - 1;

        }

        // if check is successful
        if (iResult)
        {
            // Modify return value by sOnEventOn, only check the one case that would modify behaviour.
            if (sOnEventOn == "fail")
                iReturn = FALSE;
            else
                iReturn = TRUE;
        }
        //if check fails
        else if (!iResult)
        {
            // Modify return value by sOnEventOn, only check the one case that would modify behaviour.
            if (sOnEventOn == "pass")
                iReturn = TRUE;
            else
                iReturn = FALSE;
        }

        if(iReturn)
        {
            if(sPassResponse!="")
                SendMessageToPC(oPC, LIGHTBLUE+"(Success) "+DoColorize(sPassResponse));
        }
        else if(sFailResponse!="")
            SendMessageToPC(oPC, RED+"(Failure) "+DoColorize(sFailResponse));

    } // END if skillcheck
    return iReturn;
}

//::///////////////////////////////////////////////
//:: Name: DoExtinguish
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
Checks conditions and makes the PC move to and turns
off a light source if appropriate, gives feedback
*/
//:://////////////////////////////////////////////
//:: Created:   Jesse Wright 3/18/2006
//:://////////////////////////////////////////////
//:: Modified:  Henesua (2013 dec 1) executes script v2_light_use

int DoExtinguish(object oTarget, object oPC)
{
    string sVerb    = "extinguish";
    int bSuccess    = SkillCheck(oTarget, oPC, sVerb);
    string sExting  = GetLocalString(oTarget, sVerb);
    int iSpecial    = GetLocalInt(oTarget, "LIGHTABLE");

    float fDelay = FindDelay(oPC, oTarget);
    //Clear oPC's Action Que
    AssignCommand(oPC, ClearAllActions());
    //force oPC to move to oTarget
    AssignCommand(oPC, ActionMoveToObject(oTarget));
    //PC faces oTarget
    DelayCommand(fDelay, AssignCommand(oPC, SetFacingPoint(GetPosition(oTarget))));

    if (sExting!="")
    {
        bSuccess = OnExtinguish(oTarget, oPC, bSuccess);
    }
    else if(iSpecial)
    {
        if(bSuccess)
        {
            DoManipulate(oPC, oTarget, ANIMATION_LOOPING_GET_MID, 1.0);

            if (GetLocalInt(oTarget,"NW_L_AMION"))
            {
                SetLocalObject(oTarget, AID_TRIGGERING_OBJECT, oPC);
                ExecuteScript("_light_use", oTarget);
                return TRUE;
            }
            else
            {
                DoSpeak(oTarget, (sBadCommand + " The flame is not lit."));
                return TRUE;
            }
        }
        else
        {
            return FALSE;
        }
    }
    else
    {
        DoSpeak(oTarget, sBadCommand);
        return FALSE;
    }

    return bSuccess;
}

//::///////////////////////////////////////////////
//:: Name: DoLight
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
Checks conditions and makes the PC move to and turns
on a light source if appropriate, gives feedback
*/
//:://////////////////////////////////////////////
//:: Created:   Jesse Wright 3/18/2006
//:: Modified: 11/12/2006
//:://////////////////////////////////////////////
//:: Modified:  Henesua (2013 dec 1) executes script v2_light_use


int DoLight(object oTarget, object oPC)
{
    string sVerb    = "light";
    int bSuccess    = SkillCheck(oTarget, oPC, sVerb);
    string sLight   = GetLocalString(oTarget, sVerb);
    int iSpecial    = GetLocalInt(oTarget, "LIGHTABLE");

    float fDelay = FindDelay(oPC, oTarget);
    //Clear oPC's Action Que
    AssignCommand(oPC, ClearAllActions());
    //force oPC to move to oTarget
    AssignCommand(oPC, ActionMoveToObject(oTarget));
    //PC faces oTarget
    DelayCommand(fDelay, AssignCommand(oPC, SetFacingPoint(GetPosition(oTarget))));

    if (sLight!="")
    {
        bSuccess = OnLight(oTarget, oPC, bSuccess);
    }
    else if(iSpecial)
    {
        if(bSuccess)
        {
            DoManipulate(oPC, oTarget, ANIMATION_LOOPING_GET_MID, 1.0f);
            if (!GetLocalInt(oTarget,"NW_L_AMION"))
            {
                SetLocalObject(oTarget, AID_TRIGGERING_OBJECT, oPC);
                ExecuteScript("_light_use", oTarget);
                return TRUE;
            }
            else
            {
                DoSpeak(oTarget, (sBadCommand + " The flame is already lit."));
                return TRUE;
            }
        }
        else
        {
            return FALSE;
        }
    }
    else
    {
        DoSpeak(oTarget, sBadCommand);
        return FALSE;
    }

    return bSuccess;
}

//::///////////////////////////////////////////////
//:: Name: DoManipulate
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
Makes the PC move to an object and do an animation. fDurationSeconds is the
duration to play the animation.
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 3/6/2006
//:://////////////////////////////////////////////

void DoManipulate(object oPC, object oTarget, int iAnimation, float fDurationAnim=0.0)
{
     float fDelay = FindDelay(oPC, oTarget);

     AssignCommand(oPC, ClearAllActions());       //Clear oPC's Action Que
     AssignCommand(oPC, ActionMoveToObject(oTarget, FALSE, 1.5f));   //force oPC to move to oTarget
     DelayCommand((fDelay-0.1), AssignCommand(oPC, SetFacingPoint(GetPosition(oTarget))));  //PC faces oTarget
     DelayCommand(fDelay, AssignCommand(oPC, ActionPlayAnimation(iAnimation, 1.0f, fDurationAnim)));//make them do some animation
}

//::///////////////////////////////////////////////
//:: Name: DoSpeak
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
oSpeaker speaks sSpeech at iVolume
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 5/22/2006
//:: Last Modified 5/22/2006
//:://////////////////////////////////////////////

void DoSpeak(object oSpeaker, string sSpeech, int iVolume=TALKVOLUME_TALK)
{
    AssignCommand(oSpeaker, ActionSpeakString(sSpeech, iVolume));
}

//::///////////////////////////////////////////////
//:: Name: EffectHit
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
Applies a linked effect of eEffect and iVFX to oPC of DURATION_TYPE_*, iDurationType and a duration of fDuration
oPC excliams sPCExclaims (cry out, cuss, groan, "wtf?!")
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 3/7/2006
//:: Last Modified: 5/18/2006
//:://////////////////////////////////////////////

void EffectHit(object oPC, effect eEffect, int iVFX, int iDurationType = DURATION_TYPE_INSTANT, float fDuration = 0.0, string sPCExclaims="")
{
    if (sPCExclaims != "")
    {
        AssignCommand(oPC, ActionSpeakString(sPCExclaims, TALKVOLUME_TALK));
    }
    ApplyEffectToObject(iDurationType, EffectLinkEffects(EffectVisualEffect(iVFX), eEffect), oPC, fDuration);
}

//::///////////////////////////////////////////////
//:: Name: FindDelay
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
  Returns an appropriate amount of time to delay for the distance oTargetA must
  move to arrive at oTargetB. For running target iIsRunning = TRUE, for a
  walking target use FALSE.
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 3/9/2006
//:: Last Modified On: 9/21/2006
//:://////////////////////////////////////////////

float FindDelay(object oTargetA, object oTargetB, int iIsRunning = TRUE)
{
    int iDivisor;
    float fDistance;
    float fDelay;
    float fConstant;    // Attempt to account for the amount of time it takes to get going and to stop

    if (iIsRunning)     {   iDivisor = 6; fConstant = 0.3;      }
    else                {   iDivisor = 3; fConstant = 0.6;      }

    fDistance = GetDistanceBetween(oTargetA, oTargetB);
    fDelay = fDistance/iDivisor /*+ fConstant*/;

    return fDelay;
}

//:://////////////////////////////////////////////
//:: Function Name: GetObjectInArea
//:: Borrowed from Darkness over Daggerford hf hak
/*
  returns the nth instance of an object with a given tag in a given area

  .. I wrote this function after observing that GetNearestObjectByTag()
  .. sometimes fails when the player object is used in area onEnter scripts
  .. my thinking is that the player isn't fully "inside" the area when
  .. the area's onEnter script executes.
*/
//:: Author was not specified in comments
//:://////////////////////////////////////////////

object GetObjectInArea(string sTag, object oPC, int n)
{
    object oMyArea = GetArea(oPC);
    int nFound = FALSE;
    int j = 0;
    int i = 0;
    object o = GetObjectByTag(sTag, i);
    while (GetIsObjectValid(o))
    {
        if (GetArea(o) == oMyArea)
        {
            if (++j == n)
            {
                nFound = TRUE;
                break;
            }
        }
        o = GetObjectByTag(sTag, ++i);
    }
    if (nFound == TRUE)
        return(o);
    return(OBJECT_INVALID);
}

//::///////////////////////////////////////////////
//:: Name: GetTriggeringObject
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
For use in nwaid onevent scripts.
returns the object that triggered the nwaid event
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 7/13/2006
//:://////////////////////////////////////////////
object GetTriggeringObject()
{
     return GetLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT);
}

int IsIgnoredWord(string sWord)
{
    if(    sWord == "" // ignore blank strings
        || sWord == " " // ignore spaces
        || sWord == "*"
        || sWord == "a"
        || sWord == "an"
        || sWord == "the"
        || sWord == "at"
        || sWord == "from"
        || sWord == "to"
        || sWord == "for"
        || sWord == "in"
        || sWord == "into"
        || sWord == "out"
        || sWord == "through"
        || sWord == "across"
        || sWord == "over"
        || sWord == "under"
        || sWord == "up"
        || sWord == "down"
        || sWord == "away"
      )
        return TRUE;
    else
        return FALSE;
}

//::///////////////////////////////////////////////
//:: Name: RollSave
//:: Copyright (c) 2006 Jesse Wright
//:://////////////////////////////////////////////
/*
Saving throw
iSaveType - 0=Fort 1=Ref 2=Will
not used yet
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright
//:: Created On: 3/7/2006
//:://////////////////////////////////////////////

int RollSave(object oPC, int iDC, int iSaveType, int iSaveSubType)
{
    int iResult;

    if (iSaveType == 0)
    {
        iResult = FortitudeSave(oPC, iDC, iSaveSubType, OBJECT_SELF);
    }
    else if (iSaveType == 1)
    {
        iResult = ReflexSave(oPC, iDC, iSaveSubType, OBJECT_SELF);
    }
    else if (iSaveType == 2)
    {
        iResult = WillSave(oPC, iDC, iSaveSubType, OBJECT_SELF);
    }

    if (iResult == 1 && iSaveType == 0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FORTITUDE_SAVING_THROW_USE), oPC);
    }
    else if (iResult == 1 && iSaveType == 1)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_REFLEX_SAVE_THROW_USE), oPC);
    }
    else if (iResult == 1 && iSaveType == 2)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE), oPC);
    }

    return (iResult);
}

//For compile testing only
//void main(){}
