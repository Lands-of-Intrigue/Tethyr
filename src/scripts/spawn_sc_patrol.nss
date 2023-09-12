//
//   NESS
//   Patrol Scripts v8.1.3
//
//
#include "spawn_functions"
#include "te_functions"

//
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);


void NESSServer(int nThisStop)
{
    if(     GetIsDMPossessed(OBJECT_SELF)
        ||  CreatureGetIsBusy(OBJECT_SELF,ACTION_MOVETOPOINT)
      )
    {
        DelayCommand(6.0,NESSServer(nThisStop) );
        return;
    }

    int nNext   = GetLocalInt(OBJECT_SELF, "PR_NEXTSTOP");
    int nLast   = GetLocalInt(OBJECT_SELF, "PR_LASTSTOP");
    if(     (nNext==nThisStop&&nLast!=nThisStop)
        ||  (nNext==-1&&nLast==nThisStop)
      )
    {
        string sSay = GetLocalString(OBJECT_SELF,"DIALOG_MERCH");
        if(sSay=="")
        {
            sSay    = GetLocalString(OBJECT_SELF,"DIALOG_GREETING");
            if(sSay=="")
                sSay= "Hello.";
        }
        //int nLang   = GetCurrentLanguageSpoken(OBJECT_SELF);
        //if(!nLang)
        int nLang=3;

        int nNow    = GetTimeCumulative();

        string sBuddyID;
        int bSuccess;
        int nNth = 1;
        int nDelay,bPC;
        object oBuddy  = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, nNth);
        while(oBuddy!=OBJECT_INVALID)
        {
            bPC = GetIsPC(oBuddy);
            if(bPC){nDelay  = 15;}
            else{nDelay  = 3;}

            sBuddyID    = ObjectToString(oBuddy);
            if(     GetObjectSeen(oBuddy)
                &&  !GetIsEnemy(oBuddy)
                &&( (GetLocalInt(OBJECT_SELF,sBuddyID)+(nDelay*IGMINUTES_PER_RLMINUTE)) < nNow )
              )
            {
                if(bPC)
                {
                    SetLocalInt(OBJECT_SELF,sBuddyID,nNow);
                    ActionMoveToObject(oBuddy);
                    ActionSpeakString(sSay,TALKVOLUME_TALK);
                    ActionWait(7.0);
                    bSuccess=TRUE;
                    break;
                }
                else if(    GetPhenoType(oBuddy)==40
                        &&  !GetLocalInt(oBuddy,"PERFORMING")
                       )
                {
                    SetLocalInt(OBJECT_SELF,sBuddyID,nNow);
                    ActionMoveToObject(oBuddy);
                    ActionWait(3.0);
                    bSuccess=TRUE;
                    break;
                }
            }
            oBuddy  = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, OBJECT_SELF, ++nNth);
        }
        // no more to serve right now so look for something else to do

        if(!bSuccess)
        {
            object oHome    = GetLocalObject(OBJECT_SELF,"SERVER_HOME");
            object oArea    = GetArea(OBJECT_SELF);
            if(GetArea(oHome)==oArea)
            {
                nNth    = 1;
                object oDoor    = GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF,nNth);
                while(oDoor!=OBJECT_INVALID)
                {
                    if(     GetTransitionTarget(oDoor)!=OBJECT_INVALID
                        &&  GetIsOpen(oDoor)
                      )
                    {
                       // Get the position for the door
                        vector vDoor = GetPosition(oDoor);
                        vector vServerFromDoor = GetPosition(OBJECT_SELF)-vDoor;
                        vector vPastDoor1M = vDoor + VectorNormalize(vServerFromDoor);
                        location lLoc = Location(
                                                oArea,
                                                vPastDoor1M,
                                                VectorToAngle(vServerFromDoor)
                                                );
                        ActionMoveToLocation(lLoc);
                        ActionDoCommand(AssignCommand(oDoor,ActionCloseDoor(oDoor)));

                        bSuccess=TRUE;
                        break;
                    }
                    oDoor    = GetNearestObject(OBJECT_TYPE_DOOR,OBJECT_SELF,++nNth);
                }
                // if all else fails return to server's home waypoint
                if(!bSuccess)
                {
                    ActionMoveToObject(oHome);
                    ActionDoCommand(SetFacing(GetFacing(oHome)));
                }
            }
        }
        DelayCommand(6.0,NESSServer(nThisStop) );
    }
}


