int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"te_insignia");

    if(oItem != OBJECT_INVALID)
      return TRUE;
    else
        return FALSE;
}
