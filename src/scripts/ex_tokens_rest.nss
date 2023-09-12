//::////////////////////////////////////////////////////////////////////////////
//:: Excelsior Rest System, Bed Rest Conversation
//:: Name: ex_tokens_rest
//:: Copyright (c) 2001 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Sets a few custom tokens for the Bed Rest Conversation.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Ardimus
//:: Created On: 30 Oct 2005
//::////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iRace = GetRacialType(oPC);

    if (iRace == RACIAL_TYPE_ELF)
    {
      SetCustomToken(202, "Go into reverie");
    }
    else SetCustomToken(202, "Sleep");

  return TRUE;
}
