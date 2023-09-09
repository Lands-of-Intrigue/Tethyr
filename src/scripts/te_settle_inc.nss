const string TRADE_FISH             = "te_item_8491";
const string TRADE_ELF              = "te_item_8492";
const string TRADE_GRAIN            = "te_item_8484";
const string TRADE_HEAL             = "te_trd_healsup";
const string TRADE_GARLIC           = "te_garlici";
const string TRADE_ANTIDOTE         = "te_item_9001";
const string TRADE_BLOODSTAUNCH     = "te_bloodstaunchi";
const string TRADE_IRONBAR          = "te_item_0007";
const string TRADE_IRONINGOT        = "te_item_8464";
const string TRADE_IRONORE          = "te_item_8668";
const string TRADE_MAGIC            = "te_item_8489";
const string TRADE_MUSHROOM         = "te_item_8485";
const string TRADE_PEACH            = "te_item_8490";
const string TRADE_BELLADONNA       = "te_belladonnai";
const string TRADE_BLOODPURGE       = "te_bloodpurgei";
const string TRADE_WOLF             = "te_item_9004";
const string TRADE_SILVERBARK       = "te_silverbarki";
const string TRADE_FLOUR            = "te_item_8486";
const string TRADE_CRATESHADEALE    = "te_item_8493";
const string TRADE_SHADEALE         = "te_item_8107";
const string TRADE_SKIN             = "xxx";
const string TRADE_SKINSOFT         = "te_cebcraft020";
const string TRADE_SKINHARD         = "te_cebcraft01";
const string TRADE_SMUGGLE          = "te_item_8488";
const string TRADE_STONE            = "te_item_8487";
const string TRADE_WAGON            = "te_item_8388";
const string TRADE_SUPPLIES         = "te_item_8494";
const float VALUE_FISH                = 50.0f    ;
const float VALUE_ELF                 = 200.0f   ;
const float VALUE_GRAIN               = 15.0f    ;
const float VALUE_HEAL                = 100.0f   ;
const float VALUE_GARLIC              = 50.0f     ;
const float VALUE_ANTIDOTE            = 1000.0f     ;
const float VALUE_BLOODSTAUNCH        = 250.0f     ;
const float VALUE_IRONBAR             = 500.0f   ;
const float VALUE_IRONINGOT           = 500.0f   ;
const float VALUE_IRONORE             = 250.0f    ;
const float VALUE_MAGIC               = 500.0f   ;
const float VALUE_MUSHROOM            = 25.0f    ;
const float VALUE_PEACH               = 45.0f    ;
const float VALUE_BELLADONNA          = 150.0f     ;
const float VALUE_BLOODPURGE          = 250.0f     ;
const float VALUE_WOLF                = 250.0f     ;
const float VALUE_SILVERBARK          = 250.0f     ;
const float VALUE_FLOUR               = 100.0f    ;
const float VALUE_CRATESHADEALE       = 100.0f    ;
const float VALUE_SHADEALE            = 10.0f     ;
const float VALUE_SKIN                = 250.0f    ;
const float VALUE_SKINSOFT            = 300.0f     ;
const float VALUE_SKINHARD            = 300.0f     ;
const float VALUE_SMUGGLE             = 500.0f   ;
const float VALUE_STONE               = 20.0f    ;
const float VALUE_WAGON               = 25.0f     ;
const float VALUE_SUPPLIES            = 100.0f   ;

//oPC == Object you wish to give XP to. Only PCs have multiclassing penalty.
//nXPToGive == Amount of XP Reward. If negative, multiclassing penalty will never be calculated or looked at.
//nMulticlass == TRUE for assessing multiclassing penalty. Default = 0/False.
void GiveTrueXPToCreature(object oPC, int nXPToGive, int nMulticlass);

//Gets how many of the item are produced.
int GetProductionValue(string sSettlement);

//Resets all trade variables.
void ResetTradeVariables(object oPC);

