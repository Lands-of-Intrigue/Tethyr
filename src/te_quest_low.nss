int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nLvl = GetLocalInt(OBJECT_SELF,"LevelChk");

    if(GetHitDice(oPC) < nLvl)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
