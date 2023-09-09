//::///////////////////////////////////////////////
//:: DM Tool 4 Instant Feat
//:: x3_dm_tool04
//:: Copyright (c) 2007 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is a blank feat script for use with the
    10 DM instant feats provided in NWN v1.69.

    Look up feats.2da, spells.2da and iprp_feats.2da

*/
//:://////////////////////////////////////////////
//:: Created By: Brian Chung
//:: Created On: 2007-12-05
//:://////////////////////////////////////////////
string ConvertTime(int nHours);

void main()
{
    object oTarget = GetSpellTargetObject();
    object oItem = GetItemPossessedBy(oTarget,"PC_Data_Object");

    int sPCTime = GetLocalInt(oItem,"PCTime");
    int sCDTime = GetCampaignInt("PC_Playtime",GetPCPublicCDKey(oTarget));


    string sMsg = "Playername: "+GetPCPlayerName(oTarget);
    sMsg += "Name: "+GetName(oTarget)+"\n";
    sMsg += "CDKey: "+GetPCPublicCDKey(oTarget)+"\n";
    sMsg += "IP: "+GetPCIPAddress(oTarget)+"\n";
    sMsg += "PC Playtime: "+ConvertTime(sPCTime)+"\n";
    sMsg += "CDKey Playtime: "+ConvertTime(sPCTime)+"\n";



    SendMessageToPC(OBJECT_SELF,sMsg);



 }

string ConvertTime(int nHours)
{
    string sDays = IntToString(nHours/24);
    string sReturn = (sDays+" Days ("+IntToString(nHours)+" Hours)");

    return sReturn;
}
