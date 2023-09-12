//::///////////////////////////////////////////////
//::  Drown Functions
//:: //:: Function(D20) 2019
//:://////////////////////////////////////////////
//:: Created By; Jonathan Lorentsen (Sloth)
//:: Email: jlorents93@hotmail.com
//:: Updated by Djinn on 3/1/20
//:://////////////////////////////////////////////

/*
    Instructions: Add below string at beginning of script for functions
        #include "DF_Handler"

    Table of Contents
    1. CONSTANTS LIST - Descriptors
        1.1 Variables
                DF_GetBreathType
                DF_GetCurrentOxygenHD
                DF_GetDrownDC
                DF_GetDrownState
                DF_GetMaxOxygenHD
                DF_SetBreathType
                DF_SetCurrentOxygenHD
                DF_SetDrownDC
                DF_SetDrownState
                DF_SetMaxOxygenHD
                GetCON
                GetCONMod
        1.2 System
                DF_CheckBreathAreaType
                DF_CheckBreathImmune
                DF_CheckBreathType
                DF_ReplenishOxygen
                DF_RestoreOxygen

    2. FUNCTION LIST - Where The Magic Happens
        2.1 Variables
                DF_GetBreathType
                DF_GetCurrentOxygenHD
                DF_GetDrownDC
                DF_GetDrownState
                DF_GetMaxOxygenHD
                DF_SetBreathType
                DF_SetCurrentOxygenHD
                DF_SetDrownDC
                DF_SetDrownState
                DF_SetMaxOxygenHD
                GetCON
                GetCONMod
        2.2 System
                DF_CheckBreathAreaType
                DF_CheckBreathImmune
                DF_CheckBreathType
                DF_ReplenishOxygen
                DF_RestoreOxygen

    3. DEBUG
*/


/*
Description (3.5e):
Any character can hold her breath for a number of rounds equal to
twice her Constitution score.
After this period of time, the character must make a DC 10 Constitution
check every round in order to continue holding her breath.
Each round, the DC increases by 1. See also: Swim skill description.

When the character finally fails her Constitution check, she begins to drown.
In the first round, she falls unconscious (0 hp). In the following round,
she drops to -1 hit points and is dying. In the third round, she drowns.

It is possible to drown in substances other than water, such as sand, quicksand,
fine dust, and silos full of grain.

Script Story Board:
    //State: Not Drowning
    1a. Replenish Oxygen (DrownState 0)
    1b. Check WaterBreathing:
            1 - GoTo 1a
            0 - GoTo 2a

    //State: Holding Breath
    2a. Check DrownState
        Set MaxOxygenHD:
            0||1 - GoTo 2b
            2 - GoTo4a
    2b. Set DrownState 1
        Check CurrentOxygen:
            >0 - GoTo 2c
            =0 - GoTo 3a
    2c. -1 CurrentOxygen:
            GoTo 1a

    //State: Drowning CON Checks
    3a. Check DrownDC [10 + (1 per Round)]:
            Success - GoTo 3b
            Failure - GoTo 4a
    3b. +1 DrownDC:
            GoTo 1a

    //State: Drowning
    4a. Set DrownState 2
        Check CurrentOxygen:
            =0 - GoTo 4b
            >0 - GoTo 2b
    4b. Set Player HD to 0:
            Do not run further on player until >0 HP.
            Set CurrentOxgen to 1 if >0 again.
            Reset DrownDC.
*/

//:://////////////////////////////////////////////
/*
1. CONSTANTS
*/
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//::1.1 Variables
//:://////////////////////////////////////////////

//Const Variables
const int DF_DrownState_NotDrowning = 0;
const int DF_DrownState_HoldingBreath = 1;
const int DF_DrownState_Drowning = 2;

const int DF_BreathType_Water = 1;
const int DF_BreathType_Smog = 2;
const int DF_BreathType_Buried = 3;
const int DF_BreathType_LowOxygen = 4;
const int DF_BreathType_NoOxygen = 5;

const int DF_BreathArea_Water = 1;
const int DF_BreathArea_Smog = 2;
const int DF_BreathArea_LowOxygen = 3;
const int DF_BreathArea_NoOxygen = 4;

const int RACIAL_TYPE_PLANT = 52;

//Int Variables
int nBreathLowOxygen;
int nBreathNoOxygen;
int nBreathSmog;
int nBreathWater;

int nDrownDC;
int nDrownState;

