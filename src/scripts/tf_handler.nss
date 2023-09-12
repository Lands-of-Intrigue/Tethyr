//::///////////////////////////////////////////////
//:: Tracking Functions
//:: Function(D20) 2019
//:://////////////////////////////////////////////
//:: Created By; Sloth
//:: Credits:
//:: Map Pin System - https://nwn.fandom.com/wiki/Map_pin
//:://////////////////////////////////////////////
/*
    Instructions: Add below string at beginning of script for functions
        #include "TF_Handler"

    Table of Contents
    1. CONSTANTS LIST - Descriptors
        1.1 Variables
            TF_GetCreatureSizeType
            TF_GetCreatureSizeDC
            TF_GetEnvironmentDC
            TF_GetFavored
            TF_GetFog
            TF_GetFogDC
            TF_GetHasBeenTracked
            TF_GetIsTrackable
            TF_GetRacialType
            TF_GetSizeType
            TF_GetSurvival
            TF_GetSurvivalMod
            TF_GetTerrainType
            TF_GetTerrainDC
            TF_GetTimeDC
            TF_GetTrackDC
            TF_GetVisibility
            TF_GetVisibilityDC
            TF_GetWeatherType
            TF_GetWeatherDC
        1.2 Tracking System
            TF_ClearHasBeenTrackedArray
            TF_SetHasBeenTracked
        1.3 Map Pin System
            DeleteMapPin
            GetAreaOfMapPin
            GetFirstDeletedMapPin
            SetMapPin
            TF_ClearTracks
            TF_TrackRun

    2. FUNCTION LIST - Where The Magic Happens
        2.1 Variables
            TF_GetCreatureSizeType
            TF_GetCreatureSizeDC
            TF_GetEnvironmentDC
            TF_GetFavored
            TF_GetFog
            TF_GetFogDC
            TF_GetHasBeenTracked
            TF_GetIsTrackable
            TF_GetRacialType
            TF_GetSizeType
            TF_GetSurvival
            TF_GetSurvivalMod
            TF_GetTerrainType
            TF_GetTerrainDC
            TF_GetTimeDC
            TF_GetTrackDC
            TF_GetVisibility
            TF_GetVisibilityDC
            TF_GetWeatherType
            TF_GetWeatherDC
        2.2 Tracking System
            TF_ClearHasBeenTrackedArray
            TF_SetHasBeenTracked
        2.3 Map Pin System
            DeleteMapPin
            GetAreaOfMapPin
            GetFirstDeletedMapPin
            SetMapPin
            TF_ClearTracks
            TF_TrackRun
    3. DEBUG
*/
#include "array_handler"
#include "x3_inc_horse"
//:://////////////////////////////////////////////
/*
1. CONSTANTS
*/
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//::1.1 Variables
//:://////////////////////////////////////////////

//DECLARE CONSTANTS
//Custom Server Constants
const string SERVER_IP = "192.168.1.8:5121"; //IP Address:Port
const string SERVER_PW = "";                 //IP Address:Password
//Custom Token Constants
const int CTOKEN_LIST_BEGIN = 3000;          //First Custom Token Number
const int CTOKEN_LIST_END = 3100;            //Last Custom Token Number
//Custom Journal Constants
const string CJOURNAL_S_TAG = "jTracking";   //sTag of Journal
const int CJOURNAL_N_STATE = 100;            //nState of Journal



//PERSISTANT CONSTANTS
//Race Constants
const int RACIAL_TYPE_PLANT = 52;
//Size Constants
const int TF_CREATURESIZETYPE_TINY = 1;
const int TF_CREATURESIZETYPE_SMALL = 2;
const int TF_CREATURESIZETYPE_MEDIUM = 3;
const int TF_CREATURESIZETYPE_HUGE = 4;
const int TF_CREATURESIZETYPE_LARGE = 5;
//Terrain Constants
const int TF_TERRAINTYPE_NONE = 0;
const int TF_TERRAINTYPE_VERYSOFT = 1;
const int TF_TERRAINTYPE_SOFT = 2;
const int TF_TERRAINTYPE_FIRM = 3;
const int TF_TERRAINTYPE_HARD = 4;
//Terrain Constants
const int TF_VISIBILITY_LIGHT = 0;
const int TF_VISIBILITY_NOLIGHT = 1;
//Weather Constants
const int TF_WEATHERTYPE_NONE = 0;
const int TF_WEATHERTYPE_RAIN = 1;
const int TF_WEATHERTYPE_STORM = 2;
//Delay Constant
const float SERVER_CLEAR_DELAY = 30.0;

int i;
int iPinID;
int iTotal;
int iUpdateDeleted;
int nEnvMod;
int nFog;
int nFogMod;
int nLevel;
int nNth;
int nSize;
int nSizeMod;
int nObjectMod;
int nRacialType;
int nRangerMod;
int nRoll;
int nSizeType;
int nSurvival;
int nSurvivalMod;
int nTerrain;
int nTerrainMod;
int nTotal;
int nTrackDC;
int nTrackedSizeDC;
int nTrackedTypeDC;
int nTrackedNameDC;
int nTrackID;
int nTimeMod;
int nVisibility;
int nVisibilityMod;
int nWeather;
int nWeatherMod;
int nWIS;

string sClear;
string sName;
string sNth;
string sPinID;
string sRacialType;
string sSizeType;
string sTrackID;

location lTArea;

object oArea;
object oTArea;
object oTarget;
object oTracked;

vector vPos;

//Returns Gender string
string TF_GetGenderName(int nGender);

//Return Weight string
string TF_GetWeightName(int nWeight);

//Function: Get Racial Type name
string TF_GetRacialName(int nRacialType);

// Function for getting nearest trackable object and returning relevant details after DC checks.
// Works on Blood placeables and on Footprints
void TF_Looking(object oPC);

