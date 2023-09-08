int StartingConditional()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement
    string sID           = GetSubString(GetPCPublicCDKey(oPC)+"_"+GetName(oPC), 0, 15);  //Unique ID for player interacting to be compared to sRenter.
    string sOwner        = GetLocalString(oDoor,"sOwner");                              //Owner ID / Settlement that owns this location.
    string sBank         = GetCampaignString("Settlement",sOwner+"_sBank");             //Bank ID associated with settlement that owns this location.
    string sSetOwner     = GetCampaignString("Settlement",sOwner+"_sOwner");            //Barony that owns this Settlement and therefore this location.
    string sRenter       = GetCampaignString("Housing",sUnique+"Rent");                 //Unique ID for the player that is renting this location.
    string sName         = GetCampaignString("Housing",sUnique+"Name");                 //The Name of this location that will get printed to a key when generated.

    //Integers
    int nPrice           = GetCampaignInt("Housing",sUnique+"Pric");                    //The Price set by the owner automatically deducted from the renter's bank at barony.
    int nState           = GetCampaignInt("Housing",sUnique+"Stat");                    //The state of this location. Is it just a door?
    int nQuality         = GetCampaignInt("Housing",sUnique+"Qual");

    if(nQuality == 1 && GetHasFeat(1152,oPC) )
    {
        return TRUE;
    }
    else if (nQuality == 2 && GetHasFeat(1151,oPC))
    {
        return TRUE;
    }
    else if (nQuality == 3 && GetHasFeat(1150,oPC))
    {
        return TRUE;
    }
    else if(nQuality == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }



}
