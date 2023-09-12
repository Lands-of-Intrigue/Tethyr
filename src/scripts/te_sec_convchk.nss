int StartingConditional()


{


    object oPC = GetPCSpeaker();


    string sStoredKey = GetCampaignString("PlayernameKey", GetPCPlayerName(oPC));


    if (sStoredKey != "") {


        int nLength =  GetStringLength(sStoredKey);


        if (nLength > 65) /* allow 7 keys max SET-key-key-key-key-key-key-key   SET/ADD + 7 spacers + 7x8 keys = 66 */


            return FALSE;


    }


    return TRUE;


}
