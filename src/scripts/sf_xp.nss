//:://////////////////////////////////////////////
//:: Scarface's XP/GP System V2.1
//:: SF_XP
//:://////////////////////////////////////////////
/*
     All code created and written by Scarface
*/
//////////////////////////////////////////////////
#include "te_afflic_func"
#include "loi_xp"
//:: CONSTANTS
//:: You can adjust these constants to suit your module

// XP modifier for adjusting XP reward given - higher means more XP
// Default is 10.
// Setting this to 10 will give a similar XP amount to the default
// bioware XP engines XP Slider.
// Do NOT set this to 0
const int XP_MODIFIER = 10;

// Reward gold to players for killing creatures?
// If TRUE use the GP_REWARD_MULTIPLIER const to multiply amount of gold rewarded
// TRUE = Yes     :     FALSE = No
const int REWARD_GP = FALSE;

// This will multiply the Gold rewarded if the REWARD_GP const above is set to TRUE
// Default is 1.0 (1.0 means equal to the amount of XP given, 2.0 would mean
// double the amount of gold and 0.5 would mean half).
// It basically multiplies the XP reward (GP_REWARD_MULTIPLIER x XP = GP Reward)
const float GP_REWARD_MULTIPLIER = 0.0;

// Bonus XP/GP reward for the dealing the killing blow to the creature
// Default is 0.1 = 10%
// If the REWARD_GP const above is set to FALSE then ONLY an XP bonus is given
// * Note * Changed so this will only apply if the killer is in party
const float KILLER_XP_GP_BONUS = 0.05;

// This will give an XP/GP bonus per player in the party
// Default is 0.1 = 10% per player
const float PARTY_XP_GP_BONUS = 0.10;

// Display floating text above each party member for XP/GP rewarded
// TRUE = Yes     :     FALSE = No
const int FLOATING_TEXT = FALSE;

// Distance between each party member and the dead creature to be
// included for XP reward
// Default is 15.0 meters
// I recommend you do NOT set this lower than about 5.0 meters
// otherwise you could end up not getting any XP/GP reward
const float PARTY_DIST = 25.0;

// Party level gap for minimal XP
// If the difference between highest level party member and the lowest
// level party member is greater than this, then XP/GP rewarded will be
// the minumum possible, this helps to stop powerleveling
// Default 10  (set to 40 to turn this feature off)
const int MAX_PARTY_GAP = 5;

// XP pentalty for each summon/familiar/henchman in the party within
// the specified distance set by the PARTY_DIST const
// Default 0.2 = 20% penalty per summon/familiar/henchman)
const float SUMMON_PENALTY = 0.05;

// Do you want XP to be divided between all PC's in the party within
// the specified distance set by the PARTY_DIST consts
// If set TRUE then XP will be divided between PC's so if the XP was 200
// and there were 2 PC's they would get 100 XP each
// If set FALSE they would get 200 XP each
// Default TRUE
const int PC_DIVIDE_XP = FALSE;

// Minimum XP possible for all PC's
// Default is 5 XP
// Do NOT set this to 0
const int MIN_XP = 1;

