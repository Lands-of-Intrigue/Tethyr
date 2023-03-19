//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT2
/*
  Default OnPerception event handler for NPCs.

  Handles behavior when perceiving a creature for the
  first time.
 */
//:://////////////////////////////////////////////////
//:: Modified: Henesua (2014 feb 18)

#include "nw_i0_generic"
#include "te_functions"

// meaglyn's waypoints
#include "aww_inc_walkway"

// NESS
#include "spawn_functions"

void FindVanishedCreature(object oPercep, int bAttack=FALSE);
void FindVanishedCreature(object oPercep, int bAttack=FALSE)
{
    // SpeakString("I_HEAR_AN_UNSEEN_CREATURE", TALKVOLUME_SILENT_TALK);
    //if(!GetLocalInt(OBJECT_SELF, "PATROL_OVERRIDE"))
        ClearAllActions();

    if(     bAttack && GetHasSpell(SPELL_TRUE_SEEING)
        &&(     GetStealthMode(oPercep)
            ||  GetHasEffect(EFFECT_TYPE_INVISIBILITY,oPercep)
          )
      )
    {
        ActionCastSpellAtObject(SPELL_TRUE_SEEING, OBJECT_SELF);
        //if(bAttack)
            ActionDoCommand(AIAggressiveResponse(oPercep));
    }
    else if(    GetHasSpell(SPELL_SEE_INVISIBILITY)
            &&  GetHasEffect(EFFECT_TYPE_INVISIBILITY,oPercep)
           )
    {
        ActionCastSpellAtObject(SPELL_SEE_INVISIBILITY, OBJECT_SELF);
        if(bAttack)
            ActionDoCommand(AIAggressiveResponse(oPercep));
    }
    else if(    GetHasSpell(SPELL_INVISIBILITY_PURGE)
            &&  GetHasEffect(EFFECT_TYPE_INVISIBILITY,oPercep)
           )
    {
        ActionCastSpellAtLocation(SPELL_INVISIBILITY_PURGE, GetLocation(oPercep));
        if(bAttack)
            ActionDoCommand(AIAggressiveResponse(oPercep));
    }
    else
    {
        ActionMoveToLocation(GetLocation(oPercep), bAttack);

        if(     bAttack
                &&(     GetHasFeat(FEAT_BLIND_FIGHT)
                    ||  GetScentRange(OBJECT_SELF)>0.0
                  )
          )
            ActionDoCommand(AIAggressiveResponse(oPercep));
        else
        {
            ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.5);
            ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.5);
            ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 0.5);
        }
    }
}

void DoMeaglynWaypointCode(object oPercep);
void DoMeaglynWaypointCode(object oPercep)
{
    // activate ambient animations or walk waypoints if appropriate
    if(     !GetLocalInt(OBJECT_SELF, "SLEEPING")   // henesua -- we check elsewhere for a busy creature
      )
    {
        if (aww_GetIsPostOrWalking())
        {
            if (!GetLocalInt(OBJECT_SELF, "aww_perc_throttle" ))
            {
                      //SendMessageToPC(GetFirstPC(), "Perception event calls aww_WalkWaypoints for " + GetTag(OBJECT_SELF));
                SetLocalInt(OBJECT_SELF, "aww_perc_throttle", 1);
                aww_WalkWayPoints();
            }
            DelayCommand(2.0,DeleteLocalInt(OBJECT_SELF, "aww_perc_throttle"));
        }
        else if(    GetIsPC(oPercep)
                &&(     GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS)
                    ||  GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN)
                    ||  GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS)
                    ||  GetIsEncounterCreature()
                   )
               )
        {
            SetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE);
        }
    }
}

