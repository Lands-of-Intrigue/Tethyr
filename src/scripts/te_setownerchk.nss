int StartingConditional()
{
    object oSettlement = OBJECT_SELF;
    object oPC = GetPCSpeaker();


    object oBailiff     = GetItemPossessedBy(oPC,"te_item_8508");                           //Bailiff's Writ.
    object oBaron       = GetItemPossessedBy(oPC,"te_item_8509");                           //Baron's Writ.
    string sSettlement  = GetLocalString(oSettlement,"sSettlement");                        //Owner ID / Settlement that owns this location.
    string sOwner       = GetCampaignString("Settlement",(sSettlement+"_sOwner"));
    object oItem;

    if( GetLocalString(oBailiff,"Settlement") == sSettlement  || //I am the Bailiff for this location.
        GetLocalString(oBaron,"Settlement")   == sOwner       || //I am the Baron for this location.
        GetIsDM(oPC))
        {
            return TRUE;
        }

        return FALSE;
}
