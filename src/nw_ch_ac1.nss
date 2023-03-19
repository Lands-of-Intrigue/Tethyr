//::///////////////////////////////////////////////
//:: Associate: Heartbeat
//:: NW_CH_AC1.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Move towards master or wait for him

    The Magus' Innocuous Familiars
    see FamiliarHeartbeatEvent()

*/
//:://////////////////////////////////////////////
//:: Created: Preston Watamaniuk Nov 21, 2001
//:: Updated: Jul 25, 2003 - Georg Zoeller
//:://////////////////////////////////////////////
//:: Modified: The Magus (2013 jan 16) Innocuous Familiar Heartbeat in FamiliarHeartbeatEvent()

//#include "X0_INC_HENAI"
#include "X2_INC_SUMMSCALE"
#include "X2_INC_SPELLHOOK"

#include "te_functions"

void main()
{   //SpawnScriptDebugger();
    object oMaster  = GetMaster();

    int nAction     = GetCurrentAction(OBJECT_SELF);

    // GZ: Fallback for timing issue sometimes preventing epic summoned creatures from leveling up to their master's level.
    // There is a timing issue with the GetMaster() function not returning the fof a creature
    // immediately after spawn. Some code which might appear to make no sense has been added
    // to the nw_ch_ac1 and x2_inc_summon files to work around this
    // This code is only run at the first hearbeat
    int nLevel =SSMGetSummonFailedLevelUp(OBJECT_SELF);
    if (nLevel != 0)
    {
        int nRet;
        if (nLevel == -1) // special shadowlord treatment
          SSMScaleEpicShadowLord(OBJECT_SELF);
        else if  (nLevel == -2)
          SSMScaleEpicFiendishServant(OBJECT_SELF);
        else
        {
            nRet = SSMLevelUpCreature(OBJECT_SELF, nLevel, CLASS_TYPE_INVALID);
            if (nRet == FALSE)
                WriteTimestampedLogEntry("WARNING - nw_ch_ac1:: could not level up " + GetTag(OBJECT_SELF) + "!");
        }

        // regardless if the actual levelup worked, we give up here, because we do not
        // want to run through this script more than once.
        SSMSetSummonLevelUpOK(OBJECT_SELF);
    }

    // Check if concentration is required to maintain this creature
    X2DoBreakConcentrationCheck();

    if(!GetAssociateState(NW_ASC_IS_BUSY))
    {
        //Seek out and disable undisabled traps
        object oTrap = GetNearestTrapToObject();
        if (bkAttemptToDisarmTrap(oTrap))
            return ; // succesful trap found and disarmed

        if(GetIsObjectValid(oMaster))
        {
            float fDistToMaster = GetDistanceToObject(oMaster);
            float fDistFollow   = GetFollowDistance();

           if(     nAction != ACTION_FOLLOW
                &&  nAction != ACTION_DISABLETRAP
                &&  nAction != ACTION_OPENLOCK
                &&  nAction != ACTION_REST
                &&  nAction != ACTION_ATTACKOBJECT
              )
            {
                if(    !GetIsObjectValid(GetAttackTarget())
                    && !GetIsObjectValid(GetAttemptedSpellTarget())
                    && !GetIsObjectValid(GetAttemptedAttackTarget())
                    && !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN))
                  )
                {
                    if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                    {
                        if(fDistToMaster > fDistFollow)
                        {
                            ClearAllActions();
                            ActionForceFollowObject(oMaster, fDistFollow);

                        } // END farther than follow dist
                    }// END not standing ground
                    else
                    {
                        ClearAllActions();
                    }// END standing ground
                }// END not fighting and no enemies in range.
            }// not following etc...
        } // END Has Master

        // * if I am dominated, ask for some help
        if (GetHasEffect(EFFECT_TYPE_DOMINATED, OBJECT_SELF) && !GetIsEncounterCreature(OBJECT_SELF))
        {
            SendForHelp();
        }

        if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
        {
            SignalEvent(OBJECT_SELF, EventUserDefined(1001));
        }
    }
}