////////////////////////////////////////////////////////////////////////////////
// PC Level Max XP consts
////////////////////////////////////////////////////////////////////////////////
// You can set the maximum XP possible for each PC level for more control
// Do NOT set any of these lower than the MIN_XP const above
// Default is 600 XP max possible for all levels
// * NOTE: This is ONLY a maximum possible, PC's will still get there normal
//         XP based on the XP_MODIFIER const.
const int
LEVEL_1_MAX_XP = 25,
LEVEL_2_MAX_XP = 25,
LEVEL_3_MAX_XP = 25,
LEVEL_4_MAX_XP = 25,
LEVEL_5_MAX_XP = 25,
LEVEL_6_MAX_XP = 25,
LEVEL_7_MAX_XP = 25,
LEVEL_8_MAX_XP = 25,
LEVEL_9_MAX_XP = 25,
LEVEL_10_MAX_XP = 25,
LEVEL_11_MAX_XP = 25,
LEVEL_12_MAX_XP = 25,
LEVEL_13_MAX_XP = 25,
LEVEL_14_MAX_XP = 25,
LEVEL_15_MAX_XP = 25,
LEVEL_16_MAX_XP = 25,
LEVEL_17_MAX_XP = 25,
LEVEL_18_MAX_XP = 25,
LEVEL_19_MAX_XP = 25,
LEVEL_20_MAX_XP = 25,
LEVEL_21_MAX_XP = 25,
LEVEL_22_MAX_XP = 25,
LEVEL_23_MAX_XP = 25,
LEVEL_24_MAX_XP = 25,
LEVEL_25_MAX_XP = 25,
LEVEL_26_MAX_XP = 25,
LEVEL_27_MAX_XP = 25,
LEVEL_28_MAX_XP = 25,
LEVEL_29_MAX_XP = 25,
LEVEL_30_MAX_XP = 25,
LEVEL_31_MAX_XP = 25,
LEVEL_33_MAX_XP = 25,
LEVEL_32_MAX_XP = 25,
LEVEL_34_MAX_XP = 50,
LEVEL_35_MAX_XP = 50,
LEVEL_36_MAX_XP = 50,
LEVEL_37_MAX_XP = 50,
LEVEL_38_MAX_XP = 50,
LEVEL_39_MAX_XP = 50,
LEVEL_40_MAX_XP = 50; // No need for this really

////////////////////////////////////////////////////////////////////////////////
//:: DO NOT TOUCH ANYTHING BELOW HERE !!!!!
////////////////////////////////////////////////////////////////////////////////
// Declare the functions
int GetMaxXP(object oPC);

int CalculateXP(float fLevel, float fCR);

void GiveXP(object oKiller, int nXP, float fKillerBonus, int nDiff, int nPlayer, int nBossReward);

int GetLevelFromXP(object oPC);

void XPDebugMessage(object oPC, float fCR, int nDiff, int nLoLevel,

int nHiLevel, float fAvLevel);

