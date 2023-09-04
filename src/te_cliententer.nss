//:://////////////////////////////////////////////
//:: OnClientEnter
//:: TE_ClientEnter
//:: Function(D20) 2016
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: March 22, 2016
//:://////////////////////////////////////////////

#include "nw_i0_plot"
#include "dmfi_init_inc"
#include "habd_include"
#include "te_functions"
#include "subdual_inc"
#include "sf_hips_inc"
#include "loi_functions"
#include "nwnx_webhook"
#include "nwnx_time"
#include "nwnx_webhook_rch"
#include "x3_inc_horse"
#include "colors_inc"

void main()
{
     string COLOR_S_WHITE     = "<cÿÿÿ>";
     string COLOR_SGREY       = "<c¥¥¥>";
     string COLOR_SLIGHTGREY  = "<c¥¥¥>";
     string COLOR_SSANDY      = ColorTokenShout();

     string COLOR_SRED        = ColorTokenRed();
     string COLOR_SDARKRED    = ColorTokenRed();
     string COLOR_SPINK       = ColorTokenPink();
     string COLOR_SLIGHTPINK  = ColorTokenPink();

     string COLOR_SORANGE     = ColorTokenOrange();
     string COLOR_SYELLOWSERV = ColorTokenServer();

     string COLOR_SLEMON      = ColorTokenYellow();
     string COLOR_SYELLOW     = ColorTokenYellow();

     string COLOR_SNEONGREEN  = ColorTokenTell();
     string COLOR_SGREEN      = ColorTokenGreen();
     string COLOR_SLIME       = ColorTokenGreen();
     string COLOR_SLIGHTGREEN = ColorTokenGreen();

     string COLOR_SDARKBLUE   = ColorTokenBlue();
     string COLOR_SBLUE       = ColorTokenSkillCheck();

     string COLOR_SPERIWINKLE = "<czzþ>";
     string COLOR_SCYAN       = ColorTokenSkillCheck();

     string COLOR_SLIGHTBLUE  = ColorTokenDM();
     string COLOR_SDMBLUE     = ColorTokenDM();
     string COLOR_SPALEBLUE   = ColorTokenSkillCheck();

     string COLOR_SVIOLET     = ColorTokenLightPurple();
     string COLOR_SPURPLE     = ColorTokenPurple();

     string COLOR_SEND  = ColorTokenEnd();

    SF_HipsRestrictionOnClientEnter();
    object oPC = GetEnteringObject();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    int iHP = GetLocalInt(oItem, "PC_HP");

    SetPlotFlag(oPC, FALSE);

        //string sJoinMsg = GetPCPublicCDKey(oPC) + " has joined the server.";
        //NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sJoinMsg, GetName(oPC));

        struct NWNX_WebHook_Message sJoinMessage;
        sJoinMessage.sUsername = "Player Logs";
        sJoinMessage.sTitle = "Player Login";
        sJoinMessage.sColor = "#0000FF";
        sJoinMessage.sAuthorName = GetName(oPC);
        sJoinMessage.sDescription = "**" + GetName(oPC) + "** has entered the server!";
        sJoinMessage.sField1Name = "Playername";
        sJoinMessage.sField1Value = GetPCPlayerName(oPC);
        sJoinMessage.iField1Inline = TRUE;
        sJoinMessage.sField2Name = "IP";
        sJoinMessage.sField2Value = GetPCIPAddress(oPC);
        sJoinMessage.iField2Inline = TRUE;
        sJoinMessage.sField3Name = "CDKey";
        sJoinMessage.sField3Value = GetPCPublicCDKey(oPC);
        sJoinMessage.iField3Inline = TRUE;
        sJoinMessage.sFooterText = "Knights of Noromath Player Event";
        sJoinMessage.iTimestamp = NWNX_Time_GetTimeStamp();
        string sConstructedMsg = NWNX_WebHook_BuildMessageForWebHook("discordapp.com", WEBHOOK_CHAT_CHANNEL, sJoinMessage);
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com",WEBHOOK_CHAT_CHANNEL, sConstructedMsg);

    SetLocalInt(oPC,"SUBDUAL",0);
    FloatingTextStringOnCreature("**Not Doing Subdual Damage**",oPC,FALSE);

    effect eGhost = SupernaturalEffect( EffectCutsceneGhost());
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eGhost,oPC);

    //TE_Faction_Fix(oPlayer);

    //Racial/Class Language Reapplication:
    if((GetRacialType(oPC) == RACIAL_TYPE_ELF)||(GetRacialType(oPC) == RACIAL_TYPE_HALFELF))
    {
        SetLocalInt(oItem,"1",1);
    }
    if(GetRacialType(oPC) == RACIAL_TYPE_GNOME)
    {
        SetLocalInt(oItem,"2",1);
    }
    if(GetRacialType(oPC) == RACIAL_TYPE_HALFLING)
    {
        SetLocalInt(oItem,"3",1);
    }
    if(GetRacialType(oPC) == RACIAL_TYPE_DWARF)
    {
        SetLocalInt(oItem,"4",1);
    }
    if(GetRacialType(oPC) == RACIAL_TYPE_HALFORC)
    {
        SetLocalInt(oItem,"5",1);
    }
    if((GetLevelByClass(CLASS_TYPE_RANGER,oPC) >= 8 )||( GetLevelByClass(CLASS_TYPE_DRUID,oPC) >= 5 ))
    {
        SetLocalInt(oItem,"8",1);
    }
    if((GetLevelByClass(CLASS_TYPE_ROGUE,oPC)) >= 1 ||( GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC) >= 1 ))
    {
        SetLocalInt(oItem,"9",1);
    }
    if(GetLevelByClass(CLASS_TYPE_DRUID,oPC) >= 5)
    {
        SetLocalInt(oItem,"14",1);
    }
    if(GetHasFeat(BACKGROUND_CALISHITE_TRAINED,oPC) ==TRUE)
    {
        SetLocalInt(oItem,"23",1);
    }
    if(GetHasFeat(BACKGROUND_TALFIRIAN,oPC) ==TRUE || GetHasFeat(1445,oPC) == TRUE)
    {
        SetLocalInt(oItem,"38",1);
    }
    if(GetHasFeat(BACKGROUND_CIRCLE_BORN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"8",1);
    }
    if(GetHasFeat(BACKGROUND_DARK_ELF,oPC) == TRUE)
    {
        SetLocalInt(oItem,"13",1);
        SetLocalInt(oItem,"81",1);
        SetLocalInt(oItem,"46",1);
    }
    if(GetHasFeat(BACKGROUND_GREY_DWARF,oPC) == TRUE)
    {
        SetLocalInt(oItem,"64",1);
        SetLocalInt(oItem,"46",1);
    }
    if(GetHasFeat(ETHNICITY_CALISHITE,oPC) == TRUE)
    {
        SetLocalInt(oItem,"23",1);
    }
    if(GetHasFeat(ETHNICITY_CHONDATHAN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"53",1);
    }
    if(GetHasFeat(ETHNICITY_DAMARAN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"56",1);
    }
    if(GetHasFeat(ETHNICITY_ILLUSKAN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"22",1);
    }
    if(GetHasFeat(ETHNICITY_MULAN,oPC) == TRUE)
    {
        SetLocalInt(oItem,"27",1);
    }
    if(GetHasFeat(ETHNICITY_RASHEMI,oPC) == TRUE)
    {
        SetLocalInt(oItem,"30",1);
    }
    if(GetHasFeat(1137,oPC) == TRUE)
    {
        SetLocalInt(oItem,"11",1);
    }
    if(GetHasFeat(1139,oPC) == TRUE)
    {
        SetLocalInt(oItem,"12",1);
    }




