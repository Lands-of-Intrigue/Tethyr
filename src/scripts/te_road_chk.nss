int StartingConditional()
{
    object oPC   = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"te_insignia");
    int nLastCleared = GetLocalInt(OBJECT_SELF,"nLastCleared");

    if(GetLocalInt(OBJECT_SELF,"nLastCleared") == 0)
    {
        return TRUE;
    }


    return FALSE;
}
