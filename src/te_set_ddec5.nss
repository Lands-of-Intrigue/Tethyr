void main()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;

    //Strings
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement

    int nLockDC          = GetCampaignInt("Housing",sUnique+"Lock");                    //The DC for trying to unlock this door using Open Lock skill.
    int nDoorDC          = GetCampaignInt("Housing",sUnique+"Door");                    //The DC for trying to bust down this door using STR.
    int nUpkeep          = GetCampaignInt("Housing",sUnique+"Base");                    //The default upkeep/price for maintaining this door/location behind the door.


    nDoorDC = nDoorDC-5;

    if(nDoorDC < 0)
    {
        SetCampaignInt("Housing",sUnique+"Door",0);
        SetCampaignInt("Housing",sUnique+"Base",((nLockDC+0)*10)+50);
    }
    else if (nDoorDC > 30)
    {
        SetCampaignInt("Housing",sUnique+"Door",30);
        SetCampaignInt("Housing",sUnique+"Base",((nLockDC+30)*10)+50);
    }
    else
    {
        SetCampaignInt("Housing",sUnique+"Door",nDoorDC);
        SetCampaignInt("Housing",sUnique+"Base",((nLockDC+nDoorDC)*10)+50);
    }
}
