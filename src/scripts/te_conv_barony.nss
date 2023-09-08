void main()
{
    object oSettlement = OBJECT_SELF;
    string sSettlement = GetLocalString(oSettlement,"sSettlement");
    string sOwner = GetCampaignString("Settlement",(sSettlement+"_sOwner"));

    string sSettle = "";

    int nUpkeep,nPeasant,nSoldier,nKnight;

    //Main Fortresses
    sSettle = "sBrost";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","BR01Base");
        nUpkeep += GetCampaignInt("Housing","BR02Base");
        nUpkeep += GetCampaignInt("Housing","BR03Base");
        nUpkeep += GetCampaignInt("Housing","BR04Base");
        nUpkeep += GetCampaignInt("Housing","BR05Base");
        nUpkeep += GetCampaignInt("Housing","BR06Base");
        nUpkeep += GetCampaignInt("Housing","BR07Base");
        nUpkeep += GetCampaignInt("Housing","BR08Base");
        nUpkeep += GetCampaignInt("Housing","BR09Base");
        nUpkeep += GetCampaignInt("Housing","BR10Base");
        nUpkeep += GetCampaignInt("Housing","BR11Base");
        nUpkeep += GetCampaignInt("Housing","BR12Base");
        nUpkeep += GetCampaignInt("Housing","BR13Base");
        nUpkeep += GetCampaignInt("Housing","BR14Base");
        nUpkeep += GetCampaignInt("Housing","BR15Base");
        nUpkeep += GetCampaignInt("Housing","BR16Base");
        nUpkeep += GetCampaignInt("Housing","BR17Base");
        nUpkeep += GetCampaignInt("Housing","BR18Base");
        nUpkeep += GetCampaignInt("Housing","BR19Base");
        nUpkeep += GetCampaignInt("Housing","BR20Base");
        nUpkeep += GetCampaignInt("Housing","BR21Base");
        nUpkeep += GetCampaignInt("Housing","BR22Base");
    }
    sSettle = "sLock";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","LW01Base");
        nUpkeep += GetCampaignInt("Housing","LW02Base");
        nUpkeep += GetCampaignInt("Housing","LW03Base");
        nUpkeep += GetCampaignInt("Housing","LW04Base");
        nUpkeep += GetCampaignInt("Housing","LW05Base");
        nUpkeep += GetCampaignInt("Housing","LW06Base");
        nUpkeep += GetCampaignInt("Housing","LW07Base");
        nUpkeep += GetCampaignInt("Housing","LW08Base");
        nUpkeep += GetCampaignInt("Housing","LW09Base");
        nUpkeep += GetCampaignInt("Housing","LW10Base");
        nUpkeep += GetCampaignInt("Housing","LW11Base");
        nUpkeep += GetCampaignInt("Housing","LW12Base");
        nUpkeep += GetCampaignInt("Housing","LW13Base");
        nUpkeep += GetCampaignInt("Housing","LW14Base");
        nUpkeep += GetCampaignInt("Housing","LW15Base");
        nUpkeep += GetCampaignInt("Housing","LW16Base");
        nUpkeep += GetCampaignInt("Housing","LW17Base");
        nUpkeep += GetCampaignInt("Housing","LW18Base");
        nUpkeep += GetCampaignInt("Housing","LW19Base");
        nUpkeep += GetCampaignInt("Housing","LW20Base");
        nUpkeep += GetCampaignInt("Housing","LW21Base");
        nUpkeep += GetCampaignInt("Housing","LW22Base");
        nUpkeep += GetCampaignInt("Housing","LW23Base");
        nUpkeep += GetCampaignInt("Housing","LW24Base");
        nUpkeep += GetCampaignInt("Housing","LW25Base");
        nUpkeep += GetCampaignInt("Housing","LW26Base");
        nUpkeep += GetCampaignInt("Housing","LW27Base");
        nUpkeep += GetCampaignInt("Housing","LW28Base");
        nUpkeep += GetCampaignInt("Housing","LW29Base");
        nUpkeep += GetCampaignInt("Housing","LW30Base");
        nUpkeep += GetCampaignInt("Housing","LW31Base");
        nUpkeep += GetCampaignInt("Housing","LW32Base");
        nUpkeep += GetCampaignInt("Housing","LW33Base");
        nUpkeep += GetCampaignInt("Housing","LW34Base");
        nUpkeep += GetCampaignInt("Housing","LW35Base");
        nUpkeep += GetCampaignInt("Housing","LW36Base");
        nUpkeep += GetCampaignInt("Housing","LW37Base");
        nUpkeep += GetCampaignInt("Housing","LW38Base");
        nUpkeep += GetCampaignInt("Housing","LW39Base");
        nUpkeep += GetCampaignInt("Housing","LW40Base");
        nUpkeep += GetCampaignInt("Housing","LW41Base");
        nUpkeep += GetCampaignInt("Housing","LW42Base");
        nUpkeep += GetCampaignInt("Housing","LW43Base");
        nUpkeep += GetCampaignInt("Housing","LW44Base");
        nUpkeep += GetCampaignInt("Housing","LW45Base");
        nUpkeep += GetCampaignInt("Housing","LW46Base");
        nUpkeep += GetCampaignInt("Housing","LW47Base");
        nUpkeep += GetCampaignInt("Housing","LW48Base");
        nUpkeep += GetCampaignInt("Housing","LW49Base");
        nUpkeep += GetCampaignInt("Housing","LW50Base");
        nUpkeep += GetCampaignInt("Housing","LW51Base");
        nUpkeep += GetCampaignInt("Housing","LW52Base");
        nUpkeep += GetCampaignInt("Housing","LW53Base");
        nUpkeep += GetCampaignInt("Housing","LW54Base");
        nUpkeep += GetCampaignInt("Housing","LW55Base");
        nUpkeep += GetCampaignInt("Housing","LW56Base");
        nUpkeep += GetCampaignInt("Housing","LW57Base");
        nUpkeep += GetCampaignInt("Housing","LW58Base");
        nUpkeep += GetCampaignInt("Housing","LW59Base");
        nUpkeep += GetCampaignInt("Housing","LW60Base");
    }
    sSettle = "sTejarn";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","TG01Base");
        nUpkeep += GetCampaignInt("Housing","TG02Base");
        nUpkeep += GetCampaignInt("Housing","TG03Base");
        nUpkeep += GetCampaignInt("Housing","TG04Base");
        nUpkeep += GetCampaignInt("Housing","TG05Base");
        nUpkeep += GetCampaignInt("Housing","TG06Base");
        nUpkeep += GetCampaignInt("Housing","TG07Base");
        nUpkeep += GetCampaignInt("Housing","TG08Base");
        nUpkeep += GetCampaignInt("Housing","TG09Base");
        nUpkeep += GetCampaignInt("Housing","TG10Base");
        nUpkeep += GetCampaignInt("Housing","TG11Base");
    }
    sSettle = "sSpire";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","SS01Base");
        nUpkeep += GetCampaignInt("Housing","SS02Base");
        nUpkeep += GetCampaignInt("Housing","SS03Base");
        nUpkeep += GetCampaignInt("Housing","SS04Base");
        nUpkeep += GetCampaignInt("Housing","SS05Base");
        nUpkeep += GetCampaignInt("Housing","SS06Base");
        nUpkeep += GetCampaignInt("Housing","SS07Base");
        nUpkeep += GetCampaignInt("Housing","SS08Base");
        nUpkeep += GetCampaignInt("Housing","SS09Base");
        nUpkeep += GetCampaignInt("Housing","SS10Base");
        nUpkeep += GetCampaignInt("Housing","SS11Base");
        nUpkeep += GetCampaignInt("Housing","SS12Base");
        nUpkeep += GetCampaignInt("Housing","SS13Base");
        nUpkeep += GetCampaignInt("Housing","SS14Base");
        nUpkeep += GetCampaignInt("Housing","SS15Base");
        nUpkeep += GetCampaignInt("Housing","SS16Base");
        nUpkeep += GetCampaignInt("Housing","SS17Base");
        nUpkeep += GetCampaignInt("Housing","SS18Base");
        nUpkeep += GetCampaignInt("Housing","SS19Base");
        nUpkeep += GetCampaignInt("Housing","SS20Base");
        nUpkeep += GetCampaignInt("Housing","SS21Base");
        nUpkeep += GetCampaignInt("Housing","SS22Base");
        nUpkeep += GetCampaignInt("Housing","SS23Base");
        nUpkeep += GetCampaignInt("Housing","SS24Base");
        nUpkeep += GetCampaignInt("Housing","SS25Base");
        nUpkeep += GetCampaignInt("Housing","SS26Base");
        nUpkeep += GetCampaignInt("Housing","SS27Base");
        nUpkeep += GetCampaignInt("Housing","SS28Base");
        nUpkeep += GetCampaignInt("Housing","SS29Base");
        nUpkeep += GetCampaignInt("Housing","SS30Base");
        nUpkeep += GetCampaignInt("Housing","SS31Base");
        nUpkeep += GetCampaignInt("Housing","SS32Base");
        nUpkeep += GetCampaignInt("Housing","SS33Base");
        nUpkeep += GetCampaignInt("Housing","SS34Base");
        nUpkeep += GetCampaignInt("Housing","SS35Base");
        nUpkeep += GetCampaignInt("Housing","SS36Base");
        nUpkeep += GetCampaignInt("Housing","SS37Base");
        nUpkeep += GetCampaignInt("Housing","SS38Base");
        nUpkeep += GetCampaignInt("Housing","SS39Base");
        nUpkeep += GetCampaignInt("Housing","SS40Base");
        nUpkeep += GetCampaignInt("Housing","SS41Base");
        nUpkeep += GetCampaignInt("Housing","SS42Base");
        nUpkeep += GetCampaignInt("Housing","SS43Base");
    }
    sSettle = "sSwamp";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","SW01Base");
        nUpkeep += GetCampaignInt("Housing","SW02Base");
        nUpkeep += GetCampaignInt("Housing","SW03Base");
        nUpkeep += GetCampaignInt("Housing","SW04Base");
        nUpkeep += GetCampaignInt("Housing","SW05Base");
        nUpkeep += GetCampaignInt("Housing","SW06Base");
        nUpkeep += GetCampaignInt("Housing","SW07Base");
        nUpkeep += GetCampaignInt("Housing","SW08Base");
        nUpkeep += GetCampaignInt("Housing","SW09Base");
        nUpkeep += GetCampaignInt("Housing","SW10Base");
        nUpkeep += GetCampaignInt("Housing","SW11Base");
        nUpkeep += GetCampaignInt("Housing","SW12Base");
        nUpkeep += GetCampaignInt("Housing","SW13Base");
        nUpkeep += GetCampaignInt("Housing","SW14Base");
        nUpkeep += GetCampaignInt("Housing","SW15Base");
        nUpkeep += GetCampaignInt("Housing","SW16Base");
        nUpkeep += GetCampaignInt("Housing","SW17Base");
        nUpkeep += GetCampaignInt("Housing","SW18Base");
        nUpkeep += GetCampaignInt("Housing","SW19Base");
        nUpkeep += GetCampaignInt("Housing","SW20Base");
        nUpkeep += GetCampaignInt("Housing","SW21Base");
        nUpkeep += GetCampaignInt("Housing","SW22Base");
        nUpkeep += GetCampaignInt("Housing","SW23Base");
        nUpkeep += GetCampaignInt("Housing","SW24Base");
        nUpkeep += GetCampaignInt("Housing","SW25Base");
        nUpkeep += GetCampaignInt("Housing","SW26Base");
        nUpkeep += GetCampaignInt("Housing","SW27Base");
        nUpkeep += GetCampaignInt("Housing","SW28Base");
        nUpkeep += GetCampaignInt("Housing","SW29Base");
        nUpkeep += GetCampaignInt("Housing","SW30Base");
        nUpkeep += GetCampaignInt("Housing","SW31Base");
        nUpkeep += GetCampaignInt("Housing","SW32Base");
        nUpkeep += GetCampaignInt("Housing","SW33Base");
    }

