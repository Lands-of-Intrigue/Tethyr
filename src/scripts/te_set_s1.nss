void main()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;

    //Strings
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement
    int nState           = GetCampaignInt("Housing",sUnique+"Stat");                    //The state of this location. Is it just a door?

    SetCampaignInt("Housing",sUnique+"Stat",1);
}
