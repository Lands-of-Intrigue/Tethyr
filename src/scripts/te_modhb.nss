//::///////////////////////////////////////////////
//:: Heartbeat Event
//:: x3_mod_def_hb
//:: (c) 2008 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This heartbeat exists only to make sure it
    handles in its own way the benefits of having
    the feat Mounted Combat.   See the script
    x3_inc_horse for complete details of variables
    and flags that can be used with this.   This script
    is also used to provide support for persistence.
*/
//:://////////////////////////////////////////////
//:: Created By: Deva Winblood
//:: Created On: April 2nd, 2008
//:://////////////////////////////////////////////

int CalculateCost(string sOwner);
void UpdateRentPayments(object oModule);
void UpdateSettlementBank(object oModule);
int CheckMonkWeapon(object oPC);

#include "x3_inc_horse"
#include "x3_inc_skin"
#include "sas_include"
#include "so_inc_weather"
#include "nwnx_webhook"
#include "inc_sqlite_time"
#include "sj_footprint_i"
//Updates all Settlement Banks

/////////////////////////////////////////////////////////////[ MAIN ]///////////
void main()
{
    object oMod = GetModule();
    int iCurrentHour = GetTimeHour();
    int nCurrentMinute = GetTimeMinute();
    int nCurrentSecond = GetTimeSecond();
    int nCurrentMilli = GetTimeMillisecond();

    int nRoll;
    int bNoCombat=GetLocalInt(oMod,"X3_NO_MOUNTED_COMBAT_FEAT");
    object oInsig,oPlace2,oBlood;
    int nTurn, nHour, nRandBlood, nD4;
    int nSpireDC;
    int nQuake = 0;
    object oData;
    object oArea;
    object oPlace;
    int nKi,nMonk,nWeap;
    //SetTime(iCurrentHour, nCurrentMinute, nCurrentSecond, nCurrentMilli);

    int nGoldDay = GetCampaignInt("DeathAndTaxes","LastGoldAdd");
    int nTimeStamp = SQLite_GetTimeStamp();

    int nBankCheck = abs(nGoldDay-nTimeStamp);

    if(nBankCheck >= 604800)
    {
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL, "All Banks receiving updated bank totals from upkeep. Rent is being charged where applicable.", "MODULE WIDE UPDATE");
        UpdateSettlementBank(oMod);
        UpdateRentPayments(oMod);
        //Save the new Timestamp
        SetCampaignInt("DeathAndTaxes","LastGoldAdd",nTimeStamp);
    }

    if(GetLocalInt(oMod,"WeatherUpdate") <= nTimeStamp)
    {
        UpdateGlobalWeather(FALSE);
        SetLocalInt(oMod,"WeatherUpdate",nTimeStamp+180);
    }

    //Sauvegarde a chaque heure
    if(GetLocalInt(oMod, "CheckMinute") != GetTimeMinute())
    {
        SetLocalInt(oMod, "CheckMinute", GetTimeMinute());
        nTurn = 1;

    }
    //Sauvegarde a chaque heure
    if(GetLocalInt(oMod, "CheckHour") != GetTimeHour())
    {
        SetLocalInt(oMod, "CheckHour", GetTimeHour());
        SetCampaignInt(GetName(oMod),"GROVE_MARSH",GetLocalInt(oMod,"GROVE_MARSH"));
        SetCampaignInt(GetName(oMod),"GROVE_LAKE",GetLocalInt(oMod,"GROVE_LAKE"));
        SetCampaignInt(GetName(oMod),"GROVE_ELF",GetLocalInt(oMod,"GROVE_ELF"));
        SetCampaignInt(GetName(oMod),"GROVE_SPIRE",GetLocalInt(oMod,"GROVE_SPIRE"));
        SetCampaignInt(GetName(oMod),"GROVE_TEJARN",GetLocalInt(oMod,"GROVE_TEJARN"));
        SetCampaignInt(GetName(oMod),"GROVE_OAK",GetLocalInt(oMod,"GROVE_OAK"));
        nSpireDC = d100(1);

        if(GetLocalInt(oMod,"GROVE_SPIRE") > nSpireDC){nQuake = 1;}
        ExecuteScript("temps_sauv", oMod);
        ExportAllCharacters();
        nHour = 1;
    }

    object oPC=GetFirstPC();

    while (GetIsObjectValid(oPC) == TRUE)
    {
        oData = GetItemPossessedBy(oPC,"PC_Data_Object");

        if(GetLevelByClass(CLASS_TYPE_MONK,oPC) >= 1)
        {
            nMonk = GetLocalInt(oPC,"MonkStyle");
            nKi   = GetLocalInt(oData,"KiLevel");
            nWeap = CheckMonkWeapon(oPC);

            if(nWeap == TRUE && HorseGetIsMounted(oPC) == FALSE)
            {
                if(nMonk >= 1 && nKi < 1)
                {
                    SetLocalInt(oPC,"MonkStyle",0);
                    SendMessageToPC(oPC,"You have depleted your store of ki and are exhausted.");
                    SetLocalInt(oData,"nExhaust",TRUE);
                }
                else
                {
                    if(nMonk >= 1 && nKi > 1)
                    {
                        SetLocalInt(oData,"KiLevel",nKi-1);
                        SendMessageToPC(oPC,"Using your martial arts style depletes your ki to "+IntToString(nKi-1)+".");
                        if(nMonk == 1 || nMonk == 3 || nMonk == 4)
                        {
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAttackIncrease(2,ATTACK_BONUS_MISC),oPC,6.1f);
                        }
                        else if(nMonk == 2)
                        {
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectACIncrease(4,AC_DODGE_BONUS),oPC,6.1f);
                        }
                        else if(nMonk == 5)
                        {
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectACIncrease(2,AC_DODGE_BONUS),oPC,6.1f);
                        }
                    }
                }
            }
            else
            {
                SetLocalInt(oPC,"MonkStyle",0);
                if(GetPhenoType(oPC) == 50||GetPhenoType(oPC) == 57||GetPhenoType(oPC) == 58||GetPhenoType(oPC) == 59||GetPhenoType(oPC) == 60){SetPhenoType(0,oPC);}
            }
        }


        if(GetPCAffliction(oPC) == 8)
        {
            SetCreatureAppearanceType(oPC, 1099);
            if(GetLocalInt(oData,"Blood") >= 1)
            {
                oPlace2 = CreateObject(OBJECT_TYPE_PLACEABLE,"te_crim_mist",GetLocation(oPC),FALSE);
                SetLocalInt(oPlace2,"nTimeStamp",nTimeStamp);
            }
        }

        if(GetPCAffliction(oPC) == 6 || GetPCAffliction(oPC) == 4)
        {
            if(GetGender(oPC) == GENDER_MALE)
            {
                SetCreatureAppearanceType(oPC,3548);
            }
            else
            {
                SetCreatureAppearanceType(oPC,3541);
            }
        }

        oArea = GetArea(oPC);
        if(GetLocalInt(oArea,"WeatherUpdate") != TRUE)
        {
            SetLocalInt(oArea,"WeatherUpdate",TRUE);
        }
        if(!GetIsDM(oPC) && GetLocalInt(oPC,"WeatherChk") != nCurrentMinute)
        {
            SetLocalInt(oPC,"WeatherChk",nCurrentMinute);
            DelayCommand(0.1f,WeatherApplyFrostDamage(oPC));
        }

        if(GetPercentageHPLoss(oPC) <= 30 && GetIsUndead(oPC) == FALSE)
        {
            nRandBlood = d4(1);
            if(nRandBlood == 1)
            {
                oBlood = CreateObject(OBJECT_TYPE_PLACEABLE,"te_blood1",GetLocation(oPC),FALSE);
                SetLocalInt(oBlood,"nTimeStamp",nTimeStamp);
            }
            else if(nRandBlood = 2)
            {
                oBlood =CreateObject(OBJECT_TYPE_PLACEABLE,"te_blood2",GetLocation(oPC),FALSE);
                SetLocalInt(oBlood,"nTimeStamp",nTimeStamp);
            }
            else if(nRandBlood = 3)
            {
                oBlood =CreateObject(OBJECT_TYPE_PLACEABLE,"te_blood3",GetLocation(oPC),FALSE);
                SetLocalInt(oBlood,"nTimeStamp",nTimeStamp);
            }
            else if(nRandBlood = 4)
            {
                oBlood =CreateObject(OBJECT_TYPE_PLACEABLE,"te_blood4",GetLocation(oPC),FALSE);
                SetLocalInt(oBlood,"nTimeStamp",nTimeStamp);
            }
        }
        SetLocalInt(oData,"PC_HP",GetCurrentHitPoints(oPC));

        DelayCommand(0.1f,UpdateAreaWeather(oArea));
        if (GetLocalInt(oMod, "WeatherHour") != GetTimeHour())
        {
            SendMessageToPC(oPC,GetWeatherFeedback(oPC));
            SetLocalInt(oMod,"WeatherHour", GetTimeHour());
        }
        if (GetLocalInt(oPC,"bX3_STORE_MOUNT_INFO"))
        { // store
            DeleteLocalInt(oPC,"bX3_STORE_MOUNT_INFO");
            HorseSaveToDatabase(oPC,X3_HORSE_DATABASE);
        } // store
        if(nTurn == 1)
        {
            if(GetPCAffliction(oPC) == 8)
            {
                oPlace = CreateObject(OBJECT_TYPE_PLACEABLE,"te_crim_mist",GetLocation(oPC),FALSE);
                SetLocalInt(oPlace,"nTimeStamp",nTimeStamp);
            }

            if(GetHasFeat(FEAT_TRACKLESS_STEP,oPC) == FALSE && GetPCAffliction(oPC) != 8)
            {
                if(GetLocalInt(oData,"nMana") >= 35)
                {
                    SetLocalString(oPC,"sj_footprint_visual","60");
                }

                // -- New footprint update --

                SetLocalFloat(oPC,"sj_footprint_duration", 3.0);
                SJ_Footprint_Start(oPC);

                // -- Old footprint update --

                //if(GetLocalInt(oData,"nMud") >= 30 && GetLocalFloat(oPC,"sj_footprint_duration") <= 3.0 && HorseGetIsMounted(oPC) == FALSE)
                //{
                //    SetLocalFloat(oPC,"sj_footprint_duration",600.0);
                //    SJ_Footprint_Start(oPC);
                //}
                //else
                //{
                //    SetLocalFloat(oPC,"sj_footprint_duration",3.0);
                //    SJ_Footprint_Start(oPC);
                //}

                if(GetLocalInt(oData,"nWet") >= 50)
                {
                    oPlace = CreateObject(OBJECT_TYPE_PLACEABLE,"te_puddle",GetLocation(oPC),FALSE);
                    SetLocalInt(oPlace,"nTimeStamp",nTimeStamp);
                }

                if(GetLocalInt(oData,"nBlood") >= 75)
                {
                    nD4 = d4(1);
                    if(nD4 == 1)
                    {
                        oPlace = CreateObject(OBJECT_TYPE_PLACEABLE,"te_blood1",GetLocation(oPC),FALSE);
                        SetLocalInt(oPlace,"nTimeStamp",nTimeStamp);
                    }
                    else if(nD4 = 2)
                    {
                        oPlace = CreateObject(OBJECT_TYPE_PLACEABLE,"te_blood2",GetLocation(oPC),FALSE);
                        SetLocalInt(oPlace,"nTimeStamp",nTimeStamp);
                    }
                    else if(nD4 = 3)
                    {
                        oPlace = CreateObject(OBJECT_TYPE_PLACEABLE,"te_blood3",GetLocation(oPC),FALSE);
                        SetLocalInt(oPlace,"nTimeStamp",nTimeStamp);
                    }
                    else if(nD4 = 4)
                    {
                        oPlace = CreateObject(OBJECT_TYPE_PLACEABLE,"te_blood4",GetLocation(oPC),FALSE);
                        SetLocalInt(oPlace,"nTimeStamp",nTimeStamp);
                    }
                }

            }


            if(GetLocalInt(oData,"nFatigue") == TRUE)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_STRENGTH,2)),oPC,60.1);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectAbilityDecrease(ABILITY_DEXTERITY,2)),oPC,60.1);
                if(GetLocalInt(oData,"nExhaus") != TRUE)
                {
                    SendMessageToPC(oPC,"You are fatigued. You must rest to regain your strength.");
                }
            }

            if(GetLocalInt(oData,"nExhaust") == TRUE)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectMovementSpeedDecrease(50)),oPC,60.1);
                SendMessageToPC(oPC,"You are exhausted. You must rest to regain your strength.");
            }

            if (!bNoCombat&&GetHasFeat(FEAT_MOUNTED_COMBAT,oPC)&&HorseGetIsMounted(oPC))
            { // check for AC increase
                nRoll=GetSkillRank(SKILL_RIDE,oPC);
                if (nRoll>4)
                { // ac increase
                    nRoll=nRoll/5;
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectACIncrease(nRoll)),oPC,60.1);
                } // ac increase

                //Barding Check
                object oSaddle = GetItemPossessedBy(oPC,"te_saddle");

                if(GetIsObjectValid(oSaddle) == TRUE)
                {
                    if(GetLocalInt(oSaddle,"Masterwork") == 1)
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectSkillIncrease(SKILL_DISCIPLINE,4)),oPC,60.1);
                    }
                    else
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectSkillIncrease(SKILL_DISCIPLINE,2)),oPC,60.1);
                    }
                }

                if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_lightbard")) == TRUE)
                {
                    if(GetLocalInt(GetItemPossessedBy(oPC,"te_lightbard"),"Masterwork") == 1)
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectACIncrease(4)),oPC,62.0);
                    }
                    else
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectACIncrease(2)),oPC,62.0);
                    }
                }
                else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_medbard")) == TRUE)
                {
                    if(GetLocalInt(GetItemPossessedBy(oPC,"te_medbard"),"Masterwork") == 1)
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectACIncrease(6)),oPC,62.0);
                    }
                    else
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectACIncrease(4)),oPC,62.0);
                    }
                }
                else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_heabard")) == TRUE)
                {
                    if(GetLocalInt(GetItemPossessedBy(oPC,"te_heabard"),"Masterwork") == 1)
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectACIncrease(8)),oPC,62.0);
                    }
                    else
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ExtraordinaryEffect(EffectACIncrease(6)),oPC,62.0);
                    }
                }

            } // check for AC increase
        }

        if(nHour == 1)
        {
            SetLocalInt(oData,"PCTime",GetLocalInt(oData,"PCTime")+1);
            SetCampaignInt("PC_Playtime",GetPCPublicCDKey(oPC),GetCampaignInt("PC_Playtime",GetPCPublicCDKey(oPC))+1);

            if(GetLocalInt(oData,"nPrayStamp") < nTimeStamp)
            {
                SetLocalInt(oData,"nPrayStamp",nTimeStamp+86400);
                SetLocalInt(oData,"nPiety",GetLocalInt(oData,"nPiety")-1);
                if(GetLocalInt(oData,"nPiety") < 0)     {SetLocalInt(oData,"nPiety",0);}
                if(GetLocalInt(oData,"nPiety") > 100)   {SetLocalInt(oData,"nPiety",100);}
                SendMessageToPC(oPC,"Your piety naturally declines by one point daily. Ensure you perform actions that venerate your diety!");
            }

            if(nQuake == 1 && GetLocalInt(GetArea(oPC),"OOR") != 1)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SCREEN_SHAKE),oPC);
                SendMessageToPC(oPC,"The ground around you suddenly seems to shake and move in daunting fashion...");

                if(GetLocalInt(oMod,"GROVE_SPIRE") > 50)
                {
                    if(GetIsAreaAboveGround(GetArea(oPC)) == FALSE)
                    {
                        SendMessageToPC(oPC,"A cloud of dust descends around you and debris breaks loose from the ceiling!");
                        if(ReflexSave(oPC,15,SAVING_THROW_TYPE_NONE) == 0)
                        {
                            AssignCommand(oPC, ClearAllActions(FALSE));
                            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d8(1),DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_NORMAL),oPC);
                            AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_CUSTOM13, 1.0, 6.0));
                            SendMessageToPC(oPC,"You protect yourself from the falling debris, acquiring a few scrapes and bruises in the process.");
                        }
                        else
                        {
                            AssignCommand(oPC, ClearAllActions(FALSE));
                            AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_DODGE_SIDE, 1.0));
                            SendMessageToPC(oPC,"You narrowly avoid the falling debris.");
                        }
                    }
                }
            }

            //Campaign Information Ticks
            if(GetLocalInt(oData,"PCTime") > -1)  {AddJournalQuestEntry("te_camp1",1,oPC);}
            if(GetLocalInt(oData,"PCTime") >  2)  {AddJournalQuestEntry("te_camp2",1,oPC);}
            if(GetLocalInt(oData,"PCTime") >  4)  {AddJournalQuestEntry("te_camp3",1,oPC);}
            if(GetLocalInt(oData,"PCTime") >  8)  {AddJournalQuestEntry("te_camp4",1,oPC);}
            if(GetLocalInt(oData,"PCTime") >  10) {AddJournalQuestEntry("te_camp5",1,oPC);}
            if(GetLocalInt(oData,"PCTime") >  13) {AddJournalQuestEntry("te_camp6",1,oPC);}
            if(GetLocalInt(oData,"PCTime") >  15) {AddJournalQuestEntry("te_camp7",1,oPC);}
            if(GetLocalInt(oData,"PCTime") >  20) {AddJournalQuestEntry("te_camp8",1,oPC);}
            if(GetLocalInt(oData,"PCTime") >  25) {AddJournalQuestEntry("te_camp9",1,oPC);}
            if(GetLocalInt(oData,"PCTime") >  30) {AddJournalQuestEntry("te_camp10",1,oPC);}

            oInsig = GetItemPossessedBy(oPC,"te_insignia");
            if(GetIsObjectValid(oInsig) == TRUE && abs(GetLocalInt(oInsig,"nLastCheck")-nTimeStamp) >= 1209600)
            {
                SendMessageToPC(oPC,"Your monthly honor acquisition and barony tax impact is being reset. Previous Totals - Honor: "+IntToString(GetLocalInt(oInsig,"nHonor"))+" Gold: "+IntToString(GetLocalInt(oInsig,"nGold")));
                SetLocalInt(oInsig,"nHonor",0);
                SetLocalInt(oInsig,"nGold",0);
                SetLocalInt(oInsig,"nLastCheck",nTimeStamp);
            }
        }

        oPC = GetNextPC();
    }
}