//test
void TF_SetTrackingList(string sText, int nToken);

//test
void TF_ClearTrackingList();

//Get Size Type
//Return nSize
//  TF_CREATURESIZETYPE_TINY = 1
//  TF_CREATURESIZETYPE_SMALL = 2
//  TF_CREATURESIZETYPE_MEDIUM = 3
//  TF_CREATURESIZETYPE_HUGE = 4
//  TF_CREATURESIZETYPE_LARGE = 5
int TF_GetCreatureSizeType(object oObject);

//Get Size DC
//Return nSizeMod
//  TF_CREATURESIZETYPE_TINY = +4 DC
//  TF_CREATURESIZETYPE_SMALL = +2 DC
//  TF_CREATURESIZETYPE_MEDIUM = 0 DC
//  TF_CREATURESIZETYPE_HUGE = -2 DC
//  TF_CREATURESIZETYPE_LARGE = -4 DC
int TF_GetCreatureSizeDC(int nSize);

//Get Environment DC
//Returns nEnvDC
//  Inside =
//      nTerrainMod +
//      nVisibilityMod
//  Outside =
//      nTerrainMod +
//      nTimeMod +
//      nWeatherMod +
//      nFogMod
int TF_GetEnvironmentDC(object oArea, int nFogMod, int nTerrainMod, int nTimeMod, int nWeatherMod, int nVisibilityMod);

//Get if oTarget is Favored by oObject
//Returns TRUE, FALSE
int TF_GetFavored(object oObject, object oTarget);

//Get Fog
//Returns nFog
int TF_GetFog(object oArea);

//Get Fog DC
//Returns nFogMod
// None = 0 DC
// Fog = +3 DC
int TF_GetFogDC(int nFog);

//Function: Get Has Been Tracked
int TF_GetHasBeenTracked(object oTarget, object oPC);

//Get Is Trackable
//Returns Boolean
int TF_GetIsTrackable(object oObject);

//Returns Creature Type String
//Invalid returns Creature Type #
string TF_GetRacialType(object oObject);

//Returns Creature Size String
//Invalid returns Creature Type #
string TF_GetSizeType(object oObject);

//Get Total Survival
// nSurvival =
//  (nLevel of oObject) +
//  (nWIS of oObject) +
//  (nRangerMod) +
//  (nSurvivalMod)
int TF_GetSurvival(object oObject, int nSurvivalMod=0);

//Get Survival Modifier
//  +5 vs Animal (Feat 1437)
//  +2 vs Outside (Feat 1430)
//  +2 vs Favored (Favored)
int TF_GetSurvivalMod(object oObject, object oTarget, object oArea);

//Get Terrain Type
//Returns int "nTerrain" from "iXPRate"
//TF_TERRAINTYPE_NONE: (NULL or ERROR)
//TF_TERRAINTYPE_VERYSOFT:
//  4    Marshes (Exterior)
//TF_TERRAINTYPE_SOFT:
//  2    Plains (Exterior)
//  5    Forests (Exterior)
//TF_TERRAINTYPE_FIRM:
//  3    Hills/Mountains (Exterior)
//  7    Roads (Exterior)
//  8    Towns (Exterior)
//  11    Taverns (Interior)
//TF_TERRAINTYPE_HARD:
//  1    Deserts (Exterior)
//  6    Crypts/Caverns (Interior/Exterior)
//  9    Temples (Interior)
//  10    Secret Areas (Interior)
//  12    Keeps (Interior)
//  13     Magic Gain Area
int TF_GetTerrainType(object oArea);

//Get Terrain DC
//Returns int nTerrainMod
//TF_TERRAINTYPE_NONE = 0 DC (NULL or ERROR)
//TF_TERRAINTYPE_VERYSOFT = +5 DC
//TF_TERRAINTYPE_SOFT = +10 DC
//TF_TERRAINTYPE_FIRM = +15 DC
//TF_TERRAINTYPE_HARD = +20 DC
int TF_GetTerrainDC(int nTerrain);

//Get Time DC
//Returns nTimeMod
//Day = 0 DC
//Night = +4 DC
int TF_GetTimeDC(object oObject);

//Get Track DC
//  nTrackDC =
//      nEnvDC +
//      nSizeMod +
//      nWeatherMod +
//      nFogMod
int TF_GetTrackDC(int nEnvMod, int nSizeMod);

//Get Visibility
//Returns int nVisibility
//TF_VISIBILITY_NOLIGHT = 1
//TF_VISIBILITY_LIGHT = 0
int TF_GetVisibility(object oArea);

//Get Visibility DC
//Returns nVisibilityMod
// Light = 0 DC
// No Light = +6 DC
int TF_GetVisibilityDC(int nVisibility, object oObject);

//Get Weather Type
//Return nWeather
//  TF_WEATHERTYPE_NONE = 0
//  TF_WEATHERTYPE_RAIN = 1
//  TF_WEATHERTYPE_STORM = 2
int TF_GetWeatherType(object oArea);

//Get Weather DC
//Return nWeather
//  TF_WEATHERTYPE_NONE = 0 DC
//  TF_WEATHERTYPE_RAIN = +2 DC
//  TF_WEATHERTYPE_STORM = +4 DC
int TF_GetWeatherDC(int nWeather);

//:://////////////////////////////////////////////
//::1.2 Tracking System
//:://////////////////////////////////////////////

//Clears Stored Has Been Tracked Arrays
void TF_ClearHasBeenTrackedArray(object oPC);

//Set Has Been Tracked on Array
void TF_SetHasBeenTracked(object oTarget, object oPC);


//:://////////////////////////////////////////////
//::1.3 Map Pin System
//:://////////////////////////////////////////////

// Mark a map pin as deleted. Not a real delete to maintain the array
void DeleteMapPin(object oPC, int iPinID);

