#include "nwnx_time"
#include "nwnx_item"
#include "gs_inc_container"
#include "sfpb_config"
#include "nwnx_webhook"
/////////////////////////////////////////////////////////////////////////////
// Loosely based on Gigaschatten Shop Library recoded for Knights of Noromath
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
//////////// Author: David Novotny
//////////// Email: Raetzain@gmail.com
/////////////////////////////////////////////////////////////////////////////
//////////// Created: 12/15/19
//////////// Last Modified: 12/15/19
/////////////////////////////////////////////////////////////////////////////

//Shop Database name
const string sDatabase      = "GS_SHOP";
//PC Owner ID for Shop (CDKEY + CHAR NAME)
const string sShopOwner     = "OWNER_";
//Stored name for the shop
const string sShopName      = "SHOPNAME_";
//Stored name of the PC
const string sOwnerName     = "OWNERNAME_";
//Time shop last interacted with by owner
const string sTimeLast      = "TIMELAST_";
//Time between reset intervals/shop reset
const string sTimeInterval  = "TIMEINTER_";

//Returns true if oPC is the shop owner
int TE_SH_GetIsOwner(object oShop,object oPC);
//Return Owner ID of the shop
string TE_SH_GetOwnerID(object oShop);
//Return Owner Name for the shop
string TE_SH_GetOwnerName(object oShop);
//Return Shop Name for the shop
string TE_SH_GetShopName(object oShop);
//Update owner of shop and all information
void TE_SH_SetShopOwner(object oShop,object oPC);
//Update name of the shop
void TE_SH_SetShopName(object oShop, string sName);
//Updates the last touched timestamps for the shop, preventing someone from buying
void TE_SH_OwnerTouch(object oShop);
//Returns if shop is available for purchasing
int TE_SH_GetIsAvailable(object oShop);
//Load Inventory
void TE_SH_LoadShop(object oShop);
//Save Inventory
void TE_SH_SaveShop(object oShop);
//Abandon Shop
void TE_SH_AbandonShop(object oShop);
//Import Item
void TE_SH_ImportItem(object oItem,object oShop);
//Export Item
void TE_SH_ExportItem(object oItem,object oTarget);
//Set sales markup of the shop to nValue
void TE_SH_SetSalePrice(object oShop,int nValue);
//Return sales markup of the shop
int TE_SH_GetSalePrice(object oShop);
//Return Item Value
int TE_SH_GetItemValue(object oItem);
//Transfers nGold from oPC inventory to Playervault of sID at sBank
void TE_GoldTransfer(object oPC, string sID, int nGold, string sBank);
//Returns whether barony insignia is required
int TE_SH_GetInsignia(object oShop);
//Sets whether barony insignia is required
void TE_SH_SetInsignia(object oShop,int nReq = FALSE);
//Gets price for renting the stall
int TE_SH_GetRentPrice(object oShop);
//Sets price for renting the stall
void TE_SH_SetRentPrice(object oShop,int nPrice = 250);
//Returns true if oPC is the shop owner
int TE_SH_GetIsOwner(object oShop,object oPC)
{
    string sUnique = GetLocalString(oShop,"sUnique");
    string sID = GetSubString(GetPCPublicCDKey(oPC)+"_" + GetName(oPC), 0, 15);

    if(TE_SH_GetOwnerID(oShop) == sID)
    {
        return TRUE;
    }

    return FALSE;
}

//Return Owner ID of the shop
string TE_SH_GetOwnerID(object oShop)
{
    string sUnique = GetLocalString(oShop,"sUnique");
    return GetCampaignString(sDatabase,sShopOwner+sUnique);
}

//Return Owner Name for the shop
string TE_SH_GetOwnerName(object oShop)
{
    string sUnique = GetLocalString(oShop,"sUnique");
    return GetCampaignString(sDatabase,sOwnerName+sUnique);
}

//Return Shop Name for the shop
string TE_SH_GetShopName(object oShop)
{
    string sUnique = GetLocalString(oShop,"sUnique");
    return GetCampaignString(sDatabase,sShopName+sUnique);
}

//Update owner of shop and all information
void TE_SH_SetShopOwner(object oShop,object oPC)
{
    string sUnique = GetLocalString(oShop,"sUnique");
    string sID = GetSubString(GetPCPublicCDKey(oPC)+"_" + GetName(oPC), 0, 15);
    SetCampaignString(sDatabase,sShopOwner+sUnique,sID);
    SetCampaignString(sDatabase,sOwnerName+sUnique,GetName(oPC));
    SetCampaignInt(sDatabase,sTimeLast+sUnique,NWNX_Time_GetTimeStamp());
    SendMessageToAllDMs(sUnique+" shop set to owner "+sID);
}

