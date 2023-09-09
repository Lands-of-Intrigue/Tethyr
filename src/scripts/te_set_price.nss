void main()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;                                                 //The Door.
    //Strings
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement

    //Integers
    int nPrice           = GetCampaignInt("Housing",sUnique+"Pric");                    //The Price set by the owner automatically deducted from the renter's bank at barony.

    SetCampaignInt("Housing",sUnique+"Pric",StringToInt(GetLocalString(OBJECT_SELF, "GOLD")));
}
