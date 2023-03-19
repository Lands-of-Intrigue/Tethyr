int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"te_insignia");
    int nHonor = GetLocalInt(oItem,"nHonor");
    int nHonorTotal = GetLocalInt(oItem,"nHonor");
    int nGold = GetLocalInt(oItem,"nGold");
    int nGoldTotal  = GetLocalInt(oItem,"nGoldTotal");
    int nLastCheck = GetLocalInt(oItem,"nLastCheck");

    if(nHonor == 0)
    {
        SetCustomToken(9123,"You have performed no viable actions for the Barony, and thus earned no honor for yourself or the Queen this past month.");
    }
    else if (nHonor == 1)
    {
        SetCustomToken(9123,"You have performed minimal actions for the Barony, and thus have earned almost no honor for yourself or the Queen this past month. Your actions have added "+IntToString(nGold)+" Aenar to the coffers.");
    }
    else if (nHonor > 1 && nHonor <= 25)
    {
        SetCustomToken(9123,"You have performed regular actions for the Barony, and thus have earned some honor for yourself and the Queen this past month. Your actions have added "+IntToString(nGold)+" Aenar to the coffers.");
    }
    else if (nHonor > 25 && nHonor <= 50)
    {
        SetCustomToken(9123,"You have performed many actions for the Barony, and thus have earned a great deal of honor for yourself and the Queen this past month. Your actions have added "+IntToString(nGold)+" Aenar to the coffers.");
    }
    else if (nHonor > 50)
    {
        SetCustomToken(9123,"You have performed a staggering number of actions for the Barony, and thus have earned a exemplary amount of honor for yourself and the Queen this past month. Your actions have added "+IntToString(nGold)+" Aenar to the coffers.");
    }


    if(GetIsObjectValid(oItem) == TRUE)
    {
        return TRUE;
    }
    return FALSE;

}