int nCurOxygenHD;
int nMaxOxygenHD;
int nOxygen;

//String Variables
string sBreathWater;
string sBreathSmog;
string sBreathLowOxygen;
string sBreathNoOxygen;

string sDrownDC;
string sDrownState;

string sCurOxygenHD;
string sMaxOxygenHD;
string sOxygen;

//Get Breath Type
// Returns nBreath - 0 = False
//                   1 = True
// nBreathType - DF_BreathType_Water = 1;
//               DF_BreathType_Smog = 2;
//       DF_BreathType_LowOxygen = 3;
//       DF_BreathType_NoOxygen = 4;
int DF_GetBreathType(object oObject, int nBreathType);

//Get Current Oxygen HD Variable
// Returns nCurOxygenHD
int DF_GetCurrentOxygenHD(object oObject);

//Get Drown DC
// Returns nDrownDC
int DF_GetDrownDC(object oObject);

//Get Drown State Variable
// Returns;
// nDrownState - 0 = Not Drowning,
//               1 = Holding Breath,
//               2 = Drowning
int DF_GetDrownState(object oObject);

//Get Max Oxygen HD Variable
// Returns nMaxOxygenHD
int DF_GetMaxOxygenHD(object oObject);

//Set Breath Type
// nBreath - 0 = False
//                   1 = True
// nBreathType - DF_BreathType_Water = 1;
//               DF_BreathType_Smog = 2;
//       DF_BreathType_LowOxygen = 3;
//       DF_BreathType_NoOxygen = 4;
void DF_SetBreathType(object oObject, int nBreathType, int nBreath);

//Set Current Oxygen HD Variable
// nCurOxygenHD
void DF_SetCurrentOxygenHD(object oObject, int nCurOxygenHD);

//Set Drown DC
// nDrownDC
void DF_SetDrownDC(object oObject, int nDrownDC);

//Set Drown State Variable
// nDrownState - 0 = Not Drowning,
//               1 = Holding Breath,
//               2 = Drowning
void DF_SetDrownState(object oObject, int nDrownState);

//Set Max Oxygen HD Variable
// nMaxOxygenHD
void DF_SetMaxOxygenHD(object oObject, int nMaxOxygenHD);

//Returns PC CON Score
//oObject - Target Object
int GetCON(object oObject);

//Returns PC CON Mod
//oObject - Target Object
int GetCONMod(object oObject);

//:://////////////////////////////////////////////
//::1.2 System
//:://////////////////////////////////////////////

//Check Area Breath Type
// Returns - 0 = False
//                   1 = True
// nBreathType - DF_BreathType_Water = 1
//               DF_BreathType_Smog = 2
//       DF_BreathType_LowOxygen = 3
//       DF_BreathType_NoOxygen = 4
int DF_CheckBreathAreaType(object oArea);


//Check Suffocation Immunity
// Returns - 0 = False
//                   1 = True
int DF_CheckBreathImmune(object oObject);

//Check Water Breathing Variables
// Appropriate Uses:
//      OnHearbeat - Unbreathable Area
//      OnEquip/UnEquip - WaterBreathing Item
//      OnActivate - Potions?
//
// Returns - 0 = False
//                   1 = True
// nBreathType - DF_BreathType_Water = 1
//               DF_BreathType_Smog = 2
//       DF_BreathType_LowOxygen = 3
//       DF_BreathType_NoOxygen = 4
int DF_CheckBreathType(object oObject, int nBreathType);

//Reset Drowning Variables
// Appropriate Uses:
//      Initializing variables for first time
//      OnExit - Leaving Unbreathable Area/Trigger
//      OnEnter - Entering Breathable Area/Trigger
//      OnActivate - Potions?
//
// nBreathWater - 0 = False, 1 = True
// nDrownState - 0 = Not Drowning
//               1 = Holding Breath
//               2 = Drowning
// nDrownDC - 10 + 1 (per Round)
// nCurOxygenHD - Current Oxygen
// nMaxOxygenHD - Constitution Modifier * 2
void DF_ReplenishOxygen(object oObject);

//Restore Current Oxygen
// Appropriate Uses:
//      OnUse - Objects/Items/Potions?
// nOxygen = Amount to Restore
void DF_RestoreOxygen(object oObject, int nOxygen);

//:://////////////////////////////////////////////
/*
2. FUNCTION LIST
*/
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//::2.1 Variables
//:://////////////////////////////////////////////