void main()
{
    // sleepers do not perceive anything
    if(GetHasEffect(EFFECT_TYPE_SLEEP))
        return;

    // * if not runnning normal or better AI then exit for performance reasons
    if (GetAILevel() == AI_LEVEL_VERY_LOW)
    {
        // first ensure that there is no "PC COUNT" - scry sensors are also counted
        if(GetLocalInt(GetArea(OBJECT_SELF), SPAWN_PCS_IN_AREA)<1)
            return;
    }
    object oPercep      = GetLastPerceived();
    if(!GetIsObjectValid(oPercep) || GetIsDM(oPercep)) return;
    object oArea        = GetArea(OBJECT_SELF);
    int bSpecial        = GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL);
    int bCombat         = GetIsInCombat();
    int bShareGroup     = GetFactionEqual(oPercep);//GetSharesGroupMembership(oPercep);
    int nReactionType   = GetReputationReactionType(oPercep, OBJECT_SELF, bShareGroup);
    int bEnemy, bFriend, bNeutral;

    if(nReactionType==1)
        bEnemy          = TRUE;
    else if(nReactionType==2)
        bFriend         = TRUE;
    else
        bNeutral        = TRUE;

    //int bBusy       = GetIsBusy();
    //int bPC         = GetIsPC(oPercep);
    string sSense;

    if(GetLastPerceptionHeard())
    {
        sSense  = "HEARD";

        int bSentry     = GetLocalInt(OBJECT_SELF, "AI_SENTRY");
        if(bCombat)
        {

        }
        else if(bEnemy)
        {

            if( !GetObjectSeen(oPercep) )
            {
                // if we can't see this one but we should have, go looking for them
                if(LineOfSightObject(OBJECT_SELF, oPercep))
                {
                    FindVanishedCreature(oPercep, TRUE);
                }
                // we've heard an enemy that is not yet in our sight
                else
                {
                    // do we prefer to hide?
                    if(GetLocalInt(OBJECT_SELF,"AI_STEALTHY"))
                    {
                        SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, TRUE);
                    }
                    if(bSentry)
                        FindVanishedCreature(oPercep, TRUE);
                }
            }
        }
        else if(CreatureGetIsBusy())
        {

        }
        else
        {
            // if we can't see this one, investigate what made the sound
            if(!GetObjectSeen(oPercep) && (bSentry&&!bFriend&&!bShareGroup))
            {
                //SpeakString("*listening*");
                FindVanishedCreature(oPercep);
            }
            // comment out if we get performance issues
            else
            {
                DoMeaglynWaypointCode(oPercep);
            }
        }
    }
    else if(GetLastPerceptionInaudible())
    {
        sSense  = "INAUDIBLE";

        /*
        if(bCombat)
        {

        }
        else if(bEnemy)
        {

        }
        */
    }
    else if(GetLastPerceptionSeen())
    {
        sSense  = "SEEN";

        if(bCombat)
        {

        }
        else if(bEnemy)
        {
            // animal behavior
            if(bSpecial)
                AIAggressiveResponse(OBJECT_INVALID);
            else
                AIAggressiveResponse(oPercep);
        }
        else if(CreatureGetIsBusy())
        {

        }
        else if( GetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION) &&  GetIsPC(oPercep) )
        {
            // The NPC will try to start a conversation
            DetermineConversation(OBJECT_SELF,oPercep);
        }
        // ANIMAL BEHAVIOR: perceive neutral or friend
        else if(bSpecial)
        {
            float fDist = GetDistanceToObject(oPercep);
            if(bFriend||bShareGroup)
            {
                // do nothing
            }
            // neutrals only past here
            else if(fDist<=GetLocalFloat(OBJECT_SELF, "AI_DISTANCE_THREATENED"))
            {
                if(     GetBehaviorState(NW_FLAG_BEHAVIOR_CARNIVORE)
                    ||  GetBehaviorState(NW_FLAG_BEHAVIOR_OMNIVORE)
                  )
                {
                    if(GetIsPrey(oPercep))
                        AIAggressiveResponse(oPercep);
                    else if(    GetIsPrey(OBJECT_SELF, oPercep)
                            &&  GetLocalInt(OBJECT_SELF, "AI_COWARD")
                           )
                    {
                        if(fDist>=20.0)
                            fDist+=5.0;
                        else
                            fDist   = 20.0;
                        ClearAllActions();
                        ActionMoveAwayFromObject(oPercep, TRUE, fDist);
                    }
                    else
                    {
                        int nVoice=VOICE_CHAT_GATTACK1;

                        switch(d3())
                        {
                            case 1:nVoice=VOICE_CHAT_GATTACK1;break;
                            case 2:nVoice=VOICE_CHAT_GATTACK2;break;
                            case 3:nVoice=VOICE_CHAT_GATTACK3;break;
                        }

                        SetFacingPoint(GetPosition(oPercep));
                        PlayVoiceChat(nVoice);
                    }
                }
                // herbivores
                else
                {
                    int nVoice=VOICE_CHAT_GATTACK1;
                    switch(d3())
                    {
                        case 1:nVoice=VOICE_CHAT_GATTACK1;break;
                        case 2:nVoice=VOICE_CHAT_GATTACK2;break;
                        case 3:nVoice=VOICE_CHAT_GATTACK3;break;
                    }
                    SetFacingPoint(GetPosition(oPercep));
                    PlayVoiceChat(nVoice);

                    int nSize               = GetCreatureSize(OBJECT_SELF)+GetLocalInt(OBJECT_SELF, "AI_SIZE_MODIFIER");
                    int nSizeDifference     = nSize - GetCreatureSize(oPercep);
                    if(     GetLocalInt(OBJECT_SELF, "AI_COWARD")
                       ||   nSizeDifference<0
                      )
                    {
                        if(fDist>=20.0)
                            fDist+=5.0;
                        else
                            fDist   = 20.0;
                        ClearAllActions();
                        ActionMoveAwayFromObject(oPercep, TRUE, fDist);
                    }
                }
            }
            else if(H_DoSkillCheck(oPercep, SKILL_ANIMAL_EMPATHY, GetLocalInt(OBJECT_SELF, "ANIMAL_EMPATHY_DC")) )
            {
                SetIsTemporaryFriend(oPercep);
            }
            else if(GetLocalInt(OBJECT_SELF, "AI_COWARD"))
            {
                int nSize               = GetCreatureSize(OBJECT_SELF)+GetLocalInt(OBJECT_SELF, "AI_SIZE_MODIFIER");
                int nSizeDifference     = nSize - GetCreatureSize(oPercep);
                if(nSizeDifference<0)
                {
                    if(fDist>=20.0)
                        fDist+=5.0;
                    else
                        fDist   = 20.0;
                    ClearAllActions();
                    ActionMoveAwayFromObject(oPercep, TRUE, fDist);
                }
            }
            // comment out if we get performance issues
            else
            {
                DoMeaglynWaypointCode(oPercep);
            }
        }
        // comment out if we get performance issues
        else
        {
            DoMeaglynWaypointCode(oPercep);
        }
    }
    else if(GetLastPerceptionVanished())
    {
        sSense  = "VANISHED";

        int bSentry     = GetLocalInt(OBJECT_SELF, "AI_SENTRY");
        int bPack       = GetLocalInt(OBJECT_SELF, "AI_PACK");
        if(bCombat)
        {

        }
        else if(bEnemy)
        {
            // Vanishing creature is still heard
            if(GetObjectHeard(oPercep))
            {
                //SpeakString("*listening*");
                FindVanishedCreature(oPercep, TRUE);
            }
        }
        else if(CreatureGetIsBusy())
        {

        }
        else
        {
            // Vanishing creature is still heard
            // and creature is a look out, or a friend disappeared and creature is pack oriented
            if(     GetObjectHeard(oPercep)
                &&(     (bSentry && !bFriend && !bShareGroup)
                    ||  (bPack && ( bFriend || bShareGroup ) )
                  )
              )
            {
                //SpeakString("*listening*");
                FindVanishedCreature(oPercep);
            }
            // comment out if we get performance issues
            else
            {
                DoMeaglynWaypointCode(oPercep);
            }

        }
    }
    /*
    // all types of perception when not in combat and not perceiving an enemy
    if(!bCombat && !bEnemy)
    {
        // activate ambient animations or walk waypoints if appropriate
       if (!IsInConversation(OBJECT_SELF))
       {
           if(GetIsPostOrWalking())
               WalkWayPoints();
           else if( GetIsPC(oPercep)
                    &&(     GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS)
                        ||  GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN)
                        ||  GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS)
                        ||  GetIsEncounterCreature()
                      )
                  )
                SetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE);
        }
    }
    */
    // For debuging


    // Send the user-defined event if appropriate
    if(GetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT))
    {
        SetLocalObject(OBJECT_SELF, "PERCEIVED", oPercep);
        SetLocalString(OBJECT_SELF, "PERCEIVED_TYPE", sSense);
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_PERCEIVE));
    }
}

