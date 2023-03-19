// Make the NPC do one of the simple activities near the current waypoint.
//
// This happens until the waypoint set changes (if it does) or for an optional amount of time.
//
// aww_do_activity.nss
//
//
#include "x0_i0_position"
#include "nw_i0_generic"
#include "aww_inc_walkway"

const int CHAIR_LIMIT          =   5;

void ActionMoveNear(object oDestination, int bRun = FALSE) {
    ActionMoveToLocation(GetRandomLocation(GetArea(oDestination),oDestination,5.0), bRun);
}


// AWW_ACTIVITY_AVOIDPC
void activityShy() {
    AssignCommand(OBJECT_SELF,ActionMoveAwayFromObject(GetFirstPC(),TRUE,10.0));
}

// AWW_ACTIVITY_SLEEP
// TODO This needs to be tnp_sleep and then need to wake up in main script or when timout expires.
void activitySleep() {
    //tbPutToSleep(OBJECT_SELF); // if have other tb libraries

     if (!GetLocalInt(OBJECT_SELF, "SLEEPING")) {
        if (GetRacialType(OBJECT_SELF) == RACIAL_TYPE_ELF || GetRacialType(OBJECT_SELF) == RACIAL_TYPE_HALFELF) {
            AssignCommand(OBJECT_SELF, PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 3600.0)); // that should be long enough
        } else
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSleep(),OBJECT_SELF,3600.0);
        SetLocalInt(OBJECT_SELF,"SLEEPING",TRUE);
    }

        // If not using TNP HB and userdefined enable this to get some zzzs
    if (d4()==1)
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), OBJECT_SELF);
}

// AWW_ACTIVITY_SIT
void activitySit() {
        int iChairs = 1;
        object oMyChair;

        if (GetCurrentAction(OBJECT_SELF) != ACTION_SIT) {
        // Check for a current chair
                oMyChair = GetLocalObject(OBJECT_SELF, "aww_current_chair");

                SendMessageToPC(GetFirstPC(), "Distance to my chair is " + FloatToString(GetDistanceBetween(OBJECT_SELF, oMyChair)));
                if (GetDistanceBetween(OBJECT_SELF, oMyChair) > 15.0)
                    oMyChair = OBJECT_INVALID;

        // This will look for a different one if current is invalid or now occupied
                while (((!GetIsObjectValid(oMyChair))
                  ||(GetIsObjectValid(GetSittingCreature(oMyChair)))
                        &&(iChairs <= CHAIR_LIMIT))) {
                        oMyChair = GetNearestObjectByTag("Chair",OBJECT_SELF,iChairs++);
                }

                if (GetIsObjectValid(oMyChair) && !GetIsObjectValid(GetSittingCreature(oMyChair))) {
                        AssignCommand(OBJECT_SELF,ActionSit(oMyChair));
                SetLocalObject(OBJECT_SELF, "aww_current_chair", oMyChair);
                } else {
                DeleteLocalObject(OBJECT_SELF, "aww_current_chair");
                }
        }
}

// AWW_ACTIVITY_MOBILE
void activityMobile() {
    int nTimes = GetLocalInt(OBJECT_SELF, "aww_activity_counter");
    if (nTimes == 0)
        PlayMobileAmbientAnimations();
    nTimes ++;
    SetLocalInt(OBJECT_SELF, "aww_activity_counter" , nTimes %5);

}
// AWW_ACTIVITY_IMMMOBILE
void activityImmobile() {
    int nTimes = GetLocalInt(OBJECT_SELF, "aww_activity_counter");
    if (nTimes == 0)
        PlayImmobileAmbientAnimations();
    nTimes ++;
    SetLocalInt(OBJECT_SELF, "aww_activity_counter" , nTimes %5);
}


//AWW_ACTIVITY_RANDOM
void activityRandom() {
    // randomly pick something to do.
    switch (Random(4)) {
    case 0:
    case 1:
        activityMobile();
        return;
    case 2:
        activitySit();
        return;
    case 3: // keep doing whatever was last
        return;
    }
}


// AWW_ACTIVITY_THIEF
// This is for single player only at the moment.
void activityThief() {
    ClearAllActions();
    if (d4()==1) AssignCommand(OBJECT_SELF,ActionForceFollowObject(GetFirstPC(),0.5));
    if (d3()==1) AssignCommand(OBJECT_SELF,ActionMoveToObject(GetFirstPC()));
    else if (d2()-1) AssignCommand(OBJECT_SELF,ActionMoveNear(GetFirstPC(), FALSE));
    else AssignCommand(OBJECT_SELF,ActionMoveAwayFromObject(GetFirstPC(),TRUE,10.0));
}

void main () {

    int nAct = GetLocalInt(OBJECT_SELF, "AWW_DO_ACTIVITY");

    if (GetIsInCombat(OBJECT_SELF) || IsInConversation(OBJECT_SELF))
        return;

    aww_debug(GetTag(OBJECT_SELF) + " Doing activity " + IntToString(nAct));
    switch (nAct) {
    case AWW_ACTIVITY_NONE:
        return;
    case AWW_ACTIVITY_AVOIDPC:
        activityShy(); break;
    case AWW_ACTIVITY_SLEEP:
        activitySleep(); break;
    case AWW_ACTIVITY_SIT:
        activitySit() ; break;
    case AWW_ACTIVITY_MOBILE:
        activityMobile() ; break;
    case AWW_ACTIVITY_IMMOBILE:
        activityImmobile() ; break;
    case AWW_ACTIVITY_RANDOM:
        activityRandom() ; break;

    default :
        return;
    }
}

