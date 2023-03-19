// Name     : Local Persistence System
// Purpose  : Local persistence related functions
// Authors  : Ingmar Stieger, Adam Colon, Josh Simon, Benton
// Modified : January 1st, 2005
// Modified : December 28, 2017 Glorwinger - Updated for NWNX EE

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

//    This is the implementation for local "persistence". 
//    All data is stored in memory on objects and does not 'persist' between restarts

#include "pf_mock_sql_inc"

int GetPFCampaignInt(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { return GetLocalInt(oPlayer, sVarName); }

float GetPFCampaignFloat(string sCampaignName, string sVarName,object oPlayer=OBJECT_INVALID)
    { return GetLocalFloat(oPlayer, sVarName); }

location GetPFCampaignLocation(string sCampaignName, string sVarName,object oPlayer=OBJECT_INVALID)
    { return GetLocalLocation(oPlayer, sVarName); }

string GetPFCampaignString(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID, int nRandom=FALSE)
    { return GetLocalString(oPlayer, sVarName); }

// For some reason, Vectors can't be stored locally
vector GetPFCampaignVector(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
    { return Vector(0.0, 0.0, 0.0); }

void SetPFCampaignInt(string sCampaignName, string sVarName, int nInt,
    object oPlayer=OBJECT_INVALID)
    { SetLocalInt(oPlayer, sVarName, nInt);}

void SetPFCampaignFloat(string sCampaignName, string sVarName, float flFloat,
    object oPlayer=OBJECT_INVALID)
    { SetLocalFloat(oPlayer, sVarName, flFloat);}

void SetPFCampaignLocation(string sCampaignName, string sVarName, location locLocation,
    object oPlayer=OBJECT_INVALID)
    { SetLocalLocation(oPlayer, sVarName, locLocation);}

void SetPFCampaignString(string sCampaignName, string sVarName, string sString,
    object oPlayer=OBJECT_INVALID)
    { SetLocalString(oPlayer, sVarName, sString);}

// For some reason, Vectors can't be stored locally
void SetPFCampaignVector(string sCampaignName, string sVarName, vector vVector,
    object oPlayer=OBJECT_INVALID) { }

void DeletePFCampaignVariable(string sCampaignName, string sVarName, object oPlayer=OBJECT_INVALID)
{
        DeleteLocalInt(oPlayer, sVarName);
        DeleteLocalFloat(oPlayer, sVarName);
        DeleteLocalLocation(oPlayer, sVarName);
        DeleteLocalObject(oPlayer, sVarName);
        DeleteLocalString(oPlayer, sVarName);
}

void DestroyPFCampaignDatabase(string sCampaignName) {}

int StorePFCampaignObject(string sCampaignName, string sVarName, object oObject, object oPlayer=OBJECT_INVALID)
    { SetLocalObject(GetModule(), sVarName, oObject); return 1; }

object RetrievePFCampaignObject(string sCampaignName, string sVarName, location locLocation,
    object oOwner = OBJECT_INVALID, object oPlayer=OBJECT_INVALID)
    { return GetLocalObject(GetModule(), sVarName); }