void NESSFarmer(int nThisStop, string sTag="", object oField=OBJECT_INVALID)
{
    if(     GetIsDMPossessed(OBJECT_SELF)
        ||  CreatureGetIsBusy(OBJECT_SELF,ACTION_MOVETOPOINT)
      )
    {
        DelayCommand(6.0,NESSFarmer(nThisStop, sTag, oField) );
        return;
    }

    int nNext   = GetLocalInt(OBJECT_SELF, "PR_NEXTSTOP");
    int nLast   = GetLocalInt(OBJECT_SELF, "PR_LASTSTOP");
    if(     (nNext==nThisStop&&nLast!=nThisStop)
        ||  (nNext==-1&&nLast==nThisStop)
      )
    {

        int nNow    = GetTimeCumulative(TIME_SECONDS);

        string sFarmID;
        int bSuccess;
        int nNth = 1;
        int nDelay  = 900;
        object oFarm  = GetNearestObjectByTag(sTag,OBJECT_SELF,nNth);
        while(oFarm!=OBJECT_INVALID)
        {
            sFarmID    = ObjectToString(oFarm);
            if(GetLocalInt(oFarm,"FARM_ATTENDED")+(nDelay) < nNow )
            {
                SetLocalInt(oFarm,"FARM_ATTENDED",nNow);
                ActionMoveToObject(oFarm);

                int nAction = GetLocalInt(oFarm,"FARM_ACTION");
                switch(nAction)
                {
                    case 1:
                        ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,6.0);
                    break;
                    case 2:
                        ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,6.0);
                    break;
                    case 3:
                        ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED,1.0,6.0);
                    break;
                    case 4:
                        ActionInteractObject(oFarm);
                    break;
                    case 5:
                        ActionAttack(oFarm,TRUE);
                    break;
                    default:
                        ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,6.0);
                    break;
                }

                bSuccess=TRUE;
                break;
            }

            oFarm  = GetNearestObjectByTag(sTag,OBJECT_SELF,++nNth);
        }
        // no more to farm right now so look for something else to do
        if(!bSuccess)
        {
            location lLoc;
            if(     !GetIsInSubArea(OBJECT_SELF,oField)
                &&  GetIsObjectValid(oField)
              )
                lLoc    = GetLocation(oField);
            else
                lLoc    = GetRandomLocation(GetArea(OBJECT_SELF),OBJECT_SELF,2.0);

            switch(d6())
            {
                case 1:
                case 2:
                case 3:
                    ActionMoveToLocation(lLoc);
                break;
                case 4:
                case 5:
                    ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0,6.0);
                break;
                case 6:
                    ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED,1.0,6.0);
                break;
                default:
                    ActionMoveToLocation(lLoc);
                break;
            }

        }
        DelayCommand(6.0,NESSFarmer(nThisStop, sTag, oField) );
    }
}

void main()
{

    if(GetIsDMPossessed(OBJECT_SELF))
        return;

    // Retrieve Script Number
    int nPatrolScript = GetLocalInt(OBJECT_SELF, "PatrolScript");

    // Retrieve Stop Information
    int nStopNumber = GetLocalInt(OBJECT_SELF, "PR_NEXTSTOP");
    object oStop = GetLocalObject(OBJECT_SELF, "PR_SN" + PadIntToString(nStopNumber, 2));

    // Invalid Script
    if (nPatrolScript == -1)
    {
        return;
    }

//
// Only Make Modifications Between These Lines
// -------------------------------------------


    // Script 00
    if (nPatrolScript == 0)
    {
        ActionDoCommand(SpeakString("Example!"));
    }
    // Turn Off Lights
    else if (nPatrolScript == 7)
    {
        object oLight = GetNearestObjectByTag("Light", oStop);
        if ((GetIsDay() == TRUE && GetPlaceableIllumination(oLight) == TRUE)
         || (GetIsNight() == TRUE && GetPlaceableIllumination(oLight) == FALSE))
        {
            ActionDoCommand(DoPlaceableObjectAction(oLight, PLACEABLE_ACTION_USE));
        }
    }
    // Socialize (seek out PCs (any) and NPCs (with social phenotype) which have not yet been approached)
    else if(nPatrolScript == 10)
    {
        object oHome    = GetNearestObjectByTag("server_home");
        if(GetIsObjectValid(oHome))
            SetLocalObject(OBJECT_SELF,"SERVER_HOME",oHome);
        NESSServer(nStopNumber);
    }
    // Farm
    else if(nPatrolScript == 11)
    {
        object oField    = GetNearestObjectByTag("farm",oStop);

        NESSFarmer(nStopNumber, GetLocalString(oStop,"FARM_ID"),oField);
    }


    // script 20 Vocalization at time of arrival
    else if(nPatrolScript == 20)
    {
        int nVoice;
        int nRandom = d4();
        switch(nRandom)
        {
            case 1: nVoice  = VOICE_CHAT_GATTACK1; break;
            case 2: nVoice  = VOICE_CHAT_GATTACK2; break;
            case 3: nVoice  = VOICE_CHAT_GATTACK3; break;
            case 4: nVoice  = VOICE_CHAT_GATTACK1; break;
        }
        ActionDoCommand(PlayVoiceChat(nVoice));
    }

    // script 21 Play Animation x for y Duration at z Speed
    else if(nPatrolScript == 21)
    {
        int nAnimation  = GetLocalInt(oStop, "NESS_ANIMATION");
        float fSpeed    = GetLocalFloat(oStop, "NESS_ANIMATION_SPEED");
        float fDuration = GetLocalFloat(oStop, "NESS_ANIMATION_DURATION");

        if(fSpeed==0.0)
            fSpeed = 1.0;

        ActionPlayAnimation(nAnimation, fSpeed, fDuration);
    }

// -------------------------------------------
// Only Make Modifications Between These Lines
//

}
