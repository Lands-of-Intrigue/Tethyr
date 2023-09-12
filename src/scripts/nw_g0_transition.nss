// -----------------------------------------------------------------------------
//  nw_g0_transition
// -----------------------------------------------------------------------------
/*
    A replacement for the default OnAreaTransitionClick door and OnClick area
    transition trigger event script to resolve issues with multiple henchmen and
    nested associates being left behind during intra-area transitions.

    This script is called when:

    - no OnClick event script has been specified for an Area Transition Trigger
    - no OnAreaTransitionClick event script has been specified for a Door which
      has a Destination Type other than None
*/
// -----------------------------------------------------------------------------
/*
    Version 1.02 - 21 Jun 2012 - Sunjammer
    - fixed issue caused by GetAssociate and ASSOCIATE_TYPE_DOMINATED

    Version 1.01 - 25 Sep 2006 - Sunjammer
    - fixed issue caused by using JumpToLocation with door transitions

    Version 1.00 - 28 Aug 2006 - Sunjammer
    - rewritten

    Credits
    - Sydney Tang (BioWare)
*/
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
//  CONSTANTS
// -----------------------------------------------------------------------------

// number of associate types (including ASSOCIATE_TYPE_NONE)
const int NUM_ASSOCIATE_TYPES = 6;


// -----------------------------------------------------------------------------
//  PROTOTYPES
// -----------------------------------------------------------------------------

// Jumps all of the caller's associates to the location of an object. The action
// is added to the top of the action queue.
//  - oDestination:     object to jump to
void JumpAssociatesToObject(object oDestination);


// -----------------------------------------------------------------------------
//  FUNCTIONS
// -----------------------------------------------------------------------------

void JumpAssociatesToObject(object oDestination)
{
    int nType;

    // loop through every type of associate
    for(nType = 1; nType < NUM_ASSOCIATE_TYPES; nType++)
    {
        int nCount;

        // use pre-increment as associates are 1-based
        object oAssociate = GetAssociate(nType, OBJECT_SELF, ++nCount);
        while(GetIsObjectValid(oAssociate))
        {
            // jump the associate AND the associate's associates
            AssignCommand(oAssociate, JumpAssociatesToObject(oDestination));
            AssignCommand(oAssociate, JumpToObject(oDestination));

            // NOTE: GetAssociate appears to ignore the nTh parameter when
            // nAssociateType is ASSOCIATE_TYPE_DOMINATED and so will never
            // return OBJECT_INVALID which will result in a TMI
            if(nType == ASSOCIATE_TYPE_DOMINATED)
                break;

            // next associate of THIS type
            oAssociate = GetAssociate(nType, OBJECT_SELF, ++nCount);
        }
    }
}


// -----------------------------------------------------------------------------
//  MAIN
// -----------------------------------------------------------------------------


////////////////////////////////////////////////////////////
// OnClick/OnAreaTransitionClick
// NW_G0_Transition.nss
// Copyright (c) 2001 Bioware Corp.
////////////////////////////////////////////////////////////
// Created By: Sydney Tang
// Created On: 2001-10-26
// Description: This is the default script that is called
//              if no OnClick script is specified for an
//              Area Transition Trigger or
//              if no OnAreaTransitionClick script is
//              specified for a Door that has a LinkedTo
//              Destination Type other than None.
////////////////////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified On: Apr 12th, 2008
//:: Added Support for Keeping mounts out of no mount areas
//::////////////////////////////////////////////////////////


#include "x3_inc_horse"
#include "x0_inc_henai"
#include "nwnx_time"