////////////////////////////////////////////////////////////////////////////////
//Journal Entries Begin:
////////////////////////////////////////////////////////////////////////////////

    AddJournalQuestEntry("quest_welcome",1,oPC);
    AddJournalQuestEntry("quest_amn",1,oPC);
    AddJournalQuestEntry("quest_calimshan",1,oPC);
    AddJournalQuestEntry("quest_tethyr",1,oPC);

//Time based Journal Entries:

    //Campaign Clock:
            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"PCTime") > -1)  {AddJournalQuestEntry("te_camp1",1,oPC);}
            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"PCTime") >  2)  {AddJournalQuestEntry("te_camp2",1,oPC);}
            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"PCTime") >  4)  {AddJournalQuestEntry("te_camp3",1,oPC);}
            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"PCTime") >  8)  {AddJournalQuestEntry("te_camp4",1,oPC);}
            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"PCTime") >  10) {AddJournalQuestEntry("te_camp5",1,oPC);}
            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"PCTime") >  13) {AddJournalQuestEntry("te_camp6",1,oPC);}
            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"PCTime") >  15) {AddJournalQuestEntry("te_camp7",1,oPC);}
            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"PCTime") >  20) {AddJournalQuestEntry("te_camp8",1,oPC);}
            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"PCTime") >  25) {AddJournalQuestEntry("te_camp9",1,oPC);}
            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"PCTime") >  30) {AddJournalQuestEntry("te_camp10",1,oPC);}