void UpdateRentPayments(object oMod)
{
    string sDoor, sID, sOwner, sBank,sBank_Coffer;
    int nAccount, nRent, nCoffAmount;
    string sMessage;
    //Swamprise
    sOwner = "sSwamp"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    /////////////////////
    sDoor = "SW01";
    sID = GetCampaignString("Housing",sDoor+"Rent");
    nRent = GetCampaignInt("Housing",sDoor+"Pric");
    nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != "")
    {
        if(nAccount>= nRent)
        {
            SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent);
            SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent);
            sMessage += "Rent for: "+sDoor+" charged. ";
        }
        else
        {
            SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";
        }
    }
    sID = ""; nRent = 0; nAccount = 0;

    sDoor = "SW02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW06"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW07"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW08"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW09"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW10"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW11"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW12"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW13"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW14"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW15"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW16"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW17"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW18"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW19"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW20"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW21"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW22"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW23"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW24"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW25"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW26"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW27"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW28"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW29"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW30"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW31"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW32"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SW33"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;


    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";

    //Lockwood
    sOwner = "sLock"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    /////////////////////
    sDoor = "LW01"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW06"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW07"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW08"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW09"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW10"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW11"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW12"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW13"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW14"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW15"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW16"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW17"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW18"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW19"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW20"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW21"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW22"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW23"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW24"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW25"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW26"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW27"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW28"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW29"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW30"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW31"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW32"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW33"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW34"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW35"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW36"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW37"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW38"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW39"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW40"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW41"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW42"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW43"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW44"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW45"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW46"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW47"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW48"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW49"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW50"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW51"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW52"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW53"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW54"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW55"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW56"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW57"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW58"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW59"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LW60"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;



    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";

    //Briarwood
    sOwner = "sHamlet4"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    sDoor = "BW01"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW06"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW07"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW08"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW09"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW10"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW11"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW12"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW13"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW14"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW15"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW16"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BW17"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;

    //Brost
    sOwner = "sBrost"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    sDoor = "BR01"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR06"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR07"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR08"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR09"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR10"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR11"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR12"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR13"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR14"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR15"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR16"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR17"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR18"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR19"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR20"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR21"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "BR22"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";

    //Mystran Tower
    sOwner = "sGuild9"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    sDoor = "MT07"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT08"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT09"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT10"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT11"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT12"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT13"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT14"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT15"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT16"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT17"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT18"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT19"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT20"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT21"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT22"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT23"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT24"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT25"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT26"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MT27"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";

    //LOCKWOOD HAMLET
    sOwner = "sHamlet2"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    sDoor = "LM01"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LM02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LM03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LM04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LM05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LM06"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LM07"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LM08"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LM10"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "LM11"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";

    //TEJARN TOWER
    sOwner = "sFort7"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    sDoor = "TT01"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TT02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TT03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TT04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TT05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TT06"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TT07"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TT08"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TT09"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TT10"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";

    //NORTH GATE KEEP
    sOwner = "sFort2"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    sDoor = "NG01"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "NG02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "NG03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "NG04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "NG05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "NG06"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "NG07"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "NG08"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "NG09"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "NG10"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "NG11"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "NG12"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "NG13"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "NG14"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "NG15"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";

        //Southspire
    sOwner = "sSpire"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    /////////////////////
    sDoor = "SS01"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS06"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS07"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS08"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS09"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS10"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS11"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS12"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS13"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS14"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS15"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS16"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS17"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS18"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS19"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS20"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS21"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS22"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS23"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS24"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS25"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS26"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS27"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS28"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS29"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS30"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS31"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS32"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS33"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS34"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS35"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS36"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS37"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS38"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS39"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS40"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS41"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS42"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "SS43"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";

    //ELIORA'S PERCH
    sOwner = "sGuild12"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    sDoor = "EP01"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EP02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EP03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EP04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EP05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EP06"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EP07"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EP08"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EP09"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EP10"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";

    //WEST HAVEN
    sOwner = "sFort6"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    sDoor = "WH01"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "WH02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "WH03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "WH04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "WH05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "WH06"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "WH07"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "WH08"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "WH09"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "WH10"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";

    //Mystran Arseface
    sOwner = "sGuild13"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    sDoor = "MA01"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MA02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MA03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MA04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MA05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MA06"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MA07"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MA08"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MA09"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MA10"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MA11"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "MA12"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";

    //Elf Home
    sOwner = "sGuild8"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    sDoor = "EH01"; sID = GetCampaignString("Housing",sDoor+"Rent");nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent);SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";}else {SetCampaignString("Housing",sDoor+"Rent","");sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }}sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EH02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EH03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EH04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EH05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EH06"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EH07"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EH08"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EH09"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "EH10"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";

    //Tejarn Gate
    sOwner = "sTejarn"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    sDoor = "TG01"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TG02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TG03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TG04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TG05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TG06"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TG07"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TG08"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TG09"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TG10"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "TG11"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";

    //Abandoned Mines - Forgotten Thieves Den
    sOwner = "sGuild3"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    sDoor = "AM01"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "AM02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "AM03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "AM04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "AM05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "AM06"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";

    //Abandoned Mines - Forgotten Thieves Den
    sOwner = "sHamlet1"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);

    sDoor = "WF01"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted."; }} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "WF02"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "WF03"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "WF04"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;
    sDoor = "WF05"; sID = GetCampaignString("Housing",sDoor+"Rent"); nRent = GetCampaignInt("Housing",sDoor+"Pric"); nAccount = GetCampaignInt(GetName(oMod), "TE_GD_"+ sID + sBank);
    if(sID != ""){if(nAccount>= nRent){SetCampaignInt(GetName(oMod),sBank_Coffer,nCoffAmount+nRent); SetCampaignInt(GetName(oMod),"TE_GD_"+ sID + sBank,nAccount - nRent); sMessage += "Rent for: "+sDoor+" charged. ";} else {SetCampaignString("Housing",sDoor+"Rent",""); sMessage += "Rent for: "+sDoor+" not charged. Tenant Evicted.";}} sID = ""; nRent = 0; nAccount = 0;

    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,sMessage,"RENT UPDATE");
    sMessage = "";



    //Next
    /*
    sOwner = "sSwamp"; sBank = GetCampaignString("Settlement",sOwner+"_sBank"); sBank_Coffer = sBank+"Coffers";
    nCoffAmount = GetCampaignInt(GetName(oMod),sBank_Coffer);
    */

}
/////////////////////////////////////////////////////////////[ MAIN ]///////////
void UpdateSettlementBank(object oMod)
{
    //Quick Update Variables:
        //Brost
            string sBrost = GetCampaignString("Settlement","sBrost_sBank");
            string sBrostC = sBrost+"Coffers";
            string sBrostH = sBrost+"Holding";
            int nBrostGain = CalculateCost("sBrost");

    //Southspire
            string sSSpire = GetCampaignString("Settlement","sSpire_sBank");
            string sSSpireC = sSSpire+"Coffers";
            string sSSpireH = sSSpire+"Holding";
            int nSpireGain = CalculateCost("sSpire");

    //Tejarn Gate
            string sTejarn = GetCampaignString("Settlement","sTejarn_sBank");
            string sTejarnC = sTejarn+"Coffers";
            string sTejarnH = sTejarn+"Holding";
            int nTejarnGain = CalculateCost("sTejarn");

    //Swamprise
            string sSwamp = GetCampaignString("Settlement","sSwamp_sBank");
            string sSwampC = sSwamp+"Coffers";
            string sSwampH = sSwamp+"Holding";
            int nSwampGain = CalculateCost("sSwamp");

    //Lockwood Falls
            string sLock = GetCampaignString("Settlement","sLock_sBank");
            string sLockC = sLock+"Coffers";
            string sLockH = sLock+"Holding";
            int nLockGain =  CalculateCost("sLock");

    //Golden Lion Company
            string sMerc1 = GetCampaignString("Settlement","sMerc1_sBank");
            string sMerc1C = sMerc1+"Coffers";
            string sMerc1H = sMerc1+"Holding";
            int nMerc1Gain =  CalculateCost("sMerc1");

    //Undead
            string sUndead = GetCampaignString("Settlement","sUndead_sBank");
            string sUndeadC = sUndead+"Coffers";
            string sUndeadH = sUndead+"Holding";
            int nUndeadGain =  CalculateCost("sUndead");

    //Outlaw
            string sOutlaw1 = GetCampaignString("Settlement","sOutlaw1_sBank");
            string sOutlaw1C = sOutlaw1+"Coffers";
            string sOutlaw1H = sOutlaw1+"Holding";
            int nOutlaw1Gain =  CalculateCost("sOutlaw1");

    //Outlaw
            string sOutlaw2 = GetCampaignString("Settlement","sOutlaw2_sBank");
            string sOutlaw2C = sOutlaw2+"Coffers";
            string sOutlaw2H = sOutlaw2+"Holding";
            int nOutlaw2Gain =  CalculateCost("sOutlaw2");

            //ADD A CRAP TON OF CASH TO YOUR ACCOUNT!!!!!!!!!!

        //Brost
        int nBrostCoffer = GetCampaignInt(GetName(oMod), sBrostC);
        int nBrostHolding = GetCampaignInt(GetName(oMod), sBrostH);
        SetCampaignInt(GetName(oMod),sBrostC,nBrostCoffer+nBrostGain);
        SetCampaignInt(GetName(oMod),sBrostH,nBrostHolding+nBrostGain);

        //SouthSpire
        int nSpireCoffer = GetCampaignInt(GetName(oMod), sSSpireC);
        int nSpireHolding = GetCampaignInt(GetName(oMod), sSSpireH);
        SetCampaignInt(GetName(oMod),sSSpireC,nSpireCoffer+nSpireGain);
        SetCampaignInt(GetName(oMod),sSSpireH,nSpireHolding+nSpireGain);
        //Tejarn Gate
        int nTejarnCoffer = GetCampaignInt(GetName(oMod), sTejarnC);
        int nTejarnHolding = GetCampaignInt(GetName(oMod), sTejarnH);
        SetCampaignInt(GetName(oMod),sTejarnC,nTejarnCoffer+nTejarnGain);
        SetCampaignInt(GetName(oMod),sTejarnH,nTejarnHolding+nTejarnGain);
        //Swamprise
        int nSwampCoffer = GetCampaignInt(GetName(oMod), sSwampC);
        int nSwampHolding = GetCampaignInt(GetName(oMod), sSwampH);
        SetCampaignInt(GetName(oMod),sSwampC,nSwampCoffer+nSwampGain);
        SetCampaignInt(GetName(oMod),sSwampH,nSwampHolding+nSwampGain);
        //Lockwood
        int nLockCoffer = GetCampaignInt(GetName(oMod), sLockC);
        int nLockHolding = GetCampaignInt(GetName(oMod), sLockH);
        SetCampaignInt(GetName(oMod),sLockC,nLockCoffer+nLockGain);
        SetCampaignInt(GetName(oMod),sLockH,nLockHolding+nLockGain);
        //Golden Lion
        int nMercCoffer = GetCampaignInt(GetName(oMod), sMerc1C);
        int nMercHolding = GetCampaignInt(GetName(oMod), sMerc1H);
        SetCampaignInt(GetName(oMod),sMerc1C,nMercCoffer+nMerc1Gain);
        SetCampaignInt(GetName(oMod),sMerc1H,nMercHolding+nMerc1Gain);
        //Undead
        int nUndeadCoffer = GetCampaignInt(GetName(oMod), sUndeadC);
        int nUndeadHolding = GetCampaignInt(GetName(oMod), sUndeadH);
        SetCampaignInt(GetName(oMod),sUndeadC,nMercCoffer+nUndeadGain);
        SetCampaignInt(GetName(oMod),sUndeadH,nMercHolding+nUndeadGain);
        //Outlaw1
        int nOutlaw1Coffer = GetCampaignInt(GetName(oMod), sOutlaw1C);
        int nOutlaw1Holding = GetCampaignInt(GetName(oMod), sOutlaw1H);
        SetCampaignInt(GetName(oMod),sOutlaw1C,nMercCoffer+nOutlaw1Gain);
        SetCampaignInt(GetName(oMod),sOutlaw1H,nMercHolding+nOutlaw1Gain);
        //Outlaw2
        int nOutlaw2Coffer = GetCampaignInt(GetName(oMod), sOutlaw2C);
        int nOutlaw2Holding = GetCampaignInt(GetName(oMod), sOutlaw2H);
        SetCampaignInt(GetName(oMod),sOutlaw2C,nMercCoffer+nOutlaw2Gain);
        SetCampaignInt(GetName(oMod),sOutlaw2H,nMercHolding+nOutlaw2Gain);

        //Push Updated Amount
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,("**Lockwood Coffers Updated** Previous Coffers: "+IntToString(nLockCoffer)+" New Coffers: "+IntToString(nLockCoffer+nLockGain)+" Previous Holding: "+IntToString(nLockHolding)+" New Holding: "+IntToString(nLockHolding+nLockGain)+"NET UPKEEP: "+IntToString(nLockGain)),"MODULE WIDE UPDATE");
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,("**Brost Coffers Updated** Previous Coffers: " + IntToString(nBrostCoffer) + " New Coffers: " + IntToString(nBrostCoffer+nBrostGain) + " Previous Holding: " + IntToString(nBrostHolding) + " New Holding: " + IntToString(nBrostHolding+nBrostGain)+" NET UPKEEP: "+IntToString(nBrostGain)+"."),"MODULE WIDE UPDATE");
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,("**Southspire Coffers Updated** Previous Coffers: "+IntToString(nSpireCoffer)+" New Coffers: "+IntToString(nSpireCoffer+nSpireGain)+" Previous Holding: "+IntToString(nSpireHolding)+" New Holding: "+IntToString(nSpireHolding+nSpireGain)+"NET UPKEEP: "+IntToString(nSpireGain)),"MODULE WIDE UPDATE");
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,("**Tejarn Coffers Updated** Previous Coffers: "+IntToString(nTejarnCoffer)+" New Coffers: "+IntToString(nTejarnCoffer+nTejarnGain)+" Previous Holding: "+IntToString(nTejarnHolding)+" New Holding: "+IntToString(nTejarnHolding+nTejarnGain)+"NET UPKEEP: "+IntToString(nTejarnGain)),"MODULE WIDE UPDATE");
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,("**Swamprise Coffers Updated** Previous Coffers: "+IntToString(nSwampCoffer)+" New Coffers: "+IntToString(nSwampCoffer+nSwampGain)+" Previous Holding: "+IntToString(nSwampHolding)+" New Holding: "+IntToString(nSwampHolding+nSwampGain)+"NET UPKEEP: "+IntToString(nSwampGain)),"MODULE WIDE UPDATE");
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,("**Golden Lion Coffers Updated** Previous Coffers: "+IntToString(nMercCoffer)+" New Coffers: "+IntToString(nMercCoffer+nMerc1Gain)+" Previous Holding: "+IntToString(nMercHolding)+" New Holding: "+IntToString(nMercHolding+nMerc1Gain)+"NET UPKEEP: "+IntToString(nMerc1Gain)),"MODULE WIDE UPDATE");
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,("**Undead Coffers Updated** Previous Coffers: "+IntToString(nUndeadCoffer)+" New Coffers: "+IntToString(nUndeadCoffer+nUndeadGain)+" Previous Holding: "+IntToString(nUndeadHolding)+" New Holding: "+IntToString(nUndeadHolding+nUndeadGain)+"NET UPKEEP: "+IntToString(nUndeadGain)),"MODULE WIDE UPDATE");
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BANK_CHANNEL,("**Outlaw Coffers Updated** Previous Coffers: "+IntToString(nOutlaw1Coffer)+" New Coffers: "+IntToString(nOutlaw1Coffer+nOutlaw1Gain)+" Previous Holding: "+IntToString(nOutlaw1Holding)+" New Holding: "+IntToString(nOutlaw1Holding+nOutlaw1Gain)+"NET UPKEEP: "+IntToString(nOutlaw1Gain)),"MODULE WIDE UPDATE");

}

