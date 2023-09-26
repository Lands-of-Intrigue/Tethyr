int StartingConditional()
{
    object oPC = GetPCSpeaker();
    return GetIsDM(oPC) == TRUE;

    // removed settlement checks for now

    // object oSettlement = OBJECT_SELF;
    // object oPC = GetPCSpeaker();
    // object oItem = GetItemPossessedBy(oPC,"te_item_8509");
    // string sSettlement = GetLocalString(oSettlement,"sOwner");
    // string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    // if((sSettlement != "sLock")||(sSettlement != "sTejarn")||(sSettlement != "sSpire")||(sSettlement != "sSwamp")||(sSettlement != "sBrost"))
    // {
    //     if(GetLocalString(oItem,"Settlement") == sOwner || GetIsDM(oPC) == TRUE)
    //     {
    //         return TRUE;
    //     }
    //     else
    //     {
    //         return FALSE;
    //     }
    // }
    // else
    // {
    //     return FALSE;
    // }

}