/*
    //1 Hours playtime
    if((GetLocalInt(oItem,"PCTime") >= 1) && GetLocalInt(oItem,"PCTime") < 5 && GetHitDice(oPC) > 3)
    {
        //Good - 4, Neutral - 1, Evil - 5, Chaos - 3, Law - 2, All - 0?
        if (GetHasFeat(BACKGROUND_DARK_ELF,oPC) || GetHasFeat(BACKGROUND_GREY_DWARF,oPC))
        {
            if(GetAlignmentGoodEvil(oPC) != ALIGNMENT_EVIL)
            {
                AddJournalQuestEntry("quest_explore",15,oPC);
            }
            else
            {
                AddJournalQuestEntry("quest_explore",16,oPC);
            }
        }
        else if(GetHasFeat(BACKGROUND_UPPER,oPC) && GetAlignmentGoodEvil(oPC) != ALIGNMENT_EVIL)
        {
            AddJournalQuestEntry("quest_explore",13,oPC);
        }
        else if (GetHasFeat(BACKGROUND_UPPER,oPC) && GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
        {
            AddJournalQuestEntry("quest_explore",14,oPC);
        }
        else if ((GetHasFeat(BACKGROUND_MIDDLE,oPC) || GetHasFeat(BACKGROUND_LOWER,oPC)) && GetAlignmentGoodEvil(oPC) != ALIGNMENT_EVIL)
        {
            AddJournalQuestEntry("quest_explore",11,oPC);
        }
        else if ((GetHasFeat(BACKGROUND_MIDDLE,oPC) || GetHasFeat(BACKGROUND_LOWER,oPC)) && GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
        {
            AddJournalQuestEntry("quest_explore",12,oPC);
        }
    }
    //5 Hours playtime

    //10 hours playtime

*/