//Test Ownerships -- Fortresses
    sSettle = "sFort1";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sFort2";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","NG01Base");
        nUpkeep += GetCampaignInt("Housing","NG02Base");
        nUpkeep += GetCampaignInt("Housing","NG03Base");
        nUpkeep += GetCampaignInt("Housing","NG04Base");
        nUpkeep += GetCampaignInt("Housing","NG05Base");
        nUpkeep += GetCampaignInt("Housing","NG06Base");
        nUpkeep += GetCampaignInt("Housing","NG07Base");
        nUpkeep += GetCampaignInt("Housing","NG08Base");
        nUpkeep += GetCampaignInt("Housing","NG09Base");
        nUpkeep += GetCampaignInt("Housing","NG10Base");
        nUpkeep += GetCampaignInt("Housing","NG11Base");
        nUpkeep += GetCampaignInt("Housing","NG12Base");
        nUpkeep += GetCampaignInt("Housing","NG13Base");
        nUpkeep += GetCampaignInt("Housing","NG14Base");
        nUpkeep += GetCampaignInt("Housing","NG15Base");
    }
    sSettle = "sFort3";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sFort4";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sFort5";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sFort6";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","WH01Base");
        nUpkeep += GetCampaignInt("Housing","WH02Base");
        nUpkeep += GetCampaignInt("Housing","WH03Base");
        nUpkeep += GetCampaignInt("Housing","WH04Base");
        nUpkeep += GetCampaignInt("Housing","WH05Base");
        nUpkeep += GetCampaignInt("Housing","WH06Base");
        nUpkeep += GetCampaignInt("Housing","WH07Base");
        nUpkeep += GetCampaignInt("Housing","WH08Base");
        nUpkeep += GetCampaignInt("Housing","WH09Base");
        nUpkeep += GetCampaignInt("Housing","WH10Base");
        nUpkeep += GetCampaignInt("Housing","WH11Base");
        nUpkeep += GetCampaignInt("Housing","WH12Base");
        nUpkeep += GetCampaignInt("Housing","WH13Base");
        nUpkeep += GetCampaignInt("Housing","WH14Base");
        nUpkeep += GetCampaignInt("Housing","WH15Base");
        nUpkeep += GetCampaignInt("Housing","WH16Base");
        nUpkeep += GetCampaignInt("Housing","WH17Base");
        nUpkeep += GetCampaignInt("Housing","WH18Base");

    }
    sSettle = "sFort7";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","TT01Base");
        nUpkeep += GetCampaignInt("Housing","TT02Base");
        nUpkeep += GetCampaignInt("Housing","TT03Base");
        nUpkeep += GetCampaignInt("Housing","TT04Base");
        nUpkeep += GetCampaignInt("Housing","TT05Base");
        nUpkeep += GetCampaignInt("Housing","TT06Base");
        nUpkeep += GetCampaignInt("Housing","TT07Base");
        nUpkeep += GetCampaignInt("Housing","TT08Base");
        nUpkeep += GetCampaignInt("Housing","TT09Base");
        nUpkeep += GetCampaignInt("Housing","TT10Base");
    }

    //Test - Hamlet
    sSettle = "sHamlet1";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sHamlet2";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","LM01Base");
        nUpkeep += GetCampaignInt("Housing","LM02Base");
        nUpkeep += GetCampaignInt("Housing","LM03Base");
        nUpkeep += GetCampaignInt("Housing","LM04Base");
        nUpkeep += GetCampaignInt("Housing","LM05Base");
        nUpkeep += GetCampaignInt("Housing","LM06Base");
        nUpkeep += GetCampaignInt("Housing","LM07Base");
        nUpkeep += GetCampaignInt("Housing","LM08Base");
        nUpkeep += GetCampaignInt("Housing","LM10Base");
        nUpkeep += GetCampaignInt("Housing","LM11Base");
    }
    sSettle = "sHamlet3";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sHamlet4";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","BW01Base");
        nUpkeep += GetCampaignInt("Housing","BW02Base");
        nUpkeep += GetCampaignInt("Housing","BW03Base");
        nUpkeep += GetCampaignInt("Housing","BW04Base");
        nUpkeep += GetCampaignInt("Housing","BW05Base");
        nUpkeep += GetCampaignInt("Housing","BW06Base");
        nUpkeep += GetCampaignInt("Housing","BW07Base");
        nUpkeep += GetCampaignInt("Housing","BW08Base");
        nUpkeep += GetCampaignInt("Housing","BW09Base");
        nUpkeep += GetCampaignInt("Housing","BW10Base");
        nUpkeep += GetCampaignInt("Housing","BW11Base");
        nUpkeep += GetCampaignInt("Housing","BW12Base");
        nUpkeep += GetCampaignInt("Housing","BW13Base");
        nUpkeep += GetCampaignInt("Housing","BW14Base");
        nUpkeep += GetCampaignInt("Housing","BW15Base");
        nUpkeep += GetCampaignInt("Housing","BW16Base");
        nUpkeep += GetCampaignInt("Housing","BW17Base");
    }
    sSettle = "sHamlet5";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sHamlet6";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }

    //Test series - Guildhouses
    sSettle = "sGuild1";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sGuild2";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sGuild3";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","AM01Base");
        nUpkeep += GetCampaignInt("Housing","AM02Base");
        nUpkeep += GetCampaignInt("Housing","AM03Base");
        nUpkeep += GetCampaignInt("Housing","AM04Base");
        nUpkeep += GetCampaignInt("Housing","AM05Base");
        nUpkeep += GetCampaignInt("Housing","AM06Base");
    }
    sSettle = "sGuild4";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sGuild5";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sGuild6";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sGuild7";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sGuild8";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","EH01Base");
        nUpkeep += GetCampaignInt("Housing","EH02Base");
        nUpkeep += GetCampaignInt("Housing","EH03Base");
        nUpkeep += GetCampaignInt("Housing","EH04Base");
        nUpkeep += GetCampaignInt("Housing","EH05Base");
        nUpkeep += GetCampaignInt("Housing","EH06Base");
        nUpkeep += GetCampaignInt("Housing","EH07Base");
        nUpkeep += GetCampaignInt("Housing","EH08Base");
        nUpkeep += GetCampaignInt("Housing","EH09Base");
        nUpkeep += GetCampaignInt("Housing","EH10Base");
    }
    /*
    sSettle = "sGuild9";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","MT07Base");
        nUpkeep += GetCampaignInt("Housing","MT08Base");
        nUpkeep += GetCampaignInt("Housing","MT09Base");
        nUpkeep += GetCampaignInt("Housing","MT10Base");
        nUpkeep += GetCampaignInt("Housing","MT11Base");
        nUpkeep += GetCampaignInt("Housing","MT12Base");
        nUpkeep += GetCampaignInt("Housing","MT13Base");
        nUpkeep += GetCampaignInt("Housing","MT14Base");
        nUpkeep += GetCampaignInt("Housing","MT15Base");
        nUpkeep += GetCampaignInt("Housing","MT16Base");
        nUpkeep += GetCampaignInt("Housing","MT17Base");
        nUpkeep += GetCampaignInt("Housing","MT18Base");
        nUpkeep += GetCampaignInt("Housing","MT19Base");
        nUpkeep += GetCampaignInt("Housing","MT20Base");
        nUpkeep += GetCampaignInt("Housing","MT21Base");
        nUpkeep += GetCampaignInt("Housing","MT22Base");
        nUpkeep += GetCampaignInt("Housing","MT23Base");
        nUpkeep += GetCampaignInt("Housing","MT24Base");
        nUpkeep += GetCampaignInt("Housing","MT25Base");
        nUpkeep += GetCampaignInt("Housing","MT26Base");
        nUpkeep += GetCampaignInt("Housing","MT27Base");
    }
    */
    sSettle = "sGuild10";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sGuild11";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight += GetCampaignInt("Settlement",sSettle+"_nKnight");
    }
    sSettle = "sGuild12";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight  += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","EP01Base");
        nUpkeep += GetCampaignInt("Housing","EP02Base");
        nUpkeep += GetCampaignInt("Housing","EP03Base");
        nUpkeep += GetCampaignInt("Housing","EP04Base");
        nUpkeep += GetCampaignInt("Housing","EP05Base");
        nUpkeep += GetCampaignInt("Housing","EP06Base");
        nUpkeep += GetCampaignInt("Housing","EP07Base");
        nUpkeep += GetCampaignInt("Housing","EP08Base");
        nUpkeep += GetCampaignInt("Housing","EP09Base");
        nUpkeep += GetCampaignInt("Housing","EP10Base");
    }
    sSettle = "sGuild13";
    if(GetCampaignString("Settlement",sSettle+"_sOwner") == sOwner)
    {
        nPeasant += GetCampaignInt("Settlement",sSettle+"_nPeasant");
        nSoldier += GetCampaignInt("Settlement",sSettle+"_nSoldier");
        nKnight  += GetCampaignInt("Settlement",sSettle+"_nKnight");
        nUpkeep += GetCampaignInt("Housing","MA01Base");
        nUpkeep += GetCampaignInt("Housing","MA02Base");
        nUpkeep += GetCampaignInt("Housing","MA03Base");
        nUpkeep += GetCampaignInt("Housing","MA04Base");
        nUpkeep += GetCampaignInt("Housing","MA05Base");
        nUpkeep += GetCampaignInt("Housing","MA06Base");
        nUpkeep += GetCampaignInt("Housing","MA07Base");
        nUpkeep += GetCampaignInt("Housing","MA08Base");
        nUpkeep += GetCampaignInt("Housing","MA09Base");
        nUpkeep += GetCampaignInt("Housing","MA10Base");
        nUpkeep += GetCampaignInt("Housing","MA11Base");
        nUpkeep += GetCampaignInt("Housing","MA12Base");
    }
    sSettle = "";


    SetCustomToken(8071,IntToString(nPeasant));
    SetCustomToken(8072,IntToString(nSoldier));
    SetCustomToken(9126,IntToString(nUpkeep));
    SetCustomToken(8073,IntToString(nKnight));
    SetCustomToken(8074,IntToString((nPeasant*5)+(nSoldier*-5)+(nKnight*-50)+(-1*nUpkeep)));
}
