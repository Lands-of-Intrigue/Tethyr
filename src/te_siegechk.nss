int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if(GetHasFeat(1429,oPC) == TRUE || GetIsDM(oPC) == TRUE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