// Returns oArea from iPinID
object GetAreaOfMapPin(object oPC, int iPinID);

/* Declarations */
// Return iPinID of the first deleted map pin within the personal map pin array
int GetFirstDeletedMapPin(object oPC);

// Set a personal map pin on oPC. Returns iPinID.
// Defaults: GetArea(oPC) and fX/fY from GetPosition(oPC)
int SetMapPin(object oPC, string sPinText, float fX=-1.0, float fY=-1.0, object oArea=OBJECT_INVALID);

//Force Clear Tracks
void TF_ForceClearTracks(object oObject);

//Clear Track Pins
void TF_ClearTracks(object oObject);

//Execute Tracking
void TF_TrackRun(object oObject);

//:://////////////////////////////////////////////
/*
2. FUNCTIONS
*/
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//::2.1 Variables
//:://////////////////////////////////////////////

//Function: Get Size Type
int TF_GetCreatureSizeType(object oObject)
{
    nSize = GetCreatureSize(oObject);
    if(nSize == 1){return TF_CREATURESIZETYPE_TINY;}
    if(nSize == 2){return TF_CREATURESIZETYPE_SMALL;}
    if(nSize == 3){return TF_CREATURESIZETYPE_MEDIUM;}
    if(nSize == 4){return TF_CREATURESIZETYPE_HUGE;}
    if(nSize == 5){return TF_CREATURESIZETYPE_LARGE;}
    return 0;
}

//Function: Get Creature Size DC
int TF_GetCreatureSizeDC(int nSize)
{
    if(nSize == TF_CREATURESIZETYPE_TINY){return 4;}
    if(nSize == TF_CREATURESIZETYPE_SMALL){return 2;}
    if(nSize == TF_CREATURESIZETYPE_MEDIUM){return 0;}
    if(nSize == TF_CREATURESIZETYPE_HUGE){return -2;}
    if(nSize == TF_CREATURESIZETYPE_LARGE){return -4;}
    return 0;
}

//Function: Get Environment DC
int TF_GetEnvironmentDC(object oArea, int nFogMod, int nTerrainMod, int nTimeMod, int nWeatherMod, int nVisibilityMod)
{
    if ((!GetIsAreaInterior(oArea)) && GetIsAreaAboveGround(oArea))
    {
        nEnvMod = (nTerrainMod + nTimeMod + nWeatherMod + nFogMod);
        return nEnvMod;
    }
    if (GetIsAreaInterior(oArea) || (!GetIsAreaAboveGround(oArea)))
    {
        nEnvMod = (nTerrainMod + nVisibilityMod);
        return nEnvMod;
    }
    return 0;
}

