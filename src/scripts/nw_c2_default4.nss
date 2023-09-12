//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT4
/*
  Default OnConversation event handler for NPCs.

 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////

#include "nw_i0_generic"

#include "te_functions"

void main()
{

    if(GetLocalString(OBJECT_SELF,"Town") != "")
    {
        BeginConversation();
        if (GetListenPatternNumber() == 1 &&
            GetLastSpeaker() == GetPCSpeaker())
        {
            string sGold = GetMatchedSubstring(0);
            SetLocalString(OBJECT_SELF, "GOLD", sGold);
            SetCustomToken(1000, sGold);
        }
    }

    // * if petrified or dead, exit directly.
    if(     GetHasEffect(EFFECT_TYPE_PETRIFY, OBJECT_SELF)
        ||  GetIsDead(OBJECT_SELF)
      )
        return;

    // See if what we just 'heard' matches any of our predefined patterns
    int nMatch      = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();

    if (nMatch == -1)
    {
        //DMFI CODE ADDITIONS BEGIN HERE ---------------------------------------
        if(     GetIsPC(oShouter)
            &&(     GetLocalInt(GetModule(), "dmfi_AllMute")
                ||  GetLocalInt(OBJECT_SELF, "dmfi_Mute")
              )
          )
        {
            SendMessageToAllDMs(GetName(oShouter) + " is trying to speak to a muted NPC, " + GetName(OBJECT_SELF) + ", in area " + GetName(GetArea(OBJECT_SELF)));
            SendMessageToPC(oShouter, DMBLUE+"This NPC is muted. A DM will be here shortly.");
            return;
        }
        //DMFI CODE ADDITIONS END HERE -----------------------------------------

        // Not a match -- start an ordinary conversation
        if(     GetCommandable(OBJECT_SELF)
            ||  GetHasEffect(EFFECT_TYPE_CHARMED) // only charmed... convo still possible
          )
        {
            if(GetLocalInt(OBJECT_SELF, "IN_CONV"))
            {
                string sBusy    = GetLocalString(OBJECT_SELF, "DIALOG_BUSY");
                if(sBusy=="")
                       sBusy    = "*Indicates they are busy*";

                SpeakString(sBusy, TALKVOLUME_TALK);
                FloatingTextStringOnCreature(GREEN+GetName(oShouter)+LIME+" unsuccessfully tries to start a conversation with "+GREEN+GetName(OBJECT_SELF)+LIME+".", oShouter);
            }
            else
            {
                ClearAllActions();
                string sRef = GetLocalString(OBJECT_SELF,"SOCIAL_SOUND");
                if(sRef!="")
                    PlaySound(sRef);

                // attempt to use a custom conversation file
                // if nothing available, play a voice chat
                if(!DetermineConversation(OBJECT_SELF, oShouter, TRUE, TRUE))
                {
                    PlayVoiceChat(VOICE_CHAT_SELECTED);
                }
            }
        }
    }
    // Respond to shouts from valid shouters only
    else if(    GetIsObjectValid(oShouter) )
    {
      object oIntruder = OBJECT_INVALID;

      // Respond to shouts from friendly non-PCs
      if(   !GetIsPC(oShouter)
         && (   GetIsFriend(oShouter)
            //||  GetSharesGroupMembership(oShouter)
            ||  GetFactionEqual(oShouter)
            )
        )
      {
        // Determine the intruder if any
        if(nMatch==4)
        {
            oIntruder = GetLocalObject(oShouter, "NW_BLOCKER_INTRUDER");
        }
        else if(nMatch==5)
        {
            oIntruder = GetLastHostileActor(oShouter);
            if(!GetIsObjectValid(oIntruder))
            {
                oIntruder = GetAttemptedAttackTarget();
                if(!GetIsObjectValid(oIntruder))
                {
                    oIntruder = GetAttemptedSpellTarget();
                    if(!GetIsObjectValid(oIntruder))
                    {
                        oIntruder = OBJECT_INVALID;
                    }
                }
            }
        }
        // FLEE SHOUT HEARD ---------------------
        else if( nMatch==13 )
        {
            // animals shouting to flee
            if( GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL) )
            {
                if(     GetLocalInt(OBJECT_SELF, "AI_PACK")
                    //&&  GetSharesGroupMembership(oShouter)
                    &&  GetFactionEqual(oShouter)
                    &&  !GetLocalInt(OBJECT_SELF, "AI_MODE_FLEEING")
                   )
                {
                    ClearAllActions(TRUE);
                    ActionForceFollowObject(oShouter, 3.0);
                    SetLocalInt(OBJECT_SELF, "AI_MODE_FLEEING", TRUE);
                    DelayCommand(18.0, DeleteLocalInt(OBJECT_SELF, "AI_MODE_FLEEING"));
                }
            }
        }
        // ALARM SHOUT HEARD ---------------------
        else if(    nMatch==12
                &&  GetIsShoutHeard(oShouter)
               )
        {
            // is the NPC already in a state of alert?
            if( GetLocalInt(OBJECT_SELF, "AI_ALERTED"))
            {
                // what to do?
                // determine if this new alarm takes precedence?
                // ignore for now unless we introduce more functionality
            }
            // not in a state of alarm
            else
            {
                // gather pointer to the ALARM_SOURCE
                // the ALARM_SOURCE is the object which holds all data for the alarm
                object oAlarm  = GetLocalObject(oShouter, "ALARM_SOURCE");
                if(oAlarm==OBJECT_INVALID)
                       oAlarm  = oShouter;
                SetLocalObject(OBJECT_SELF, "ALARM_SOURCE", oAlarm);

                // signal EVENT_ALERTED
                SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_ALERTED));
            }
        }
        // SUBDUAL ATTACK SHOUT HEARD ---------------------
        else if( nMatch==15 )
        {
            if(!GetIsInCombat())
            {
                oIntruder = GetLastHostileActor(oShouter);
                if(!GetIsObjectValid(oIntruder))
                {
                    oIntruder = GetAttemptedAttackTarget();
                    if(!GetIsObjectValid(oIntruder))
                    {
                        oIntruder = GetAttemptedSpellTarget();
                        if(!GetIsObjectValid(oIntruder))
                        {
                            oIntruder = OBJECT_INVALID;
                        }
                    }
                }

                if(CreatureGetIsCivilized())
                {
                    if(!GetLocalInt(OBJECT_SELF,"COMBAT_NONLETHAL"))
                    {
                        SetLocalInt(OBJECT_SELF,"COMBAT_NONLETHAL",TRUE);
                        DelayCommand(60.0,DeleteLocalInt(OBJECT_SELF,"COMBAT_NONLETHAL"));
                    }
                }

                SetIsTemporaryEnemy(oIntruder);
                ClearActions(CLEAR_NW_I0_GENERIC_834);
                DetermineCombatRound(oIntruder);
            }
        }
      }
      // respond to enemies - PC and NPC
      else if(GetIsEnemy(oShouter))
      {
        // SUBDUAL DEATH SHOUT HEARD ---------------------
        if( nMatch==14 )
        {
            if(GetLocalInt(OBJECT_SELF, "COMBAT_NONLETHAL"))
            {
                if(     GetAttemptedAttackTarget()==oShouter
                    ||  GetAttemptedSpellTarget()==oShouter
                  )
                {
                    ClearAllActions(TRUE);
                }
            }
        }
      }

      // Actually respond to the shout
      RespondToShout(oShouter, nMatch, oIntruder);
    }

    // Send the user-defined event if appropriate
    if(GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DIALOGUE));
    }
}