////////////////////////////////////////////////////////////////////////////////
void main()
{
    // Define major variables
    object oKiller = GetLastKiller();
    object oArea = GetArea(oKiller);
    if (!GetIsPC(oKiller) && !GetIsPC(GetMaster(oKiller)))  return;
    object oParty = GetFirstFactionMember(oKiller, FALSE);
    int iECL = Calc_ECL(oParty);
    float fCR = GetChallengeRating(OBJECT_SELF), fDist;
    int nPlayer, nSummon, nTotalLevel, nHD, nXPToGive, nHiLevel, nLoLevel = 40;
    int nBossReward = GetLocalInt(OBJECT_SELF,"BossReward");

    // Calculate the amount of members oPC's Party
    while (GetIsObjectValid(oParty))
    {
        if (GetArea(oParty) != oArea)
        {
            SendMessageToPC(oParty,"You are in a cross-area party. This contributes to lag across the server. Please leave your cross-area party if you are not actively adventuring with those in your party.");
        }
        // Make sure the party member is NOT dead and are within the specified distance
        fDist = GetDistanceToObject(oParty);
        if (!GetIsDead(oParty) && fDist >= 0.0 && fDist <= PARTY_DIST)
        {
                // Party member is a player
                if(GetIsPC(oParty))
                {
                    iECL = Calc_ECL(oParty);

                    // Number of players
                    nPlayer++;

                    // Get total level of all PC party members
                    nTotalLevel += (GetLevelFromXP(oParty)+iECL);

                    // GetHighest/lowest party members
                    nHD = GetLevelFromXP(oParty);
                    if (nHD > nHiLevel) nHiLevel = nHD;
                    if (nHD < nLoLevel) nLoLevel = nHD;
                }
                // Party member is a summon/familiar/henchman
                else
                {
                    nSummon++;
                }
        }
        else if (!GetIsDead(oParty)&& fDist >= PARTY_DIST)
        {
            SendMessageToPC(oParty,"You are too far away to gain meaningful experience from this encounter.");
        }

        oParty = GetNextFactionMember(oKiller, FALSE);

    }

    // This check is to stop the "DIVIDED BY ZERO" error message
    if (!nPlayer) nPlayer = 1;


    // Get average party level calculate difference between highest and lowest
    float fAvLevel = (IntToFloat(nTotalLevel) / nPlayer);
    int nDiff = abs(nHiLevel - nLoLevel);

    // Calculate XP
    int nBaseXP = CalculateXP(fAvLevel, fCR);
    int nXP = ((nBaseXP * XP_MODIFIER) / 10);

    // Lets make sure the XP reward is within consts parameters
    int nMaxXP = GetMaxXP(oKiller);

    // Calculate Penalties based on consts
    float fPenalty = (nXP *(nSummon * SUMMON_PENALTY)), fPartyBonus, fKillerBonus;

    if (PC_DIVIDE_XP)
    {
        nXPToGive = ((nXP - FloatToInt(fPenalty)) / nPlayer);
    }
    else
    {
        nXPToGive = (nXP - FloatToInt(fPenalty));
    }
    // If there is more than 1 player in the party then calculate
    // XP Bonuses based on consts
    if (nPlayer)
    {
        if(nPlayer >= 4)
        {
            fPartyBonus = (nXP * (PARTY_XP_GP_BONUS * nPlayer));
            fKillerBonus = (nXPToGive * KILLER_XP_GP_BONUS);
            nXPToGive = FloatToInt(fPartyBonus) + nXPToGive;
        }
        else if( (nPlayer < 4)&&(nPlayer>=6) )
        {
            fPartyBonus = (nXP * (PARTY_XP_GP_BONUS * 4));
            fKillerBonus = (nXPToGive * KILLER_XP_GP_BONUS);
            nXPToGive = FloatToInt(fPartyBonus) + nXPToGive;
        }
        else if ( (nPlayer < 7)&&(nPlayer >=8) )
        {
            fPartyBonus = ((nXP * PARTY_XP_GP_BONUS) / 2);
            fKillerBonus = (nXPToGive * KILLER_XP_GP_BONUS);
            nXPToGive = FloatToInt(fPartyBonus) + nXPToGive;
        }
        else
        {
            fPartyBonus = ((nXP * PARTY_XP_GP_BONUS) / 4);
            fKillerBonus = (nXPToGive * KILLER_XP_GP_BONUS);
            nXPToGive = FloatToInt(fPartyBonus) + nXPToGive;
        }

    }

    GiveXP(oKiller, nXPToGive, fKillerBonus, nDiff, nPlayer, nBossReward);
    //XPDebugMessage(oKiller, fCR, nDiff, nLoLevel, nHiLevel, fAvLevel);
}
// This is my function that calculates the XP reward
int CalculateXP(float fLevel, float fCR)
{
    float fXPModifier, fDiff = fabs(fLevel - fCR), fBonus = (((0.1 * fCR) * 10) / 2);
    if (fCR >= fLevel)
    {
        if (fDiff >= 10.0) fXPModifier = 10.0;
        else if (fDiff >= 5.0 && fDiff < 10.0) fXPModifier = 5.0;
        else if (fDiff >= 4.0 && fDiff < 5.0) fXPModifier = 4.0;
        else if (fDiff >= 3.0 && fDiff < 4.0) fXPModifier = 3.5;
        else if (fDiff >= 2.0 && fDiff < 3.0) fXPModifier = 3.0;
        else if (fDiff >= 1.0 && fDiff < 2.0) fXPModifier = 2.5;
        else fXPModifier = 2.0;
    }
    else if (fCR < fLevel)
    {
        if (fDiff >= 4.0) fXPModifier = 0.25;
        else if (fDiff >= 4.0 && fDiff < 5.0) fXPModifier = 0.25;
        else if (fDiff >= 3.0 && fDiff < 4.0) fXPModifier = 0.75;
        else if (fDiff >= 2.0 && fDiff < 3.0) fXPModifier = 1.2;
        else if (fDiff >= 1.0 && fDiff < 2.0) fXPModifier = 1.5;
        else fXPModifier = 2.0;
    }
    return FloatToInt((fXPModifier * 10) + fBonus);
}