//Function: Get Favored
int TF_GetFavored(object oObject, object oTarget)
{
    if (GetHasFeat(FEAT_FAVORED_ENEMY_ABERRATION, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_ABERRATION){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_ANIMAL, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_ANIMAL){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_BEAST, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_BEAST){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_CONSTRUCT, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_DRAGON, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_DRAGON){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_DWARF, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_DWARF){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_ELEMENTAL, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_ELEMENTAL){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_ELF, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_ELF){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_FEY, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_FEY){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_GIANT, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_GIANT){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_GNOME, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_GNOME){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_GOBLINOID, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_GOBLINOID){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_HALFELF, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_HALFELF){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_HALFLING, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_HALFLING){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_HALFORC, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_HALFORC){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_HUMAN, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_HUMAN){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_MAGICAL_BEAST, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_MAGICAL_BEAST){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_MONSTROUS, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_MONSTROUS){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_ORC, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_ORC){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_OUTSIDER, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_OUTSIDER){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_REPTILIAN, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_REPTILIAN){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_SHAPECHANGER, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_SHAPECHANGER){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_UNDEAD, oObject) == TRUE && (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD|| GetIsUndead(oTarget) == TRUE)){return TRUE;}
    if (GetHasFeat(FEAT_FAVORED_ENEMY_VERMIN, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_VERMIN){return TRUE;}
    return FALSE;
}

//Function: Get Fog
int TF_GetFog(object oArea)
{
    float fHumidity=GetLocalFloat(GetModule(),"Weather_Local_Sky_Humidity")+IntToFloat(GetLocalInt(oArea,"Humidity"));
    if (fHumidity >= 90.0){return TRUE;}
    return FALSE;
}

//Function: Get Fog DC
int TF_GetFogDC(int nFog)
{
    if (nFog == TRUE){return 3;}
    return 0;
}

//Function: Get Has Been Tracked
int TF_GetHasBeenTracked(object oTarget, object oPC)
{
    nLoop = 1;
    oTracked = JL_GetLocalArrayObject(oPC, "oTracked", nLoop);
    while (oTracked != OBJECT_INVALID)
    {
        if (oTracked == oTarget) {return TRUE;}

        nLoop = nLoop+1;
        oTracked = JL_GetLocalArrayObject(oPC, "oTracked", nLoop);
    }
    return FALSE;
}

//Function: Get Is Trackable
int TF_GetIsTrackable(object oObject)
{
    if(GetHasFeat(FEAT_TRACKLESS_STEP, oObject) ||
       GetHasFeat(FEAT_WOODLAND_STRIDE, oObject) ||
       GetLevelByClass(CLASS_TYPE_ASSASSIN, oObject) == 4 ||
       GetLocalInt(oObject, "X2_L_IS_INCORPOREAL") == 1 ||
       GetLocalInt(oObject, "nFlying") == 1 ||
       GetRacialType(oObject) == RACIAL_TYPE_PLANT)
    {
        return FALSE;
    }
return TRUE;
}

//Function: Get Racial Type
string TF_GetRacialType(object oObject)
{
    nRacialType = GetRacialType(oObject);
    if (nRacialType == RACIAL_TYPE_ABERRATION) {return "Aberration";}
    if (nRacialType == RACIAL_TYPE_ANIMAL) {return "Animal";}
    if (nRacialType == RACIAL_TYPE_BEAST) {return "Beast";}
    if (nRacialType == RACIAL_TYPE_CONSTRUCT) {return "Construct";}
    if (nRacialType == RACIAL_TYPE_DRAGON) {return "Dragon";}
    if (nRacialType == RACIAL_TYPE_DWARF) {return "Dwarf";}
    if (nRacialType == RACIAL_TYPE_ELEMENTAL) {return "Elemental";}
    if (nRacialType == RACIAL_TYPE_ELF) {return "Elf";}
    if (nRacialType == RACIAL_TYPE_FEY) {return "Fey";}
    if (nRacialType == RACIAL_TYPE_GIANT) {return "Giant";}
    if (nRacialType == RACIAL_TYPE_GNOME) {return "Gnome";}
    if (nRacialType == RACIAL_TYPE_HALFELF) {return "Half-Elf";}
    if (nRacialType == RACIAL_TYPE_HALFLING) {return "Halfing";}
    if (nRacialType == RACIAL_TYPE_HALFORC) {return "Half-Orc";}
    if (nRacialType == RACIAL_TYPE_HUMAN) {return "Human";}
    if (nRacialType == RACIAL_TYPE_HUMANOID_GOBLINOID) {return "Goblin";}
    if (nRacialType == RACIAL_TYPE_HUMANOID_MONSTROUS) {return "Monster";}
    if (nRacialType == RACIAL_TYPE_HUMANOID_ORC) {return "Orc";}
    if (nRacialType == RACIAL_TYPE_HUMANOID_REPTILIAN) {return "Reptile";}
    if (nRacialType == RACIAL_TYPE_MAGICAL_BEAST) {return "Magical Beast";}
    if (nRacialType == RACIAL_TYPE_OOZE) {return "Ooze";}
    if (nRacialType == RACIAL_TYPE_OUTSIDER) {return "Outsider";}
    if (nRacialType == RACIAL_TYPE_PLANT) {return "Plant";}
    if (nRacialType == RACIAL_TYPE_SHAPECHANGER) {return "Shapechanger";}
    if (nRacialType == RACIAL_TYPE_UNDEAD) {return "Undead";}
    if (nRacialType == RACIAL_TYPE_VERMIN) {return "Vermin";}
    return IntToString(nRacialType);
}

//Function: Get Racial Type
string TF_GetSizeType(object oObject)
{
    nSizeType = GetCreatureSize(oObject);
    if (nSizeType == CREATURE_SIZE_HUGE) {return "Huge";}
    if (nSizeType == CREATURE_SIZE_LARGE) {return "Large";}
    if (nSizeType == CREATURE_SIZE_MEDIUM) {return "Medium";}
    if (nSizeType == CREATURE_SIZE_SMALL) {return "Small";}
    if (nSizeType == CREATURE_SIZE_TINY) {return "Tiny";}
    return IntToString(nSizeType);
}

//Function: Get Survival
int TF_GetSurvival(object oObject, int nSurvivalMod=0)
{
    nLevel = GetHitDice(oObject);
    nWIS = GetAbilityModifier(ABILITY_WISDOM, oObject);
    nSurvival = (nLevel+nWIS);
    nRangerMod = GetLevelByClass(CLASS_TYPE_RANGER, oObject)/2;
    nSurvival = (nSurvival+nRangerMod+nSurvivalMod);
    return nSurvival;
}

//Function: Get SurvivalMod
int TF_GetSurvivalMod(object oObject, object oTarget, object oArea)
{
    nSurvivalMod = 0;
    if (GetHasFeat(1437, oObject) == TRUE && GetRacialType(oTarget) == RACIAL_TYPE_ANIMAL)
    {
        nSurvivalMod = (nSurvivalMod+5);
    }
    if (GetHasFeat(1430, oObject) == TRUE && GetIsAreaInterior(oArea) || (!GetIsAreaAboveGround(oArea)))
    {
        nSurvivalMod = (nSurvivalMod+2);
    }
    if (TF_GetFavored(oObject, oTarget) == TRUE)
    {
        nSurvivalMod = (nSurvivalMod+2);
    }
    return nSurvivalMod;
}

//Function: Get Terrain Type
int TF_GetTerrainType(object oArea)
{
    nTerrain = GetLocalInt(oArea, "iXPRate");
    if (nTerrain == 4)
    {
        return TF_TERRAINTYPE_VERYSOFT;
    }
    if (nTerrain == 2 ||
        nTerrain == 5)
        {
            return TF_TERRAINTYPE_SOFT;
        }
    if (nTerrain == 3 ||
        nTerrain == 7 ||
        nTerrain == 8 ||
        nTerrain == 11)
        {
            return TF_TERRAINTYPE_FIRM;
        }
    if (nTerrain == 1 ||
        nTerrain == 6 ||
        nTerrain == 9 ||
        nTerrain == 10 ||
        nTerrain == 12 ||
        nTerrain == 13)
        {
            return TF_TERRAINTYPE_HARD;
        }
    return TF_TERRAINTYPE_NONE;
}

//Function: Get Terrain DC
int TF_GetTerrainDC(int nTerrain)
{
    if(nTerrain == TF_TERRAINTYPE_VERYSOFT){return 5;}
    if(nTerrain == TF_TERRAINTYPE_SOFT){return 10;}
    if(nTerrain == TF_TERRAINTYPE_FIRM){return 15;}
    if(nTerrain == TF_TERRAINTYPE_HARD){return 20;}
    return 0;
}

//Function: GetTimeDC
int TF_GetTimeDC(object oObject)
{
    if (!GetIsDay())
    {
        if (GetHasFeat(FEAT_LOWLIGHTVISION, oObject) || GetHasFeat(FEAT_DARKVISION, oObject))
        {
        return 0;
        }
        else
        {
        return 4;
        }
    }
    return 0;
}

//Function: Get Track DC
int TF_GetTrackDC(int nEnvMod, int nSizeMod)
{
    nTrackDC = (nEnvMod + nSizeMod);
    return nTrackDC;
}

//Function: Get Visibility
int TF_GetVisibility(object oArea)
{
    if (GetIsAreaNatural(oArea) && GetIsAreaInterior(oArea))
    {
        return TF_VISIBILITY_NOLIGHT;
    }
    return TF_VISIBILITY_LIGHT;
}

//Function: Get Visibility DC
int TF_GetVisibilityDC(int nVisibility, object oObject)
{
    if (nVisibility == TF_VISIBILITY_NOLIGHT)
    {
        if (GetHasFeat(FEAT_DARKVISION, oObject))
        {
        return 0;
        }
        else
        {
        return 6;
        }
    }
    return 0;
}

//Function: Get Weather Type
int TF_GetWeatherType(object oArea)
{
    float fRain = GetLocalFloat(GetModule(),"Weather_Local_Rain");
    float fWind=GetLocalFloat(GetModule(),"Weather_Global_Wind")*(100.0+IntToFloat(GetLocalInt(oArea,"Wind")))/100.0;
    if (fRain >= 0.5 && fWind >= 20.0){return TF_WEATHERTYPE_STORM;}
    else if (fRain >= 0.5) {return TF_WEATHERTYPE_RAIN;}
    else {return TF_WEATHERTYPE_NONE;}
}

//Function: Get Weather DC
int TF_GetWeatherDC(int nWeather)
{
    if (nWeather == TF_WEATHERTYPE_RAIN) {return 2;}
    else if (nWeather == TF_WEATHERTYPE_STORM) {return 4;}
    else {return 0;}
}

//:://////////////////////////////////////////////
//::2.2 Tracking System
//:://////////////////////////////////////////////

//Function: Clears Has Been Tracked Array
void TF_ClearHasBeenTrackedArray(object oPC)
{
    JL_ClearLocalArrayObject(oPC, "oTracked");
}

//Function: Set Has Been Tracked
void TF_SetHasBeenTracked(object oTarget, object oPC)
{
    nLoop = 1;
    oTracked = JL_GetLocalArrayObject(oPC, "oTracked", nLoop);
    while (oTracked != OBJECT_INVALID)
    {
        if (oTracked == oTarget) {return;}

        nLoop = nLoop+1;
        oTracked = JL_GetLocalArrayObject(oPC, "oTracked", nLoop);
    }
    JL_SetLocalArrayObject(oPC, "oTracked", nLoop, oTarget);
}

//:://////////////////////////////////////////////
//::2.2 Map Pin System
//:://////////////////////////////////////////////
 void DeleteMapPin(object oPC, int iPinID)
{
   sPinID = IntToString(iPinID);
   // Only mark as deleted if set
   if(GetLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID) != "") {
       SetLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID, "DELETED");
       SetLocalFloat(oPC, "NW_MAP_PIN_XPOS_" + sPinID, 0.0);
       SetLocalFloat(oPC, "NW_MAP_PIN_YPOS_" + sPinID, 0.0);
       SetLocalObject(oPC, "NW_MAP_PIN_AREA_" + sPinID, OBJECT_INVALID);
   }
}

