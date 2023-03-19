void main()


{


    object oPC = GetPCSpeaker();


    string sStoredKey = GetCampaignString("PlayernameKey", GetPCPlayerName(oPC));


    string sKeys = "ADD" + GetStringRight(sStoredKey, GetStringLength(sStoredKey) - 3);//mark as adding


    SetCampaignString("PlayernameKey", GetPCPlayerName(oPC), sKeys);


}
