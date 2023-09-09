//::////////////////////////////////////////////////////////////////////////////
//:: Excelsior Rest System, Bed Rest Conversation
//:: Name: ex_bedrest_at2
//:: Copyright (c) 2001 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Starts the Actions Taken for the Bed Rest Conversation.
    Resets the variables if PC does not or cannot rest.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Ardimus
//:: Created On: 30 Oct 2005
//::////////////////////////////////////////////////////////////////////////////
void main()
{
  object oPC = GetPCSpeaker();
  //object oArea = GetArea(oPC);
  //SetLocalInt(oArea, "NO_RESTING", TRUE);
  SetLocalInt(oPC, "RESTING_BED", FALSE);
}