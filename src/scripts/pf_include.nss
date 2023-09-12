// Name     : Persistence Facade
// Purpose  : Persistence Facde functions to allow easy selection of Bioware vs NWNX persistence
// Authors  : Ingmar Stieger, Adam Colon, Josh Simon, Benton
// Modified : January 1st, 2005
// Modified : December 28, 2017 Glorwinger - Updated for NWNX EE

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

//    This file is used to define the persistence functions, and
//    to include the desired persistence implementation.
//
//    Include this file wherever you want to use these functions:
//        GetPFCampaign<VarType>.
//        SetPFCampaign<VarType>.
//        StorePFCampaignObject.
//        RetrievePFCampaignObject.
//        GetPFCampaign<VarType>.
//
//    Below you must uncomment exactly
//    one #include line. Each of the possible include files
//    implements the following functions differently.

//*******************************************************************
// Persistance Facade IMPLEMENTATION:
//    Uncomment One of the three choices
//
//    Uncomment the following for built-in Bioware persistence
 #include "pf_bio_inc"
//
//    Uncomment the following for NWNX APS persistence
//#include "pf_nwnx_inc"
//
//    Uncomment the following for local "Persistence" emulation
//     (for testing without writing any permanent data)
//     This persistence system simply calls the equivalent
//     functions on the player and SQL mocks
// #include "pf_local_inc"
//*******************************************************************

//  Define default used by the set and get campaign functions
const string PF_CAMPAIGN = "pwdata";
const string PF_CAMPAIGN_OBJ = "pwobjdata";

/************************************/
/* Function prototypes              */
/************************************/

// Set Int Campaign variable for BioDB or NWNX
//      sCampaignName - This is the BioDB name or table name when using NWNX
//      sVarName - This is the name of the vairable
//      nInt - The integer to store
//      oPlayer - This is the player associated with the variable
void SetPFCampaignInt(string sCampaignName, string sVarName, int nInt, object oPlayer=OBJECT_INVALID);
// Set Float Campaign variable for BioDB or NWNX
//      sCampaignName - This is the BioDB name or table name when using NWNX
//      sVarName - This is the name of the vairable
//      flFloat - The float to store
//      oPlayer - This is the player associated with the variable
void SetPFCampaignFloat(string sCampaignName, string sVarName, float flFloat, object oPlayer=OBJECT_INVALID);
// Set Location Campaign variable for BioDB or NWNX
//      sCampaignName - This is the BioDB name or table name when using NWNX
//      sVarName - This is the name of the vairable
//      locLocation - The location to store
//      oPlayer - This is the player associated with the variable
void SetPFCampaignLocation(string sCampaignName, string sVarName, location locLocation, object oPlayer=OBJECT_INVALID);
// Set String Campaign variable for BioDB or NWNX
//      sCampaignName - This is the BioDB name or table name when using NWNX
//      sVarName - This is the name of the vairable
//      sString - The string to store
//      oPlayer - This is the player associated with the variable
void SetPFCampaignString(string sCampaignName, string sVarName, string sString, object oPlayer=OBJECT_INVALID);
// Set Vector Campaign variable for BioDB or NWNX
//      sCampaignName - This is the BioDB name or table name when using NWNX
//      sVarName - This is the name of the vairable
//      vVector - The vector to store
//      oPlayer - This is the player associated with the variable
void SetPFCampaignVector(string sCampaignName, string sVarName, vector vVector, object oPlayer=OBJECT_INVALID);
// Store a campaign object
//   Returns 0 for failure, 1 for success.
//      sCampaignName - This is the BioDB name or table name when using NWNX
//      sVarName - This is the name of the object to store
//      oObject - This is object that will be stored
//      oPlayer - This represents the owner (creature or object) if desired
int StorePFCampaignObject(string sCampaignName, string sVarName, object oObject, object oPlayer=OBJECT_INVALID);


// Get Int Campaign variable for BioDB or NWNX
//      sCampaignName - This is the BioDB name or table name when using NWNX
//      sVarName - This is the name of the vairable
//      oPlayer - This is the player associated with the variable
int GetPFCampaignInt(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID);
// Get Float Campaign variable for BioDB or NWNX
//      sCampaignName - This is the BioDB name or table name when using NWNX
//      sVarName - This is the name of the vairable
//      oPlayer - This is the player associated with the variable
float GetPFCampaignFloat(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID);
// Get Location Campaign variable for BioDB or NWNX
//      sCampaignName - This is the BioDB name or table name when using NWNX
//      sVarName - This is the name of the vairable
//      oPlayer - This is the player associated with the variable
location GetPFCampaignLocation(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID);
// Get String Campaign variable for BioDB or NWNX
//      sCampaignName - This is the BioDB name or table name when using NWNX
//      sVarName - This is the name of the vairable
//      oPlayer - This is the player associated with the variable
string GetPFCampaignString(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID, int nRandom=FALSE);
// Get Vector Campaign variable for BioDB or NWNX
//      sCampaignName - This is the BioDB name or table name when using NWNX
//      sVarName - This is the name of the vairable
//      oPlayer - This is the player associated with the variable
vector GetPFCampaignVector(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID);
// Retrieve a campaign object
// If you specify an owner, the object will try to be created in their repository
// If the owner can't handle the item (or if it's a creature) it will be created on the ground.
//      sCampaignName - This is the BioDB name or table name when using NWNX
//      sVarName - This is the name of the object
//      locLocation - Location to create the object.  This is used if an owner is not specified.
//      oOwner - The retrieved object will be added to the object inventory. For NWNX this will be used first and locLocation will be ignored.
//      oPlayer - This is used only with BioDB and is the player associated with the object
object RetrievePFCampaignObject(string sCampaignName, string sVarName, location locLocation, object oOwner=OBJECT_INVALID, object oPlayer=OBJECT_INVALID);

// Delete a Campaign variable from BioDB or NWNX
//      sCampaignName - This is the BioDB name or table name when using NWNX
//      sVarName - This is the name of the vairable
//      oPlayer - This is the player associated with the variable
void DeletePFCampaignVariable(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID);
