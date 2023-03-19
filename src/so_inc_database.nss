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

#include "so_inc_general"
#include "so_inc_factions"


//The total size of a PC database.
//const int DATABASE_PC_SIZE=500;


//Module database
/*const int DATABASE_MODULE_INIT=0;
const int DATABASE_MODULE_TIME_YEAR_START=1;
const int DATABASE_MODULE_TIME_YEAR_COUNT=4;
const int DATABASE_MODULE_TIME_MONTH_START=5;
const int DATABASE_MODULE_TIME_MONTH_COUNT=2;
const int DATABASE_MODULE_TIME_DAY_START=7;
const int DATABASE_MODULE_TIME_DAY_COUNT=2;
const int DATABASE_MODULE_TIME_HOUR_START=9;
const int DATABASE_MODULE_TIME_HOUR_COUNT=2;
const int DATABASE_MODULE_TIME_PLAYER_DATABASE_START=11;
const int DATABASE_MODULE_TIME_PLAYER_DATABASE_COUNT=5;
const int DATABASE_MODULE_SIZE=100;*/
//Functions post declaration.





//Store the running database of player oPC in the persistant database.
void PCDataSave(object oPC);

//Restore the persistant database for player oPC into the running database.
//void PCDataLoad(object oPC);

//Write an integer nNewValue into the running database of player oPC at the address nStart.
//void PCDataWriteInt(object oPC,int nNewValue,int nStart,int nCount=1);

//Read an integer from the running database of player oPC at the address nStart.
//int PCDataReadInt(object oPC,int nStart,int nCount=1);

//Write a string sNewValue into the running database of player oPC at the address nStart.
//void PCDataWriteString(object oPC,string sNewValue,int nStart,int nCount=1);

//Read a string from the running database of player oPC at the address nStart.
//string PCDataReadString(object oPC,int nStart,int nCount=1);

//Build a new database for player oPC.
void PCBuildNewDatabase(object oPC);

//Stores the current location on the player oPC's database
void PCStoreLocation(object oPC);

//Returns the stored location from the player oPC's database
location PCRestoreLocation(object oPC);


void PCStoreDeathLocation(object oPC, object oCorpse=OBJECT_INVALID);

location PCRestoreDeathLocation(object oPC);


//Store the running database of the module in the persistant database.
void ModuleDataSave();

//Restore the persistant database for the module into the running database.
void ModuleDataLoad();

//Write an integer nNewValue into the running database of the module at the address nStart.
void ModuleDataWriteInt(int nNewValue,int nStart,int nCount=1);

//Read an integer from the running database of the module at the address nStart.
int ModuleDataReadInt(int nStart,int nCount=1);

//Write a string sNewValue into the running database of the module at the address nStart.
void ModuleDataWriteString(string sNewValue,int nStart,int nCount=1);

//Read a string from the running database of the module at the address nStart.
string ModuleDataReadString(int nStart,int nCount=1);

//Store the module time into the running database.
void ModuleStoreTime();

//Build a new database for the module.
void ModuleBuildNewDatabase();




//PC database.

//Store the running database of player oPC in the persistant database.
void PCDataSave(object oPC)
{
    //string sDatabase=GetLocalString(oPC,"DatabaseString");
    //SetCampaignString("Ravenloft","PlayerDatabase"+GetDeity(oPC),sDatabase);
    //SetLocalString(GetModule(),"DatabaseString"+GetDeity(oPC),sDatabase);
    //SetLocalString(GetSkin(oPC),"DatabaseString",sDatabase);
    object oPC=GetPCSpeaker();
    effect eTemp=GetFirstEffect(oPC);
    while(GetIsEffectValid(eTemp))
    {
        if(GetEffectType(eTemp)==EFFECT_TYPE_POLYMORPH)
        {
            return;
        }
        eTemp=GetNextEffect(oPC);
    }
    ExportSingleCharacter(oPC);
}

//Restore the persistant database for player oPC into the running database.
/*void PCDataLoad(object oPC)
{
    //string sDatabase=GetCampaignString("Ravenloft","PlayerDatabase"+GetDeity(oPC));
    string sDatabase=GetLocalString(GetModule(),"PlayerDatabaseString#"+GetDeity(oPC));
    if(sDatabase!="")
    {
        SetLocalString(GetSkin(oPC),"DatabaseString",sDatabase);
    }
    else
    {
        sDatabase=GetLocalString(GetSkin(oPC),"DatabaseString");
        SetLocalString(GetModule(),"PlayerDatabaseString#"+GetDeity(oPC),sDatabase);
    }
}*/