//Update name of the shop
void TE_SH_SetShopName(object oShop,string sName)
{
    string sUnique = GetLocalString(oShop,"sUnique");
    SetCampaignString(sDatabase,sShopName+sUnique,sName);
}

//Updates the last touched timestamps for the shop, preventing someone from buying
void TE_SH_OwnerTouch(object oShop)
{
    string sUnique = GetLocalString(oShop,"sUnique");
    SetCampaignInt(sDatabase,sTimeLast+sUnique,NWNX_Time_GetTimeStamp());
    //SendMessageToAllDMs(sUnique+" shop timestamp refreshed");
}

//Returns if shop is available for purchasing
int TE_SH_GetIsAvailable(object oShop)
{
    string sUnique = GetLocalString(oShop,"sUnique");
    if(GetCampaignString(sDatabase,sShopOwner+sUnique) == "")
    {
        //SendMessageToAllDMs(sUnique+" shop is available with no owner.");
        return TRUE;
    }
    else
    {
        int nTimeLast = GetCampaignInt(sDatabase,sTimeLast+sUnique);
        if(NWNX_Time_GetTimeStamp() > nTimeLast + 604800)
        {
            //SendMessageToAllDMs(sUnique+" shop is available with owner w/o interaction.");
            return TRUE;
        }
        else
        {
            //SendMessageToAllDMs(sUnique+" shop is not available and is owned.");
            return FALSE;
        }
    }
    return FALSE;
}

//Load Inventory
void TE_SH_LoadShop(object oShop)
{
    string sUnique = GetLocalString(oShop,"sUnique");
    gsCOLoad(sDatabase+"_"+sUnique,oShop,20);

    object oItem = GetFirstItemInInventory(oShop);
    while (GetIsObjectValid(oItem))
    {
        SetLocalObject(oItem,"GS_SH_CONTAINER",oShop);
        oItem = GetNextItemInInventory(oShop);
    }
    //SendMessageToAllDMs(sUnique+" shop inventory loaded.");
}

//Save Inventory
void TE_SH_SaveShop(object oShop)
{
    string sUnique = GetLocalString(oShop,"sUnique");

    gsCOSave(sDatabase+"_"+sUnique, oShop, 20);
    //SendMessageToAllDMs(sUnique+" shop inventory saved.");
}
//Abandon Shop
void TE_SH_AbandonShop(object oShop)
{
    string sUnique = GetLocalString(oShop,"sUnique");
    SetCampaignString(sDatabase,sShopOwner+sUnique,"");
    //SendMessageToAllDMs(sUnique+" shop abandoned.");
}
//Import Item
void TE_SH_ImportItem(object oItem,object oShop)
{
    string sUnique = GetLocalString(oShop,"sUnique");
    string sTag = GetTag(oItem);
    string sName = GetName(oItem);
    if (GetStringLeft(sTag, 6) != "GS_SH_")
    {
        object oCopy = CopyObject(oItem,
                                  GetLocation(oShop),
                                  oShop,
                                  "GS_SH_" + sTag);

        if (GetIsObjectValid(oCopy))
        {
            SetLocalObject(oCopy, "GS_SH_CONTAINER", oShop);
            DestroyObject(oItem);
        }
    }
    SendMessageToAllDMs(sUnique+" shop imported "+sName+"/"+sTag);
}
//Export Item
void TE_SH_ExportItem(object oItem,object oTarget)
{
    string sTag = GetTag(oItem);
    string sName = GetName(oItem);
    if (GetStringLeft(sTag, 6) == "GS_SH_")
    {
        object oCopy = CopyObject(oItem,
                                  GetLocation(oTarget),
                                  oTarget,
                                  GetStringRight(sTag, GetStringLength(sTag) - 6));

        if (GetIsObjectValid(oCopy))
        {
            DestroyObject(oItem);
        }
    }
    SendMessageToAllDMs("Shop exported "+sName+"/"+sTag);
}
//Set sale price of the shop to nValue
void TE_SH_SetSalePrice(object oShop, int nValue)
{
    string sUnique    = GetLocalString(oShop, "sUnique");

    if (nValue < 1)         nValue = 1;
    else if (nValue > 10)   nValue = 10;

    SetCampaignInt(sDatabase+"_"+sUnique, "SALE_PRICE_" + sUnique, nValue);
    //SendMessageToAllDMs(sUnique+" shop price set to "+IntToString(nValue));
}
//Return sale price of the shop
int TE_SH_GetSalePrice(object oShop)
{
    string sUnique    = GetLocalString(oShop, "sUnique");
    int nValue    = GetCampaignInt(sDatabase+"_"+sUnique, "SALE_PRICE_" + sUnique);

    return nValue <= 0 ? 100 : nValue;
}