//Function: Get BreathType
int DF_GetBreathType(object oObject, int nBreathType)
{
    if (nBreathType == DF_BreathType_Water)
    {
        //Variables
        sBreathWater = "nBreathWater";

        //Return Local Variable
        return GetLocalInt(oObject, sBreathWater);
    }
    if (nBreathType == DF_BreathType_Smog)
    {
        //Variables
        sBreathSmog = "nBreathSmog";

        //Return Local Variable
        return GetLocalInt(oObject, sBreathSmog);
    }
    if (nBreathType = DF_BreathType_LowOxygen)
    {
        //Variables
        sBreathLowOxygen = "nBreathLowOxygen";

        //Return Local Variable
        return GetLocalInt(oObject, sBreathLowOxygen);
    }
    if (nBreathType = DF_BreathType_NoOxygen)
    {
        //Variables
        sBreathNoOxygen = "nBreathNoOxygen";

        //Return Local Variable
        return GetLocalInt(oObject, sBreathNoOxygen);
    }
    return 0;
}

//Function: Get CurrentOxygenHD
int DF_GetCurrentOxygenHD(object oObject)
{
    //Variables
    sCurOxygenHD  = "nCurOxygenHD";

    //Return Local Variable
    return GetLocalInt(oObject, sCurOxygenHD);
}

//Function: Get DrownDC
int DF_GetDrownDC (object oObject)
{
    //Variables
    sDrownDC = "nDrownDC";

    //Return Local Variable
    return GetLocalInt(oObject, sDrownDC);
}

//Function: Get DrownState
int DF_GetDrownState(object oObject)
{
    //Variables
    sDrownState = "nDrownState";

    //Return Local Variable
    return GetLocalInt(oObject, sDrownState);
}

//Function: Get MaxOxygenHD
int DF_GetMaxOxygenHD(object oObject)
{
    //Variables
    sMaxOxygenHD  = "nMaxOxygenHD";

    //Return Local Variable
    return GetLocalInt(oObject, sMaxOxygenHD);
}

//Function: Set Breath Type
void DF_SetBreathType(object oObject, int nBreathType, int nBreath)
{
    if (nBreathType = DF_BreathType_Water)
    {
        //Variables
        sBreathWater = "nBreathWater";

        //Return Local Variable
        SetLocalInt(oObject, sBreathWater, nBreath);
    }
    if (nBreathType = DF_BreathType_Smog)
    {
        //Variables
        sBreathSmog = "nBreathSmog";

        //Return Local Variable
        SetLocalInt(oObject, sBreathSmog, nBreath);
    }
    if (nBreathType = DF_BreathType_LowOxygen)
    {
        //Variables
        sBreathLowOxygen = "nBreathLowOxygen";

        //Return Local Variable
        SetLocalInt(oObject, sBreathLowOxygen, nBreath);
    }
    if (nBreathType = DF_BreathType_NoOxygen)
    {
        //Variables
        sBreathNoOxygen = "nBreathNoOxygen";

        //Return Local Variable
        SetLocalInt(oObject, sBreathNoOxygen, nBreath);
    }

}

//Function: Set Drown DC
void DF_SetDrownDC(object oObject, int nDrownDC)
{
    //Variables
    sDrownDC  = "nDrownDC";

    //Return Local Variable
    SetLocalInt(oObject, sDrownDC, nDrownDC);
}

//Function: Set CurrentOxygen HD
void DF_SetCurrentOxygenHD(object oObject, int nCurOxygenHD)
{
    //Variables
    sCurOxygenHD  = "nCurOxygenHD";

    //Return Local Variable
    SetLocalInt(oObject, sCurOxygenHD, nCurOxygenHD);
}

//Function: Set DrownState
void DF_SetDrownState(object oObject, int nDrownState)
{
    //Variables
    sDrownState = "nDrownState";

    //Return Local Variable
    SetLocalInt(oObject, sDrownState, nDrownState);
}

//Function: Set MaxOxygen HD
void DF_SetMaxOxygenHD(object oObject, int nMaxOxygenHD)
{
    //Variables
    sMaxOxygenHD  = "nMaxOxygenHD";

    //Return Local Variable
    SetLocalInt(oObject, sMaxOxygenHD, nMaxOxygenHD);
}

//Function: Get PC Ability Score
int GetCON(object oObject)
{
    return GetAbilityScore(oObject, ABILITY_CONSTITUTION);
}

