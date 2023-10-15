void RewardRoadClearing(object oPC,string sRoad);
void RewardParty(object oPC,int nReward);

#include "nwnx_webhook"
#include "nwnx_time"
#include "loi_xp"

void main()
{
    object oPC = GetPCSpeaker();
    object oPlace = OBJECT_SELF;
    int nLocalTime = GetTimeHour()*100+GetTimeMinute();
    int nResetTime = GetLocalInt(oPlace,"nResetTime");
    string sOwner = GetLocalString(oPlace,"sOwner");
    object oItem = GetItemPossessedBy(oPC,"te_insignia");
    SendMessageToPC(oPC,"Insignia: "+GetName(oItem));
    string sInsig = GetLocalString(oItem,"Settlement");
    SendMessageToPC(oPC,"Settlement: "+sInsig);
    SetLocalInt(oPlace,"nLastCleared",nLocalTime);
    RewardRoadClearing(oPC, sOwner);

    SetLocalString(oItem,"sLastCleared",sOwner);

    int nGuardGroup;
    string sTemplate;

    object oWaypoint = GetFirstObjectInShape(SHAPE_SPHERE,100.0f,GetLocation(oPlace),FALSE,OBJECT_TYPE_WAYPOINT);
    while (GetIsObjectValid(oWaypoint) == TRUE)
    {
        if(GetLocalString(oWaypoint,"sOwner") == "sTrade1" ||
           GetLocalString(oWaypoint,"sOwner") == "sTrade2" ||
           GetLocalString(oWaypoint,"sOwner") == "sTrade3" ||
           GetLocalString(oWaypoint,"sOwner") == "sTrade4" ||
           GetLocalString(oWaypoint,"sOwner") == "sTrade5" ||
           GetLocalString(oWaypoint,"sOwner") == "sFort1")
        {
            nGuardGroup = GetLocalInt(oWaypoint,"GuardGroup");
            if (sInsig == "sLock")
            {
                switch (nGuardGroup)
                {
                    case 1: sTemplate = "sg_lockpf"; break;
                    case 2: sTemplate = "sg_lockpa"; break;
                    case 3: sTemplate = "sg_lockga"; break;
                    case 4: sTemplate = "sg_lockkf"; break;
                    case 5: sTemplate = "sg_lockka"; break;
                    default: sTemplate = "sg_lockpf";
                }
            }
            else if (sInsig == "sTejarn")
            {
                switch (nGuardGroup)
                {
                    case 1: sTemplate = "sg_tejpf"; break;
                    case 2: sTemplate = "sg_tejpa"; break;
                    case 3: sTemplate = "sg_tejga"; break;
                    case 4: sTemplate = "sg_tejkf"; break;
                    case 5: sTemplate = "sg_tejkf"; break;
                    default: sTemplate = "sg_tejka";
                }
            }
            else if (sInsig == "sSwamp")
            {
                switch (nGuardGroup)
                {
                    case 1: sTemplate = "sg_swapf"; break;
                    case 2: sTemplate = "sg_swapa"; break;
                    case 3: sTemplate = "sg_swaga"; break;
                    case 4: sTemplate = "sg_swakf"; break;
                    case 5: sTemplate = "sg_swaka"; break;
                    default: sTemplate = "sg_swapf";
                }
            }
            else if (sInsig == "sSpire")
            {
                switch (nGuardGroup)
                {
                    case 1: sTemplate = "sg_spipf"; break;
                    case 2: sTemplate = "sg_spipa"; break;
                    case 3: sTemplate = "sg_spiga"; break;
                    case 4: sTemplate = "sg_spikf"; break;
                    case 5: sTemplate = "sg_spika"; break;
                    default: sTemplate = "sg_spipf";
                }
            }
            else if (sInsig == "sBrost")
            {
                switch (nGuardGroup)
                {
                    case 1: sTemplate = "sg_bropf"; break;
                    case 2: sTemplate = "sg_bropa"; break;
                    case 3: sTemplate = "sg_broga"; break;
                    case 4: sTemplate = "sg_brokf"; break;
                    case 5: sTemplate = "sg_broka"; break;
                    default: sTemplate = "sg_bropf";
                }
            }
            SetLocalString(oWaypoint, "f_Template", sTemplate);
        }
        else if(GetLocalString(oWaypoint,"sOwner") == "sMine1" ||
                GetLocalString(oWaypoint,"sOwner") == "sMine2" ||
                GetLocalString(oWaypoint,"sOwner") == "sMine3")
        {
            sTemplate = "sg_lwminer";
            SetLocalString(oWaypoint, "f_Template", sTemplate);
        }
        else if(GetLocalString(oWaypoint,"sOwner") == "sGate1")
        {
            nGuardGroup = GetLocalInt(oWaypoint,"GuardGroup");
            switch (nGuardGroup)
            {
                case 1: sTemplate = "sg_swapf"; break;
                case 2: sTemplate = "sg_swapa"; break;
                case 3: sTemplate = "sg_swaga"; break;
                case 4: sTemplate = "sg_swakf"; break;
                case 5: sTemplate = "sg_swaka"; break;
                default: sTemplate = "sg_swapf";
            }
            SetLocalString(oWaypoint, "f_Template", sTemplate);
        }
        else if(GetLocalString(oWaypoint,"sOwner") == "sGate2")
        {
            nGuardGroup = GetLocalInt(oWaypoint,"GuardGroup");
            switch (nGuardGroup)
            {
                case 1: sTemplate = "sg_armym"; break;
                case 2: sTemplate = "sg_armya"; break;
                case 3: sTemplate = "sg_armym"; break;
                case 4: sTemplate = "sg_armym"; break;
                case 5: sTemplate = "sg_armya"; break;
                default: sTemplate = "sg_armym";
            }
            SetLocalString(oWaypoint, "f_Template", sTemplate);
        }
        else if(GetLocalString(oWaypoint,"sOwner") == "sGate3")
        {
            nGuardGroup = GetLocalInt(oWaypoint,"GuardGroup");
            switch (nGuardGroup)
            {
                case 1: sTemplate = "sg_bropf"; break;
                case 2: sTemplate = "sg_bropa"; break;
                case 3: sTemplate = "sg_broga"; break;
                case 4: sTemplate = "sg_brokf"; break;
                case 5: sTemplate = "sg_broka"; break;
                default: sTemplate = "sg_bropf";
            }
            SetLocalString(oWaypoint, "f_Template", sTemplate);
        }
        else if(GetLocalString(oWaypoint,"sOwner") == "sGate4")
        {
            nGuardGroup = GetLocalInt(oWaypoint,"GuardGroup");
            switch (nGuardGroup)
            {
                case 1: sTemplate = "sg_bropf"; break;
                case 2: sTemplate = "sg_bropa"; break;
                case 3: sTemplate = "sg_broga"; break;
                case 4: sTemplate = "sg_brokf"; break;
                case 5: sTemplate = "sg_broka"; break;
                default: sTemplate = "sg_bropf";
            }
            SetLocalString(oWaypoint, "f_Template", sTemplate);
        }
        oWaypoint = GetNextObjectInShape(SHAPE_SPHERE,75.0f,GetLocation(oPlace),FALSE,OBJECT_TYPE_WAYPOINT);
    }
}

