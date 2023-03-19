//::////////////////////////////////////////////////////////////////////////////
//:: Excelsior Resting System, Bed Rest On Used
//:: Name: ex_bedrest_ou
//:: Copyright (c) 2001 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Fires the resting conversation for Bed Resting.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Ardimus
//:: Created On: 30 Oct 2005
//::////////////////////////////////////////////////////////////////////////////
#include "ex_i0_mod_funcs"

void main()
{
  object oUser = GetLastUsedBy();
  if (!GetIsPC(oUser))
  {
    return;
  }
  string sBed = GetTag(OBJECT_SELF);
  int nRestQuality = GetParseFlagValue(sBed, "BR", 1);
  SetLocalInt(oUser, "RESTING_QUALITY_BED", nRestQuality);
  SetLocalInt(oUser, "RESTING_BED", TRUE);
  ActionStartConversation(oUser, "", TRUE);
}
