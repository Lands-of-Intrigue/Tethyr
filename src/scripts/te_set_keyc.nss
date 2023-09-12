void main()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;

    //Strings
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement

    //Integers
    int nPrice           = GetCampaignInt("Housing",sUnique+"Pric");                    //The Price set by the owner automatically deducted from the renter's bank at barony.
    int nKey             = GetCampaignInt("Housing",sUnique+"Keys");                    //The Number of times this lock has been changed. String is the same, just modified by 1.

    int nGold = GetGold(oPC);

    if(nGold > 100)
    {
        TakeGoldFromCreature(100,oPC,TRUE);
        SendMessageToPC(oPC,"You have updated the locks for this door!");
        SetCampaignInt("Housing",sUnique+"Keys",nKey+1);
    }
    else
    {
        SendMessageToPC(oPC,"You require 100 gold to update the locks for this door!");
    }

}
