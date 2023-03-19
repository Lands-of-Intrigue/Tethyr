void main()
{
    // Set the banker to listen
    SetListening(OBJECT_SELF, FALSE);

    // Set the custom token for the amount spoken
    SetCustomToken(1002, GetLocalString(OBJECT_SELF, "GOLD"));
    SetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Tax", StringToInt(GetLocalString(OBJECT_SELF, "GOLD")));
}