//Function: Get PC Ability Modifer
int GetCONMod(object oObject)
{
    return GetAbilityModifier(ABILITY_CONSTITUTION, oObject);
}

//:://////////////////////////////////////////////
//::2.2 System
//:://////////////////////////////////////////////

//Function: Check Area Breath Type
int DF_CheckBreathAreaType(object oArea)
{
return GetLocalInt(oArea, "nBreathType");
}

//Function: Check Breath Immune
int DF_CheckBreathImmune(object oObject)
{
    //Check Suffocation Immunity
    if(GetRacialType(oObject) == RACIAL_TYPE_ABERRATION ||
       GetRacialType(oObject) == RACIAL_TYPE_CONSTRUCT ||
       GetRacialType(oObject) == RACIAL_TYPE_DRAGON ||
       GetRacialType(oObject) == RACIAL_TYPE_ELEMENTAL ||
       GetRacialType(oObject) == RACIAL_TYPE_OOZE ||
       GetRacialType(oObject) == RACIAL_TYPE_OUTSIDER ||
       GetRacialType(oObject) == RACIAL_TYPE_PLANT ||
       GetRacialType(oObject) == RACIAL_TYPE_HUMANOID_REPTILIAN ||
       GetRacialType(oObject) == RACIAL_TYPE_UNDEAD ||
       GetLevelByClass(CLASS_TYPE_UNDEAD, oObject) >= 1 ||
       GetLocalInt(GetItemPossessedBy(oObject, "PC_Data_Object"), "iUndead") == 1 ||
       GetRacialType(oObject) == RACIAL_TYPE_VERMIN ||
       GetHasFeat(FEAT_PERFECT_SELF, oObject))
    {
        //Object Can Breath Water
        return 1;
    }
    return 0;
}

//Function: Check Breathing Variables
int DF_CheckBreathType(object oObject, int nBreathType)
{
    if (nBreathType == DF_BreathType_Water)
    {
        //Check Water Breathing By Item
        if (GetLocalInt(GetItemInSlot(INVENTORY_SLOT_NECK, oObject), "Adaptation") == 5 ||
            GetLocalInt(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oObject), "WaterBreathing") == 5 ||
            GetLocalInt(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oObject), "WaterBreathing") == 5)
        {
            //Object Can Breath
            DF_SetBreathType(oObject, DF_BreathType_Water, 1);
            return 1;
        }
        else
        {
            //Object Cannot Breath
            DF_SetBreathType(oObject, DF_BreathType_Water, 0);
            return 0;
        }
    }
    if (nBreathType == DF_BreathArea_Smog)
    {
        //Check Smog Breathing By Item Or Race
        if (GetLocalInt(GetItemInSlot(INVENTORY_SLOT_NECK, oObject), "Adaptation") == 5 ||
            GetHasFeat(1186, oObject) || //Aasimar
            GetHasFeat(1187, oObject) || //Tiefling
            GetHasFeat(1458, oObject))   //Fey'ri
        {
            //Object Can Breath
            DF_SetBreathType(oObject, DF_BreathType_Smog, 1);
            return 1;
        }
        else
        {
            //Object Cannot Breath
            DF_SetBreathType(oObject, DF_BreathType_Smog, 0);
            return 0;
        }
    }
    if (nBreathType == DF_BreathArea_LowOxygen)
    {
        //Check Low Oxygen Breathing By Item Or Race
        if (GetLocalInt(GetItemInSlot(INVENTORY_SLOT_NECK, oObject), "Adaptation") == 5 ||
            GetHasFeat(1179, oObject) || //dark elf
            GetHasFeat(1182, oObject) || //gold dwarf
            GetHasFeat(1183, oObject) || //grey dwarf
            GetHasFeat(1452, oObject) || //deep gnome
            GetHasFeat(1184, oObject))   //shield dwarf
        {
            //Object Can Breath
            DF_SetBreathType(oObject, DF_BreathType_LowOxygen, 1);
            return 1;
        }
        else
        {
            //Object Cannot Breath
            DF_SetBreathType(oObject, DF_BreathType_LowOxygen, 0);
            return 0;
        }
    }
    if (nBreathType == DF_BreathArea_NoOxygen)
    {
        //Check Breathing By Item
        if (GetLocalInt(GetItemInSlot(INVENTORY_SLOT_NECK, oObject), "Adaptation") == 5)
        {
            //Object Can Breath
            DF_SetBreathType(oObject, DF_BreathType_NoOxygen, 1);
            return 1;
        }
        else
        {
            //Object Cannot Breath
            DF_SetBreathType(oObject, DF_BreathType_NoOxygen, 0);
            return 0;
        }
    }
    return 0;
}

