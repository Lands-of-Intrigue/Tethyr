int StartingConditional()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement
    string sID           = GetSubString(GetPCPublicCDKey(oPC)+"_"+GetName(oPC), 0, 15);  //Unique ID for player interacting to be compared to sRenter.

    //Integers
    int nPrice           = GetCampaignInt("Housing",sUnique+"Pric");                    //The Price set by the owner automatically deducted from the renter's bank at barony.

    if(GetGold(oPC) >= nPrice)
    {
        return TRUE;
    }
    else
    {
        SendMessageToPC(oPC,"You do not have enough gold.");
        return FALSE;
    }

}