//Return Item Value
int TE_SH_GetItemValue(object oItem)
{
    int nValue = GetLocalInt(oItem,"Value");
    int nStack = GetItemStackSize(oItem);

    if(GetBaseItemType(oItem) == BASE_ITEM_ARROW || GetBaseItemType(oItem) == BASE_ITEM_BOLT || GetBaseItemType(oItem) == BASE_ITEM_BULLET)
    {
        nStack = 1;
    }

    if(nValue == 0)
    {
        nValue = NWNX_Item_GetBaseGoldPieceValue(oItem)+NWNX_Item_GetAddGoldPieceValue(oItem);
    }

    if(nValue < 25) {nValue = 25;}

    if(GetTag(oItem) == "GS_SH_te_paper" || GetTag(oItem) == "te_paper")
    {
        nValue = 1000000;
        if(GetName(oItem) == "Blank Paper")
        {
            nValue = 5;
        }
    }

    return nValue*2*nStack;
}

void TE_GoldTransfer(object oPC, string sID, int nGold, string sBank)
{
    if(GetGold(oPC) < nGold){return;}
    if(GetIsObjectValid(oPC) != TRUE){return;}
    string sBankbase = GetName(GetModule());

    TakeGoldFromCreature(nGold,oPC,TRUE);

    int nAccount = GetCampaignInt(sBankbase, DATABASE_GOLD+sID+sBank);
    int nHolding = GetCampaignInt(sBankbase,sBank+"Holding");
    int nCoffers = GetCampaignInt(sBankbase,sBank+"Coffers");
    int nTax     = GetCampaignInt(sBankbase,sBank+"Tax");
    int nAfterTax;
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    int nPiety = GetLocalInt(oItem,"nPiety");

    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC) >= 1 && GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) < 1)
    {
       nAfterTax = (nGold * (10+nTax))/100;
       if(nPiety != 0 && nPiety <= 55 && nGold >= 1000)
       {
            SendMessageToPC(oPC,"Your actions have increased your piety to "+IntToString(nPiety+5)+ " out of 100.");
            SetLocalInt(oItem,"nPiety",nPiety+5);
       }
    }
    else{nAfterTax = (nGold * nTax)/100;}

    int nNewAccount = nAccount+nGold - nAfterTax;
    int nNewHolding = nHolding+nGold;
    int nNewCoffers = nCoffers + nAfterTax;
    SetCampaignInt(sBankbase,DATABASE_GOLD+sID+sBank,nNewAccount);
    SetCampaignInt(sBankbase,sBank+"Holding",nNewHolding);
    SetCampaignInt(sBankbase,sBank+"Coffers",nNewCoffers);

    string sReturn = "**"+GetName(oPC)+"** ("+GetPCPlayerName(oPC)+"/"+GetPCPublicCDKey(oPC)+") made a purchase for "+IntToString(nGold)+" into account "+sID+
    " **Prev Acc Balance:** "+IntToString(nAccount)+" **New Acc Balance:** "+IntToString(nNewAccount)+
    " **Prev Hol Balance:** "+IntToString(nHolding)+" **New Hol Balance:** "+IntToString(nNewHolding)+
    " **Prev Cof Balance:** "+IntToString(nCoffers)+" **New Cof Balance:** "+IntToString(nNewCoffers);
    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL, sReturn, sBank);
}

//Return whether barony insignia is required
int TE_SH_GetInsignia(object oShop)
{
    string sUnique    = GetLocalString(oShop, "sUnique");
    return GetCampaignInt(sDatabase, "INSI_"+sUnique);
}
//Return whether barony insignia is required
void TE_SH_SetInsignia(object oShop,int nReq = FALSE)
{
    string sUnique    = GetLocalString(oShop, "sUnique");
    SetCampaignInt(sDatabase, "INSI_"+sUnique, nReq);
}
//Gets price for renting the stall
int TE_SH_GetRentPrice(object oShop)
{
    string sUnique    = GetLocalString(oShop, "sUnique");
    return GetCampaignInt(sDatabase, "PRICE_"+sUnique);
}
//Sets price for renting the stall
void TE_SH_SetRentPrice(object oShop,int nPrice = 250)
{
    string sUnique    = GetLocalString(oShop, "sUnique");
    SetCampaignInt(sDatabase, "PRICE_"+sUnique, nPrice);
}
