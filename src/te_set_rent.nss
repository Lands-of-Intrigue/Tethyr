void main()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;
    //Strings
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement
    string sID           = GetSubString(GetPCPublicCDKey(oPC)+"_"+GetName(oPC), 0, 15);  //Unique ID for player interacting to be compared to sRenter.
    string sOwner        = GetLocalString(oDoor,"sOwner");                              //Owner ID / Settlement that owns this location.
    string sRentName     = GetCampaignString("Housing",sUnique+"RentName");
    int nPrice           = GetCampaignInt("Housing",sUnique+"Pric");                    //The Price set by the owner automatically deducted from the renter's bank at barony.

    if(GetGold(oPC) >= nPrice)
    {
        TakeGoldFromCreature(nPrice,oPC,TRUE);
        SetCampaignString("Housing",sUnique+"Rent",sID);
        SetCampaignString("Housing",sUnique+"RentName",GetName(oPC));
    }
    else
    {
        SendMessageToPC(oPC,"You do not have enough gold to rent this location.");
    }


}