/*
if(GetHasFeat(1153,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",1,oPC);}
if(GetHasFeat(1154,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",2,oPC);}
if(GetHasFeat(1155,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",3,oPC);}
if(GetHasFeat(1156,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",4,oPC);}
if(GetHasFeat(1157,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",5,oPC);}
if(GetHasFeat(1158,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",6,oPC);}
if(GetHasFeat(1159,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",7,oPC);}
if(GetHasFeat(1160,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",8,oPC);}
if(GetHasFeat(1161,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",9,oPC);}
if(GetHasFeat(1162,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",10,oPC);}
if(GetHasFeat(1163,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",11,oPC);}
if(GetHasFeat(1164,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",12,oPC);}
if(GetHasFeat(1165,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",13,oPC);}
if(GetHasFeat(1167,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",14,oPC);}
if(GetHasFeat(1168,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",15,oPC);}
if(GetHasFeat(1169,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",16,oPC);}
if(GetHasFeat(1170,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",17,oPC);}
if(GetHasFeat(1171,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",18,oPC);}
if(GetHasFeat(1172,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",19,oPC);}
if(GetHasFeat(1173,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",20,oPC);}
if(GetHasFeat(1174,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",21,oPC);}
if(GetHasFeat(1176,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",22,oPC);}
if(GetHasFeat(1389,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",23,oPC);}
if(GetHasFeat(1390,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",24,oPC);}
if(GetHasFeat(1391,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",25,oPC);}
if(GetHasFeat(1392,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",26,oPC);}
if(GetHasFeat(1393,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",27,oPC);}
if(GetHasFeat(1394,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",28,oPC);}
if(GetHasFeat(1395,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",29,oPC);}
if(GetHasFeat(1396,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",30,oPC);}
if(GetHasFeat(1397,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",31,oPC);}
if(GetHasFeat(1398,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",32,oPC);}
if(GetHasFeat(1399,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",33,oPC);}
if(GetHasFeat(1400,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",34,oPC);}
if(GetHasFeat(1401,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",35,oPC);}
if(GetHasFeat(1460,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",36,oPC);}
if(GetHasFeat(1461,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",37,oPC);}
if(GetHasFeat(1462,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",38,oPC);}
if(GetHasFeat(1463,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",39,oPC);}
if(GetHasFeat(1464,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",40,oPC);}
if(GetHasFeat(1465,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",41,oPC);}
if(GetHasFeat(1466,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",42,oPC);}
if(GetHasFeat(1467,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",43,oPC);}
if(GetHasFeat(1468,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",44,oPC);}
if(GetHasFeat(1469,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",45,oPC);}
if(GetHasFeat(1470,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",46,oPC);}
if(GetHasFeat(1471,oPC) && GetLocalInt(oItem,"PCTime")>1){AddJournalQuestEntry("te_background",47,oPC);}
*/


/*/ Vampire Chain Events
    if (GetPCAffliction(oPC) == 2) AddJournalQuestEntry("te_undeadjourn",1,oPC);
    if (GetPCAffliction(oPC) == 3) AddJournalQuestEntry("te_undeadjourn",2,oPC);
    if (GetPCAffliction(oPC) == 8)
    {
        AddJournalQuestEntry("te_undeadjourn",3,oPC);
        AddJournalQuestEntry("te_greatblack",1,oPC);
        AddJournalQuestEntry("te_shoonstat",1,oPC);
    }

    if(GetLocalInt(oItem,"ShoonAfflic") == 3) AddJournalQuestEntry("te_shoondisease",1,oPC);
    if(GetLocalInt(oItem,"ShoonAfflic") == 2) AddJournalQuestEntry("te_shoondisease",2,oPC);
    if(GetLocalInt(oItem,"ShoonAfflic") == 1) AddJournalQuestEntry("te_shoondisease",3,oPC);

// Location Based Journal Entries:
    int iTethirRoad = GetLocalInt(oItem,"iQuestTethyr");
    int iTejarnGate = GetLocalInt(oItem,"iQuestTejarn");


// Chain Based Journal Entries:
    int iRegister = GetLocalInt(oItem,"te_register");
    int iUndead = GetLocalInt(oItem,"te_undead");
    int iOrc = GetLocalInt(oItem,"te_orc");

    if(iRegister > 0)  {AddJournalQuestEntry("te_register",iRegister,oPC);}
    if(iUndead > 0)    {AddJournalQuestEntry("te_register",iUndead,oPC);}
    if(iOrc > 0)       {AddJournalQuestEntry("te_register",iOrc,oPC);}
       */
