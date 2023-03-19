//::///////////////////////////////////////////////
//:: aid_exammove
//:://////////////////////////////////////////////
/*
    script for handling examination of a move node
*/
//:://////////////////////////////////////////////
//:: Created By: The Magus (2014 jan 8)
//:: Modified:
//:://////////////////////////////////////////////

#include "aid_inc_fcns"

#include "te_functions"


// The skill types.
const int MS_SKILL_CLIMB        = 1;
const int MS_SKILL_SWIM         = 2;
const int MS_SKILL_TIGHT_SPACE  = 3;

void main()
{
    object oPC      = GetLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT);
    DeleteLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT); // Garbage collection

    string sDesc    = GetLocalString(OBJECT_SELF, "examine_move");
    string sMove;
    string sDanger;
    string sChallenge;


    // move skill data
    int bRoped      = GetLocalInt(OBJECT_SELF, "ROPED");
    int iSkill      = GetLocalInt(OBJECT_SELF, "MOVE_SKILL");
    if(!iSkill)iSkill=MS_SKILL_CLIMB;
    int iDC         = GetLocalInt(OBJECT_SELF, "MOVE_DC");
    if(     iSkill==MS_SKILL_CLIMB
        &&( !iDC || ( iDC>5 && bRoped && CreatureGetHasHands(oPC)) )
      )
        iDC         = 5;
    // Climb Related
    int bTop        = GetLocalInt(OBJECT_SELF, "MOVE_TOP");
    int nFall       = GetLocalInt(OBJECT_SELF, "MOVE_HEIGHT");


    // skill name
    switch (iSkill)
    {
        case MS_SKILL_CLIMB: sMove="Climb";break;
        case MS_SKILL_SWIM: sMove="Swim";break;
        case MS_SKILL_TIGHT_SPACE: sMove="Escape Artist";break;
    }

    // dangerous consequences
    if(bTop)
    {
        sDanger = " with a fall of "+IntToString(nFall)+" feet";
    }

    // describe challenge
    sChallenge = "{"+sMove+" DC "+IntToString(iDC)+sDanger+".}";

    SendMessageToPC(oPC, COLOR_MESSAGE+"Upon examination:");
    DelayCommand(0.1, SendMessageToPC(oPC, "  "+DoColorize(sDesc+sChallenge,TRUE)) );
}
