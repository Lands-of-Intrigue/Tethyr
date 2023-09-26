#include "gs_inc_shop"


int StartingConditional()
{
    object oShop         = OBJECT_SELF;
    object oPC           = GetPCSpeaker();
    // object oInsig        = GetItemPossessedBy(oPC,"te_insignia");                       //Insignia
    // string sUnique       = GetLocalString(oShop,"sUnique");                             //Unique ID for Settlement
    // string sOwner        = GetLocalString(oShop,"sOwner");                              //Owner ID / Settlement that owns this location.
    // string sSetOwner     = GetCampaignString("Settlement",sOwner+"_sOwner");            //Barony that owns this Settlement and therefore this location.

    // int nInsig = TE_SH_GetInsignia(oShop);

    if (TE_SH_GetIsAvailable(oShop))
    {
        SetCustomToken(100, IntToString(TE_SH_GetRentPrice(oShop)));

        if(GetItemPossessedBy(oPC,"te_merchant") == OBJECT_INVALID)
        {
            SendMessageToPC(oPC,"This shop requires a merchant license to rent.");
            return FALSE;
        }

        // if(nInsig == TRUE)
        // {
        //     if(oInsig == OBJECT_INVALID)
        //     {
        //         SendMessageToPC(oPC,"This shop requires a barony insignia to rent.");
        //         return FALSE;
        //     }
        //     else
        //     {
        //         if(GetLocalString(oInsig,"Settlement") != sSetOwner)
        //         {
        //             SendMessageToPC(oPC,"This shop requires a barony insignia to rent.");
        //             return FALSE;
        //         }
        //     }
        // }

        return TRUE;
    }

    return FALSE;
}
