int StartingConditional()
{
    int iResult;

    int nDeity = GetLocalInt(OBJECT_SELF,"nDeity");
    object oPC = GetPCSpeaker();
    iResult = !GetHasFeat(nDeity,oPC);

    return iResult;
}
