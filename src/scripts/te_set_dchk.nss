#include "nwnx_webhook"

int StartingConditional()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;
    string sUnique       = GetLocalString(oDoor,"sUnique");    //Unique ID for Settlement
    string sOwner        = GetLocalString(oDoor,"sOwner");                              //Owner ID / Settlement that owns this location.
    string sBank         = GetCampaignString("Settlement",sOwner+"_sBank");             //Bank ID associated with settlement that owns this location.
    int nLockDC          = GetCampaignInt("Housing",sUnique+"Lock");                    //The DC for trying to unlock this door using Open Lock skill.
    int nDoorDC          = GetCampaignInt("Housing",sUnique+"Door");                    //The DC for trying to bust down this door using STR.

    if(GetCampaignInt("Housing",sUnique+"Brok") == 1)
    {
        return TRUE;
    }
    return FALSE;
}