// Class Based Journal Entries:
if(GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER,oPC)>=1){AddJournalQuestEntry("te_cl_1",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC)>=1){AddJournalQuestEntry("te_cl_2",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)>=1){AddJournalQuestEntry("te_cl_3",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_BARD,oPC)>=1){AddJournalQuestEntry("te_cl_4",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_BLACKCOAT,oPC)>=1){AddJournalQuestEntry("te_cl_5",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC)>=1){AddJournalQuestEntry("te_cl_6",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_BLADESINGER,oPC)>=1){AddJournalQuestEntry("te_cl_7",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_BLIGHTER,oPC)>=1){AddJournalQuestEntry("te_cl_8",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_CLERIC,oPC)>=1){AddJournalQuestEntry("te_cl_9",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_DIVINE_CHAMPION,oPC)>=1){AddJournalQuestEntry("te_cl_10",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE,oPC)>=1){AddJournalQuestEntry("te_cl_11",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_DRUID,oPC)>=1){AddJournalQuestEntry("te_cl_12",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER,oPC)>=1){AddJournalQuestEntry("te_cl_13",1,oPC);}
if(GetLevelByClass(55,oPC)>=1){AddJournalQuestEntry("te_cl_14",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)>=1){AddJournalQuestEntry("te_cl_15",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_HARPER,oPC)>=1){AddJournalQuestEntry("te_cl_16",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_MONK,oPC)>=1){AddJournalQuestEntry("te_cl_17",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC)>=1){AddJournalQuestEntry("te_cl_18",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_PALE_MASTER,oPC)>=1){AddJournalQuestEntry("te_cl_19",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_PURPLE_DRAGON_KNIGHT,oPC)>=1){AddJournalQuestEntry("te_cl_20",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_RANGER,oPC)>=1){AddJournalQuestEntry("te_cl_21",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_ROGUE,oPC)>=1){AddJournalQuestEntry("te_cl_22",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_SHADOW_ADEPT,oPC)>=1){AddJournalQuestEntry("te_cl_23",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_SHADOWDANCER,oPC)>=1){AddJournalQuestEntry("te_cl_24",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_SHIFTER,oPC)>=1){AddJournalQuestEntry("te_cl_25",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_SORCERER,oPC)>=1){AddJournalQuestEntry("te_cl_26",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_SPELLFIRE,oPC)>=1){AddJournalQuestEntry("te_cl_27",1,oPC);}
if(GetIsUndead(oPC) == 1 ){AddJournalQuestEntry("te_cl_28",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_WARLOCK,oPC)>=1){AddJournalQuestEntry("te_cl_29",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_WARMAGE,oPC)>=1){AddJournalQuestEntry("te_cl_30",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_WEAPON_MASTER,oPC)>=1){AddJournalQuestEntry("te_cl_31",1,oPC);}
if(GetLevelByClass(CLASS_TYPE_WIZARD,oPC)>=1){AddJournalQuestEntry("te_cl_32",1,oPC);}