// This is my function to give XP to each party member within
// the distance specified by the constants
void GiveXP(object oKiller, int nXPToGive, float fKillerBonus, int nDiff, int nPlayer, int nBossReward)
{
    int nMaxXP;
    float fDist;
    location lLoc = GetLocation(oKiller);

    // Get first party members (Only PC's)
    object oParty = GetFirstFactionMember(oKiller,TRUE);

    object oItem = GetItemPossessedBy(oParty, "PC_Data_Object");
    // Loops through all party members
    while (GetIsObjectValid(oParty))
    {
        oItem = GetItemPossessedBy(oParty,"PC_Data_Object");
        // Make sure the party member is NOT dead and are within the specified distance
        fDist = GetDistanceToObject(oParty);
        if (GetIsPC(oParty))
        {
            if (!GetIsDead(oParty) && fDist >= 0.0 && fDist <= PARTY_DIST && GetIsObjectValid(oParty) == TRUE)
            {
                // Reward the killer with bonus if specified in consts
                nMaxXP = GetMaxXP(oParty);
                if (nXPToGive > nMaxXP)
                {
                    nXPToGive = nMaxXP;
                }
                else if (nXPToGive < MIN_XP)
                {
                    nXPToGive = MIN_XP;
                }
                if (oKiller == oParty && nPlayer > 1)
                {
                    if (nDiff > MAX_PARTY_GAP)
                    {
                        FloatingTextStringOnCreature("Party level difference is too great", oParty);
                        nXPToGive = MIN_XP;
                    }

                    if(nXPToGive <= 4)
                    {
                        SendMessageToPC(oParty,"You gain no meaningful experience from this encounter.");
                        return;
                    }
                    else
                    {
                        AwardXP(oParty, (nXPToGive + FloatToInt(fKillerBonus)));

                        if(nBossReward != 0)
                        {
                            SendMessageToPC(oParty,"You receive a bonus for killing a boss!");
                            AwardXP(oParty,nBossReward);
                        }
                    }
                }
                // Reward other party members
                else
                {
                    if(nXPToGive <= 4)
                    {
                        SendMessageToPC(oParty,"You gain no meaningful experience from this encounter.");
                    }
                    else
                    {
                        AwardXP(oParty, nXPToGive);
                        if(nBossReward != 0)
                        {
                            SendMessageToPC(oParty,"You receive a bonus for killing a boss!");
                            AwardXP(oParty,nBossReward);
                        }
                    }
                }
            }
        }
        oParty = GetNextFactionMember(oKiller,TRUE);
    }
}