object GetAreaOfMapPin(object oPC, int iPinID)
{
   return GetLocalObject(oPC, "NW_MAP_PIN_AREA_"+IntToString(iPinID));
}

//Function: Get First Deleted Map Pin
int GetFirstDeletedMapPin(object oPC)
{
   iPinID = 0;
   iTotal = GetLocalInt(oPC, "NW_TOTAL_MAP_PINS");
   if(iTotal > 0) {
       for(i=1; i<=iTotal; i++) {
           if(GetLocalString(oPC, "NW_MAP_PIN_NTRY_" + IntToString(i)) == "DELETED") {
               iPinID = i;
               break;
           }
       }
   }
   return iPinID;
}

//Function: Set Map Pin
int SetMapPin(object oPC, string sPinText, float fX=-1.0, float fY=-1.0, object oArea=OBJECT_INVALID)
{
   // If oArea is not valid, we use the current area.
   if(oArea == OBJECT_INVALID) { oArea = GetArea(oPC); }
   // if fX and fY are both -1.0, we use the position of oPC
   if(fX == -1.0 && fY == -1.0) {
       vPos=GetPosition(oPC);
       fX = vPos.x;
       fY = vPos.y;
   }
   // Find out if we can reuse a deleted map pin
   iUpdateDeleted = TRUE;
   iPinID = 0;
   iTotal = GetLocalInt(oPC, "NW_TOTAL_MAP_PINS");
   if(iTotal > 0) { iPinID = GetFirstDeletedMapPin(oPC); }
   // Otherwise use a new one
   if(iPinID == 0) { iPinID = iTotal + 1; iUpdateDeleted = FALSE; }
   // Set the pin
   sPinID = IntToString(iPinID);
   SetLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID, sPinText);
   SetLocalFloat(oPC, "NW_MAP_PIN_XPOS_" + sPinID, fX);
   SetLocalFloat(oPC, "NW_MAP_PIN_YPOS_" + sPinID, fY);
   SetLocalObject(oPC, "NW_MAP_PIN_AREA_" + sPinID, oArea);
   if(!iUpdateDeleted) { SetLocalInt(oPC, "NW_TOTAL_MAP_PINS", iPinID); }
   return iPinID;
}

