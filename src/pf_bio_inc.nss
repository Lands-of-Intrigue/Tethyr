// Name     : Bioware Persistence System
// Purpose  : Bioware persistence related functions
// Authors  : Ingmar Stieger, Adam Colon, Josh Simon, Benton
// Modified : January 1st, 2005
// Modified : December 28, 2017 Glorwinger - Updated for NWNX EE

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

//    This is the implementation for Bioware persistence. 

#include "pf_mock_sql_inc"

/*  The Bioware Persistence system will not store object-specific variables unless
    the object is a PC. To get around this, the object tag is appended to the variable
    name if the object is valid and not a PC
*/
string ObjectVarName(string sVarName, object oObject)
{
    if ((oObject == OBJECT_INVALID) | GetIsPC(oObject))
        return sVarName;
    else return sVarName + GetTag(oObject);
}

int GetPFCampaignInt(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { return GetCampaignInt(sCampaignName, ObjectVarName(sVarName, oPlayer), oPlayer); }

float GetPFCampaignFloat(string sCampaignName, string sVarName,object oPlayer=OBJECT_INVALID)
    { return GetCampaignFloat(sCampaignName, ObjectVarName(sVarName, oPlayer), oPlayer); }

location GetPFCampaignLocation(string sCampaignName, string sVarName,object oPlayer=OBJECT_INVALID)
    { return GetCampaignLocation(sCampaignName, ObjectVarName(sVarName, oPlayer), oPlayer); }

string GetPFCampaignString(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID, int nRandom=FALSE)
    { return GetCampaignString(sCampaignName, ObjectVarName(sVarName, oPlayer), oPlayer); }

vector GetPFCampaignVector(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { return GetCampaignVector(sCampaignName, ObjectVarName(sVarName, oPlayer), oPlayer); }

void SetPFCampaignInt(string sCampaignName, string sVarName, int nInt,
    object oPlayer=OBJECT_INVALID)
    { SetCampaignInt(sCampaignName, ObjectVarName(sVarName, oPlayer), nInt, oPlayer);}

void SetPFCampaignFloat(string sCampaignName, string sVarName, float flFloat,
    object oPlayer=OBJECT_INVALID)
    { SetCampaignFloat(sCampaignName, ObjectVarName(sVarName, oPlayer), flFloat, oPlayer);}

void SetPFCampaignLocation(string sCampaignName, string sVarName, location locLocation,
    object oPlayer=OBJECT_INVALID)
    { SetCampaignLocation(sCampaignName, ObjectVarName(sVarName, oPlayer), locLocation, oPlayer);}

void SetPFCampaignString(string sCampaignName, string sVarName, string sString,
    object oPlayer=OBJECT_INVALID)
    { SetCampaignString(sCampaignName, ObjectVarName(sVarName, oPlayer), sString, oPlayer);}

void SetPFCampaignVector(string sCampaignName, string sVarName, vector vVector,
    object oPlayer=OBJECT_INVALID)
    { SetCampaignVector(sCampaignName, ObjectVarName(sVarName, oPlayer), vVector, oPlayer);}

void DeletePFCampaignVariable(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { DeleteCampaignVariable(sCampaignName, ObjectVarName(sVarName, oPlayer), oPlayer); }

void DestroyPFCampaignDatabase(string sCampaignName)
    { DestroyCampaignDatabase(sCampaignName); }

int StorePFCampaignObject(string sCampaignName, string sVarName, object oObject, object oPlayer=OBJECT_INVALID)
    { return StoreCampaignObject(sCampaignName, ObjectVarName(sVarName, oPlayer), oObject, oPlayer);}

object RetrievePFCampaignObject(string sCampaignName, string sVarName, location locLocation,
    object oOwner = OBJECT_INVALID, object oPlayer=OBJECT_INVALID)
    { return RetrieveCampaignObject(sCampaignName, ObjectVarName(sVarName, oPlayer), locLocation, oOwner, oPlayer); }





