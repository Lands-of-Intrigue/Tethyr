
const int BACKGROUND_LOWER = 1150;
const int BACKGROUND_MIDDLE = 1151;
const int BACKGROUND_UPPER = 1152;
const int BACKGROUND_AFFLUENCE = 1153;
const int BACKGROUND_BRAWLER = 1154;
const int BACKGROUND_COSMOPOLITAN = 1155;
const int BACKGROUND_CRUSADER = 1156;
const int BACKGROUND_DUELIST = 1157;
const int BACKGROUND_EVANGELIST = 1158;
const int BACKGROUND_FORESTER = 1159;
const int BACKGROUND_HARD_LABORER = 1160;
const int BACKGROUND_HEALER = 1161;
const int BACKGROUND_KNIGHT = 1162;
const int BACKGROUND_MAGE_APPRENTICE = 1163;
const int BACKGROUND_MENDICANT = 1164;
const int BACKGROUND_MERCHANT = 1165;
const int BACKGROUND_METALSMITH = 1166;
const int BACKGROUND_MINSTREL = 1167;
const int BACKGROUND_OCCULTIST = 1168;
const int BACKGROUND_SABOTEUR = 1169;
const int BACKGROUND_SCOUT = 1170;
const int BACKGROUND_SNEAK = 1171;
const int BACKGROUND_SOLDIER = 1172;
const int BACKGROUND_TRAVELER = 1173;
const int BACKGROUND_SPELLFIRE = 1174;
const int BACKGROUND_NAT_LYCAN = 1175;
const int BACKGROUND_SHADOW = 1176;
const int BACKGROUND_COPPER_ELF = 1177;
const int BACKGROUND_GREEN_ELF = 1178;
const int BACKGROUND_DARK_ELF = 1179;
const int BACKGROUND_SILVER_ELF = 1180;
const int BACKGROUND_GOLD_ELF = 1181;
const int BACKGROUND_GOLD_DWARF = 1182;
const int BACKGROUND_GREY_DWARF = 1183;
const int BACKGROUND_SHIELD_DWARF = 1184;
const int BACKGROUND_OUTSIDER = 1185;
const int BACKGROUND_AASIMAR = 1186;
const int BACKGROUND_TIEFLING = 1187;

#include "nw_i0_plot"

