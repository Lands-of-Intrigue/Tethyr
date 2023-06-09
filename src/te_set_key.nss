void main()
{
    object oPC           = GetPCSpeaker();
    object oDoor         = OBJECT_SELF;
    object oBailiff      = GetItemPossessedBy(oPC,"te_item_8508");                           //Bailiff"s Writ.
    object oBaron        = GetItemPossessedBy(oPC,"te_item_8509");                           //Baron"s Writ.
    //Strings
    string sUnique       = GetLocalString(oDoor,"sUnique");                             //Unique ID for Settlement
    string sID           = GetSubString(GetPCPlayerName(oPC)+"_"+GetName(oPC), 0, 15);  //Unique ID for player interacting to be compared to sRenter.
    string sOwner        = GetLocalString(oDoor,"sOwner");                              //Owner ID / Settlement that owns this location.
    string sBank         = GetCampaignString("Settlement",sOwner+"_sBank");             //Bank ID associated with settlement that owns this location.
    string sSetOwner     = GetCampaignString("Settlement",sOwner+"_sOwner");            //Barony that owns this Settlement and therefore this location.
    string sRenter       = GetCampaignString("Housing",sUnique+"Rent");                 //Unique ID for the player that is renting this location.
    string sName         = GetCampaignString("Housing",sUnique+"Name");                 //The Name of this location that will get printed to a key when generated.
    //Integers
    int nPrice           = GetCampaignInt("Housing",sUnique+"Pric");                    //The Price set by the owner automatically deducted from the renter"s bank at barony.
    int nKey             = GetCampaignInt("Housing",sUnique+"Keys");                    //The Number of times this lock has been changed. String is the same, just modified by 1.
    int nLockDC          = GetCampaignInt("Housing",sUnique+"Lock");                    //The DC for trying to unlock this door using Open Lock skill.
    int nDoorDC          = GetCampaignInt("Housing",sUnique+"Door");                    //The DC for trying to bust down this door using STR.
    int nUpkeep          = GetCampaignInt("Housing",sUnique+"Base");                    //The default upkeep/price for maintaining this door/location behind the door.
    int nState           = GetCampaignInt("Housing",sUnique+"Stat");                    //The state of this location. Is it just a door?

    if(sUnique =="LW01") sName = "Lockwood Main Gate 1";
    else if(sUnique == "LW02") sName = "Lockwood Main Gate 2";
    else if(sUnique == "LW03") sName = "Lockwood Main Gate 3";
    else if(sUnique == "LW04") sName = "Lockwood Main Door 1";
    else if(sUnique == "LW05") sName = "Lockwood Servant Door ";
    else if(sUnique == "LW06") sName = "Lockwood Jail Door";
    else if(sUnique == "LW07") sName = "Lockwood Armory Door";
    else if(sUnique == "LW08") sName = "Lockwood Interior Main 1";
    else if(sUnique == "LW09") sName = "Lockwood Throne Main";
    else if(sUnique == "LW10") sName = "Lockwood Lord Chambers";
    else if(sUnique == "LW11") sName = "Lockwood Jail Room 1";
    else if(sUnique == "LW12") sName = "Lockwood Jail Room 2";
    else if(sUnique == "LW13") sName = "Lockwood Jail Room 3";
    else if(sUnique == "LW14") sName = "Lockwood Jail Room 4";
    else if(sUnique == "LW15") sName = "Lockwood Jail Room 5";
    else if(sUnique == "LW16") sName = "Lockwood Jail Room 6";
    else if(sUnique == "LW17") sName = "Lockwood Jail Room 7";
    else if(sUnique == "LW18") sName = "Lockwood Jail Room 8";
    else if(sUnique == "LW19") sName = "Lockwood Jail Room 9";
    else if(sUnique == "LW20") sName = "Lockwood Library";
    else if(sUnique == "LW21") sName = "Lockwood Room 1";
    else if(sUnique == "LW22") sName = "Lockwood Room 2";
    else if(sUnique == "LW23") sName = "Lockwood Room 3";
    else if(sUnique == "LW24") sName = "Lockwood Room 4";
    else if(sUnique == "LW25") sName = "Lockwood Room 5";
    else if(sUnique == "LW26") sName = "Lockwood Room 6";
    else if(sUnique == "LW27") sName = "Lockwood Room 7";
    else if(sUnique == "LW28") sName = "Lockwood Room 8";
    else if(sUnique == "LW29") sName = "Lockwood Room 9";
    else if(sUnique == "LW30") sName = "Lockwood Room 10";
    else if(sUnique == "LW31") sName = "Lockwood Room 11";
    else if(sUnique == "LW32") sName = "Lockwood Room 12";
    else if(sUnique == "LW33") sName = "Lockwood Room 13";
    else if(sUnique == "LW34") sName = "Lockwood Room 14";
    else if(sUnique == "LW35") sName = "Lockwood Balcony Door 1";
    else if(sUnique == "LW36") sName = "Lockwood Balcony Door 2";
    else if(sUnique == "LW37") sName = "Lockwood Balcony Door 3";
    else if(sUnique == "LW38") sName = "Lockwood Balcony Door 4";
    else if(sUnique == "LW39") sName = "Lockwood Balcony Door 5";
    else if(sUnique == "LW40") sName = "Lockwood Balcony Door 6";
    else if(sUnique == "LW41") sName = "Lockwood Balcony Door 7";
    else if(sUnique == "LW42") sName = "Lockwood Balcony Door 8";
    else if(sUnique == "LW43") sName = "Lockwood Low Entrance N";
    else if(sUnique == "LW44") sName = "Lockwood Low Entrance S";
    else if(sUnique == "LW45") sName = "Lockwood Inquisition Storage";
    else if(sUnique == "SW01") sName = "Swamprise Outergate";
    else if(sUnique == "SW02") sName = "Swamprise Maingate";
    else if(sUnique == "SW03") sName = "Swamprise Innergate";
    else if(sUnique == "SW04") sName = "Swamprise Servant Door";
    else if(sUnique == "SW05") sName = "Swamprise Main Jail";
    else if(sUnique == "SW06") sName = "Swamprise Jail Room 1";
    else if(sUnique == "SW07") sName = "Swamprise Jail Room 2";
    else if(sUnique == "SW08") sName = "Swamprise Jail Room 3";
    else if(sUnique == "SW09") sName = "Swamprise Jail Room 4";
    else if(sUnique == "SW10") sName = "Swamprise Jail Room 5";
    else if(sUnique == "SW11") sName = "Swamprise Storage Room";
    else if(sUnique == "SW12") sName = "Swamprise Servant Quarter 1";
    else if(sUnique == "SW13") sName = "Swamprise Servant Quarter 2";
    else if(sUnique == "SW14") sName = "Swamprise Servant Quarter 3";
    else if(sUnique == "SW15") sName = "Swamprise Servant Quarter 4";
    else if(sUnique == "SW16") sName = "Swamprise Merchant Quarter 1";
    else if(sUnique == "SW17") sName = "Swamprise Merchant Quarter 2";
    else if(sUnique == "SW18") sName = "Swamprise Merchant Quarter 3";
    else if(sUnique == "SW19") sName = "Swamprise Merchant Quarter 4";
    else if(sUnique == "SW20") sName = "Swamprise Merchant Quarter 5";
    else if(sUnique == "SW21") sName = "Swamprise Knight Quarter 1";
    else if(sUnique == "SW22") sName = "Swamprise Knight Quarter 2";
    else if(sUnique == "SW23") sName = "Swamprise Knight Quarter 3";
    else if(sUnique == "SW24") sName = "Swamprise Knight Quarter 4";
    else if(sUnique == "SW25") sName = "Swamprise Knight Quarter 5";
    else if(sUnique == "SW26") sName = "Swamprise Knight Quarter 6";
    else if(sUnique == "SW27") sName = "Swamprise Lord's Quarter";
    else if(sUnique == "SW28") sName = "Swamprise Upstairs Door";
    else if(sUnique == "BW01") sName = "Fort Briarwood Gate 1";
    else if(sUnique == "BW02") sName = "Fort Briarwood Gate 2";
    else if(sUnique == "BW03") sName = "Fort Briarwood Gate 3";
    else if(sUnique == "BW04") sName = "Fort Briarwood Maingate";
    else if(sUnique == "BW05") sName = "Fort Briarwood Innergate";
    else if(sUnique == "BW06") sName = "Fort Briarwood Room 1";
    else if(sUnique == "BW07") sName = "Fort Briarwood Room 2";
    else if(sUnique == "BW08") sName = "Fort Briarwood Room 3";
    else if(sUnique == "BW09") sName = "Fort Briarwood Room 4";
    else if(sUnique == "BW10") sName = "Fort Briarwood Lord Quarter";
    else if(sUnique == "BW11") sName = "Fort Briarwood Jail";
    else if(sUnique == "BW12") sName = "Fort Briarwood Jail Room 1";
    else if(sUnique == "BW13") sName = "Fort Briarwood Jail Room 2";
    else if(sUnique == "BW14") sName = "Fort Briarwood Jail Room 3";
    else if(sUnique == "BW15") sName = "Fort Briarwood Armory";
    else if(sUnique == "BW16") sName = "Fort Briarwood Upper Door";
    else if(sUnique == "BW17") sName = "Fort Briarwood Peasant Gate 4";
    else if(sUnique == "BR01") sName = "Brost Magistrate Room";
    else if(sUnique == "BR02") sName = "Brost ";
    else if(sUnique == "BR03") sName = "Brost Magistrate Jail 1";
    else if(sUnique == "BR04") sName = "Brost Magistrate Jail 2";
    else if(sUnique == "BR05") sName = "Brost Comfortable Home";
    else if(sUnique == "BR06") sName = "Brost House 1";
    else if(sUnique == "BR07") sName = "Brost House 2";
    else if(sUnique == "BR08") sName = "Brost House 3";
    else if(sUnique == "BR09") sName = "Brost House 4";
    else if(sUnique == "BR10") sName = "Brost Commons Room 1";
    else if(sUnique == "BR11") sName = "Brost Commons Room 2";
    else if(sUnique == "BR12") sName = "Brost Commons Room 3";
    else if(sUnique == "BR13") sName = "Brost Commons Room 4";
    else if(sUnique == "BR14") sName = "Brost Inn Room 1";
    else if(sUnique == "BR15") sName = "Brost Inn Room 2";
    else if(sUnique == "BR16") sName = "Brost Inn Room 3";
    else if(sUnique == "BR17") sName = "Brost Inn Room 4";
    else if(sUnique == "BR18") sName = "Brost Inn Room 5";
    else if(sUnique == "BR19") sName = "Brost Inn Room 6";
    else if(sUnique == "BR20") sName = "Brost Inn Room 7";
    else if(sUnique == "BR21") sName = "Brost Inn Room 8";
    else if(sUnique == "BR22") sName = "Brost Inn Room 9";
    else if(sUnique == "MT01") sName = "Mystran Tower Crypt to Vault";
    else if(sUnique == "MT02") sName = "Mystran Tower Crypt to Main";
    else if(sUnique == "MT03") sName = "Mystran Tower Vault Door";
    else if(sUnique == "MT04") sName = "Mystran Tower Mal Door";
    else if(sUnique == "MT05") sName = "Mystran Tower Corpse Storage";
    else if(sUnique == "MT06") sName = "Mystran Tower Vault to Main";
    else if(sUnique == "MT07") sName = "Mystran Tower Front Door";
    else if(sUnique == "MT08") sName = "Mystran Tower Stair Door 1";
    else if(sUnique == "MT09") sName = "Mystran Tower Stair Door 2";
    else if(sUnique == "MT10") sName = "Mystran Tower Stair Door 3";
    else if(sUnique == "MT11") sName = "Mystran Tower Stair Door 4";
    else if(sUnique == "MT12") sName = "Mystran Tower Stair Door 5";
    else if(sUnique == "MT13") sName = "Mystran Tower Room 1";
    else if(sUnique == "MT14") sName = "Mystran Tower Room 2";
    else if(sUnique == "MT15") sName = "Mystran Tower Room 3";
    else if(sUnique == "MT16") sName = "Mystran Tower Room 4";
    else if(sUnique == "MT17") sName = "Mystran Tower Room 5";
    else if(sUnique == "MT18") sName = "Mystran Tower Kitchen Door";
    else if(sUnique == "MT19") sName = "Mystran Tower Stair Door 6";
    else if(sUnique == "MT20") sName = "Mystran Tower Stair Door 7";
    else if(sUnique == "MT21") sName = "Mystran Tower Stair Door 8";
    else if(sUnique == "MT22") sName = "Mystran Tower Stair Door 9";
    else if(sUnique == "MT23") sName = "Mystran Tower Room Door1";
    else if(sUnique == "MT24") sName = "Mystran Tower Storage Room";
    else if(sUnique == "MT25") sName = "Mystran Tower West Balcony Door";
    else if(sUnique == "MT26") sName = "Mystran Tower East Balcony Door";
    else if(sUnique == "MT27") sName = "Mystran Tower Roof Door";
    else if(sUnique == "LM01") sName = "Lockwood Hamlet Inn Room 1";
    else if(sUnique == "LM02") sName = "Lockwood Hamlet Inn Room 2";
    else if(sUnique == "LM03") sName = "Lockwood Hamlet Inn Room 3";
    else if(sUnique == "LM04") sName = "Lockwood Hamlet Inn Room 4";
    else if(sUnique == "LM05") sName = "Lockwood Hamlet Inn Room 5";
    else if(sUnique == "LM06") sName = "Lockwood Hamlet Inn Room 6";
    else if(sUnique == "LM07") sName = "Lockwood Hamlet Inn Room 7";
    else if(sUnique == "LM08") sName = "Lockwood Hamlet Inn Room 8";
    else if(sUnique == "LM10") sName = "Lockwood Hamlet Bailiff Jail";
    else if(sUnique == "LM11") sName = "Lockwood Hamlet Bailiff Meeting";
    else if(sUnique == "TT01") sName = "Tejarn Tower Main Door";
    else if(sUnique == "TT02") sName = "Tejarn Tower Balcony Door";
    else if(sUnique == "TT03") sName = "Tejarn Tower Room 1";
    else if(sUnique == "TT04") sName = "Tejarn Tower Room 2";
    else if(sUnique == "TT05") sName = "Tejarn Tower Room 3";
    else if(sUnique == "TT06") sName = "Tejarn Tower Commander Room";
    else if(sUnique == "TT07") sName = "Tejarn Tower Chapel";
    else if(sUnique == "TT08") sName = "Tejarn Tower Jail 1";
    else if(sUnique == "TT09") sName = "Tejarn Tower Jail 2";
    else if(sUnique == "TT10") sName = "Tejarn Tower Storage Room";
    else if(sUnique == "LWM01") sName = "Lockwood Mines Main Door";
    else if(sUnique == "NG01") sName = "North Gate Main Door";
    else if(sUnique == "NG02") sName = "North Gate Storage Room";
    else if(sUnique == "NG03") sName = "North Gate Upper Keep Door";
    else if(sUnique == "NG04") sName = "North Gate Lord Chambers";
    else if(sUnique == "NG05") sName = "North Gate Room 1";
    else if(sUnique == "NG06") sName = "North Gate Room2";
    else if(sUnique == "NG07") sName = "North Gate Room3";
    else if(sUnique == "NG08") sName = "North Gate Room4";
    else if(sUnique == "NG09") sName = "North Gate Room5";
    else if(sUnique == "NG10") sName = "North Gate Room6";
    else if(sUnique == "NG11") sName = "North Gate Room7";
    else if(sUnique == "NG12") sName = "North Gate Room8";
    else if(sUnique == "NG13") sName = "North Gate Room9";
    else if(sUnique == "NG14") sName = "North Gate Room10";
    else if(sUnique == "NG15") sName = "North Gate Room11";
    else if(sUnique == "SS01") sName = "Southspire Drunken Djinn 1";
    else if(sUnique == "SS02") sName = "Southspire Drunken Djinn 2";
    else if(sUnique == "SS03") sName = "Southspire Drunken Djinn 3";
    else if(sUnique == "SS04") sName = "Southspire Drunken Djinn 4";
    else if(sUnique == "SS05") sName = "Southspire Drunken Djinn 5";
    else if(sUnique == "SS06") sName = "Southspire Drunken Djinn 6";
    else if(sUnique == "SS07") sName = "Southspire Drunken Djinn 7";
    else if(sUnique == "SS08") sName = "Southspire Drunken Djinn 8";
    else if(sUnique == "SS09") sName = "Southspire Main Gate 1";
    else if(sUnique == "SS10") sName = "Southspire Main Gate 2";
    else if(sUnique == "SS11") sName = "Southspire Sadman Upper";
    else if(sUnique == "SS12") sName = "Southspire Sadman Barracks";
    else if(sUnique == "SS13") sName = "Southspire Main Floor";
    else if(sUnique == "SS14") sName = "Southspire Main Gate 3";
    else if(sUnique == "SS15") sName = "Southspire Main Gate 4";
    else if(sUnique == "SS16") sName = "Southspire Servants Entrance";
    else if(sUnique == "SS17") sName = "Southspire House 1";
    else if(sUnique == "SS18") sName = "Southspire House 2";
    else if(sUnique == "SS19") sName = "Southspire House 3";
    else if(sUnique == "SS20") sName = "Southspire Castle Side Entrance";
    else if(sUnique == "SS21") sName = "Southspire Castle Side Upper";
    else if(sUnique == "SS22") sName = "Southspire Main Hall Side Door";
    else if(sUnique == "SS23") sName = "Southspire Library";
    else if(sUnique == "SS24") sName = "Southspire Lord's Lounge";
    else if(sUnique == "SS25") sName = "Southspire Lord's Chambers";
    else if(sUnique == "SS26") sName = "Southspire Secondary Suite";
    else if(sUnique == "SS27") sName = "Southspire Secret Servant Door";
    else if(sUnique == "SS28") sName = "Southspire Quarters 1";
    else if(sUnique == "SS29") sName = "Southspire Quarters 2";
    else if(sUnique == "SS30") sName = "Southspire Quarters 3";
    else if(sUnique == "SS31") sName = "Southspire Small QTR 4";
    else if(sUnique == "SS32") sName = "Southspire Small QTR 5";
    else if(sUnique == "SS33") sName = "Southspire Jail Main";
    else if(sUnique == "SS34") sName = "Southspire Jail 1";
    else if(sUnique == "SS35") sName = "Southspire Jail 2";
    else if(sUnique == "SS36") sName = "Southspire Jail 3";
    else if(sUnique == "SS37") sName = "Southspire Jail 4";
    else if(sUnique == "SS38") sName = "Southspire Jail 5";
    else if(sUnique == "SS39") sName = "Southspire Jail 6";
    else if(sUnique == "SS40") sName = "Southspire Blacksmith/Armory";
    else if(sUnique == "SS41") sName = "Southspire Hall-Gate Entrance";
    else if(sUnique == "SS42") sName = "Southspire Hall-Main Entrance";
    else if(sUnique == "SS43") sName = "Southspire Hall-Sadman Entrance";
    else if(sUnique == "EP01") sName = "Eliora Perch Main Door";
    else if(sUnique == "EP02") sName = "Eliora Perch Balcony Door";
    else if(sUnique == "EP03") sName = "Eliora Perch Room 1";
    else if(sUnique == "EP04") sName = "Eliora Perch Room 2";
    else if(sUnique == "EP05") sName = "Eliora Perch Room 3";
    else if(sUnique == "EP06") sName = "Eliora Perch Commander Room";
    else if(sUnique == "EP07") sName = "Eliora Perch Chapel";
    else if(sUnique == "EP08") sName = "Eliora Perch Jail 1";
    else if(sUnique == "EP09") sName = "Eliora Perch Jail 2";
    else if(sUnique == "EP10") sName = "Eliora Perch Storage Room";
    else if(sUnique == "MA01") sName = "Mystran Hideway Main Door";
    else if(sUnique == "MA02") sName = "Mystran Hideway Side Door 1";
    else if(sUnique == "MA03") sName = "Mystran Hideway Side Door 2";
    else if(sUnique == "MA04") sName = "Mystran Hideway Secondary Door";
    else if(sUnique == "MA05") sName = "Mystran Hideway Side Hall 1";
    else if(sUnique == "MA06") sName = "Mystran Hideway Side Hall 2";
    else if(sUnique == "MA07") sName = "Mystran Hideway Room1";
    else if(sUnique == "MA08") sName = "Mystran Hideway Room2";
    else if(sUnique == "MA09") sName = "Mystran Hideway Room3";
    else if(sUnique == "MA10") sName = "Mystran Hideway Room4";
    else if(sUnique == "MA11") sName = "Mystran Hideway Clone Chamber Secret Storage";
    else if(sUnique == "MA12") sName = "Mystran Hideway Rear Storage";
    else if(sUnique == "EH01") sName = "Teranthvar Inn Room 1";
    else if(sUnique == "EH02") sName = "Teranthvar Inn Room 2";
    else if(sUnique == "EH03") sName = "Teranthvar Inn Room 3";
    else if(sUnique == "EH04") sName = "Teranthvar Inn Room 4";
    else if(sUnique == "EH05") sName = "Teranthvar Inn Room 5";
    else if(sUnique == "EH06") sName = "Teranthvar Inn Room 6";
    else if(sUnique == "EH07") sName = "Teranthvar Elven Home 1";
    else if(sUnique == "EH08") sName = "Teranthvar Elven Home 2";
    else if(sUnique == "EH09") sName = "Teranthvar Elven Home 3";
    else if(sUnique == "EH10") sName = "Teranthvar Elven Home 4";
    else if(sUnique == "AM01") sName = "Abandoned Mines Main Door";
    else if(sUnique == "AM02") sName = "Abandoned Mines Room 1";
    else if(sUnique == "AM03") sName = "Abandoned Mines Room 2";
    else if(sUnique == "AM04") sName = "Abandoned Mines Room 3";
    else if(sUnique == "AM05") sName = "Abandoned Mines Room 4";
    else if(sUnique == "AM06") sName = "Abandoned Mines Storage Room";
    else{}

    object oKey = CreateItemOnObject("te_set_key",oPC,1,sUnique+IntToString(nKey));
    SetName(oKey,sName);
    SetDescription(oKey,"This key is to a doorway. It was created by: "+GetName(oPC)+". //Debug:"+sUnique+" "+sID+" "+sOwner+" "+sBank+" "+sSetOwner+" "+sRenter);
    SetIdentified(oKey,TRUE);

}
