int StartingConditional()
{
    object oPC   = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"te_insignia");
    int nLastCleared = GetLocalInt(OBJECT_SELF,"nLastCleared");

    if(GetIsObjectValid(oItem) == TRUE && GetLocalInt(OBJECT_SELF,"nLastCleared") == 0)
    {
        return TRUE;
    }
    else if((GetLocalString(OBJECT_SELF,"sOwner") == "sGate1" || GetLocalString(OBJECT_SELF,"sOwner") == "sGate2"|| GetLocalString(OBJECT_SELF,"sOwner") == "sGate3")&& GetLocalInt(OBJECT_SELF,"nLastCleared") == 0)
    {
        return TRUE;
    }

    return FALSE;
}
