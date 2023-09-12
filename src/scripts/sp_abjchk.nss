int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MBreaker") == 4 || (GetHasFeat(1614, oPC)) == TRUE)
        iResult = 0;
    else
        iResult = 1;
    return iResult;
}