//Write an integer nNewValue into the running database of player oPC at the address nStart.
/*void PCDataWriteInt(object oPC,int nNewValue,int nStart,int nCount=1)
{
    string sNewValue=IntToString(nNewValue);
    if(GetStringLength(sNewValue)>nCount)
    {
        SpeakString("Stack Overflow!!! Value too high! Player: "+GetName(oPC)+" Location: "+IntToString(nStart)+" Value: "+sNewValue);
        return;
    }
    while(GetStringLength(sNewValue)<nCount)
    {
        sNewValue="0"+sNewValue;
    }
    string sDatabase=GetLocalString(GetSkin(oPC),"DatabaseString");
    sDatabase=GetSubString(sDatabase,0,nStart)+sNewValue+GetSubString(sDatabase,nStart+nCount,DATABASE_PC_SIZE-(nStart+nCount));
    //SetLocalString(GetModule(),"DatabaseString"+GetDeity(oPC),sDatabase);
    SetLocalString(GetSkin(oPC),"DatabaseString",sDatabase);
}*/

//Read an integer from the running database of player oPC at the address nStart.
/*int PCDataReadInt(object oPC,int nStart,int nCount=1)
{
    string sDatabase=GetLocalString(GetSkin(oPC),"DatabaseString");
    int nValue=StringToInt(GetSubString(sDatabase,nStart,nCount));
    return nValue;
}*/

//Write a string sNewValue into the running database of player oPC at the address nStart.
/*void PCDataWriteString(object oPC,string sNewValue,int nStart,int nCount=1)
{
    if(GetStringLength(sNewValue)>nCount)
    {
        SpeakString("Stack Overflow!!! String too long! Player: "+GetName(oPC)+" Location: "+IntToString(nStart)+" String: "+sNewValue);
        return;
    }
    while(GetStringLength(sNewValue)<nCount)
    {
        sNewValue=sNewValue+" ";
    }
    string sDatabase=GetLocalString(GetSkin(oPC),"DatabaseString");
    sDatabase=GetSubString(sDatabase,0,nStart)+sNewValue+GetSubString(sDatabase,nStart+nCount,DATABASE_PC_SIZE-(nStart+nCount));
    SetLocalString(GetSkin(oPC),"DatabaseString",sDatabase);
}*/

//Read a string from the running database of player oPC at the address nStart.
/*string PCDataReadString(object oPC,int nStart,int nCount=1)
{
    string sDatabase=GetLocalString(GetSkin(oPC),"DatabaseString");
    string sReturnString=GetSubString(sDatabase,nStart,nCount);
    while(GetStringRight(sReturnString,1)==" ")
    {
        sReturnString=GetStringLeft(sReturnString,GetStringLength(sReturnString)-1);
    }
    return sReturnString;
}*/

