//::///////////////////////////////////////////////
//:: Name
//:: FileName
//:: Copyright (c) 2005 The Ravenloft PW Project
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Soeren Peter Moeller/Zarathustra217
//:: Created On:

//:://////////////////////////////////////////////

#include "so_inc_debug"

const string CACHE="Cache_";
const string CACHE_DATABASE="Cache_Database_";
const string CACHE_2DA="Cache_2da_";
const string CACHE_WAYPOINT="Cache_Waypoints_";

const string CACHE_OBJECT_DATABASE="CACHE_OBJECT_DATABASE";
const string CACHE_OBJECT_POPULATION="CACHE_OBJECT_POPULATION";
const string CACHE_OBJECT_PLAYER="CACHE_OBJECT_PLAYER";
const string CACHE_OBJECT_2DA="CACHE_OBJECT_2DA";
const string CACHE_OBJECT_AREA="CACHE_OBJECT_AREA";
const string CACHE_OBJECT_ITEM_APPEARENCE="CACHE_OBJECT_ITEM_APPEARENCE";
const string CACHE_OBJECT_TREASURY="CACHE_OBJECT_TREASURY";
const string CACHE_OBJECT_FACTION="CACHE_OBJECT_FACTION";
const string CACHE_OBJECT_WEATHER="CACHE_OBJECT_WEATHER";


object GetCachedObjectByTag(string sTag, object oCacheObject=OBJECT_INVALID)
{
    if(oCacheObject==OBJECT_INVALID)
    {
        oCacheObject=GetModule();
    }
    if(sTag=="")
    {
        WriteTimestampedLogEntry("<!> "+GetObjectInfoString(OBJECT_SELF)+" attempted to cache object with no tag on "+GetObjectInfoString(oCacheObject)+".");
        return OBJECT_INVALID;
    }
    object oObject=GetLocalObject(oCacheObject,CACHE+sTag);
    if(GetIsObjectValid(oObject))
    {
        return oObject;
    }
    else
    {
        oObject=GetObjectByTag(sTag);
        if(GetIsObjectValid(oObject))
        {
            SetLocalObject(oCacheObject,CACHE+sTag,oObject);
            return oObject;
        }
        else
        {
            WriteTimestampedLogEntry("<!> "+GetObjectInfoString(OBJECT_SELF)+" failed to add object with tag "+sTag+" to cache on "+GetObjectInfoString(oCacheObject)+".");
            return OBJECT_INVALID;
        }
    }
}

object GetCachedWaypointByTag(string sTag, object oCacheObject=OBJECT_INVALID)
{
    if(oCacheObject==OBJECT_INVALID)
    {
        oCacheObject=GetModule();
    }
    if(sTag=="")
    {
        WriteTimestampedLogEntry("<!> "+GetObjectInfoString(OBJECT_SELF)+" attempted to cache waypoint with no tag on "+GetObjectInfoString(oCacheObject)+".");
        return OBJECT_INVALID;
    }
    object oWaypoint=GetLocalObject(oCacheObject,CACHE_WAYPOINT+sTag);
    if(GetIsObjectValid(oWaypoint))
    {
        return oWaypoint;
    }
    else
    {
        oWaypoint=GetWaypointByTag(sTag);
        if(GetIsObjectValid(oWaypoint))
        {
            SetLocalObject(oCacheObject,CACHE_WAYPOINT+sTag,oWaypoint);
            return oWaypoint;
        }
        else
        {
            WriteTimestampedLogEntry("<!> "+GetObjectInfoString(OBJECT_SELF)+" failed to add waypoint with tag "+sTag+" to cache on "+GetObjectInfoString(oCacheObject)+".");
            return OBJECT_INVALID;
        }

    }
}


object GetCacheObjectDatabase()
{
    object oModule=GetModule();
    return GetCachedWaypointByTag(CACHE_OBJECT_DATABASE);
}

object GetCacheObjectPlayer()
{
    object oModule=GetModule();
    return GetCachedWaypointByTag(CACHE_OBJECT_PLAYER);
}
object GetCacheObjectPopulation()
{
    object oModule=GetModule();
    return GetCachedWaypointByTag(CACHE_OBJECT_POPULATION);
}
object GetCacheObject2da()
{
    object oModule=GetModule();
    return GetCachedWaypointByTag(CACHE_OBJECT_2DA);
}

object GetCacheObjectArea()
{
    object oModule=GetModule();
    return GetCachedWaypointByTag(CACHE_OBJECT_AREA);
}

object GetCacheObjectItemAppearence()
{
    object oModule=GetModule();
    return GetCachedWaypointByTag(CACHE_OBJECT_ITEM_APPEARENCE);
}

object GetCacheObjectTreasury()
{
    object oModule=GetModule();
    return GetCachedWaypointByTag(CACHE_OBJECT_TREASURY);
}

object GetCacheObjectFaction()
{
    object oModule=GetModule();
    return GetCachedWaypointByTag(CACHE_OBJECT_FACTION);
}

object GetCacheObjectWeather()
{
    object oModule=GetModule();
    return oModule;
}






string GetCached2DAString(string s2DA, string sColumn, int nRow)
{
    object oCache=GetCacheObject2da();
    string sReturn=GetLocalString(oCache, CACHE_2DA+s2DA+sColumn+IntToString(nRow));
    if(sReturn=="")
    {
        sReturn=Get2DAString(s2DA, sColumn, nRow);
        SetLocalString(oCache, CACHE_2DA+s2DA+sColumn+IntToString(nRow), sReturn);
    }
    return sReturn;
}

void SetCachedVersionDatabaseInt(string sDatabaseName, string sVarName, int nValue)
{
    string sCurrentDatabaseName=MODULE_VERSION+sDatabaseName;
    SetCampaignInt(sCurrentDatabaseName,sVarName,nValue);
    SetLocalInt(GetCacheObjectDatabase(), CACHE_DATABASE+sDatabaseName+sVarName, nValue);
}

int GetCachedVersionDatabaseInt(string sDatabaseName, string sVarName)
{
    object oCache=GetCacheObjectDatabase();
    int nReturn=GetLocalInt(oCache,CACHE_DATABASE+sDatabaseName+sVarName);
    if(nReturn==0)
    {
        string sCurrentDatabaseName=MODULE_VERSION+sDatabaseName;
        nReturn=GetCampaignInt(sCurrentDatabaseName,sVarName);
        if(nReturn==0)
        {
            string sPreviousDatabaseName=MODULE_PREVIOUS_VERSION+sDatabaseName;
            nReturn=GetCampaignInt(sPreviousDatabaseName,sVarName);
            SetCampaignInt(sCurrentDatabaseName,sVarName,nReturn);
        }
        SetLocalInt(oCache, CACHE_DATABASE+sDatabaseName+sVarName, nReturn);
    }
    return nReturn;
}