//Function: Clear Track Pins
void TF_ClearTracks(object oObject)
{

    oTArea = GetWaypointByTag("tracking");
    lTArea =  GetLocation(oTArea);

    nNth = 1;
    sNth = IntToString(nNth);
    sClear = ("nClear" + sNth);
    iPinID = GetLocalInt(oObject, sClear);
    sPinID = IntToString(iPinID);
    //Example: "nClear1"
    while (iPinID != 0)
    {

        //SetLocalInt(oObject, sClear, 0);

        DeleteMapPin(oObject, iPinID);

        nNth = nNth+1;
        sNth = IntToString(nNth);
        sClear = ("nClear" + sNth);
        iPinID = GetLocalInt(oObject, sClear);
        sPinID = IntToString(iPinID);
    }
}

//Function: Clear Track Pins
void TF_ForceClearTracks(object oObject)
{

    oTArea = GetWaypointByTag("tracking");
    lTArea =  GetLocation(oTArea);

    nNth = 1;
    sNth = IntToString(nNth);
    sClear = ("nClear" + sNth);
    iPinID = GetLocalInt(oObject, sClear);
    sPinID = IntToString(iPinID);
    //Example: "nClear1"
    while (iPinID != 0)
    {

        //SetLocalInt(oObject, sClear, 0);

        DeleteMapPin(oObject, iPinID);

        nNth = nNth+1;
        sNth = IntToString(nNth);
        sClear = ("nClear" + sNth);
        iPinID = GetLocalInt(oObject, sClear);
        sPinID = IntToString(iPinID);
    }
    ActivatePortal(oObject, SERVER_IP, SERVER_PW, "", TRUE);
}

