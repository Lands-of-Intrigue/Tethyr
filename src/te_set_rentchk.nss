int StartingConditional()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;

    //Strings
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement
    string sRenter       = GetCampaignString("Housing",sUnique+"Rent");                 //Unique ID for the player that is renting this location.

    //Integers
    int nPrice           = GetCampaignInt("Housing",sUnique+"Pric");                    //The Price set by the owner automatically deducted from the renter's bank at barony.
    int nState           = GetCampaignInt("Housing",sUnique+"Stat");                    //The state of this location. Is it just a door?
    int nQuality         = GetCampaignInt("Housing",sUnique+"Qual");

    SetCustomToken(4403,"Price to Rent: "+IntToString(nPrice));

    if(sRenter == "" && nState > 1)
    {
        if(nQuality == 0)
        {
            return TRUE;
        }
        else if(nQuality == 1 && GetHasFeat(1152,oPC) == TRUE)
        {
            return TRUE;
        }
        else if(nQuality == 2 && GetHasFeat(1151,oPC) == TRUE)
        {
            return TRUE;
        }
        else if(nQuality == 3 && GetHasFeat(1150,oPC) == TRUE)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }
    else
    {
        return FALSE;
    }
}
