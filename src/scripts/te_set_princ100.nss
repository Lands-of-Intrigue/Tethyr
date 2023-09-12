void main()
{
    //Objects
    object oPC           = GetClickingObject();                                         //The PC clicking the door.
    object oDoor         = OBJECT_SELF;                                                 //The Door.
    object oDestination  = GetTransitionTarget(OBJECT_SELF);                            //If this door connects to something, get that object.
    object oBailiff      = GetItemPossessedBy(oPC,"te_item_8508");                           //Bailiff's Writ.
    object oBaron        = GetItemPossessedBy(oPC,"te_item_8509");                           //Baron's Writ.
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement

    //Integers
    int nPrice           = GetCampaignInt("Housing",sUnique+"Pric");                    //The Price set by the owner automatically deducted from the renter's bank at barony.
    int nUpkeep          = GetCampaignInt("Housing",sUnique+"Base");                    //The default upkeep/price for maintaining this door/location behind the door.

    nPrice = nPrice+100;

    if(nPrice < 0)
    {
        SetCampaignInt("Housing",sUnique+"Pric",0);
        SendMessageToPC(oPC,"Price set to: "+IntToString(0)+" Upkeep for Door: "+IntToString(nUpkeep));
    }
    else
    {
        SetCampaignInt("Housing",sUnique+"Pric",nPrice);
        SendMessageToPC(oPC,"Price set to: "+IntToString(nPrice)+" Upkeep for Door: "+IntToString(nUpkeep));
    }
}
