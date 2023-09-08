void main()
{
SetCustomToken(1001, GetLocalString(OBJECT_SELF, "Town"));
SetCustomToken(1002, IntToString(GetCampaignInt(GetName(GetModule()), GetLocalString(OBJECT_SELF, "Town") + "Tax")));
SetCustomToken(7771, GetLocalString(OBJECT_SELF,"TownName"));
}
