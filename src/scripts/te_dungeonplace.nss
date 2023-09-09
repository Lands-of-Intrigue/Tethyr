void main()
{
    object oPlace = OBJECT_SELF;
    object oPC = GetLastUsedBy();

    int nLore = GetSkillRank(SKILL_LORE,oPC,FALSE);

    int nAstroDC = GetLocalInt(oPlace,"nDCAstrology");
    int nDeciphDC = GetLocalInt(oPlace,"nDCDecipher");
    int nHistoryDC = GetLocalInt(oPlace,"nDCHistory");

    string sAstrology = GetLocalString(oPlace,"sAstrology");
    string sDecipher = GetLocalString(oPlace,"sDecipher");
    string sHistory = GetLocalString(oPlace,"sHistory");
    string sFail = GetLocalString(oPlace,"sFail");

    if(nAstroDC > 0)
    {
        if(GetHasFeat(1427,oPC) == TRUE || nLore > nAstroDC)
        {
            SendMessageToPC(oPC,sAstrology);
            return;
        }
        else
        {
            SendMessageToPC(oPC,sFail);
            return;
        }
    }
    if(nDeciphDC > 0)
    {
        if(GetHasFeat(1428,oPC) == TRUE || nLore > nDeciphDC)
        {
            SendMessageToPC(oPC,sDecipher);
            return;
        }
        else
        {
            SendMessageToPC(oPC,sFail);
            return;
        }
    }
    if(nHistoryDC > 0)
    {
        if(GetHasFeat(1426,oPC) == TRUE || nLore > nHistoryDC)
        {
            SendMessageToPC(oPC,sHistory);
            return;
        }
        else
        {
            SendMessageToPC(oPC,sFail);
            return;
        }
    }

}
