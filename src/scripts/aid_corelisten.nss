//::///////////////////////////////////////////////
//:: Name: AID - Ambiguous Interactive Dungeons - Core Listener
//:: FileName: aid_corelisten
//:: Copyright (c) 2006 Jesse Wright
//:: Modifications by The Magus (2011)
//:://////////////////////////////////////////////
/*
    /////////////  [Change Log AID Version 1] //////////////////////////////////
    7/2/2006 - OnEvent handles improved. Tag of triggering PC saved on object so it
        can be gotten by the onevent script (no more fudging by getting the nearest
        PC.)
    7/12/2006 - GetTriggeringObject() added in aid_inc_fcns to improve handling of
        above mentioned situations.
    7/15/2006 - inspect(s) added as touch event keyword
    7/20/2006 - added user defined actions functionality for global (module wide)
        and local (area wide) actions. User defined actions have no default
        behavior, they go straight to the on event hook. In other words, these are
        only useful to the builder who is at least somewhat proficient in scripting
        (or can use lilac souls ;))
    7/26/2006 - adding handling to try to eliminate double response zones when
        narrator listening radii overlap. (and it worked.)
    10/06/2006 - Each PC can only attempt each skillcheck once
    2/9/2007 - touching a fire changed to 2d3 dmg from 2d6
    2/23/2007 - Renaming all scripts, constants and varnames to reflect the name
        change to AID. - TV

    /////////////  [Change Log AID Version 2] //////////////////////////////////
    2011 dec 29
    The Magus rewrote the AID system with the following goals:
        (1) aid_corelisten used by a module's OnPlayerChat event instead of a listener.
            Listeners are no longer required, so the entire system runs much leaner than before.
        (2) works with DMFI
        (3) make miscellaneous improvements to the system
*/
//:://////////////////////////////////////////////
//:: Created By: Jesse Wright (Talan Va'lash, SongOfTheWeave) - talanvalash@layonara.com - 2/26/2006
//:: Modified: 2/23/2007
//:: Modified: Magus (2011 dec 29) rewrote to work as a module's OnPlayerChat script
//:://////////////////////////////////////////////

#include "aid_inc_fcns"

