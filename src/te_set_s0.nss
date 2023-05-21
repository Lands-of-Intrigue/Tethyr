// siobhan: looks like a hack to manage db stuff - remove if safe to do so!

void main()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;

    //Strings
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement
    int nState           = GetCampaignInt("Housing",sUnique+"Stat");                    //The state of this location. Is it just a door?

    SetCampaignInt("Housing",sUnique+"Stat",0);
}