void main()
{
    object oPC = GetEnteringObject();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    int iCL = GetHitDice(oPC);
    location lNo = GetLocation(GetObjectByTag("WP_Starting_Area"));
    float fStandingMod = 1.0;

    if (GetHasFeat(BACKGROUND_LOWER, oPC) == TRUE)
    {
        float fStandingMod = 0.9;

    }
    else if (GetHasFeat(BACKGROUND_MIDDLE, oPC) == TRUE)
    {
        float fStandingMod = 1.0;
    }
    else if (GetHasFeat(BACKGROUND_UPPER,oPC) == TRUE)
    {
        float fStandingMod = 1.2;
    }


    if (iCL <= 3)
    {
        CreateItemOnObject("dmfi_pc_dicebag", oPC, 1);
        CreateItemOnObject("dmfi_pc_emote", oPC, 1);

        if (GetHasFeat(BACKGROUND_AFFLUENCE,oPC) == TRUE)
        {
            RewardGP(FloatToInt(1500*fStandingMod), oPC, FALSE);
            CreateItemOnObject("housering", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_BRAWLER,oPC) == TRUE)
        {
            RewardGP(FloatToInt(75*fStandingMod), oPC, FALSE);
            CreateItemOnObject("irongauntlets", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_COSMOPOLITAN,oPC) == TRUE)
        {
            RewardGP(FloatToInt(300*fStandingMod), oPC, FALSE);
            CreateItemOnObject("housering", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_CRUSADER,oPC) == TRUE)
        {
            RewardGP(FloatToInt(250*fStandingMod), oPC, FALSE);
            CreateItemOnObject("holysymbol", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_DUELIST,oPC) == TRUE)
        {
            RewardGP(FloatToInt(200*fStandingMod), oPC, FALSE);
            CreateItemOnObject("duelingbelt", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_EVANGELIST,oPC) == TRUE)
        {
            RewardGP(FloatToInt(175*fStandingMod), oPC, FALSE);
            CreateItemOnObject("evangelicalstaff", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_FORESTER,oPC) == TRUE)
        {
            RewardGP(FloatToInt(85*fStandingMod), oPC, FALSE);
            CreateItemOnObject("woodenring", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_HARD_LABORER,oPC) == TRUE)
        {
            RewardGP(FloatToInt(325*fStandingMod), oPC, FALSE);
            CreateItemOnObject("workboots", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_HEALER,oPC) == TRUE)
        {
            RewardGP(FloatToInt(225*fStandingMod), oPC, FALSE);
            CreateItemOnObject("healersnecklace", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_KNIGHT,oPC) == TRUE)
        {
            RewardGP(FloatToInt(550*fStandingMod), oPC, FALSE);
            CreateItemOnObject("knightlycloak", oPC, 1);
            CreateItemOnObject("te_writknight",oPC,1);
            CreateItemOnObject("knightlyhalfplate",oPC,1);
            CreateItemOnObject("te_item_5022",oPC,1);
        }
        else if (GetHasFeat(BACKGROUND_MAGE_APPRENTICE,oPC) == TRUE)
        {
            RewardGP(FloatToInt(150*fStandingMod), oPC, FALSE);
            CreateItemOnObject("apprenticessta", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_MENDICANT,oPC) == TRUE)
        {
            RewardGP(FloatToInt(0*fStandingMod), oPC, FALSE);
            CreateItemOnObject("humblerobes", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_MERCHANT,oPC) == TRUE)
        {
            RewardGP(FloatToInt(550*fStandingMod), oPC, FALSE);
            CreateItemOnObject("travelersneckl", oPC, 1);
            CreateItemOnObject("ShieldKnightCoin", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_METALSMITH,oPC) == TRUE)
        {
            RewardGP(FloatToInt(150*fStandingMod), oPC, FALSE);
            CreateItemOnObject("performingmando", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_MINSTREL,oPC) == TRUE)
        {
            RewardGP(FloatToInt(150*fStandingMod), oPC, FALSE);
            CreateItemOnObject("performingmando", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_OCCULTIST,oPC) == TRUE)
        {
            RewardGP(FloatToInt(100*fStandingMod), oPC, FALSE);
            CreateItemOnObject("summonersmanual", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SABOTEUR,oPC) == TRUE)
        {
            RewardGP(FloatToInt(175*fStandingMod), oPC, FALSE);
            CreateItemOnObject("leathergloves", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SCOUT,oPC) == TRUE)
        {
            RewardGP(FloatToInt(225*fStandingMod), oPC, FALSE);
            CreateItemOnObject("scoutsring", oPC, 1);
            CreateItemOnObject("te_scoutbadge",oPC,1);
            CreateItemOnObject("te_teuniform_002",oPC,1);
        }
        else if (GetHasFeat(BACKGROUND_SNEAK,oPC) == TRUE)
        {
            RewardGP(FloatToInt(100*fStandingMod), oPC, FALSE);
            CreateItemOnObject("heavycloak", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SOLDIER,oPC) == TRUE)
        {
            RewardGP(FloatToInt(350*fStandingMod), oPC, FALSE);
            CreateItemOnObject("soldiershelm", oPC, 1);
            CreateItemOnObject("te_footsoldier",oPC,1);
            CreateItemOnObject("te_teuniform_001",oPC,1);
            CreateItemOnObject("soldiershelm",oPC,1);
        }
        else if (GetHasFeat(BACKGROUND_TRAVELER,oPC) == TRUE)
        {
            RewardGP(FloatToInt(225*fStandingMod), oPC, FALSE);
            CreateItemOnObject("travelersneckl", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SPELLFIRE,oPC) == TRUE)
        {
            RewardGP(FloatToInt(100*fStandingMod), oPC, FALSE);
            CreateItemOnObject("depletedring", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_NAT_LYCAN,oPC) == TRUE)
        {
            RewardGP(FloatToInt(100*fStandingMod), oPC, FALSE);
            CreateItemOnObject("brokentoothamule", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SHADOW,oPC) == TRUE)
        {
            RewardGP(FloatToInt(100*fStandingMod), oPC, FALSE);
            CreateItemOnObject("it_sparsc610", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_COPPER_ELF,oPC) == TRUE)
        {
            RewardGP(FloatToInt(1050*fStandingMod), oPC, FALSE);
            CreateItemOnObject("te_item_2012", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_GREEN_ELF,oPC) == TRUE)
        {
            RewardGP(FloatToInt(1050*fStandingMod), oPC, FALSE);
            CreateItemOnObject("te_item_2012", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_DARK_ELF,oPC) == TRUE)
        {
            RewardGP(FloatToInt(1050*fStandingMod), oPC, FALSE);
            CreateItemOnObject("te_item_2008", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SILVER_ELF,oPC) == TRUE)
        {
            RewardGP(FloatToInt(1050*fStandingMod), oPC, FALSE);
            CreateItemOnObject("te_item_2012", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_GOLD_ELF,oPC) == TRUE)
        {
            RewardGP(FloatToInt(1050*fStandingMod), oPC, FALSE);
            CreateItemOnObject("te_item_1010", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_GOLD_DWARF,oPC) == TRUE)
        {
            RewardGP(FloatToInt(650*fStandingMod), oPC, FALSE);
            CreateItemOnObject("wblmhw003", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_GREY_DWARF,oPC) == TRUE)
        {
            RewardGP(FloatToInt(650*fStandingMod), oPC, FALSE);
            CreateItemOnObject("travelersneckl", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_SHIELD_DWARF,oPC) == TRUE)
        {
            RewardGP(FloatToInt(650*fStandingMod), oPC, FALSE);
            CreateItemOnObject("travelersneckl", oPC, 1);
        }
        else if (GetHasFeat(BACKGROUND_OUTSIDER,oPC) == TRUE)
        {
            RewardGP(FloatToInt(100*fStandingMod), oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_AASIMAR,oPC) == TRUE)
        {
            RewardGP(FloatToInt(100*fStandingMod), oPC, FALSE);
        }
        else if (GetHasFeat(BACKGROUND_TIEFLING, oPC) == TRUE)
        {
            RewardGP(FloatToInt(100*fStandingMod), oPC, FALSE);
        }
    }
    AssignCommand(oPC, JumpToLocation(lNo));
}