/// [MAIN] called by or from OnPlayerChat event ////////////////////////////////
void main()
{
    object oPC      = GetPCChatSpeaker();           // who are we working with?

    // Only PCs and DMs are processed. Is this necessary?
    if (!GetIsPC(oPC) && !GetIsDM(oPC) && !GetIsDMPossessed(oPC))
        return;

    string sSpeech = GetPCChatMessage();            // chat string most recently entered
    // int nVolume     = GetPCChatVolume();           // not used with this script, but typical for OnPlayerChat event
    // eat leading whitespace
    while (GetStringLeft(sSpeech, 1) == " ")
        sSpeech = GetStringRight(sSpeech, GetStringLength(sSpeech)-1);

    string sLastSpeech = sSpeech;

    ///////////////////////
    //Begin Emote Handling//
    ///////////////////////
    // moved emote parsing to aid_inc_fcns in the new function AIDProcessEmote(object oPC, string sSpeech)
    if(FindSubString(sSpeech, "*")!=-1)
    {
        //isolate emote text from chat message
        int nLength = GetStringLength(sSpeech);
        int nPos1, nPos2;
        string sTemp;
        nPos1   = FindSubString(sSpeech,"*");
        while(nPos1!=-1 && nPos2!=-1)
        {
            nPos2   = FindSubString(sSpeech,"*",(nPos1+1));
            if(nPos2==-1)
            {
                sTemp   += "*"+" "+GetStringRight(sSpeech,nLength-(nPos1+1))+" ";
                break;
            }
            else if(nPos2>(nPos1+1))
            {
                sTemp   += "*"+" "+GetSubString(sSpeech,(nPos1+1),((nPos2)-(nPos1+1)))+" ";
                nPos1   = FindSubString(sSpeech,"*",(nPos2+1));
            }
            else
                nPos1   = nPos2;
        }
        sTemp = GetStringLowerCase(sTemp);

        int bAIDSuccess; // determines whether an AID action resulted in animation/action
        bAIDSuccess = AIDParseEmote(oPC, sTemp);
    }
    ///////////////
    //DM Handling//
    ///////////////
    else if ( GetStringLeft(sSpeech, 1) == "@" && GetIsDM(oPC))
    {
        int iLengthSubString1;                      // character length of SubString1 (verb)
        int iLengthSubString2;                      // character length of SubString2 (object)
        int iLocWordBreak;                          // position of break between verb and object (" ")
        int iDMNewInt;
        string sDMObject;                           // DM handling, which object is being edited
        string sDMVar;                              // DM handling, which var on that object?
        string sDMNewString;                        // DM handling, set var to this
        string sTempString;                         // used for convenience in DM handling
        object oDMObject;                           // DM handling

            // Gather data for DM IG variable manipulation
        iLocWordBreak = FindSubString(sSpeech, " ");        // Find the break between the first word and the rest
        iLengthSubString1 = (iLocWordBreak - 1);            // Length of first word is that position -1 because the zeroth char is @ and will be dropped
        sDMObject = GetSubString(sSpeech, 1, iLengthSubString1);    // Set as object/target

        iLengthSubString2 = GetStringLength(sSpeech) - (iLocWordBreak + 1);         // Find Length of all the rest of the string
        sTempString = GetSubString(sSpeech, (iLocWordBreak+1), iLengthSubString2);  // Dump rest of string into this var, will have two words left in it

        iLocWordBreak = FindSubString(sTempString, " ");    // find the break between the words in the temp string
        sDMVar = GetStringLowerCase(GetSubString(sTempString, 0, iLocWordBreak));       // take the first one and make it the Var to be adressed. Item var names must be LC.

        iLengthSubString1 = GetStringLength(sTempString) - (iLocWordBreak + 1);         // Reuse iLengthSubString1 for the length of the third word (second in tempstring)
        sDMNewString = GetSubString(sTempString, (iLocWordBreak+1), iLengthSubString1); // Whatevers left is used as the value

        oDMObject = GetNearestObjectByTag(GetStringLowerCase(sDMObject), oPC);    // all tags must be LC

        if (sDMVar == "destroy")
        {
            DestroyObject(oDMObject);
            SendMessageToPC(oPC, (COLOR_OBJECT + sDMObject + COLOR_MESSAGE + sDMDestroy));
        }
        else if (sDMVar == "dmexamine")
        {
            DumpAIDVariables(oPC, oDMObject);
        }
        else if (GetStringLeft(sDMNewString, 1) == "#")
        {
            sDMNewString = GetSubString(sDMNewString, 1, GetStringLength(sDMNewString));
            iDMNewInt = StringToInt(sDMNewString);

            SetLocalInt(oDMObject, sDMVar, iDMNewInt);
            SendMessageToPC(oPC, (COLOR_MESSAGE + sDMSet1 + COLOR_VARNAME + sDMVar + COLOR_MESSAGE + sDMSet3 + COLOR_OBJECT + sDMObject + COLOR_MESSAGE + " to: " + sDMNewString));
        }
        else
        {
            SetLocalString(oDMObject, sDMVar, sDMNewString);
            SendMessageToPC(oPC, (COLOR_MESSAGE + sDMSet1 + COLOR_VARNAME + sDMVar + COLOR_MESSAGE + sDMSet2 + COLOR_OBJECT + sDMObject + COLOR_MESSAGE + " to: " + sDMNewString));  //feedback
        }
    }
    // !! Memory Slot Commands !! //
    // save last speech in mem slot
    else if (GetStringLeft(sSpeech, 4) == ">mem")
    {
        string sMemPos = GetSubString(sSpeech, 4, 1);
        SetLocalString(oPC, "aid_memory_" + sMemPos, GetLocalString(oPC, "lastspeech"));
    }
        // speak speech from...
    else if (GetStringLeft(sSpeech, 1) == "<")
    {
            // last spoken
        if (GetStringLeft(sSpeech, 5) == "<last")
        {
            DelayCommand(0.15, AssignCommand(oPC, ActionSpeakString(GetLocalString(oPC, "lastspeech"))));
        }
            // mem slot
        else if (GetStringLeft(sSpeech, 4) == "<mem")
        {
            string sMemPos = GetSubString(sSpeech, 4, 1);
            DelayCommand(0.15, AssignCommand(oPC, ActionSpeakString(GetLocalString(oPC, "aid_memory_" + sMemPos))));
        }
    }
    else
    {
        sSpeech = GetStringLowerCase(sSpeech);  // make the whole thing lowercase (so user end isnt case sensative)

        object oSWObject = SecretWord(oPC, sSpeech);

        if (oSWObject != OBJECT_INVALID)
        {
            OnSecretWord(oSWObject, oPC);
        }
    }

    if (GetStringLeft(sLastSpeech, 1) != "<")
    {
        SetLocalString(oPC, "lastspeech", sLastSpeech); // Set last speech (which is now the current speech) to this var to enable repeat last line util.
    }

}//end main