//Function: Execute Tracking
void TF_TrackRun(object oObject)
{
    TF_ClearTracks(oObject);
    TF_ClearTrackingList();
    RemoveJournalQuestEntry(CJOURNAL_S_TAG, oObject, FALSE, FALSE);
    nNth = 0;
    nTrackID = 0;
    SetLocalLocation(oObject, "tf_stored_loc", GetLocation(oObject));

    oTArea = GetWaypointByTag("tracking");
    lTArea =  GetLocation(oTArea);

    iUpdateDeleted = TRUE;
    iPinID = 0;
    iTotal = GetLocalInt(oObject, "NW_TOTAL_MAP_PINS");
    if(iTotal > 0) {iPinID = GetFirstDeletedMapPin(oObject);}
    if(iPinID == 0) {iPinID = iTotal + 1; iUpdateDeleted = FALSE;}
    sPinID = IntToString(iPinID);

    oArea = GetArea(oObject);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 1609.34, GetLocation(oObject), FALSE, OBJECT_TYPE_CREATURE);

    nFogMod = TF_GetFogDC(TF_GetFog(oArea));
    nTerrainMod = TF_GetTerrainDC(TF_GetTerrainType(oArea));
    nTimeMod = TF_GetTimeDC(oObject);
    nWeatherMod = TF_GetWeatherDC(TF_GetWeatherType(oArea));
    nVisibilityMod = TF_GetVisibilityDC(TF_GetVisibility(oArea), oObject);
    nEnvMod = TF_GetEnvironmentDC(oArea, nFogMod, nTerrainMod, nTimeMod, nWeatherMod, nVisibilityMod);


    TF_SetTrackingList("Environment DC: " + (IntToString(nEnvMod)), nTrackID);
    while (GetIsObjectValid(oTarget))
    {
        if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE && oTarget != oObject && TF_GetIsTrackable(oObject) == TRUE)
        {
            nSizeMod = TF_GetCreatureSizeDC(TF_GetCreatureSizeType(oTarget));
            nTrackDC = TF_GetTrackDC(nEnvMod, nSizeMod);
            nTrackedSizeDC = (nTrackDC+5);
            nTrackedTypeDC = (nTrackDC+10);
            nTrackedNameDC = (nTrackDC+20);
            nSurvivalMod = TF_GetSurvivalMod(oObject, oTarget, oArea);
            nSurvival = TF_GetSurvival(oObject, nSurvivalMod);
            nRoll = d20(1);
            nTotal = (nRoll+nSurvival);
            if (nTotal >= nTrackedSizeDC && nRoll != 1 && HorseGetIsMounted(oObject) == TRUE || nRoll == 20 && HorseGetIsMounted(oObject) == TRUE)
            {
                nNth = nNth+1;
                sNth = IntToString(nNth);
                nTrackID = nTrackID+1;
                sTrackID = IntToString(nTrackID);
                sRacialType = TF_GetRacialType(oTarget);
                sName = GetName(oTarget);
                vPos = GetPosition(oTarget);

                sClear = ("nClear" + sNth);
                SetLocalInt(oObject, sClear, iPinID);
                //Example: "nClear1" = iPinID

                SetLocalString(oObject, "NW_MAP_PIN_NTRY_" + sPinID, sTrackID + ": Horse Tracks");
                SetLocalFloat(oObject, "NW_MAP_PIN_XPOS_" + sPinID, vPos.x);
                SetLocalFloat(oObject, "NW_MAP_PIN_YPOS_" + sPinID, vPos.y);
                SetLocalObject(oObject, "NW_MAP_PIN_AREA_" + sPinID, oArea);
                if(!iUpdateDeleted) { SetLocalInt(oObject, "NW_TOTAL_MAP_PINS", iPinID); }

                TF_SetTrackingList(sTrackID + ": Horse Tracks", nTrackID);
            }
            else if (nTotal >= nTrackDC && nRoll != 1 && HorseGetIsMounted(oObject) == TRUE || nRoll == 20 && HorseGetIsMounted(oObject) == TRUE)
            {
                nTrackID = nTrackID+1;
                sTrackID = IntToString(nTrackID);
                sSizeType = TF_GetSizeType(oTarget);

                TF_SetTrackingList(sTrackID + ": Horse Tracks are in the area.", nTrackID);
            }

            else if (nTotal >= nTrackedNameDC && nRoll != 1 || nRoll == 20)
            {
                nNth = nNth+1;
                sNth = IntToString(nNth);
                nTrackID = nTrackID+1;
                sTrackID = IntToString(nTrackID);
                sRacialType = TF_GetRacialType(oTarget);
                sName = GetName(oTarget);
                vPos = GetPosition(oTarget);

                sClear = ("nClear" + sNth);
                SetLocalInt(oObject, sClear, iPinID);
                //Example: "nClear1" = iPinID

                SetLocalString(oObject, "NW_MAP_PIN_NTRY_" + sPinID, sTrackID + ": " + sRacialType + " - " + sName);
                SetLocalFloat(oObject, "NW_MAP_PIN_XPOS_" + sPinID, vPos.x);
                SetLocalFloat(oObject, "NW_MAP_PIN_YPOS_" + sPinID, vPos.y);
                SetLocalObject(oObject, "NW_MAP_PIN_AREA_" + sPinID, oArea);
                if(!iUpdateDeleted) { SetLocalInt(oObject, "NW_TOTAL_MAP_PINS", iPinID); }

                TF_SetTrackingList(sTrackID + ": " + sRacialType + " - " + sName, nTrackID);
            }
            else if (nTotal >= nTrackedTypeDC && nRoll != 1)
            {
                nNth = nNth+1;
                sNth = IntToString(nNth);
                nTrackID = nTrackID+1;
                sTrackID = IntToString(nTrackID);
                sRacialType = TF_GetRacialType(oTarget);
                vPos = GetPosition(oTarget);

                sClear = ("nClear" + sNth);
                SetLocalInt(oObject, sClear, iPinID);
                //Example: "nClear1" = iPinID

                SetLocalString(oObject, "NW_MAP_PIN_NTRY_" + sPinID, sTrackID + ": " + sRacialType);
                SetLocalFloat(oObject, "NW_MAP_PIN_XPOS_" + sPinID, vPos.x);
                SetLocalFloat(oObject, "NW_MAP_PIN_YPOS_" + sPinID, vPos.y);
                SetLocalObject(oObject, "NW_MAP_PIN_AREA_" + sPinID, oArea);
                if(!iUpdateDeleted) { SetLocalInt(oObject, "NW_TOTAL_MAP_PINS", iPinID); }

                TF_SetTrackingList(sTrackID + ": " + sRacialType, nTrackID);
            }
            else if (nTotal >= nTrackedSizeDC && nRoll != 1)
            {
                nNth = nNth+1;
                sNth = IntToString(nNth);
                nTrackID = nTrackID+1;
                sTrackID = IntToString(nTrackID);
                sSizeType = TF_GetSizeType(oTarget);
                vPos = GetPosition(oTarget);

                sClear = ("nClear" + sNth);
                SetLocalInt(oObject, sClear, iPinID);
                //Example: "nClear1" = iPinID

                SetLocalString(oObject, "NW_MAP_PIN_NTRY_" + sPinID, sTrackID + ": " + sSizeType);
                SetLocalFloat(oObject, "NW_MAP_PIN_XPOS_" + sPinID, vPos.x);
                SetLocalFloat(oObject, "NW_MAP_PIN_YPOS_" + sPinID, vPos.y);
                SetLocalObject(oObject, "NW_MAP_PIN_AREA_" + sPinID, oArea);
                if(!iUpdateDeleted) { SetLocalInt(oObject, "NW_TOTAL_MAP_PINS", iPinID); }

                TF_SetTrackingList(sTrackID + ": " + sSizeType, nTrackID);
            }
            else if (nTotal >= nTrackDC && nRoll != 1)
            {
                nTrackID = nTrackID+1;
                sTrackID = IntToString(nTrackID);
                sSizeType = TF_GetSizeType(oTarget);

                TF_SetTrackingList(sTrackID + ": " + sSizeType + " sized creature is in the area.", nTrackID);
            }
        }
        iUpdateDeleted = TRUE;
        iPinID = 0;
        iTotal = GetLocalInt(oObject, "NW_TOTAL_MAP_PINS");
        if(iTotal > 0) {iPinID = GetFirstDeletedMapPin(oObject);}
        if(iPinID == 0) {iPinID = iTotal + 1; iUpdateDeleted = FALSE;}
        sPinID = IntToString(iPinID);

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 1609.34, GetLocation(oObject), FALSE, OBJECT_TYPE_CREATURE);
    }
    if (nTrackID == 0){TF_SetTrackingList("No Creatures were tracked.", 1);}
    nTrackID = nTrackID+1;
    TF_SetTrackingList("///End of List///", nTrackID);
    AddJournalQuestEntry(CJOURNAL_S_TAG, CJOURNAL_N_STATE, oObject, FALSE, FALSE, FALSE);

    //AssignCommand(oObject, ActionJumpToLocation(lTArea));
    DelayCommand(SERVER_CLEAR_DELAY, TF_ClearTrackingList());
    DelayCommand(SERVER_CLEAR_DELAY, TF_ClearTracks(oObject));
    DelayCommand(SERVER_CLEAR_DELAY, SendMessageToPC(oObject, "Tracking Pins will clear on next area transition."));

}

void TF_SetTrackingList(string sText, int nTokenID)
{
    nTokenID = (CTOKEN_LIST_BEGIN+nTokenID);
    SetCustomToken(nTokenID, sText);
}

void TF_ClearTrackingList()
{
    int nTokenID = (CTOKEN_LIST_BEGIN);
    while (nTokenID != CTOKEN_LIST_END)
    {
        SetCustomToken(nTokenID, " ");
        nTokenID = nTokenID+1;
    }
}

