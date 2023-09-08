// Name     : Avlis / NWNX Persistence System
// Purpose  : NWNX related functions
// Authors  : Ingmar Stieger, Adam Colon, Josh Simon, Benton
// Modified : January 1st, 2005
// Modified : December 28, 2017 Glorwinger - Updated for NWNX EE

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "pf_nwnx_sql_inc"

int GetPFCampaignInt(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { return GetPersistentInt(oPlayer, sVarName, sCampaignName); }

float GetPFCampaignFloat(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { return GetPersistentFloat(oPlayer, sVarName, sCampaignName); }

location GetPFCampaignLocation(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { return GetPersistentLocation(oPlayer, sVarName, sCampaignName); }

string GetPFCampaignString(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID, int nRandom=FALSE)
    { return GetPersistentString(oPlayer, sVarName, sCampaignName, nRandom); }

vector GetPFCampaignVector(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { return GetPersistentVector(oPlayer, sVarName, sCampaignName); }


void SetPFCampaignInt(string sCampaignName, string sVarName, int nInt,
    object oPlayer=OBJECT_INVALID)
    { SetPersistentInt(oPlayer, sVarName, nInt, sCampaignName);}

void SetPFCampaignFloat(string sCampaignName, string sVarName, float flFloat,
    object oPlayer=OBJECT_INVALID)
    { SetPersistentFloat(oPlayer, sVarName, flFloat, sCampaignName);}

void SetPFCampaignLocation(string sCampaignName, string sVarName, location locLocation,
    object oPlayer=OBJECT_INVALID)
    { SetPersistentLocation(oPlayer, sVarName, locLocation, sCampaignName);}

void SetPFCampaignString(string sCampaignName, string sVarName, string sString,
    object oPlayer=OBJECT_INVALID)
    { SetPersistentString(oPlayer, sVarName, sString, sCampaignName);}

void SetPFCampaignVector(string sCampaignName, string sVarName, vector vVector,
    object oPlayer=OBJECT_INVALID)
    { SetPersistentVector(oPlayer, sVarName, vVector, sCampaignName);}

void DeletePFCampaignVariable(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { DeletePersistentVariable(sVarName, sCampaignName, oPlayer); }

int StorePFCampaignObject(string sCampaignName, string sVarName, object oObject, object oPlayer=OBJECT_INVALID) {
    return SetPersistentObject(sVarName, oObject, oPlayer, sCampaignName);}

object RetrievePFCampaignObject(string sCampaignName, string sVarName,
    location locLocation, object oOwner=OBJECT_INVALID, object oPlayer=OBJECT_INVALID) {
    return GetPersistentObject(sVarName, oOwner, sCampaignName, locLocation);
}



