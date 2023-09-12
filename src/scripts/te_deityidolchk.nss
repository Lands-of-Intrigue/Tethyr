int StartingConditional()
{
    int iResult;

    int nDeity = GetLocalInt(OBJECT_SELF,"nDeity");
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"te_masidol_01");

    if(GetHasFeat(nDeity,oPC) == FALSE)
    {
        return FALSE;
    }

    if(GetIsObjectValid(oItem) == TRUE)
    {
        return TRUE;
    }
    else
    {
        oItem = GetItemPossessedBy(oPC,"te_masidol_02");
        if(GetIsObjectValid(oItem) == TRUE)
        {
            return TRUE;
        }
        else
        {
            oItem = GetItemPossessedBy(oPC,"te_masidol_03");
            if(GetIsObjectValid(oItem) == TRUE)
            {
                return TRUE;
            }
            else
            {
                return FALSE;
            }
        }
    }
}
