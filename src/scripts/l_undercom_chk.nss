int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    // Make sure the player has the required feats
    if(GetLocalInt(oItem,"46") != 1 && GetLocalInt(oItem,"nLangSelect") >= 1)
    {
        return TRUE;
    }

    return FALSE;
}

