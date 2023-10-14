#include "sp_wild_func"
#include "inc_sqlite_time"


const string WILDMAGIC_DB = "Wildmagic";
const string DEADMAGIC_DB = "Deadmagic";

const string TOKENIZER_CHAR = "_";
const int DECAY_HOURS = 1;
const int DECAY_PERCENTAGE = 17;



// Wildmagic zone
// This function will check for any wild magic effects and send calls to the
// wild magic tables based on that.
void X2WildMagicZone(object oCaster, object oTarget);

// Returns the percent chance of wild magic for the area
int FetchWildMagicChance(string sAreaTag);

// Adds to the percent chance of wild magic for the area, returns new total
int AddWildMagicChance(string sAreaTag, int nAmount);



// Deadmagic zone
// this function will check if the caster is in a Deadmagic zone and
// to what degree the deadmagic affects the caster Shadow weave practitioners
// and Mystran specialty priests will be immune
int X2DeadmagicZone(object oCaster);

// Returns the percent chance of dead magic for the area
int FetchDeadMagicChance(string sAreaTag);

// Adds to the percent chance of dead magic for the area, returns new total
int AddDeadMagicChance(string sAreaTag, int nAmount);



// PRIVATE METHODS, DO NOT CALL THESE OUTSIDE THIS SCRIPT
int FetchWeaveCorruption(string sCorruptionDB, string sAreaTag);
int AddWeaveCorruption(string sCorruptionDB, string sAreaTag, int nAmount);
void DetectionCheck(object oPC);



void X2WildMagicZone(object oCaster, object oTarget)
{
    string sAreaTag = GetTag(GetArea(oCaster));
    int nWildChance = FetchWildMagicChance(sAreaTag);

    if (GetLevelByClass(CLASS_TYPE_SPELLFIRE, oCaster) >= 1)
    {
        nWildChance = AddWildMagicChance(sAreaTag, d4(1));
        return; // corruptor, so exit without invoking wild magic reduction or effect
    } 
    else if (nWildChance > 1)
    {
        nWildChance = AddWildMagicChance(sAreaTag, -1);
    }

    if (nWildChance > 1)
    {
        DetectionCheck(oCaster);
        if (d100(1) < nWildChance)
        {
            WildMagicEffects(oCaster, oTarget);
        }
    }
}

int FetchWildMagicChance(string sAreaTag)
{
    return FetchWeaveCorruption(WILDMAGIC_DB, sAreaTag);
}

int AddWildMagicChance(string sAreaTag, int nAmount)
{
    return AddWeaveCorruption(WILDMAGIC_DB, sAreaTag, nAmount);
}




int X2DeadmagicZone(object oCaster)
{
    string sAreaTag = GetTag(GetArea(oCaster));
    int nSpellFailure = FetchDeadMagicChance(sAreaTag);

    if (GetHasFeat(FEAT_SHADOW_WEAVE_MAGIC, oCaster)
        || GetLevelByClass(CLASS_TYPE_SHADOW_ADEPT, oCaster)  >=1
        || GetLevelByClass(CLASS_TYPE_SHADOW_CHANNELER, oCaster)  >=1)
    {
        nSpellFailure = AddDeadMagicChance(sAreaTag, 1 + d4(1));
        return TRUE;
    } 
    else if (GetHasFeat(DEITY_Shar, oCaster))
    {
        return TRUE; // Shar worshippers are immune to shadow weave
    }
    else if (nSpellFailure > 1)
    {
        int nChanceToRemove = -1;
        if (GetHasFeat(DEITY_Mystra, oCaster))
        {
            nChanceToRemove -= 1;
        }
        if (GetHasFeat(DEITY_Azuth, oCaster))
        {
            nChanceToRemove -= 1;
        }
        if (GetHasFeat(FEAT_WEAVE_RESONANCE, oCaster))
        {
            nChanceToRemove -= 2;
        }
        nSpellFailure = AddDeadMagicChance(sAreaTag, nChanceToRemove);
    }

    if (nSpellFailure > 1)
    {
        DetectionCheck(oCaster);
        if (d100(1) < nSpellFailure)
        {
            return FALSE;
        }
    }
    return TRUE;
}

int FetchDeadMagicChance(string sAreaTag)
{
    return FetchWeaveCorruption(DEADMAGIC_DB, sAreaTag);
}

int AddDeadMagicChance(string sAreaTag, int nAmount)
{
    return AddWeaveCorruption(DEADMAGIC_DB, sAreaTag, nAmount);
}




// PRIVATE METHODS, DO NOT CALL THESE OUTSIDE THIS SCRIPT

int FetchWeaveCorruption(string sCorruptionDB, string sAreaTag)
{
    string sData = GetCampaignString(sCorruptionDB, sAreaTag);
    int nChance = StringToInt(StringParse(sData, TOKENIZER_CHAR));

    int nLastTimestamp = StringToInt(StringParse(sData, TOKENIZER_CHAR, TRUE));
    int nDecayPeriod = FloatToInt(HoursToSeconds(DECAY_HOURS));
    int nNow = SQLite_GetTimeStamp();
    int nIntervals = (nNow - nLastTimestamp) / nDecayPeriod;
    if (nIntervals > 0)
    {
        nChance = nChance - (DECAY_PERCENTAGE * nIntervals);
        if (nChance < 0)
        {
            nChance = 0;
        }
        sData = IntToString(nChance) 
            + TOKENIZER_CHAR 
            + IntToString(nLastTimestamp + nIntervals * nDecayPeriod);
        SetCampaignString(sCorruptionDB, sAreaTag, sData);
    }
    return nChance;
}

int AddWeaveCorruption(string sCorruptionDB, string sAreaTag, int nAmount)
{
    int nChance = FetchWeaveCorruption(sCorruptionDB, sAreaTag);
    int nTotal = nChance + nAmount;
    if (nTotal > 100)
    {
        nTotal = 100;
    }
    else if (nTotal < 0)
    {
        nTotal = 0;
    }
    int nTimestamp = SQLite_GetTimeStamp();
    string sData = IntToString(nTotal) + TOKENIZER_CHAR + IntToString(nTimestamp);
    SetCampaignString(sCorruptionDB, sAreaTag, sData);
    return nTotal;
}

void DetectionCheck(object oPC)
{
    if (GetSkillRank(SKILL_SPELLCRAFT, oPC) + d20() >= 15)
    {
        SendMessageToPC(oPC, "As you draw upon the local Weave, you sense something is amiss.");
    }
}