//Build a new database for player oPC.
void PCBuildNewDatabase(object oPC)
{
    AssignCommand(oPC,ClearAllActions());
    object oOldSkin=GetSkin(oPC);
    SetDeity(oPC,"");
    DestroyObject(oOldSkin);
    object oSkin=CreateItemOnObject("rl_pcskin",oPC);
    AssignCommand(oPC,ActionEquipItem(oSkin,INVENTORY_SLOT_CARMOUR));
    int nCount=GetCachedVersionDatabaseInt(DATABASE_CHAR_COUNT, DATABASE_MODULE_PLAYER_COUNT)+1;
    SetCachedVersionDatabaseInt(DATABASE_CHAR_COUNT,DATABASE_MODULE_PLAYER_COUNT,nCount);
    SetLocalInt(oSkin,DATABASE_PC_ID,nCount);
    SetDeity(oPC,IntToString(nCount));
    SetLocalObject(GetCacheObjectPlayer(),MODULE_PLAYER+GetDeity(oPC),oPC);
    //SetCampaignString(DATABASE_MODULE,"Player"+GetDeity(oPC),GetName(oPC));
    SetXP(oPC,1);
    SetXP(oPC,1000);
    SetLocalInt(oSkin,DATABASE_PC_LEVEL,2);
    int nRacialType=GetRacialType(oPC);
    if(nRacialType==RACIAL_TYPE_HALFORC)
    {
        SetLocalInt(oSkin,DATABASE_PC_FACTION_MARKED_AS_FRIEND+"30",TRUE);
    }
    SetLocalInt(oSkin, DATABASE_PC_BASE_RACIAL_TYPE, nRacialType);
    SetLocalInt(oSkin,DATABASE_PC_FACTION,FACTION_OUTLANDERS);
    SetLocalInt(oSkin,DATABASE_PC_SHOWN_FACTION,FACTION_OUTLANDERS);
    SetLocalInt(oSkin,DATABASE_PC_INNATE_FACTION,FACTION_OUTLANDERS);
    SetFactionByID(oPC,FACTION_OUTLANDERS);
    /*string sDatabase="1";
    while(GetStringLength(sDatabase)<DATABASE_PC_SIZE)
    {
        sDatabase=sDatabase+"0";
    }
    SetLocalString(oSkin,"DatabaseString",sDatabase);*/
    //PCDataWriteInt(oPC,TimeStamp(),DATABASE_PC_XP_BUFFER_UPDATE_TIME,DATABASE_PC_TIMESTAMP_COUNT);

    SetLocalInt(oSkin,DATABASE_PC_XP_BUFFER_UPDATE_TIME,TimeStamp());
    SetLocalInt(oSkin,DATABASE_PC_XP_BUFFER,7000);
    SetSubRace(oPC,"");
    PCDataSave(oPC);
    SendMessageToPC(oPC,"New database build.");
    WriteTimestampedLogEntry("New database build for character "+GetName(oPC)+" (ID: "+GetDeity(oPC)+").");
    AssignCommand(oPC, ActionStartConversation(oPC,"rl_conv_bgfeat",TRUE,FALSE));
}

//Stores the current location on the player oPC's database
void PCStoreLocation(object oPC)
{
    object oSkin=GetSkin(oPC);
    location lCurrent=GetLocation(oPC);
    if(!GetIsLocationValid(lCurrent))
    {
        return;
    }
    string sArea=GetTag(GetAreaFromLocation(lCurrent));
    int nFacing=FloatToInt(GetFacingFromLocation(lCurrent));
    vector vLocation=GetPositionFromLocation(lCurrent);
    int nX=FloatToInt(vLocation.x*100.0);
    int nY=FloatToInt(vLocation.y*100.0);
    int nZ=FloatToInt(vLocation.z*100.0)+1;
    SetLocalString(oSkin,DATABASE_PC_LOCATION_AREA_TAG,sArea);
    SetLocalInt(oSkin,DATABASE_PC_LOCATION_X,nX);
    SetLocalInt(oSkin,DATABASE_PC_LOCATION_Y,nY);
    SetLocalInt(oSkin,DATABASE_PC_LOCATION_Z,nZ);
    SetLocalInt(oSkin,DATABASE_PC_LOCATION_Z,nZ);
    //int nServer=GetLocalInt(GetModule(),SERVER_ID);
    //SetLocalInt(oSkin,DATABASE_PC_LOCATION_SERVER,nServer);
    SetLocalInt(oSkin,DATABASE_PC_LOCATION_FACING,nFacing);
}

//Returns the stored location from the player oPC's database
location PCRestoreLocation(object oPC)
{
    object oSkin=GetSkin(oPC);
    string sAreaTag=GetLocalString(oSkin,DATABASE_PC_LOCATION_AREA_TAG);
    object oArea=OBJECT_INVALID;
    if(sAreaTag!="")
    {
        oArea=GetCachedObjectByTag(sAreaTag, GetCacheObjectArea());
    }
    //int nServer=GetLocalInt(oSkin,DATABASE_PC_LOCATION_SERVER);
    //int nServerSelf=GetLocalInt(GetModule(),SERVER_ID);
    vector vLocation;
    //if(nServer!=nServerSelf)
    //{
    //    vLocation=Vector(0.0,0.0,-IntToFloat(nServer)*100.0);
    //
    //}
    //else
    //{
        float fX=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_LOCATION_X))*0.01;
        float fY=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_LOCATION_Y))*0.01;
        float fZ=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_LOCATION_Z))*0.01;
        vLocation=Vector(fX,fY,fZ);
    //}
    float fFacing=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_LOCATION_FACING));
    location lRestored=Location(oArea,vLocation,fFacing);
    return lRestored;
}