//Gives gold and takes out taxes.
void TurnInTradeGoods(object oPC,string sSettlement,int nGold);

//Sets custom token prices for character delivering trade goods.
void EstablishPrices(object oPC);

//Sets custom token for settlement name.
void SetupSettlementToken(string sSettlement);

//Sets custom token for owner faction name.
void SetupOwnerToken(string sOwner);

//Sets custom token for settlement resource produced.
void SetupResourceToken(string sResource);

//Gets the amount of time between producing resources.
int GetResourceProductionDelay(string sResource);

//Return default float value for trade good.
float GetTradeValue(string sResource);

//Return the name of a settlement
string GetSettlementName(string sSettlement);

//Return the cost for the guild
int CalculateGuildUpkeep(string sGuild);

//Return ownership tag for faction/barony of a settlement
string TE_SS_GetSettlementOwnerTag(string sSettlement);

//return ownership name for faction/barony tag
string TE_SS_GetSettlementOwnerName(string sSettleTag);

//Returns bank for a given settlement location (sOwner)
string TE_SS_GetSettlementBank(string sOwner);

//Return ownership tag for faction/barony of a settlement
string TE_SS_GetSettlementOwnerTag(string sSettlement);

//////////////////////////////////////////
//////////////////////////////////////////

void ResetTradeVariables(object oPC)
{
    SetLocalInt(oPC,TRADE_FISH,0);
    SetLocalInt(oPC,TRADE_ELF,0);
    SetLocalInt(oPC,TRADE_GRAIN,0);
    SetLocalInt(oPC,TRADE_HEAL,0);
    SetLocalInt(oPC,TRADE_GARLIC,0);
    SetLocalInt(oPC,TRADE_ANTIDOTE,0);
    SetLocalInt(oPC,TRADE_BLOODSTAUNCH,0);
    SetLocalInt(oPC,TRADE_IRONBAR,0);
    SetLocalInt(oPC,TRADE_IRONINGOT,0);
    SetLocalInt(oPC,TRADE_IRONORE,0);
    SetLocalInt(oPC,TRADE_MAGIC,0);
    SetLocalInt(oPC,TRADE_MUSHROOM,0);
    SetLocalInt(oPC,TRADE_PEACH,0);
    SetLocalInt(oPC,TRADE_BELLADONNA,0);
    SetLocalInt(oPC,TRADE_BLOODPURGE,0);
    SetLocalInt(oPC,TRADE_WOLF,0);
    SetLocalInt(oPC,TRADE_SILVERBARK,0);
    SetLocalInt(oPC,TRADE_FLOUR,0);
    SetLocalInt(oPC,TRADE_CRATESHADEALE,0);
    SetLocalInt(oPC,TRADE_SHADEALE,0);
    SetLocalInt(oPC,TRADE_SKIN,0);
    SetLocalInt(oPC,TRADE_SKINSOFT,0);
    SetLocalInt(oPC,TRADE_SKINHARD,0);
    SetLocalInt(oPC,TRADE_SMUGGLE,0);
    SetLocalInt(oPC,TRADE_STONE,0);
    SetLocalInt(oPC,TRADE_WAGON,0);
    SetLocalInt(oPC,TRADE_SUPPLIES,0);
}


void TurnInTradeGoods(object oPC,string sSettlement,int nGold)
{
    object oMod     = GetModule();
    string sOwner   = GetCampaignString("Settlement",(sSettlement+"_sOwner"));
    string sTown    = GetCampaignString("Settlement",(sSettlement+"_sBank"));
    string sTownC   = sTown+"Coffers";
    string sTownH   = sTown+"Holding";
    int nTax        = nGold*GetCampaignInt(GetName(GetModule()), sTown + "Tax")/100;
    int nTaxAmount  = (nGold - (nGold / 2) + nTax);
    int nRemain     = (nGold - nTaxAmount);

    SetCampaignInt(GetName(oMod),sTownC,GetCampaignInt(GetName(GetModule()),sTownC)+nRemain);
    SetCampaignInt(GetName(oMod),sTownH,GetCampaignInt(GetName(GetModule()),sTownH)+nRemain);
    GiveGoldToCreature(oPC,nTaxAmount);
}