/*
Patch 1.71

- better heard behavior
*/
/*
#include "nw_i0_generic"

void main()
{
    // * if not runnning normal or better Ai then exit for performance reasons
    if (GetAILevel() == AI_LEVEL_VERY_LOW) return;

    object oPercep = GetLastPerceived();
    int bSeen = GetLastPerceptionSeen();
    int bHeard = GetLastPerceptionHeard();
    if (bHeard == FALSE)
    {
        // Has someone vanished in front of me?
        bHeard = GetLastPerceptionVanished();
    }

    // This will cause the NPC to speak their one-liner
    // conversation on perception even if they are already
    // in combat.
    if(GetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION)
       && GetIsPC(oPercep)
       && bSeen)
    {
        SpeakOneLinerConversation();
    }

    // March 5 2003 Brent
    // Had to add this section back in, since  modifications were not taking this specific
    // example into account -- it made invisibility basically useless.
    //If the last perception event was hearing based or if someone vanished then go to search mode
    if ((GetLastPerceptionVanished()) && GetIsEnemy(GetLastPerceived()))
    {
        object oGone = GetLastPerceived();
        if((GetAttemptedAttackTarget() == GetLastPerceived() ||
           GetAttemptedSpellTarget() == GetLastPerceived() ||
           GetAttackTarget() == GetLastPerceived()) && GetArea(GetLastPerceived()) != GetArea(OBJECT_SELF))
        {
           ClearAllActions();
           DetermineCombatRound();
        }
    }

    // This section has been heavily revised while keeping the
    // pre-existing behavior:
    // - If we're in combat, keep fighting.
    // - If not and we've perceived an enemy, start to fight.
    //   Even if the perception event was a 'vanish', that's
    //   still what we do anyway, since that will keep us
    //   fighting any visible targets.
    // - If we're not in combat and haven't perceived an enemy,
    //   see if the perception target is a PC and if we should
    //   speak our attention-getting one-liner.
    if (GetIsInCombat(OBJECT_SELF))
    {
        // don't do anything else, we're busy
        //MyPrintString("GetIsFighting: TRUE");

    }
    // * BK FEB 2003 Only fight if you can see them. DO NOT RELY ON HEARING FOR ENEMY DETECTION
    else if (GetIsEnemy(oPercep) && bSeen)
    { // SpawnScriptDebugger();
        //MyPrintString("GetIsEnemy: TRUE");
        // We spotted an enemy and we're not already fighting
        if(!GetHasEffect(EFFECT_TYPE_SLEEP)) {
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
            {
                //MyPrintString("DetermineSpecialBehavior");
                DetermineSpecialBehavior();
            } else
            {
                //MyPrintString("DetermineCombatRound");
                SetFacingPoint(GetPosition(oPercep));
                SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
                DetermineCombatRound();
            }
        }
    }
    else
    {
        if (bSeen)
        {
            //MyPrintString("GetLastPerceptionSeen: TRUE");
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL)) {
                DetermineSpecialBehavior();
            } else if (GetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION)
                       && GetIsPC(oPercep))
            {
                // The NPC will speak their one-liner conversation
                // This should probably be:
                // SpeakOneLinerConversation(oPercep);
                // instead, but leaving it as is for now.
                ActionStartConversation(OBJECT_SELF);
            }
        }
        else
        // * July 14 2003: Some minor reactions based on invisible creatures being nearby
        if (bHeard && GetIsEnemy(oPercep))
        {
           // SpeakString("vanished");
            // * don't want creatures wandering too far after noises
            if (GetDistanceToObject(oPercep) <= 7.0)
            {
                ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.5);
                ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.5);
                ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 0.5);
                DetermineCombatRound();
            }
        }

        // activate ambient animations or walk waypoints if appropriate
       if (!IsInConversation(OBJECT_SELF)) {
           if (GetIsPostOrWalking()) {
               WalkWayPoints();
           } else if (GetIsPC(oPercep) &&
               (GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS)
                || GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN)
                || GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS)
                || GetIsEncounterCreature()))
           {
                SetAnimationCondition(NW_ANIM_FLAG_IS_ACTIVE);
           }
        }
    }

    // Send the user-defined event if appropriate
    if(GetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT) && GetLastPerceptionSeen())
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_PERCEIVE));
    }
}
*/
