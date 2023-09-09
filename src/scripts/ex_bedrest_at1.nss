//::////////////////////////////////////////////////////////////////////////////
//:: Excelsior Rest System, Bed Rest Conversation
//:: Name: ex_bedrest_at1
//:: Copyright (c) 2001 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Starts the Actions Taken for the Bed Rest Conversation.
    Sets the variables and allows the PC to rest.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Ardimus
//:: Created On: 30 Oct 2005
//::////////////////////////////////////////////////////////////////////////////
void main()
{
  int iGender = GetGender(GetPCSpeaker());
  if (iGender == GENDER_MALE)
    PlaySound( "as_pl_yawningm1");
  else
    PlaySound( "as_pl_yawningf1");

  object oPC = GetPCSpeaker();
  //object oArea = GetArea(oPC);
  SetLocalInt(oPC, "RESTING", 1);
  SetLocalInt(oPC, "nStartRestHP", GetCurrentHitPoints(oPC));
  //SetLocalInt(oArea, "NO_RESTING", FALSE);
  AssignCommand(oPC, ActionRest());
  //SendMessageToPC(oPC, "Debug: Bed rest starting.");
  //ExecuteScript("te_on_rest",oPC);
  //SetLocalInt(oArea, "NO_RESTING", TRUE);

}