void PCStoreDeathLocation(object oPC, object oCorpse=OBJECT_INVALID)
{
    object oSkin=GetSkin(oPC);
    location lCurrent=GetLocation(oPC);
    if(oCorpse!=OBJECT_INVALID)
    {
        lCurrent=GetLocation(oCorpse);
    }
    if(!GetIsLocationValid(lCurrent))
    {
        return;
    }
    string sArea=GetTag(GetAreaFromLocation(lCurrent));
    int nFacing=FloatToInt(GetFacingFromLocation(lCurrent));
    vector vLocation=GetPositionFromLocation(lCurrent);
    int nX=FloatToInt(vLocation.x*100.0);
    int nY=FloatToInt(vLocation.y*100.0);
    int nZ=FloatToInt(vLocation.z*100.0)+1;
    SetLocalString(oSkin,DATABASE_PC_DEATH_LOCATION_AREA_TAG,sArea);
    SetLocalInt(oSkin,DATABASE_PC_DEATH_LOCATION_FACING,nFacing);
    SetLocalInt(oSkin,DATABASE_PC_DEATH_LOCATION_X,nX);
    SetLocalInt(oSkin,DATABASE_PC_DEATH_LOCATION_Y,nY);
    SetLocalInt(oSkin,DATABASE_PC_DEATH_LOCATION_Z,nZ);
    //int nServer=GetLocalInt(GetModule(),SERVER_ID);
    //SetLocalInt(oSkin,DATABASE_PC_DEATH_LOCATION_SERVER,nServer);
}

location PCRestoreDeathLocation(object oPC)
{
    object oSkin=GetSkin(oPC);
    object oArea=GetCachedObjectByTag(GetLocalString(oSkin,DATABASE_PC_DEATH_LOCATION_AREA_TAG),GetCacheObjectArea());
    //int nServer=GetLocalInt(oSkin,DATABASE_PC_DEATH_LOCATION_SERVER);
    //int nServerSelf=GetLocalInt(GetModule(),SERVER_ID);
    vector vLocation;
    //if(nServer!=nServerSelf)
    //{
    //    vLocation=Vector(0.0,0.0,-IntToFloat(nServer)*100.0);
    //}
    //else
    //{
        float fX=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_DEATH_LOCATION_X))*0.01;
        float fY=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_DEATH_LOCATION_Y))*0.01;
        float fZ=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_DEATH_LOCATION_Z))*0.01;
        vLocation=Vector(fX,fY,fZ);
    //}
    float fFacing=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_DEATH_LOCATION_FACING));
    location lRestored=Location(oArea,vLocation,fFacing);
    return lRestored;
}


//Stores the current location on the player oPC's database
void PCStoreSafeLocation(object oPC)
{
    object oSkin=GetSkin(oPC);
    location lCurrent=GetLocation(oPC);
    if(!GetIsLocationValid(lCurrent))
    {
        return;
    }
    string sArea=GetTag(GetAreaFromLocation(lCurrent));
    int nFacing=FloatToInt(GetFacingFromLocation(lCurrent));
    vector vLocation=GetPositionFromLocation(lCurrent);
    int nX=FloatToInt(vLocation.x*100.0);
    int nY=FloatToInt(vLocation.y*100.0);
    int nZ=FloatToInt(vLocation.z*100.0)+1;
    SetLocalString(oSkin,DATABASE_PC_SAFE_LOCATION_AREA_TAG,sArea);
    SetLocalInt(oSkin,DATABASE_PC_SAFE_LOCATION_X,nX);
    SetLocalInt(oSkin,DATABASE_PC_SAFE_LOCATION_Y,nY);
    SetLocalInt(oSkin,DATABASE_PC_SAFE_LOCATION_Z,nZ);
    SetLocalInt(oSkin,DATABASE_PC_SAFE_LOCATION_FACING,nFacing);
    //int nServer=GetLocalInt(GetModule(),SERVER_ID);
    //SetLocalInt(oSkin,DATABASE_PC_SAFE_LOCATION_SERVER,nServer);
    SendMessageToPC(oPC,"Safe location stored.");
}

