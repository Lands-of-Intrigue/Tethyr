int StartingConditional()
{
    int iResult;

    iResult = GetLocalInt(OBJECT_SELF, "Stage") <= 5;
    return iResult;
}
