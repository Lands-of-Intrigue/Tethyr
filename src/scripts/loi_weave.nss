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




void X2WildMagicZone(object oCaster, object oTarget)
{
   object oArea = GetArea(oCaster);
   int nWildChance = FetchWildMagicChance(GetTag(oArea));
   if(nWildChance > 1)
   {
        SendMessageToPC(oCaster, "The weave has become strange and foreign here, magic may have additional unintended effects.");
   }
   if (GetLevelByClass(56, oCaster )>= 1)
   {
        SetCampaignInt("Wildmagic",GetTag(oArea), nWildChance - d8(1));
   }
   else if (GetLevelByClass(49, oCaster) >= 1 && d100(1) > 50)
   {
        SetCampaignInt("Wildmagic",GetTag(oArea), nWildChance + d8(1));
   }

   if(GetCampaignInt("Wildmagic",GetTag(oArea)) < 0)   {SetCampaignInt("Deadmagic",GetTag(oArea),0);}
   if(GetCampaignInt("Wildmagic",GetTag(oArea)) > 100) {SetCampaignInt("Deadmagic",GetTag(oArea),100);}

   if (d100(1) < nWildChance)
        WildMagicEffects(oCaster, oTarget);
}

int FetchWildMagicChance(string sAreaTag)
{
    return FetchWeaveCorruption(WILDMAGIC_DB, sAreaTag);
}

int AddWildMagicChance(string sAreaTag, int nAmount)
{
    return AddWeaveCorruption(WILDMAGIC_DB, sAreaTag, nAmount)
}




int X2DeadmagicZone(object oCaster)
{
    object oArea = GetArea(oCaster);
    int nSpellFailure = GetCampaignInt("Deadmagic",GetTag(oArea));

    //  checking if the caster notises the damage to the weave
    if(nSpellFailure > 1 && (GetHasFeat(1586, oCaster)))
    {
       SendMessageToPC(oCaster, "You can sense serious distortions in the local Weave. Spells cast in this area are prone to failure.");
        if (nSpellFailure < 33) { SendMessageToPC(oCaster, "After further inspection, the weave is minorly damaged here."); }
        else if (nSpellFailure < 66) { SendMessageToPC(oCaster, "After further inspection, the weave is damaged to a significant degree here."); }
        else { SendMessageToPC(oCaster, "After further inspection, the weave here is extremely damaged, and will be difficult to repair"); }
    }

    // Mearly casting the spell will strenthen or weaken the weave.
    if (GetLevelByClass(48 , oCaster)  >=1)
    {
    SetCampaignInt("Deadmagic",GetTag(oArea), nSpellFailure + (TE_GetCasterLevel(oCaster, GetLastSpellCastClass())/4));
    }
    else if (GetHasFeat(1300, oCaster))
    {
        SetCampaignInt("Deadmagic",GetTag(oArea), nSpellFailure + (TE_GetCasterLevel(oCaster, GetLastSpellCastClass())/8));
    }
    else if(GetLevelByClass(56, oCaster)  >= 1)
    {
        SetCampaignInt("Deadmagic",GetTag(oArea), nSpellFailure - (TE_GetCasterLevel(oCaster, GetLastSpellCastClass())/4));
        //SetLocalInt(oArea, "Deadmagic", nSpellFailure - TE_GetCasterLevel(oCaster, GetLastSpellCastClass()));
    }
    else if(GetHasFeat(DEITY_Mystra, oCaster) && ( GetLevelByClass(CLASS_TYPE_CLERIC, oCaster)  >= 1 || GetLevelByClass(CLASS_TYPE_PALADIN, oCaster) >= 1))
    {
        SetCampaignInt("Deadmagic",GetTag(oArea), nSpellFailure - (TE_GetCasterLevel(oCaster, GetLastSpellCastClass())/6));
        //SetLocalInt(oArea, "Deadmagic", nSpellFailure - TE_GetCasterLevel(oCaster, GetLastSpellCastClass()));
    }
    else if(GetHasFeat(DEITY_Azuth, oCaster) && GetLevelByClass(CLASS_TYPE_PALADIN, oCaster) >= 1)
    {
        SetCampaignInt("Deadmagic",GetTag(oArea), nSpellFailure - ( TE_GetCasterLevel(oCaster, GetLastSpellCastClass()) / 8 ));
        //SetLocalInt(oArea, "Deadmagic", nSpellFailure - ( TE_GetCasterLevel(oCaster, GetLastSpellCastClass()) / 2 ));
    }
    else
    {
        SetCampaignInt("Deadmagic",GetTag(oArea),nSpellFailure - 1);
        //SetLocalInt(oArea, "Deadmagic", nSpellFailure - 1);
    }

    // making shure that Deadmagic is no less then 0 (full strength of the weave) or greater than 100 (100% spell falliure)
    if(GetCampaignInt("Deadmagic",GetTag(oArea)) < 0)   {SetCampaignInt("Deadmagic",GetTag(oArea),0);}
    if(GetCampaignInt("Deadmagic",GetTag(oArea)) > 100) {SetCampaignInt("Deadmagic",GetTag(oArea),100);}

    // roll for spell failliure
    if(d100() < nSpellFailure)
    {
        // check if caster has reason to ignore thise spell failliure if caster is shadow weave practitioner or Mystran cleric then they ignore it

    if(GetHasFeat(1300, oCaster)==TRUE ||
      (GetHasFeat(DEITY_Mystra, oCaster)==TRUE && ( GetLevelByClass(CLASS_TYPE_CLERIC, oCaster)  >= 1 || GetLevelByClass(CLASS_TYPE_PALADIN, oCaster) >= 1))
          )

        {
          return TRUE;
        }
        else
        {
            SendMessageToPC(oCaster, "The spell effect fails inexplicably. In order to learn more, you need to improve your knowledge of spellcraft.");
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
    string sWildData = GetCampaignString(sCorruptionDB, sAreaTag);
    int nChance = StringToInt(StringParse(sWildData, TOKENIZER_CHAR));

    int nLastTimestamp = StringToInt(StringParse(sWildData, TOKENIZER_CHAR, TRUE));
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
        string sWildData = IntToString(nChance) 
            + TOKENIZER_CHAR 
            + IntToString(nLastTimestamp + nIntervals * nDecayPeriod);
        SetCampaignString(sCorruptionDB, sWildData);
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
    string sWildData = IntToString(nTotal) + TOKENIZER_CHAR + IntToString(nTimestamp);
    SetCampaignString(sCorruptionDB, sWildData);
    return nTotal;
}