void main()
{
    object oClicker=GetClickingObject();
    object oTarget=GetTransitionTarget(OBJECT_SELF);

/*
    if(GetIsInCombat(oClicker) == TRUE)
    {
        SendMessageToPC(oClicker,"You may not transition to another area while in combat.");
        return;
    }
*/

    if(GetLocalInt(OBJECT_SELF,"NoUndead") == 1 && GetIsUndead(oClicker))
    {
        SendMessageToPC(oClicker,"Some force seems to repel you...");
        return;
    }

    if(GetObjectType(oTarget) == OBJECT_TYPE_DOOR && GetCampaignInt("Housing",GetLocalString(OBJECT_SELF,"sUnique")+"Brok") < 1)
    {
        DelayCommand(24.0f,ActionCloseDoor(OBJECT_SELF));

        if(GetLockLockDC(OBJECT_SELF) > 0)
        {
            SetLocked(OBJECT_SELF, TRUE);
        }
    }

    location lPreJump=HORSE_SupportGetMountLocation(oClicker,oClicker,0.0); // location before jump
    int bAnim=GetLocalInt(OBJECT_SELF,"bDismountFast"); // community requested fast dismount for transitions if variable is not set (use X3_G0_Transition for animated)
    int nN=1;
    object oOb;
    object oAreaHere=GetArea(oClicker);
    object oAreaTarget=GetArea(oTarget);
    object oHitch;
    int bDelayedJump=FALSE;
    int bNoMounts=FALSE;
    float fX3_MOUNT_MULTIPLE=GetLocalFloat(GetArea(oClicker),"fX3_MOUNT_MULTIPLE");
    float fX3_DISMOUNT_MULTIPLE=GetLocalFloat(GetArea(oClicker),"fX3_DISMOUNT_MULTIPLE");
    if (GetLocalFloat(oClicker,"fX3_MOUNT_MULTIPLE")>fX3_MOUNT_MULTIPLE) fX3_MOUNT_MULTIPLE=GetLocalFloat(oClicker,"fX3_MOUNT_MULTIPLE");
    if (fX3_MOUNT_MULTIPLE<=0.0) fX3_MOUNT_MULTIPLE=1.0;
    if (GetLocalFloat(oClicker,"fX3_DISMOUNT_MULTIPLE")>0.0) fX3_DISMOUNT_MULTIPLE=GetLocalFloat(oClicker,"fX3_DISMOUNT_MULTIPLE");
    if (fX3_DISMOUNT_MULTIPLE>0.0) fX3_MOUNT_MULTIPLE=fX3_DISMOUNT_MULTIPLE; // use dismount multiple instead of mount multiple
    float fDelay=0.1*fX3_MOUNT_MULTIPLE;
    //SendMessageToPC(oClicker,"nw_g0_transition");
    if (!GetLocalInt(oAreaTarget,"X3_MOUNT_OK_EXCEPTION"))
    { // check for global restrictions
        if (GetLocalInt(GetModule(),"X3_MOUNTS_EXTERNAL_ONLY")&&GetIsAreaInterior(oAreaTarget)) bNoMounts=TRUE;
        else if (GetLocalInt(GetModule(),"X3_MOUNTS_NO_UNDERGROUND")&&!GetIsAreaAboveGround(oAreaTarget)) bNoMounts=TRUE;
    } // check for global restrictions
    if (GetLocalInt(oAreaTarget,"X3_NO_MOUNTING")||GetLocalInt(oAreaTarget,"X3_NO_HORSES")||bNoMounts)
    { // make sure all transitioning are not mounted
       //SendMessageToPC(oClicker,"nw_g0_transition:No Mounting");
        if (HorseGetIsMounted(oClicker))
        { // dismount clicker
            bDelayedJump=TRUE;
            AssignCommand(oClicker,HORSE_SupportDismountWrapper(bAnim,TRUE));
            fDelay=fDelay+0.2*fX3_MOUNT_MULTIPLE;
        } // dismount clicker
        oOb=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oClicker,nN);
        while(GetIsObjectValid(oOb))
        { // check each associate to see if mounted
            if (HorseGetIsMounted(oOb))
            { // dismount associate
                bDelayedJump=TRUE;
                DelayCommand(fDelay,AssignCommand(oOb,HORSE_SupportDismountWrapper(bAnim,TRUE)));
                fDelay=fDelay+0.2*fX3_MOUNT_MULTIPLE;
            } // dismount associate
            nN++;
            oOb=GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oClicker,nN);
        } // check each associate to see if mounted
        if (fDelay>0.1) SendMessageToPCByStrRef(oClicker,111989);
        if (bDelayedJump)
        { // some of the party has/have been mounted, so delay the time to hitch
            fDelay=fDelay+2.0*fX3_MOUNT_MULTIPLE; // non-animated dismount lasts 1.0+1.0=2.0 by default, so wait at least that!
            if (bAnim) fDelay=fDelay+2.8*fX3_MOUNT_MULTIPLE; // animated dismount lasts (X3_ACTION_DELAY+HORSE_DISMOUNT_DURATION+1.0)*fX3_MOUNT_MULTIPLE=4.8 by default, so wait at least that!
        } // some of the party has/have been mounted, so delay the time to hitch
    } // make sure all transitioning are not mounted
    if (GetLocalInt(oAreaTarget,"X3_NO_HORSES")||bNoMounts)
    { // make sure no horses/mounts follow the clicker to this area
        //SendMessageToPC(oClicker,"nw_g0_transition:No Horses");
        bDelayedJump=TRUE;
        oHitch=GetNearestObjectByTag("X3_HITCHING_POST",oClicker);
        DelayCommand(fDelay,HorseHitchHorses(oHitch,oClicker,lPreJump));
        if (bAnim) fDelay=fDelay+1.8*fX3_MOUNT_MULTIPLE;
        //fDelay=fDelay+0.5*fX3_MOUNT_MULTIPLE; // delays jump to transition, makes you stay longer before jump
    } // make sure no horses/mounts follow the clicker to this area

    //SendMessageToPC(oClicker,"nw_g0_transition:Jump  fDelay="+FloatToString(fDelay));
    int RandomDisplay = Random(5)+1;
    if(RandomDisplay == 5)      {AssignCommand(oClicker,SetAreaTransitionBMP(381));}
    else if(RandomDisplay == 4) {AssignCommand(oClicker,SetAreaTransitionBMP(382));}
    else if(RandomDisplay == 3) {AssignCommand(oClicker,SetAreaTransitionBMP(383));}
    else if(RandomDisplay == 2) {AssignCommand(oClicker,SetAreaTransitionBMP(384));}
    else if(RandomDisplay == 1) {AssignCommand(oClicker,SetAreaTransitionBMP(385));}
    //if (GetArea(oTarget)!=GetArea(oClicker)) DelayCommand(fDelay,AssignCommand(oClicker,ForceJump(oClicker,oTarget,5.0)));
    //else { DelayCommand(fDelay,AssignCommand(oClicker,ForceJump(oClicker,oTarget,5.0))); }
    if (bDelayedJump)
    { // delayed jump
        DelayCommand(fDelay,AssignCommand(oClicker,ClearAllActions()));
        //DelayCommand(fDelay+0.05*fX3_MOUNT_MULTIPLE,AssignCommand(oClicker,ActionWait(X3_ACTION_DELAY/2*fX3_MOUNT_MULTIPLE)));
        DelayCommand(fDelay+0.1*fX3_MOUNT_MULTIPLE,AssignCommand(oClicker,JumpToObject(oTarget)));
        DelayCommand(fDelay+0.1*fX3_MOUNT_MULTIPLE,AssignCommand(oClicker,JumpAssociatesToObject(oTarget)));
    } // delayed jump
    else
    { // quick jump
        AssignCommand(oClicker, JumpAssociatesToObject(oTarget));
        AssignCommand(oClicker, JumpToObject(oTarget));
    } // quick jump
    DelayCommand(fDelay+4.0*fX3_MOUNT_MULTIPLE,HorseMoveAssociates(oClicker));
}