//Function: Reset Drowning Variables
void DF_ReplenishOxygen(object oObject)
{
    //Variables
    nBreathWater = (DF_CheckBreathType(oObject, DF_BreathType_Water));
    sBreathWater = "nBreathWater";
    nBreathSmog = (DF_CheckBreathType(oObject, DF_BreathType_Smog));
    sBreathSmog = "nBreathSmog";
    nBreathLowOxygen = (DF_CheckBreathType(oObject, DF_BreathType_LowOxygen));
    sBreathLowOxygen = "nBreathLowOxygen";
    nBreathNoOxygen = (DF_CheckBreathType(oObject, DF_BreathType_NoOxygen));
    sBreathNoOxygen = "nBreathNoOxygen";
    nDrownState = 0;
    sDrownState = "nDrownState";
    nDrownDC = 10;
    sDrownDC = "nDrownDC";
    nMaxOxygenHD = (GetAbilityScore(oObject, ABILITY_CONSTITUTION)*2);
    if (GetHasFeat(1179, oObject) ||
        GetHasFeat(1183, oObject) ||
        GetHasFeat(1304, oObject) ||
        GetHasFeat(1313, oObject))
        {
        nMaxOxygenHD = (nMaxOxygenHD * 2);
        }
    if (GetHasFeat(1411, oObject))
        {
        nMaxOxygenHD = (nMaxOxygenHD + 5);
        }
    if (GetHasFeat(1436, oObject))
        {
        nMaxOxygenHD = (nMaxOxygenHD + 5);
        }
    if (GetHasFeat(FEAT_TOUGHNESS, oObject))
        {
        nMaxOxygenHD = (nMaxOxygenHD + 5);
        }
    sMaxOxygenHD = "nMaxOxygenHD";
    nCurOxygenHD = nMaxOxygenHD;
    sCurOxygenHD = "nCurOxygenHD";

    //Set Variables
    SetLocalInt(oObject, sBreathWater, nBreathWater);
    SetLocalInt(oObject, sBreathSmog, nBreathSmog);
    SetLocalInt(oObject, sBreathLowOxygen, nBreathLowOxygen);
    SetLocalInt(oObject, sBreathNoOxygen, nBreathNoOxygen);
    SetLocalInt(oObject, sDrownState, nDrownState);
    SetLocalInt(oObject, sDrownDC, nDrownDC);
    SetLocalInt(oObject, sMaxOxygenHD, nMaxOxygenHD);
    SetLocalInt(oObject, sCurOxygenHD, nCurOxygenHD);
}

//Function: Restore Oxygen
void DF_RestoreOxygen(object oObject, int nOxygen)
{
    sOxygen = IntToString(nOxygen);
    DF_SetCurrentOxygenHD(oObject, (DF_GetCurrentOxygenHD(oObject)+nOxygen));
    if (DF_GetCurrentOxygenHD(oObject) > DF_GetMaxOxygenHD(oObject))
    {
        DF_SetCurrentOxygenHD(oObject, (DF_GetMaxOxygenHD(oObject)));
    }
    FloatingTextStringOnCreature("+" + sOxygen + " O2", oObject, FALSE);
}

//:://////////////////////////////////////////////
/*
3. DEBUG
*/
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//::3.1 DEBUG
//:://////////////////////////////////////////////
//DF_DEBUGGER
void DF_DEBUG(object oObject)
{
    nDrownState = DF_GetDrownState(oObject);
    nDrownDC = DF_GetDrownDC(oObject);
    nCurOxygenHD = DF_GetCurrentOxygenHD(oObject);
    nMaxOxygenHD = DF_GetMaxOxygenHD(oObject);

    sDrownState = IntToString(nDrownState);
    sDrownDC = IntToString(nDrownDC);
    sCurOxygenHD = IntToString(nCurOxygenHD);
    sMaxOxygenHD = IntToString(nMaxOxygenHD);

SendMessageToPC(oObject, "DrownState: " + sDrownState);
SendMessageToPC(oObject, "DrownDC: " + sDrownDC);
SendMessageToPC(oObject, "Oxygen: " + sCurOxygenHD + "/" + sMaxOxygenHD);
}