void EstablishPrices(object oPC)
{
    float fMerchant = 1.0f;
    if(GetHasFeat(1111,oPC) == TRUE)
    {
        fMerchant = 1.75f;
    }

    if(GetLocalInt(oPC,TRADE_FISH) > 1)         {SetCustomToken(7708,IntToString(FloatToInt(VALUE_FISH*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_ELF) > 1)          {SetCustomToken(7709,IntToString(FloatToInt(VALUE_ELF*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_GRAIN) > 1)        {SetCustomToken(7710,IntToString(FloatToInt(VALUE_GRAIN*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_HEAL) > 1)         {SetCustomToken(7711,IntToString(FloatToInt(VALUE_HEAL*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_GARLIC) > 1)       {SetCustomToken(7712,IntToString(FloatToInt(VALUE_GARLIC*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_ANTIDOTE) > 1)     {SetCustomToken(7713,IntToString(FloatToInt(VALUE_ANTIDOTE*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_BLOODSTAUNCH) > 1) {SetCustomToken(7714,IntToString(FloatToInt(VALUE_BLOODSTAUNCH*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_IRONBAR) > 1)      {SetCustomToken(7715,IntToString(FloatToInt(VALUE_IRONBAR*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_IRONINGOT) > 1)    {SetCustomToken(7716,IntToString(FloatToInt(VALUE_IRONINGOT*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_IRONORE) > 1)      {SetCustomToken(7717,IntToString(FloatToInt(VALUE_IRONORE*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_MAGIC) > 1)        {SetCustomToken(7718,IntToString(FloatToInt(VALUE_MAGIC*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_MUSHROOM) > 1)     {SetCustomToken(7719,IntToString(FloatToInt(VALUE_MUSHROOM*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_PEACH) > 1)        {SetCustomToken(7720,IntToString(FloatToInt(VALUE_PEACH*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_BELLADONNA) > 1)   {SetCustomToken(7721,IntToString(FloatToInt(VALUE_BELLADONNA*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_BLOODPURGE) > 1)   {SetCustomToken(7722,IntToString(FloatToInt(VALUE_BLOODPURGE*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_WOLF) > 1)         {SetCustomToken(7723,IntToString(FloatToInt(VALUE_WOLF*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_SILVERBARK) > 1)   {SetCustomToken(7724,IntToString(FloatToInt(VALUE_SILVERBARK*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_FLOUR) > 1)        {SetCustomToken(7725,IntToString(FloatToInt(VALUE_FLOUR*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_CRATESHADEALE) > 1){SetCustomToken(7726,IntToString(FloatToInt(VALUE_CRATESHADEALE*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_SHADEALE) > 1)     {SetCustomToken(7727,IntToString(FloatToInt(VALUE_SHADEALE*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_SKIN) > 1)         {SetCustomToken(7728,IntToString(FloatToInt(VALUE_SKIN*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_SKINSOFT) > 1)     {SetCustomToken(7729,IntToString(FloatToInt(VALUE_SKINSOFT*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_SKINHARD) > 1)     {SetCustomToken(7730,IntToString(FloatToInt(VALUE_SKINHARD*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_SMUGGLE) > 1)      {SetCustomToken(7731,IntToString(FloatToInt(VALUE_SMUGGLE*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_STONE) > 1)        {SetCustomToken(7732,IntToString(FloatToInt(VALUE_STONE*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_WAGON) > 1)        {SetCustomToken(7733,IntToString(FloatToInt(VALUE_WAGON*fMerchant)));}
    if(GetLocalInt(oPC,TRADE_SUPPLIES) > 1)     {SetCustomToken(7734,IntToString(FloatToInt(VALUE_SUPPLIES*fMerchant)));}

}

void SetupResourceToken(string sResource)
{
if(sResource == TRADE_FISH){SetCustomToken(8052,"Barrel of Fish");}
else if(sResource == TRADE_ELF){SetCustomToken(8052,"Elven Goods");}
else if(sResource == TRADE_GRAIN){SetCustomToken(8052,"Sack of Grain");}
else if(sResource == TRADE_HEAL){SetCustomToken(8052,"Healing Supplies");}
else if(sResource == TRADE_GARLIC){SetCustomToken(8052,"Garlic");}
else if(sResource == TRADE_ANTIDOTE){SetCustomToken(8052,"Antidote");}
else if(sResource == TRADE_BLOODSTAUNCH){SetCustomToken(8052,"Bloodstaunch");}
else if(sResource == TRADE_IRONBAR){SetCustomToken(8052,"Bar of Iron");}
else if(sResource == TRADE_IRONINGOT){SetCustomToken(8052,"Iron Ingot");}
else if(sResource == TRADE_IRONORE){SetCustomToken(8052,"Iron Ore");}
else if(sResource == TRADE_MAGIC){SetCustomToken(8052,"Magical Supplies");}
else if(sResource == TRADE_MUSHROOM){SetCustomToken(8052,"Large Mushroom");}
else if(sResource == TRADE_PEACH){SetCustomToken(8052,"Crate of Peaches");}
else if(sResource == TRADE_BELLADONNA){SetCustomToken(8052,"Belladonna");}
else if(sResource == TRADE_BLOODPURGE){SetCustomToken(8052,"Bloodpurge");}
else if(sResource == TRADE_WOLF){SetCustomToken(8052,"Wolvesbane");}
else if(sResource == TRADE_SILVERBARK){SetCustomToken(8052,"Silverbark Sap");}
else if(sResource == TRADE_FLOUR){SetCustomToken(8052,"Sack of Flour");}
else if(sResource == TRADE_CRATESHADEALE){SetCustomToken(8052,"Crate of Shade Ale");}
else if(sResource == TRADE_SHADEALE){SetCustomToken(8052,"Tethir Shade Ale");}
else if(sResource == TRADE_SKIN){SetCustomToken(8052,"Bundle of Skins");}
else if(sResource == TRADE_SKINSOFT){SetCustomToken(8052,"Hide, Soft");}
else if(sResource == TRADE_SKINHARD){SetCustomToken(8052,"Hide, Tough");}
else if(sResource == TRADE_SMUGGLE){SetCustomToken(8052,"Smuggled Goods");}
else if(sResource == TRADE_STONE){SetCustomToken(8052,"Rough Block of Stone");}
else if(sResource == TRADE_WAGON){SetCustomToken(8052,"Wagon Wheel");}
else if(sResource == TRADE_SUPPLIES){SetCustomToken(8052,"Box of Supplies");}
else if(sResource == ""){SetCustomToken(8052,"Nothing");}
}

void SetupOwnerToken(string sOwner)
{
    SetCustomToken(8046, TE_SS_GetSettlementOwnerName(sOwner));
}

void SetupSettlementToken(string sSettlement)
{
 // Set name of Settlement.
    if(sSettlement == "sLock")
    {
        SetCustomToken(8045,"Lockwood Falls");
    }
    else if(sSettlement == "sTejarn")
    {
        SetCustomToken(8045,"Tejarn Gate");
    }
    else if(sSettlement == "sSpire")
    {
        SetCustomToken(8045,"South Spire");
    }
    else if(sSettlement == "sSwamp")
    {
        SetCustomToken(8045,"Swamprise");
    }
    else if(sSettlement == "sBrost")
    {
        SetCustomToken(8045,"Brost Village");
    }
    else if(sSettlement == "sFort1")
    {
        SetCustomToken(8045,"East Gate Compound");
    }
    else if(sSettlement == "sFort2")
    {
        SetCustomToken(8045,"North Gate Keep");
    }
    else if(sSettlement == "sFort3")
    {
        SetCustomToken(8045,"Fort Noromath");
    }
    else if(sSettlement == "sFort4")
    {
        SetCustomToken(8045,"Southwatch Fortress");
    }
    else if(sSettlement == "sFort5")
    {
        SetCustomToken(8045,"Amnian Overlook");
    }
    else if(sSettlement == "sFort6")
    {
        SetCustomToken(8045,"West Haven");
    }
    else if(sSettlement == "sFort7")
    {
        SetCustomToken(8045,"Tejarn Tower");
    }
    else if(sSettlement == "sHamlet1")
    {
        SetCustomToken(8045,"Watchfield");
    }
    else if(sSettlement == "sHamlet2")
    {
        SetCustomToken(8045,"Lockwood Hamlet");
    }
    else if(sSettlement == "sHamlet3")
    {
        SetCustomToken(8045,"Suoress Hamlet");
    }
    else if(sSettlement == "sHamlet4")
    {
        SetCustomToken(8045,"Fort Briarwood");
    }
    else if(sSettlement == "sHamlet5")
    {
        SetCustomToken(8045,"Sentinel Manor");
    }
    else if(sSettlement == "sHamlet6")
    {
        SetCustomToken(8045,"Wayside Shrine");
    }
    else if(sSettlement == "sGuild1")
    {
        SetCustomToken(8045,"Lockwood Mines");
    }
    else if(sSettlement == "sGuild2")
    {
        SetCustomToken(8045,"South Brost Quarry");
    }
    else if(sSettlement == "sGuild3")
    {
        SetCustomToken(8045,"Abandoned Mines");
    }
    else if(sSettlement == "sGuild4")
    {
        SetCustomToken(8045,"Mushroom Farm");
    }
    else if(sSettlement == "sGuild5")
    {
        SetCustomToken(8045,"Ieval's Plantation");
    }
    else if(sSettlement == "sGuild6")
    {
        SetCustomToken(8045,"Oakbarrel Brewery");
    }
    else if(sSettlement == "sGuild7")
    {
        SetCustomToken(8045,"Hunter's Lodges");
    }
    else if(sSettlement == "sGuild8")
    {
        SetCustomToken(8045,"Teranthvar");
    }
    else if(sSettlement == "sGuild9")
    {
        SetCustomToken(8045,"Mystran Tower");
    }
    else if(sSettlement == "sGuild10")
    {
        SetCustomToken(8045,"Smuggler's Den");
    }
    else if(sSettlement == "sGuild11")
    {
        SetCustomToken(8045,"Hospice of Ilmater");
    }
    else if(sSettlement == "sGuild12")
    {
        SetCustomToken(8045,"Eliora's Perch");
    }
    else if(sSettlement == "sGuild13")
    {
        SetCustomToken(8045,"Mystran Hideaway");
    }
}

int GetResourceProductionDelay(string sResource)
{
    if(sResource == TRADE_FISH)
    {
        return 1;
    }
    else if(sResource == TRADE_ELF)
    {
        return 10;
    }
    else if(sResource == TRADE_GRAIN)
    {
        return 1;
    }
    else if(sResource == TRADE_HEAL)
    {
        return 1;
    }
    else if(sResource == TRADE_IRONORE)
    {
        return 1;
    }
    else if(sResource == TRADE_MAGIC)
    {
        return 10;
    }
    else if(sResource == TRADE_PEACH)
    {
        return 1;
    }
    else if(sResource == TRADE_FLOUR)
    {
        return 1;
    }
    else if(sResource == TRADE_CRATESHADEALE)
    {
        return 10;
    }
    else if(sResource == TRADE_SKIN)
    {
        return 10;
    }
    else if(sResource == TRADE_SMUGGLE)
    {
        return 10;
    }
    else if(sResource == TRADE_STONE)
    {
        return 1;
    }
    else if(sResource == TRADE_WAGON)
    {
        return 1;
    }
    else if(sResource == TRADE_SUPPLIES)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}


float GetTradeValue(string sResource)
{
    if(sResource == TRADE_FISH){return VALUE_FISH;}
    if(sResource == TRADE_ELF){return VALUE_ELF;}
    if(sResource == TRADE_GRAIN){return VALUE_GRAIN;}
    if(sResource == TRADE_HEAL){return VALUE_HEAL;}
    if(sResource == TRADE_GARLIC){return VALUE_GARLIC;}
    if(sResource == TRADE_ANTIDOTE){return VALUE_ANTIDOTE;}
    if(sResource == TRADE_BLOODSTAUNCH){return VALUE_BLOODSTAUNCH;}
    if(sResource == TRADE_IRONBAR){return VALUE_IRONBAR;}
    if(sResource == TRADE_IRONINGOT){return VALUE_IRONINGOT;}
    if(sResource == TRADE_IRONORE){return VALUE_IRONORE;}
    if(sResource == TRADE_MAGIC){return VALUE_MAGIC;}
    if(sResource == TRADE_MUSHROOM){return VALUE_MUSHROOM;}
    if(sResource == TRADE_PEACH){return VALUE_PEACH;}
    if(sResource == TRADE_BELLADONNA){return VALUE_BELLADONNA;}
    if(sResource == TRADE_BLOODPURGE){return VALUE_BLOODPURGE;}
    if(sResource == TRADE_WOLF){return VALUE_WOLF;}
    if(sResource == TRADE_SILVERBARK){return VALUE_SILVERBARK;}
    if(sResource == TRADE_FLOUR){return VALUE_FLOUR;}
    if(sResource == TRADE_CRATESHADEALE){return VALUE_CRATESHADEALE;}
    if(sResource == TRADE_SHADEALE){return VALUE_SHADEALE;}
    if(sResource == TRADE_SKIN){return VALUE_SKIN;}
    if(sResource == TRADE_SKINSOFT){return VALUE_SKINSOFT;}
    if(sResource == TRADE_SKINHARD){return VALUE_SKINHARD;}
    if(sResource == TRADE_SMUGGLE){return VALUE_SMUGGLE;}
    if(sResource == TRADE_STONE){return VALUE_STONE;}
    if(sResource == TRADE_WAGON){return VALUE_WAGON;}
    if(sResource == TRADE_SUPPLIES){return VALUE_SUPPLIES;}
    else {return 0.0f;}
}



void SetupResources(string sSettlement)
{
    string sSettlement = "sHamlet1"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_GRAIN);
    sSettlement = "sHamlet2"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_GRAIN);
    sSettlement = "sHamlet3"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_GRAIN);
    sSettlement = "sHamlet4"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_GRAIN);
    sSettlement = "sHamlet5"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_GRAIN);
    sSettlement = "sHamlet6"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_GRAIN);
    sSettlement = "sGuild1"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_IRONORE);
    sSettlement = "sGuild2"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_STONE);
    sSettlement = "sGuild3"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_IRONORE);
    sSettlement = "sGuild4"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_MUSHROOM);
    sSettlement = "sGuild5"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_PEACH);
    sSettlement = "sGuild6"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_CRATESHADEALE);
    sSettlement = "sGuild7"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_SKIN);
    sSettlement = "sGuild8"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_ELF);
    sSettlement = "sGuild9"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_MAGIC);
    sSettlement = "sGuild10"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_SMUGGLE);
    sSettlement = "sGuild11"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_HEAL);
    sSettlement = "sGuild12"; SetCampaignString("Settlement",(sSettlement+"_sResource"),TRADE_HEAL);
}

int GetProductionValue(string sSettlement)
{
    string sResource = GetCampaignString("Settlement",(sSettlement+"_sResource"));

    if(sResource == TRADE_GRAIN && (GetCalendarMonth() == 10 || GetCalendarMonth() == 11 || GetCalendarMonth() == 9))
    {
        return 4;
    }

    return 1;
}

void UpdateOwnership(string sSettlement, string sOwner)
{
    if(sSettlement == "sSwamp")
    {
        SetCampaignString("Housing","SW01Ownr",sOwner);
        SetCampaignString("Housing","SW02Ownr",sOwner);
        SetCampaignString("Housing","SW03Ownr",sOwner);
        SetCampaignString("Housing","SW04Ownr",sOwner);
        SetCampaignString("Housing","SW05Ownr",sOwner);
        SetCampaignString("Housing","SW06Ownr",sOwner);
        SetCampaignString("Housing","SW07Ownr",sOwner);
        SetCampaignString("Housing","SW08Ownr",sOwner);
        SetCampaignString("Housing","SW09Ownr",sOwner);
        SetCampaignString("Housing","SW10Ownr",sOwner);
        SetCampaignString("Housing","SW11Ownr",sOwner);
        SetCampaignString("Housing","SW12Ownr",sOwner);
        SetCampaignString("Housing","SW13Ownr",sOwner);
        SetCampaignString("Housing","SW14Ownr",sOwner);
        SetCampaignString("Housing","SW15Ownr",sOwner);
        SetCampaignString("Housing","SW16Ownr",sOwner);
        SetCampaignString("Housing","SW17Ownr",sOwner);
        SetCampaignString("Housing","SW18Ownr",sOwner);
        SetCampaignString("Housing","SW19Ownr",sOwner);
        SetCampaignString("Housing","SW20Ownr",sOwner);
        SetCampaignString("Housing","SW21Ownr",sOwner);
        SetCampaignString("Housing","SW22Ownr",sOwner);
        SetCampaignString("Housing","SW23Ownr",sOwner);
        SetCampaignString("Housing","SW24Ownr",sOwner);
        SetCampaignString("Housing","SW25Ownr",sOwner);
        SetCampaignString("Housing","SW26Ownr",sOwner);
        SetCampaignString("Housing","SW27Ownr",sOwner);
        SetCampaignString("Housing","SW28Ownr",sOwner);
    }
}

string GetSettlementName(string sSettlement)
{
 // Set name of Settlement.
    if(sSettlement == "sLock")
    {
        return "Lockwood Falls";
    }
    else if(sSettlement == "sTejarn")
    {
        return "Tejarn Gate";
    }
    else if(sSettlement == "sSpire")
    {
        return "South Spire";
    }
    else if(sSettlement == "sSwamp")
    {
        return "Swamprise";
    }
    else if(sSettlement == "sBrost")
    {
        return "Brost Village";
    }
    else if(sSettlement == "sFort1")
    {
        return "East Gate Compound";
    }
    else if(sSettlement == "sFort2")
    {
        return "North Gate Keep";
    }
    else if(sSettlement == "sFort3")
    {
        return "Fort Noromath";
    }
    else if(sSettlement == "sFort4")
    {
        return "Southwatch Fortress";
    }
    else if(sSettlement == "sFort5")
    {
        return "Amnian Overlook";
    }
    else if(sSettlement == "sFort6")
    {
        return "West Haven";
    }
    else if(sSettlement == "sFort7")
    {
        return "Tejarn Tower";
    }
    else if(sSettlement == "sHamlet1")
    {
        return "Watchfield";
    }
    else if(sSettlement == "sHamlet2")
    {
        return "Lockwood Hamlet";
    }
    else if(sSettlement == "sHamlet3")
    {
        return "Suoress Hamlet";
    }
    else if(sSettlement == "sHamlet4")
    {
        return "Fort Briarwood";
    }
    else if(sSettlement == "sHamlet5")
    {
        return "Sentinel Manor";
    }
    else if(sSettlement == "sHamlet6")
    {
        return "Wayside Shrine";
    }
    else if(sSettlement == "sGuild1")
    {
        return "Lockwood Mines";
    }
    else if(sSettlement == "sGuild2")
    {
        return "South Brost Quarry";
    }
    else if(sSettlement == "sGuild3")
    {
        return "Abandoned Mines";
    }
    else if(sSettlement == "sGuild4")
    {
        return "Mushroom Farm";
    }
    else if(sSettlement == "sGuild5")
    {
        return "Ieval's Plantation";
    }
    else if(sSettlement == "sGuild6")
    {
        return "Oakbarrel Brewery";
    }
    else if(sSettlement == "sGuild7")
    {
        return "Hunter's Lodges";
    }
    else if(sSettlement == "sGuild8")
    {
        return "Teranthvar";
    }
    else if(sSettlement == "sGuild9")
    {
        return "Mystran Tower";
    }
    else if(sSettlement == "sGuild10")
    {
        return "Smuggler's Den";
    }
    else if(sSettlement == "sGuild11")
    {
        return "Hospice of Ilmater";
    }
    else if(sSettlement == "sGuild12")
    {
        return "Eliora's Perch";
    }
    else
    {
        return "";
    }

}

//oPC == Object you wish to give XP to. Only PCs have multiclassing penalty.
//nXPToGive == Amount of XP Reward. If negative, multiclassing penalty will never be calculated or looked at.
//nMulticlass == TRUE for assessing multiclassing penalty. Default = 0/False.
void GiveTrueXPToCreature(object oPC, int nXPToGive, int nMulticlass)
{
    if(nXPToGive < 0)
    {
        SetXP(oPC,GetXP(oPC)+(nXPToGive));
    }
    else
    {
        if(nMulticlass == TRUE)
        {
            object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
            if(GetLocalInt(oItem,"iMulticlass") == TRUE)
            {
                nXPToGive = (nXPToGive - FloatToInt(IntToFloat(nXPToGive)*0.20));
                SetXP(oPC,GetXP(oPC)+nXPToGive);
            }
            else
            {
                SetXP(oPC,GetXP(oPC)+(nXPToGive));
            }
        }
        else
        {
            SetXP(oPC,GetXP(oPC)+(nXPToGive));
        }
    }
}

//Return ownership tag for faction/barony of a settlement
string TE_SS_GetSettlementOwnerTag(string sSettlement)
{
    return GetCampaignString("Settlement",sSettlement+"_sOwner");
}

//Returns bank for a given settlement location (sOwner)
string TE_SS_GetSettlementBank(string sOwner)
{
    return GetCampaignString("Settlement",sOwner+"_sBank");
}

//return ownership name for faction/barony tag
string TE_SS_GetSettlementOwnerName(string sSettlement)
{
    string sOwner = TE_SS_GetSettlementOwnerTag(sSettlement);

    if(sOwner == "sLock")
    {
        return "Barony of Lockwood Falls";
    }
    else if(sOwner == "sTejarn")
    {
        return "Barony of Tejarn Gate";
    }
    else if(sOwner == "sSpire")
    {
        return "Barony of Southspire Hold";
    }
    else if(sOwner == "sSwamp")
    {
        return "Barony of Swamprise Keep";
    }
    else if(sOwner == "sBrost")
    {
        return "Mayorship of Brost";
    }
    else if(sOwner == "sAbandon"|| sOwner == "")
    {
        return "no one";
    }
    else if(sOwner == "sMerc1")
    {
        return "Golden Lion Keep";
    }
    else if(sOwner == "sMerc2")
    {
        return "Independent Control";
    }
    else if(sOwner == "sMerc3")
    {
        return "Independent Control";
    }
    else if(sOwner == "sElf")
    {
        return "Duchy of Noromath";
    }
    else if(sOwner == "sOutlaw1")
    {
        return "Lockwood Knives";
    }
    else if(sOwner == "sOutlaw2")
    {
        return "Brost Bandits";
    }
    else if(sOwner == "sUndead")
    {
        return "New Shoonite Imperium";
    }

    return "no one";
}