void TF_Looking(object oPC)
{
    oArea = GetArea(oPC);
    location lLocation = GetLocation(oPC);

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 2.0f,lLocation,TRUE,OBJECT_TYPE_PLACEABLE);
    int nCount = 0;
    nFogMod = TF_GetFogDC(TF_GetFog(oArea));
    nTerrainMod = TF_GetTerrainDC(TF_GetTerrainType(oArea));
    nTimeMod = TF_GetTimeDC(oPC);
    nWeatherMod = TF_GetWeatherDC(TF_GetWeatherType(oArea));
    nVisibilityMod = TF_GetVisibilityDC(TF_GetVisibility(oArea), oPC);
    nEnvMod = TF_GetEnvironmentDC(oArea, nFogMod, nTerrainMod, nTimeMod, nWeatherMod, nVisibilityMod);
    object oCreature;
    string sWeight, sRace, sGender;
    int nWeight,nRace,nGender;
    while (GetIsObjectValid(oTarget))
    {
        oCreature = GetLocalObject(oTarget,"oCreator");
        if(oCreature != oPC)
        {
            if(GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE && GetTag(oTarget) == "sFootprint")
            {
                nSizeMod = TF_GetCreatureSizeDC(TF_GetCreatureSizeType(oCreature));
                nTrackDC = TF_GetTrackDC(nEnvMod, nSizeMod);
                nTrackedSizeDC = (nTrackDC+5);
                nTrackedTypeDC = (nTrackDC+10);
                nSurvivalMod = TF_GetSurvivalMod(oPC, oCreature, oArea);
                nSurvival = TF_GetSurvival(oPC, nSurvivalMod);
                nRoll = d20(1);
                nTotal = (nRoll+nSurvival);
                nRace = GetLocalInt(oTarget,"nTrackRace");
                sRace =TF_GetRacialName(nRace);
                nGender = GetLocalInt(oTarget,"nTrackGend");
                sGender = TF_GetGenderName(nGender);
                nWeight = GetLocalInt(oTarget,"nTrackWeight");
                sWeight = TF_GetWeightName(nWeight);
                if (nTotal >= nTrackedTypeDC && nRoll != 1)
                {
                    SendMessageToPC(oPC,"This track appears to belong to a "+sGender+" "+sRace+" that is leaving "+sWeight+".");
                }
                else if (nTotal >= nTrackedSizeDC && nRoll != 1)
                {
                    SendMessageToPC(oPC,"This track appears to belong to a "+sRace+" that is leaving "+sWeight+".");
                }
                else if (nTotal >= nTrackDC && nRoll != 1)
                {
                    SendMessageToPC(oPC,"This track appears to belong to a "+sRace+".");
                }

                break;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 2.0f,lLocation,TRUE,OBJECT_TYPE_PLACEABLE);
    }
}

string TF_GetWeightName(int nWeight)
{
    if(nWeight < 300)
    {
        return "light footprints";
    }
    else if(nWeight >= 300 && nWeight < 800)
    {
        return "normal footprints";
    }
    else if(nWeight >= 800 && nWeight < 1500)
    {
        return "heavy footprints";
    }
    else if (nWeight >= 1500 && nWeight < 5000)
    {
        return "deep footprints";
    }
    else
    {
        return "extremely deep footprints";
    }
}

//Returns Gender string
string TF_GetGenderName(int nGender)
{
    if(nGender == GENDER_MALE)
    {
        return "Male";
    }
    else if(nGender == GENDER_FEMALE)
    {
        return "Female";
    }
    else
    {
        return "Unknown";
    }
}

//Function: Get Racial Type name
string TF_GetRacialName(int nRacialType)
{
    if (nRacialType == RACIAL_TYPE_ABERRATION) {return "Aberration";}
    if (nRacialType == RACIAL_TYPE_ANIMAL) {return "Animal";}
    if (nRacialType == RACIAL_TYPE_BEAST) {return "Beast";}
    if (nRacialType == RACIAL_TYPE_CONSTRUCT) {return "Construct";}
    if (nRacialType == RACIAL_TYPE_DRAGON) {return "Dragon";}
    if (nRacialType == RACIAL_TYPE_DWARF) {return "Dwarf";}
    if (nRacialType == RACIAL_TYPE_ELEMENTAL) {return "Elemental";}
    if (nRacialType == RACIAL_TYPE_ELF) {return "Elf";}
    if (nRacialType == RACIAL_TYPE_FEY) {return "Fey";}
    if (nRacialType == RACIAL_TYPE_GIANT) {return "Giant";}
    if (nRacialType == RACIAL_TYPE_GNOME) {return "Gnome";}
    if (nRacialType == RACIAL_TYPE_HALFELF) {return "Half-Elf";}
    if (nRacialType == RACIAL_TYPE_HALFLING) {return "Halfing";}
    if (nRacialType == RACIAL_TYPE_HALFORC) {return "Half-Orc";}
    if (nRacialType == RACIAL_TYPE_HUMAN) {return "Human";}
    if (nRacialType == RACIAL_TYPE_HUMANOID_GOBLINOID) {return "Goblin";}
    if (nRacialType == RACIAL_TYPE_HUMANOID_MONSTROUS) {return "Monster";}
    if (nRacialType == RACIAL_TYPE_HUMANOID_ORC) {return "Orc";}
    if (nRacialType == RACIAL_TYPE_HUMANOID_REPTILIAN) {return "Reptile";}
    if (nRacialType == RACIAL_TYPE_MAGICAL_BEAST) {return "Magical Beast";}
    if (nRacialType == RACIAL_TYPE_OOZE) {return "Ooze";}
    if (nRacialType == RACIAL_TYPE_OUTSIDER) {return "Outsider";}
    if (nRacialType == RACIAL_TYPE_PLANT) {return "Plant";}
    if (nRacialType == RACIAL_TYPE_SHAPECHANGER) {return "Shapechanger";}
    if (nRacialType == RACIAL_TYPE_UNDEAD) {return "Undead";}
    if (nRacialType == RACIAL_TYPE_VERMIN) {return "Vermin";}
    return IntToString(nRacialType);
}
///END OF HANDLER///