// This is my function for returning the max XP for the PC's level based on the consts
int GetMaxXP(object oPC)
{
    int iMaxXP;
    switch(GetLevelFromXP(oPC))
    {
        case 1: iMaxXP = LEVEL_1_MAX_XP; break;
        case 2: iMaxXP = LEVEL_2_MAX_XP; break;
        case 3: iMaxXP = LEVEL_3_MAX_XP; break;
        case 4: iMaxXP = LEVEL_4_MAX_XP; break;
        case 5: iMaxXP = LEVEL_5_MAX_XP; break;
        case 6: iMaxXP = LEVEL_6_MAX_XP; break;
        case 7: iMaxXP = LEVEL_7_MAX_XP; break;
        case 8: iMaxXP = LEVEL_8_MAX_XP; break;
        case 9: iMaxXP = LEVEL_9_MAX_XP; break;
        case 10: iMaxXP = LEVEL_10_MAX_XP; break;
        case 11: iMaxXP = LEVEL_11_MAX_XP; break;
        case 12: iMaxXP = LEVEL_12_MAX_XP; break;
        case 13: iMaxXP = LEVEL_13_MAX_XP; break;
        case 14: iMaxXP = LEVEL_14_MAX_XP; break;
        case 15: iMaxXP = LEVEL_15_MAX_XP; break;
        case 16: iMaxXP = LEVEL_16_MAX_XP; break;
        case 17: iMaxXP = LEVEL_17_MAX_XP; break;
        case 18: iMaxXP = LEVEL_18_MAX_XP; break;
        case 19: iMaxXP = LEVEL_19_MAX_XP; break;
        case 20: iMaxXP = LEVEL_20_MAX_XP; break;
        case 21: iMaxXP = LEVEL_21_MAX_XP; break;
        case 22: iMaxXP = LEVEL_22_MAX_XP; break;
        case 23: iMaxXP = LEVEL_23_MAX_XP; break;
        case 24: iMaxXP = LEVEL_24_MAX_XP; break;
        case 25: iMaxXP = LEVEL_25_MAX_XP; break;
        case 26: iMaxXP = LEVEL_26_MAX_XP; break;
        case 27: iMaxXP = LEVEL_27_MAX_XP; break;
        case 28: iMaxXP = LEVEL_28_MAX_XP; break;
        case 29: iMaxXP = LEVEL_29_MAX_XP; break;
        case 30: iMaxXP = LEVEL_30_MAX_XP; break;
        case 31: iMaxXP = LEVEL_31_MAX_XP; break;
        case 32: iMaxXP = LEVEL_32_MAX_XP; break;
        case 33: iMaxXP = LEVEL_33_MAX_XP; break;
        case 34: iMaxXP = LEVEL_34_MAX_XP; break;
        case 35: iMaxXP = LEVEL_35_MAX_XP; break;
        case 36: iMaxXP = LEVEL_36_MAX_XP; break;
        case 37: iMaxXP = LEVEL_37_MAX_XP; break;
        case 38: iMaxXP = LEVEL_38_MAX_XP; break;
        case 39: iMaxXP = LEVEL_39_MAX_XP; break;
        case 40: iMaxXP = LEVEL_40_MAX_XP; break;
    }
    return iMaxXP;
}
// This new function will get the players level determined by XP rather than
// the players level to stop exploiting
int GetLevelFromXP(object oPC)
{
    int iXP = GetXP(oPC);
    if (iXP >= 780000) iXP = 40;
    else if (iXP >= 741000) iXP = 39;
    else if (iXP >= 703000) iXP = 38;
    else if (iXP >= 666000) iXP = 37;
    else if (iXP >= 630000) iXP = 36;
    else if (iXP >= 595000) iXP = 35;
    else if (iXP >= 561000) iXP = 34;
    else if (iXP >= 528000) iXP = 33;
    else if (iXP >= 496000) iXP = 32;
    else if (iXP >= 465000) iXP = 31;
    else if (iXP >= 435000) iXP = 30;
    else if (iXP >= 406000) iXP = 29;
    else if (iXP >= 378000) iXP = 28;
    else if (iXP >= 351000) iXP = 27;
    else if (iXP >= 325000) iXP = 26;
    else if (iXP >= 300000) iXP = 25;
    else if (iXP >= 276000) iXP = 24;
    else if (iXP >= 253000) iXP = 23;
    else if (iXP >= 231000) iXP = 22;
    else if (iXP >= 210000) iXP = 21;
    else if (iXP >= 190000) iXP = 20;
    else if (iXP >= 171000) iXP = 19;
    else if (iXP >= 153000) iXP = 18;
    else if (iXP >= 136000) iXP = 17;
    else if (iXP >= 120000) iXP = 16;
    else if (iXP >= 105000) iXP = 15;
    else if (iXP >= 91000) iXP = 14;
    else if (iXP >= 78000) iXP = 13;
    else if (iXP >= 66000) iXP = 12;
    else if (iXP >= 55000) iXP = 11;
    else if (iXP >= 45000) iXP = 10;
    else if (iXP >= 36000) iXP = 9;
    else if (iXP >= 28000) iXP = 8;
    else if (iXP >= 21000) iXP = 7;
    else if (iXP >= 15000) iXP = 6;
    else if (iXP >= 10000) iXP = 5;
    else if (iXP >= 6000) iXP = 4;
    else if (iXP >= 3000) iXP = 3;
    else if (iXP >= 1000) iXP = 2;
    else                  iXP = 1;
    return iXP;
}

void XPDebugMessage(object oPC, float fCR, int nDiff, int nLoLevel, int nHiLevel, float fAvLevel)
{
    object oParty = GetFirstPC();
    while (GetIsObjectValid(oParty))
    {
        if (GetIsDM(oParty) == TRUE)
        {
            SendMessageToPC(oParty, "\nDebug Info"+
                                "\nCreature CR: "+FloatToString(fCR)+
                                "\nHighest Level PC: "+IntToString(nHiLevel)+
                                "\nLowest Level PC: "+IntToString(nLoLevel)+
                                "\nLevel Difference: "+IntToString(nDiff)+
                                "\nAverage Party Level: "+FloatToString(fAvLevel));
        }
        oParty = GetNextPC();
    }
}
