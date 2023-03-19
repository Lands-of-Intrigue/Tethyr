//::///////////////////////////////////////////////
//::WW: Window Look Out
//::                   onused Window
//:://////////////////////////////////////////////
/*
  using Gestalt's Cutscene Functions

  Create a placeable Window (or crystal ball for scrying, etc)
  Give it a unique tag.
  Create a Waypoint named DST_[windowtag] at the point where you
  want the view to look out on.

  Set a local INT on the Window, if it is above the ground floor.
  HEIGHT:
    0 (not set) = ground floor window, eye level view
    1 = upper storey of building
    2+ = birdseye view.  set to 2 for 20 meter zoom out 3 for 30 etc.
    (dont zoom out too far, though)
*/
//:://////////////////////////////////////////////
//:: Created By: bloodsong
//:://////////////////////////////////////////////
#include "in_g_cutscene2"


void main()
{
    object oPC = GetLastUsedBy();
    if(!GetIsPC(oPC) && !GetIsDM(oPC))  {  return;  }

    object oWindow = OBJECT_SELF;
    string sWTag = GetTag(oWindow);
    string sWPTag = "DST_"+sWTag;
    int nHeight = GetLocalInt(oWindow, "HEIGHT");
    object oWP =GetWaypointByTag(sWPTag);
    float fFace = GetFacing(oWP);
    location lStart = GetLocation(oPC);  //--send them back here.
    location lView = GetLocation(oWP);
    float fSceneTime = 14.0; //--set to how long we make this
    //-- 2 sec to jump, 6 sec x2 looks


    //--first, inviso and jump the pc.
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToLocation(lView));

    //--start the cutscene, store the pc's original camera
    GestaltStartCutscene(oPC,"window",FALSE,FALSE,FALSE,FALSE, 1);

    //--make pc invisible
    GestaltInvisibility(0.5, oPC, fSceneTime);
    //--turn all associates invisible as well (option 1)
    GestaltClearAssociates(0.3, oPC, 63, 1);

    // Camera movements -- setup
    float fDist, fAngle;
    if(nHeight == 0)                    //--eye level
    {  fDist = 1.0;  fAngle = 90.0;  }
    else if (nHeight == 1)              //--2nd storey
    {  fDist = 10.0;  fAngle = 50.0;  }
    else                                //--birds eye
    {  fDist = IntToFloat(nHeight*10);  fAngle = 30.0;  }

    //-- Camera movements -- moving
    //--this places the camera on the PC
      GestaltCameraFacing(2.0, fFace, fDist, fAngle, oPC);
                  //--delay for jumping to waypoint (load new area)
                  //--add this to fSceneTime if you adjust it
    //--look back and forth
      GestaltCameraMove  ( 2.1,    //--delay, just after the jump and reset
                           fFace + 60.0, fDist, fAngle,   //--looks 60 degrees left
                           fFace - 60.0, fDist,  fAngle,  //--then turns 60 degrees right
                           6.0, 30.0, oPC, 2); //--in 6 seconds @ 30fps, on the PC, and 2=auto direction
      //--look back and forth again.
      GestaltCameraMove  ( 8.0,  //add jump time (2) plus first move time (6)
                           fFace - 60.0, fDist,  fAngle,  //--continues pan left
                           fFace + 60.0, fDist,  fAngle,  //--then right again
                           6.0, 30.0, oPC, 2);  //--in 6 seconds @ 30fps, on the PC, and 2=auto direction


    //--required; set delay to end of cut scene time.
      //-- add some time for PC to get back into starting place
    GestaltStopCutscene(fSceneTime+1.2,oPC);
    //--and put the associates back (this goes before the cutscene end)
    GestaltReturnAssociates(fSceneTime+1.0, oPC, 63, 1);

    //--and, haha, dont forget to put the pc back where they started!
    DelayCommand(fSceneTime, AssignCommand(oPC, ActionJumpToLocation(lStart)));

}