int CalculateCost(string sOwner)
{
    int nPeasant = 0, nSoldier = 0, nKnight = 0, nUpkeep = 0;

    //Main Fortresses
    string sSettle = "sBrost";
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

    return ((nPeasant*5)+(nSoldier*-5)+(nKnight*-50)+(-1*nUpkeep));
}

int CheckMonkWeapon(object oPC)
{
    object oRight = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    object oLeft  = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
    int nBaseRight = GetBaseItemType(oRight);
    int nBaseLeft = GetBaseItemType(oLeft);


    if(GetIsObjectValid(oRight) != TRUE && GetIsObjectValid(oLeft) != TRUE)
    {
        return TRUE;
    }
    else
    {
        if(GetIsObjectValid(oLeft) != TRUE)
        {
            if(nBaseRight == 0  || //Shortsword
               nBaseRight == 1  || //Longsword
               nBaseRight == 22 || //Dagger
               nBaseRight == 50 || //Quarterstaff
               nBaseRight == 53 || //Scimitar
               nBaseRight == 59 || //Shuriken
               nBaseRight == 303|| //Sai
               nBaseRight == 304|| //nunchaku
               nBaseRight == 500) //Bal. Qstaff
            {
                return TRUE;
            }
            else
            {
                return FALSE;
            }
        }
        else
        {
            if((nBaseRight == 0 || //Shortsword
               nBaseRight == 1  || //Longsword
               nBaseRight == 22 || //Dagger
               nBaseRight == 50 || //Quarterstaff
               nBaseRight == 53 || //Scimitar
               nBaseRight == 59 || //Shuriken
               nBaseRight == 303|| //Sai
               nBaseRight == 304|| //nunchaku
               nBaseRight == 500) && //Bal. Qstaff
              (nBaseLeft == 0  || //Shortsword
               nBaseLeft == 1  || //Longsword
               nBaseLeft == 22 || //Dagger
               nBaseLeft == 50 || //Quarterstaff
               nBaseLeft == 53 || //Scimitar
               nBaseLeft == 59 || //Shuriken
               nBaseLeft == 303|| //Sai
               nBaseLeft == 304|| //nunchaku
               nBaseLeft == 500))  //Bal. Qstaff
            {
                return TRUE;
            }
            else
            {
                return FALSE;
            }
        }
    }
}
