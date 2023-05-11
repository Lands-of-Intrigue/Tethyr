const string WHITE      = "<cððð>"; // talk
const string GREY       = "<cŠŠŠ>"; //"<c€€€>"; // whisper
const string LIGHTGREY  = "<c¥¥¥>";
const string SANDY      = "<cþïP>"; // shout

const string RED        = "<cþ  >";
const string DARKRED    = "<c¡*0>";
const string PINK       = "<cÒdd>";
const string LIGHTPINK  = "<cædd>";

const string ORANGE     = "<cþ} >";
const string YELLOWSERV = "<cþf >"; // experimental

const string LEMON      = "<cþþ >";
const string YELLOW     = "<cþ× >";

const string NEONGREEN  = "<c#þ#>"; // tell
const string GREEN      = "<c0¡0>"; // name preceding description
const string LIME       = "<c¡Òd>"; // description
const string LIGHTGREEN = "<c¡Ñd>";

const string DARKBLUE   = "<c  þ>";
const string BLUE       = "<c zþ>"; // skill blue
//const string BLUE       = "<cAiá>";
//const string BLUE       = "<cd¡Ñ>";
const string PERIWINKLE = "<czzþ>";
const string CYAN       = "<c þþ>"; // saving throw

const string LIGHTBLUE  = "<c#ßþ>"; // DM chat
const string DMBLUE     = "<c#ßþ>"; // DM chat
const string PALEBLUE   = "<c‡þþ>"; // name in skill check/saving throw

const string VIOLET     = "<c¡dÑ>";
const string PURPLE     = "<c¢Gd>";

const string COLOR_END  = "</c>";

#include "nwnx_admin"
#include "nwnx_player"
#include "nwnx_player_qbs"

void main()
{
    object oPC = GetEnteringObject();
    SendMessageToPC(oPC, YELLOW+"Welcome to Lands of Intrigue!");
    SendMessageToPC(oPC, YELLOW+"This room is where Customization Feats will be applied to your character. You have been granted enough XP to reach Level 3. Please make sure you fully levelup before doing anything else in this room. All of your first three classes must be the same. Afterwards, there are no restrictions. 3.5 Edition multiclassing rules apply. ");
    SendMessageToPC(oPC, YELLOW+"Pull one of the levers to your left or right to select Customization Feats such as Class Standing, Background, Ethnicity, Deity, Language and Proficiencies.  Please note that some of these choices such as Class Standing and Background do affect certain dialogue options and mechanical opportunities in-game. ");
    SendMessageToPC(oPC, RED+"Warning: You must have completed Customization Feat Selection and leveled up to Level 3 before you leave this room.");
    SendMessageToPC(oPC, RED+"Note: If you appear to be a dwarf and are not a dwarf please re-log and it will be fixed.");
    SendMessageToPC(oPC, RED+"Note: Languages can be selected. If you do not have any options that appear for you, you have reached the limit of languages you can select.");

    NWNX_Player_ForcePlaceableExamineWindow(oPC,GetNearestObjectByTag("te_welcome",oPC,1));
    NWNX_Player_SetQuickBarSlot(oPC,12,NWNX_Player_QBS_UseFeat(1106));
    NWNX_Player_SetQuickBarSlot(oPC,11,NWNX_Player_QBS_UseFeat(1107));
    NWNX_Player_SetQuickBarSlot(oPC,10,NWNX_Player_QBS_UseFeat(1108));
    NWNX_Player_SetQuickBarSlot(oPC, 9,NWNX_Player_QBS_UseFeat(1109));
    NWNX_Player_SetQuickBarSlot(oPC, 7,NWNX_Player_QBS_UseFeat(23));
    NWNX_Player_SetQuickBarSlot(oPC, 8,NWNX_Player_QBS_UseFeat(9));

    AddJournalQuestEntry("quest_welcome",1,oPC);
    AddJournalQuestEntry("quest_amn",1,oPC);
    AddJournalQuestEntry("quest_calimshan",1,oPC);
    AddJournalQuestEntry("quest_tethyr",1,oPC);

    if(!GetIsDM(oPC) && GetIsPC(oPC) == TRUE)
    {
        if(GetRacialType(oPC) == RACIAL_TYPE_HUMAN)     {SetCreatureAppearanceType(oPC,6);}
        if(GetRacialType(oPC) == RACIAL_TYPE_DWARF)     {SetCreatureAppearanceType(oPC,0);}
        if(GetRacialType(oPC) == RACIAL_TYPE_ELF)       {SetCreatureAppearanceType(oPC,1);}
        if(GetRacialType(oPC) == RACIAL_TYPE_GNOME)     {SetCreatureAppearanceType(oPC,2);}
        if(GetRacialType(oPC) == RACIAL_TYPE_HALFLING)  {SetCreatureAppearanceType(oPC,3);}
        if(GetRacialType(oPC) == RACIAL_TYPE_HALFORC)   {SetCreatureAppearanceType(oPC,5);}
        if(GetRacialType(oPC) == RACIAL_TYPE_HALFELF)   {SetCreatureAppearanceType(oPC,4);}

        if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"EntryTest") == 0)
        {
            if(GetAbilityScore(oPC,ABILITY_STRENGTH,FALSE) >= 24 ||
               GetAbilityScore(oPC,ABILITY_CHARISMA,FALSE) >= 24 ||
               GetAbilityScore(oPC,ABILITY_CONSTITUTION,FALSE) >= 24 ||
               GetAbilityScore(oPC,ABILITY_DEXTERITY,FALSE) >= 24 ||
               GetAbilityScore(oPC,ABILITY_INTELLIGENCE,FALSE) >= 24 ||
               GetAbilityScore(oPC,ABILITY_WISDOM,FALSE) >= 24)
               {
                    SendMessageToAllDMs(GetName(oPC)+" / "+GetPCPlayerName(oPC)+" / "+GetPCPublicCDKey(oPC)+" / "+GetPCIPAddress(oPC)+" has been banned temporarily - Ability Score Exploit. Add the CDKey to the NWNServer.ini");
                    NWNX_Administration_AddBannedCDKey(GetPCPublicCDKey(oPC,FALSE));
                    BootPC(oPC,"Permanent Ban: Exploited Ability Scores.");
               }

            if(GetBaseAttackBonus(oPC) >= 12)
            {
                    SendMessageToAllDMs(GetName(oPC)+" / "+GetPCPlayerName(oPC)+" / "+GetPCPublicCDKey(oPC)+" / "+GetPCIPAddress(oPC)+" has been banned temporarily - Attack Bonus Exploit. Add the CDKey to the NWNServer.ini");
                    NWNX_Administration_AddBannedCDKey(GetPCPublicCDKey(oPC,FALSE));
                    BootPC(oPC,"Permanent Ban: Exploited Attack Bonus.");
            }

            if(GetAC(oPC) >= 20)
            {
                    SendMessageToAllDMs(GetName(oPC)+" / "+GetPCPlayerName(oPC)+" / "+GetPCPublicCDKey(oPC)+" / "+GetPCIPAddress(oPC)+" has been banned temporarily - Armor Class Exploit. Add the CDKey to the NWNServer.ini");
                    NWNX_Administration_AddBannedCDKey(GetPCPublicCDKey(oPC,FALSE));
                    BootPC(oPC,"Permanent Ban: Exploited Armor Class.");
            }
            SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"EntryTest",1);
        }
    }
}