////////////////////////////////////////////////////////////////////////////////
//End Journals
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//Begin PC Welcome:
////////////////////////////////////////////////////////////////////////////////
    string sWelcome = COLOR_SGREEN+"Welcome to Lands of Intrigue!";
    sWelcome += "\n"+COLOR_SPERIWINKLE+"For information about the setting and current timeline please check Discord and your in-game Journal.";
    sWelcome += "\n"+COLOR_SPERIWINKLE+"This is a Roleplay Server, so above all, we ask that you stay "+COLOR_SRED+"In Character"+COLOR_SPERIWINKLE+" at all times.";
    sWelcome += "\n"+COLOR_SRED+"Please report all Module and Server specific Bugs in Discord and all NWN:EE specific bugs to Beamdog. ";
    sWelcome += "\n"+COLOR_SYELLOW+"We hope you enjoy your stay.";

    SendMessageToPC(oPC,sWelcome);

    if ((GetCurrentHitPoints(oPC) > iHP) && (iHP != 0))
    {
        SendMessageToPC(oPC,(COLOR_SRED+"Restoring Previously Recorded Hitpoints:"));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage((GetCurrentHitPoints(oPC)-iHP),DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_TWENTY),oPC);
    }

    if(GetIsUndead(oPC) == TRUE)
    {
        AdjustReputation(oPC,GetObjectByTag(FACTION_HUNGUNDEAD),100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_RESTUNDEAD),100);
    }

    if((GetLevelByClass(CLASS_TYPE_DRUID,oPC) >= 3 || GetLevelByClass(CLASS_TYPE_RANGER,oPC) >= 3) && GetLevelByClass(CLASS_TYPE_BLIGHTER,oPC) < 1)
    {
         AdjustReputation(oPC,GetObjectByTag(FACTION_HOSTILE_ANIMAL),100);
    }

    if(GetPCAffliction(oPC) == 8)
    {
        SetCreatureAppearanceType(oPC, 1099);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_BROSTCOM),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_BROSTDEF),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_GOLDCOM),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_GOLDDEF),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_LOCKCOM),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_LOCKDEF),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SOUTHCOM),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SOUTHDEF),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SWAMPCOM),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SWAMPDEF),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_TEJARNCOM),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_TEJARNDEF),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_ARMY_AGIS),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_ARMY_AMN),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_ARMY_TETHYR),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_ROYAL),-100);

    }
    else if(GetPCAffliction(oPC) == 6 || GetPCAffliction(oPC) == 4)
    {
        if(GetGender(oPC) == GENDER_MALE)
        {
            SetCreatureAppearanceType(oPC,3548);
        }
        else
        {
            SetCreatureAppearanceType(oPC,3541);
        }

        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_BROSTCOM),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_BROSTDEF),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_GOLDCOM),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_GOLDDEF),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_LOCKCOM),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_LOCKDEF),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SOUTHCOM),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SOUTHDEF),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SWAMPCOM),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SWAMPDEF),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_TEJARNCOM),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_TEJARNDEF),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_ARMY_AGIS),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_ARMY_AMN),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_ARMY_TETHYR),-100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_ROYAL),-100);
    }
    else
    {
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_BROSTCOM),50);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_BROSTDEF),50);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_GOLDCOM),50);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_GOLDDEF),50);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_LOCKCOM),50);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_LOCKDEF),50);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SOUTHCOM),50);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SOUTHDEF),50);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SWAMPCOM),50);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SWAMPDEF),50);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_TEJARNCOM),50);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_TEJARNDEF),50);
        AdjustReputation(oPC,GetObjectByTag(FACTION_ARMY_AGIS),50);
        AdjustReputation(oPC,GetObjectByTag(FACTION_ARMY_TETHYR),50);
        AdjustReputation(oPC,GetObjectByTag(FACTION_ROYAL),50);
    }

    object oInsig = GetItemPossessedBy(oPC,"te_insignia");
    string sSettlement = GetLocalString(oInsig,"Settlement");
    if(sSettlement == "sLock")
    {
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_LOCKCOM),100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_LOCKDEF),100);
    }
    else if(sSettlement == "sTejarn")
    {
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_TEJARNDEF),100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_TEJARNCOM),100);
    }
    else if(sSettlement == "sSpire")
    {
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SOUTHCOM),100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SOUTHDEF),100);
    }
    else if(sSettlement == "sSwamp")
    {
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SWAMPCOM),100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_SWAMPDEF),100);
    }
    else if(sSettlement == "sBrost")
    {
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_BROSTCOM),100);
        AdjustReputation(oPC,GetObjectByTag(FACTION_KEEP_BROSTDEF),100);
    }

    // do any other module OnClientEnter work here
    ExecuteScript("x3_mod_pre_enter",OBJECT_SELF); // Override for other skin systems
    if ((GetIsPC(oPC)||GetIsDM(oPC))&&!GetHasFeat(FEAT_HORSE_MENU,oPC))
    { // add horse menu
        HorseAddHorseMenu(oPC);
        if (GetLocalInt(GetModule(),"X3_ENABLE_MOUNT_DB"))
        { // restore PC horse status from database
            DelayCommand(2.0,HorseReloadFromDatabase(oPC,X3_HORSE_DATABASE));
        } // restore PC horse status from database
    } // add horse menu

    if (GetIsPC(oPC))
    { // more details
        // restore appearance in case you export your character in mounted form, etc.
        if (!GetSkinInt(oPC,"bX3_IS_MOUNTED")) HorseIfNotDefaultAppearanceChange(oPC);
        // pre-cache horse animations for player as attaching a tail to the model
        HorsePreloadAnimations(oPC);
        DelayCommand(3.0,HorseRestoreHenchmenLocations(oPC));
    } // more details

    // initialize DMFI
    dmfiInitialize(oPC);
}