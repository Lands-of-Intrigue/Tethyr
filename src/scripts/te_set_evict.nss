void main()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;

    //Strings
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement

    SetCampaignString("Housing",sUnique+"Rent","");
}