void RewardRoadClearing(object oPC, string sRoad)
{
    object oMod = GetModule();

    object oItem = GetItemPossessedBy(oPC,"te_insignia");

    string sOwner,sBank,sBank_Coffer;
    int nCoffAmount,nReward,nGold;

    if(sRoad == "sTrade1")
    {
        nReward = 150;
        nGold = nGold +nReward;
        sOwner = "sBrost";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 150;
        nGold = nGold +nReward;
        sOwner = "sTejarn";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 250;
        nGold = nGold +nReward;
        sOwner = "sLockwood";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 20;
        nGold = nGold +nReward;
        sOwner = "sSpire";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 10;
        nGold = nGold +nReward;
        sOwner = "sSwamp";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,GetName(oPC)+" has claimed the Lockwood Tradeway. **Lockwood Coffers Updated** 250 Aenar, **Brost Coffers Updated** 150 Aenar, **Tejarn Gate Coffers Updated** 150 Aenar, **Southspire Coffers Updated** 20 Aenar, **Swamprise Coffers Updated** 10 Aenar","MODULE WIDE UPDATE");
        SendMessageToPC(oPC,"Your actions have benefited the Baronies and increased tax revenue for Lockwood Falls by 250 Aenar, Brost by 150 Aenar, Tejarn Gate by 150 Aenar, Swamprise by 10 Aenar, and Southspire by 20 Aenar.");
        RewardParty(oPC,25);
    }
    else if(sRoad == "sMine1" || sRoad == "sMine2" || sRoad == "sMine3")
    {
        nReward = 50;
        nGold = nGold +nReward;
        sOwner = "sLockwood";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,GetName(oPC)+" has claimed a vein of the Lockwood Mines. **Lockwood Coffers Updated** 50 Aenar","MODULE WIDE UPDATE");
        SendMessageToPC(oPC,"Your actions have benefited the Baronies and increased tax revenue for Lockwood Falls by 50 Aenar");
        RewardParty(oPC,25);
    }
    else if(sRoad == "sTrade2")
    {
        nReward = 50;
        nGold = nGold +nReward;
        sOwner = "sBrost";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 50;
        nGold = nGold +nReward;
        sOwner = "sTejarn";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 50;
        nGold = nGold +nReward;
        sOwner = "sLockwood";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 50;
        nGold = nGold +nReward;
        sOwner = "sSpire";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 50;
        nGold = nGold +nReward;
        sOwner = "sSwamp";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,GetName(oPC)+" has claimed the Lion's Path. **Lockwood Coffers Updated** 50 Aenar, **Brost Coffers Updated** 50 Aenar, **Tejarn Gate Coffers Updated** 50 Aenar, **Southspire Coffers Updated** 50 Aenar, **Swamprise Coffers Updated** 50 Aenar","MODULE WIDE UPDATE");
        SendMessageToPC(oPC,"Your actions have benefited the Baronies and increased tax revenue for Lockwood Falls by 50 Aenar, Brost by 50 Aenar, Tejarn Gate by 50 Aenar, Swamprise by 50 Aenar, and Southspire by 50 Aenar.");
        RewardParty(oPC,25);
    }
    else if(sRoad == "sTrade3")
    {
        nReward = 50;
        nGold = nGold +nReward;
        sOwner = "sBrost";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 150;
        nGold = nGold +nReward;
        sOwner = "sTejarn";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 50;
        nGold = nGold +nReward;
        sOwner = "sLockwood";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 20;
        nGold = nGold +nReward;
        sOwner = "sSpire";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 20;
        nGold = nGold +nReward;
        sOwner = "sSwamp";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,GetName(oPC)+" has claimed the Tejarn Road - Sentinel Pass. **Lockwood Coffers Updated** 50 Aenar, **Brost Coffers Updated** 50 Aenar, **Tejarn Gate Coffers Updated** 150 Aenar, **Southspire Coffers Updated** 20 Aenar, **Swamprise Coffers Updated** 20 Aenar","MODULE WIDE UPDATE");
        SendMessageToPC(oPC,"Your actions have benefited the Baronies and increased tax revenue for Lockwood Falls by 50 Aenar, Brost by 50 Aenar, Tejarn Gate by 150 Aenar, Swamprise by 20 Aenar, and Southspire by 20 Aenar.");
        RewardParty(oPC,25);
    }
    else if(sRoad == "sTrade4")
    {
        nReward = 250;
        nGold = nGold +nReward;
        sOwner = "sBrost";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 250;
        nGold = nGold +nReward;
        sOwner = "sTejarn";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 250;
        nGold = nGold +nReward;
        sOwner = "sLockwood";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 50;
        nGold = nGold +nReward;
        sOwner = "sSpire";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 100;
        nGold = nGold +nReward;
        sOwner = "sSwamp";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,GetName(oPC)+" has claimed the East Brost Tradeway/Lockwood Tradeway Junction. **Lockwood Coffers Updated** 250 Aenar, **Brost Coffers Updated** 250 Aenar, **Tejarn Gate Coffers Updated** 250 Aenar, **Southspire Coffers Updated** 50 Aenar, **Swamprise Coffers Updated** 100 Aenar","MODULE WIDE UPDATE");
        SendMessageToPC(oPC,"Your actions have benefited the Baronies and increased tax revenue for Lockwood Falls by 250 Aenar, Brost by 250 Aenar, Tejarn Gate by 250 Aenar, Swamprise by 100 Aenar, and Southspire by 50 Aenar.");
        RewardParty(oPC,25);
    }
    else if(sRoad == "sGate1")
    {
        nReward = 250;
        nGold = nGold +nReward;
        sOwner = "sBrost";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 50;
        nGold = nGold +nReward;
        sOwner = "sTejarn";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 50;
        nGold = nGold +nReward;
        sOwner = "sLockwood";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 100;
        nGold = nGold +nReward;
        sOwner = "sSpire";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 250;
        nGold = nGold +nReward;
        sOwner = "sSwamp";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,GetName(oPC)+" has recovered the Swamprise Approach for Swamprise Keep. **Lockwood Coffers Updated** 50 Aenar, **Brost Coffers Updated** 250 Aenar, **Tejarn Gate Coffers Updated** 50 Aenar, **Southspire Coffers Updated** 100 Aenar, **Swamprise Coffers Updated** 250 Aenar","MODULE WIDE UPDATE");
        SendMessageToPC(oPC,"Your actions have benefited the Baronies and increased tax revenue for Lockwood Falls by 50 Aenar, Brost by 250 Aenar, Tejarn Gate by 50 Aenar, Swamprise by 250 Aenar, and Southspire by 100 Aenar.");
        RewardParty(oPC,25);
    }
    else if(sRoad == "sGate2")
    {
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,GetName(oPC)+" has recovered the West Haven Forward Checkpoint. No Trade Benefit","MODULE WIDE UPDATE");
        SendMessageToPC(oPC,"Your actions have benefited the Baronies and increased your notoriety.");
        RewardParty(oPC,50);
    }
    else if(sRoad == "sTrade5")
    {
        nReward = 250;
        nGold = nGold +nReward;
        sOwner = "sBrost";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 50;
        nGold = nGold +nReward;
        sOwner = "sTejarn";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 150;
        nGold = nGold +nReward;
        sOwner = "sLockwood";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 250;
        nGold = nGold +nReward;
        sOwner = "sSpire";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 250;
        nGold = nGold +nReward;
        sOwner = "sSwamp";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,GetName(oPC)+" has claimed the Broken Tooth. **Lockwood Coffers Updated** 150 Aenar, **Brost Coffers Updated** 250 Aenar, **Tejarn Gate Coffers Updated** 50 Aenar, **Southspire Coffers Updated** 150 Aenar, **Swamprise Coffers Updated** 250 Aenar","MODULE WIDE UPDATE");
        SendMessageToPC(oPC,"Your actions have benefited the Baronies and increased tax revenue for Lockwood Falls by 150 Aenar, Brost by 250 Aenar, Tejarn Gate by 50 Aenar, Swamprise by 250 Aenar, and Southspire by 150 Aenar.");
        RewardParty(oPC,25);
    }
    else if(sRoad == "sGate3")
    {
        nReward = 250;
        nGold = nGold +nReward;
        sOwner = "sBrost";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 250;
        nGold = nGold +nReward;
        sOwner = "sTejarn";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 250;
        nGold = nGold +nReward;
        sOwner = "sLockwood";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 100;
        nGold = nGold +nReward;
        sOwner = "sSpire";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        nReward = 100;
        nGold = nGold +nReward;
        sOwner = "sSwamp";
        sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
        nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
        SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nReward);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,GetName(oPC)+" has recovered the East Brost Tradeway Approach for the Village of Brost. **Lockwood Coffers Updated** 250 Aenar, **Brost Coffers Updated** 250 Aenar, **Tejarn Gate Coffers Updated** 250 Aenar, **Southspire Coffers Updated** 100 Aenar, **Swamprise Coffers Updated** 50 Aenar","MODULE WIDE UPDATE");
        SendMessageToPC(oPC,"Your actions have benefited the Baronies and increased tax revenue for Lockwood Falls by 250 Aenar, Brost by 250 Aenar, Tejarn Gate by 250 Aenar, Swamprise by 50 Aenar, and Southspire by 100 Aenar.");
        RewardParty(oPC,25);
    }
    else if(sRoad == "sGate4")
    {
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,GetName(oPC)+" has recovered the Kelemvorite Shrine on the Duskwood Trail. No Trade Benefit","MODULE WIDE UPDATE");
        SendMessageToPC(oPC,"Your actions have benefited the Baronies and increased your notoriety.");
        RewardParty(oPC,50);
    }
    else if(sRoad == "sFort1")
    {
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,GetName(oPC)+" has recovered the Fort Noromath Checkpoint. No Trade Benefit","MODULE WIDE UPDATE");
        SendMessageToPC(oPC,"Your actions have benefited the Baronies and increased your notoriety.");
        RewardParty(oPC,50);
    }

    int nHonor = GetLocalInt(oItem,"nHonor");
    int nHonorTotal = GetLocalInt(oItem,"nHonorTotal");
    int nInsigGold = GetLocalInt(oItem,"nGold");
    int nGoldTotal = GetLocalInt(oItem,"nGoldTotal");

    SetLocalInt(oItem,"nGold",nInsigGold+nGold);
    SetLocalInt(oItem,"nGoldTotal",nGoldTotal+nGold);
    SetLocalInt(oItem,"nHonor",nHonor+1);
    SetLocalInt(oItem,"nHonorTotal",nHonorTotal+1);

}

void RewardParty(object oPC,int nReward)
{
    object oArea = GetArea(oPC);
    if(GetIsDM(oPC) == TRUE)
    {}
    else
    {
        object oPlayer = GetFirstFactionMember(oPC,TRUE);

        while (GetIsObjectValid(oPlayer) == TRUE)
        {
            if(GetArea(oPlayer) == oArea)
            {
                AwardXP(oPlayer,nReward);
            }
            oPlayer = GetNextFactionMember(oPC,TRUE);
        }
    }
}