//Returns the stored location from the player oPC's database
location PCRestoreSafeLocation(object oPC)
{
    object oSkin=GetSkin(oPC);
    object oArea=GetCachedObjectByTag(GetLocalString(oSkin,DATABASE_PC_SAFE_LOCATION_AREA_TAG),GetCacheObjectArea());
    //int nServer=GetLocalInt(oSkin,DATABASE_PC_SAFE_LOCATION_SERVER);
    //int nServerSelf=GetLocalInt(GetModule(),SERVER_ID);
    vector vLocation;
    //if(nServer!=nServerSelf)
    //{
    //    vLocation=Vector(0.0,0.0,-IntToFloat(nServer)*100.0);
    //}
    //else
    //{
        float fX=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_SAFE_LOCATION_X))*0.01;
        float fY=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_SAFE_LOCATION_Y))*0.01;
        float fZ=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_SAFE_LOCATION_Z))*0.01;
        vLocation=Vector(fX,fY,fZ);
    //}
    float fFacing=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_SAFE_LOCATION_FACING));
    location lRestored=Location(oArea,vLocation,fFacing);
    return lRestored;
}

//Stores the current location on the player oPC's database
void PCStoreMistLocation(object oPC, location lMist)
{
    object oSkin=GetSkin(oPC);
    if(!GetIsLocationValid(lMist))
    {
        return;
    }
    string sArea=GetTag(GetAreaFromLocation(lMist));
    int nFacing=FloatToInt(GetFacingFromLocation(lMist));
    vector vLocation=GetPositionFromLocation(lMist);
    int nX=FloatToInt(vLocation.x*100.0);
    int nY=FloatToInt(vLocation.y*100.0);
    int nZ=FloatToInt(vLocation.z*100.0)+1;
    SetLocalString(oSkin,DATABASE_PC_MIST_LOCATION_AREA_TAG,sArea);
    SetLocalInt(oSkin,DATABASE_PC_MIST_LOCATION_X,nX);
    SetLocalInt(oSkin,DATABASE_PC_MIST_LOCATION_Y,nY);
    SetLocalInt(oSkin,DATABASE_PC_MIST_LOCATION_Z,nZ);
    SetLocalInt(oSkin,DATABASE_PC_MIST_LOCATION_FACING,nFacing);
    //int nServer=GetLocalInt(GetModule(),SERVER_ID);
    //SetLocalInt(oSkin,DATABASE_PC_MIST_LOCATION_SERVER,nServer);
    SendMessageToPC(oPC,"New world entry point stored.");
}

//Returns the stored location from the player oPC's database
location PCRestoreMistLocation(object oPC)
{
    object oSkin=GetSkin(oPC);
    object oArea=GetCachedObjectByTag(GetLocalString(oSkin,DATABASE_PC_MIST_LOCATION_AREA_TAG), GetCacheObjectArea());
    //int nServer=GetLocalInt(oSkin,DATABASE_PC_MIST_LOCATION_SERVER);
    //int nServerSelf=GetLocalInt(GetModule(),SERVER_ID);
    vector vLocation;
    //if(nServer!=nServerSelf)
    //{
    //    vLocation=Vector(0.0,0.0,-IntToFloat(nServer)*100.0);
    //}
    //else
    //{
        float fX=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_MIST_LOCATION_X))*0.01;
        float fY=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_MIST_LOCATION_Y))*0.01;
        float fZ=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_MIST_LOCATION_Z))*0.01;
        vLocation=Vector(fX,fY,fZ);
    //}
    float fFacing=IntToFloat(GetLocalInt(oSkin,DATABASE_PC_MIST_LOCATION_FACING));
    location lRestored=Location(oArea,vLocation,fFacing);
    if(GetIsLocationValid(lRestored))
    {
        return lRestored;
    }
    return GetLocation(GetCachedWaypointByTag("rl_playerstart", GetCacheObjectPlayer()));
}


//Module Database


