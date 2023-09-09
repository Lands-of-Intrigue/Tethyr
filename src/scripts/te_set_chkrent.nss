int  StartingConditional()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;
    object oBailiff      = GetItemPossessedBy(oPC,"te_item_8508");                           //Bailiff's Writ.
    object oBaron        = GetItemPossessedBy(oPC,"te_item_8509");                           //Baron's Writ.
    //Strings
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement
    string sID           = GetSubString(GetPCPublicCDKey(oPC)+"_"+GetName(oPC), 0, 15); //Unique ID for player interacting to be compared to sRenter.
    string sOwner        = GetLocalString(oDoor,"sOwner");                              //Owner ID / Settlement that owns this location.
    string sBank         = GetCampaignString("Settlement",sOwner+"_sBank");             //Bank ID associated with settlement that owns this location.
    string sSetOwner     = GetCampaignString("Settlement",sOwner+"_sOwner");            //Barony that owns this Settlement and therefore this location.
    string sRenter       = GetCampaignString("Housing",sUnique+"Rent");                 //Unique ID for the player that is renting this location.
    string sName         = GetCampaignString("Housing",sUnique+"Name");                 //The Name of this location that will get printed to a key when generated.
    //Integers
    int nPrice           = GetCampaignInt("Housing",sUnique+"Pric");                    //The Price set by the owner automatically deducted from the renter's bank at barony.
    int nKey             = GetCampaignInt("Housing",sUnique+"Keys");                    //The Number of times this lock has been changed. String is the same, just modified by 1.
    int nLockDC          = GetCampaignInt("Housing",sUnique+"Lock");                    //The DC for trying to unlock this door using Open Lock skill.
    int nDoorDC          = GetCampaignInt("Housing",sUnique+"Door");                    //The DC for trying to bust down this door using STR.
    int nUpkeep          = GetCampaignInt("Housing",sUnique+"Base");                    //The default upkeep/price for maintaining this door/location behind the door.
    int nState           = GetCampaignInt("Housing",sUnique+"Stat");                    //The state of this location. Is it just a door?
    int nQuality         = GetCampaignInt("Housing",sUnique+"Qual");

    SetCustomToken(4401,"Door Strength DC: "+IntToString(nDoorDC));
    SetCustomToken(4402,"Door Lock DC: "+IntToString(nLockDC));
    SetCustomToken(4403,"Price to Rent: "+IntToString(nPrice));

    if(sOwner == "")
    {
        sOwner == "Blank";
    }

    if(sSetOwner == "")
    {
        sSetOwner == "Blank";
    }

    if(sRenter == "")
    {
        SetCustomToken(4404,"Current Renter: None");
    }
    else
    {
        SetCustomToken(4404,"Current Renter: "+sName);
    }

    if(nQuality == 0)
    {
        SetCustomToken(4405,"Class Standing Requirement: None");
    }
    else if(nQuality == 1)
    {
        SetCustomToken(4405,"Class Standing Requirement: High Class Only");
    }
    else if(nQuality == 2)
    {
        SetCustomToken(4405,"Class Standing Requirement: Middle Class Only");
    }
    else if(nQuality == 3)
    {
        SetCustomToken(4405,"Class Standing Requirement: Low Class Only");
    }

    if(nState == 0)
    {
        SetCustomToken(4406,"Status: Closed to the Public. Keyed Entry Only.");
    }
    else if (nState == 1)
    {
        SetCustomToken(4406,"Status: Rentable Room.");
    }
    else if (nState == 2)
    {
        SetCustomToken(4406,"Status: Open to the Public Always.");
    }
    else if (nState == 3)
    {
        SetCustomToken(4406,"Status: Open to the Public during Daytime Hours.");
    }

    SetCustomToken(4407,"Upkeep Cost: "+IntToString(nUpkeep));

    if(nState == 1 && sRenter == "")
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }

}
