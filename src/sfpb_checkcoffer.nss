void main()
{
SetCustomToken(1003, IntToString(GetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Coffers")));
SetCustomToken(1004, IntToString(GetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Coffers")+GetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Holding")));
SetCustomToken(1005, IntToString(GetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Holding")));
}