//Store the running database of the module in the persistant database.
/*void ModuleDataSave()
{
    string sDatabase=GetLocalString(GetModule(),"DatabaseString");
    SetCampaignString(DATABASE_MODULE,"ModuleDatabase",sDatabase);
}

//Restore the persistant database for the module into the running database.
void ModuleDataLoad()
{
    string sDatabase=GetCampaignString(DATABASE_MODULE,"ModuleDatabase");
    SetLocalString(GetModule(),"DatabaseString",sDatabase);
}

//Write an integer nNewValue into the running database of the module at the address nStart.
void ModuleDataWriteInt(int nNewValue,int nStart,int nCount=1)
{
    object oModule=GetModule();
    string sNewValue=IntToString(nNewValue);
    if(GetStringLength(sNewValue)>nCount)
    {
        SpeakString("Stack Overflow!!! Value too high! Module Database on location: "+IntToString(nStart)+" Value: "+sNewValue);
        return;
    }
    while(GetStringLength(sNewValue)<nCount)
    {
        sNewValue="0"+sNewValue;
    }
    string sDatabase=GetLocalString(oModule,"DatabaseString");
    sDatabase=GetSubString(sDatabase,0,nStart)+sNewValue+GetSubString(sDatabase,nStart+nCount,DATABASE_MODULE_SIZE-(nStart+nCount));
    SetLocalString(oModule,"DatabaseString",sDatabase);
}

//Read an integer from the running database of the module at the address nStart.
int ModuleDataReadInt(int nStart,int nCount=1)
{
    object oModule=GetModule();
    string sDatabase=GetLocalString(oModule,"DatabaseString");
    int nValue=StringToInt(GetSubString(sDatabase,nStart,nCount));
    return nValue;
}

//Write a string sNewValue into the running database of the module at the address nStart.
void ModuleDataWriteString(string sNewValue,int nStart,int nCount=1)
{
    object oModule=GetModule();
    if(GetStringLength(sNewValue)>nCount)
    {
        SpeakString("Stack Overflow!!! String too long! Module Database on Location: "+IntToString(nStart)+" String: "+sNewValue);
        return;
    }
    while(GetStringLength(sNewValue)<nCount)
    {
        sNewValue=sNewValue+" ";
    }
    string sDatabase=GetLocalString(oModule,"DatabaseString");
    sDatabase=GetSubString(sDatabase,0,nStart)+sNewValue+GetSubString(sDatabase,nStart+nCount,DATABASE_MODULE_SIZE-(nStart+nCount));
    SetLocalString(oModule,"DatabaseString",sDatabase);
}

//Read a string from the running database of the module at the address nStart.
string ModuleDataReadString(int nStart,int nCount=1)
{
    object oModule=GetModule();
    string sDatabase=GetLocalString(oModule,"DatabaseString");
    string sReturnString=GetSubString(sDatabase,nStart,nCount);
    while(GetStringRight(sReturnString,1)==" ")
    {
        sReturnString=GetStringLeft(sReturnString,GetStringLength(sReturnString)-1);
    }
    return sReturnString;
}
*/
void ModuleStoreTime()
{
    /*ModuleDataWriteInt(GetCalendarYear(),DATABASE_MODULE_TIME_YEAR_START,DATABASE_MODULE_TIME_YEAR_COUNT);
    ModuleDataWriteInt(GetCalendarMonth(),DATABASE_MODULE_TIME_MONTH_START,DATABASE_MODULE_TIME_MONTH_COUNT);
    ModuleDataWriteInt(GetCalendarDay(),DATABASE_MODULE_TIME_DAY_START,DATABASE_MODULE_TIME_DAY_COUNT);
    ModuleDataWriteInt(GetTimeHour(),DATABASE_MODULE_TIME_HOUR_START,DATABASE_MODULE_TIME_HOUR_COUNT);*/
    //if(GetLocalInt(GetModule(),SERVER_ID)==SERVER_MAIN_LOGIN)
    //{
        SetCampaignInt(MODULE_VERSION+DATABASE_CLOCK,DATABASE_MODULE_TIME,TimeStamp());
    //}
}

void ModuleBuildNewDatabase()
{
    /*object oModule=GetModule();
    int nCount=1;
    string sDatabase="1";
    while(GetStringLength(sDatabase)<DATABASE_MODULE_SIZE)
    {
        sDatabase=sDatabase+"0";
    }
    SetLocalString(oModule,"DatabaseString",sDatabase);*/
    ModuleStoreTime();
    //ModuleDataSave();
}





