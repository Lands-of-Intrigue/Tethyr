//::///////////////////////////////////////////////
//:: Name:      Bedlamson's Dynamic Merchant System
//::            Merchant OnOpenStore Event
//:: FileName:  bdm_store_open
//:: Copyright (c) 2003 Stephen Spann
//::///////////////////////////////////////////////
//:: Created By: Bedlamson
//:: Created On: 1/23/2003
//::///////////////////////////////////////////////

#include "bdm_include"

int CheckLimits(object oPC, object oCache);
int CheckLinkedLimits(object oPC, object oCache);
void ClearDynamics();
void DestroyDynamics(int nToDestroy);

void main()
{
// Get the stores tag with the parameters.
string sParams = GetLocalString(OBJECT_SELF, "PARAMS");
if (nDebug) SendMessageToPC(GetFirstPC(), "Opening store with parameters: " + sParams);
object oPC = GetLocalObject(OBJECT_SELF, "LAST_OPENED_BY");

int nValidCaches = GetValue(OBJECT_SELF, "NC", sParams);

// Determine the time elapsed since store was opened.
string sLastOpened = GetLocalString(OBJECT_SELF, "LAST_OPENED");
if (nDebug) SendMessageToPC(oPC, "Last Opened: " + sLastOpened);
struct cs_time CurrentTime = cs_time_GetCurrentTime();
string sCurrentTime = cs_time_TimeToString(CurrentTime);
int nCurrentTime;
int nLastTime;
int nTimeElapsed;
if (sLastOpened != "")
    {
    struct cs_time LastOpened = cs_time_StringToTime(sLastOpened);
    nLastTime = cs_time_GetSecondsSinceEpoch(LastOpened);
    nCurrentTime = cs_time_GetSecondsSinceEpoch(CurrentTime);
    nTimeElapsed = nCurrentTime - nLastTime;
    if (nDebug) SendMessageToPC(GetFirstPC(), "Time Elapsed: " + IntToString(nTimeElapsed) + " seconds");
    }

// Store the current time.
if (nDebug) SendMessageToPC(GetFirstPC(), "Current Time: " + sCurrentTime);
SetLocalString(OBJECT_SELF, "LAST_OPENED", sCurrentTime);

// Get variables.
int nNeedToCreate = GetValue(OBJECT_SELF, "IT", sParams);
int nItemsRemain = GetValue(OBJECT_SELF, "IR", sParams);

// Determine if enough time has elapsed to destroy
// any dynamic items in order to allow a chance of
// them being replaced.
int nNeedToDestroy = 0;
int nTimeDelay = GetLocalInt(OBJECT_SELF, "TIMEDELAY");
if (!nTimeDelay)
    {
    nTimeDelay = GetValue(OBJECT_SELF, "TM", sParams);
    SetLocalInt(OBJECT_SELF, "TIMEDELAY", nTimeDelay);
    }
int nTimerLinked = GetValue(OBJECT_SELF, "TL", sParams);
//if (nDebug) SendMessageToPC(GetFirstPC(), "Time Delay: " + IntToString(nTimeDelay) + " seconds");
if (nTimeElapsed && nTimeDelay && nTimerLinked)
    {
    if (nTimeElapsed > nTimeDelay)
        {
        nNeedToDestroy = nNeedToCreate;
        DeleteLocalInt(OBJECT_SELF, "TIMEDELAY");
        }
    else
        {
        nNeedToDestroy = 0;
        }
    }
else if (nTimeElapsed && nTimeDelay)
    {
    nNeedToDestroy = (nTimeElapsed / nTimeDelay) + GetValue(OBJECT_SELF, "RD", sParams);
    DeleteLocalInt(OBJECT_SELF, "TIMEDELAY");
    }
else if (!nItemsRemain)
    {
    nNeedToDestroy = nNeedToCreate;
    }

// Destroy dynamic items as needed.
DestroyDynamics(nNeedToDestroy);

// Check to see how many dynamic items already exist.
//int nNeedToCreate = GetValue(OBJECT_SELF, "IT", sTag);
//int nCurrentDynamic;
ClearDynamics();
int nCurrentDynamic;
object oInvSelf = GetFirstItemInInventory();
while (oInvSelf != OBJECT_INVALID)
    {

    // Check how many dynamic items are in the
    // current inventory and tag them for later.
    if (GetLocalInt(oInvSelf, "DYNAMIC") && !GetLocalInt(oInvSelf, "DESTROYED"))
        {
        nCurrentDynamic++;
        SetLocalObject(OBJECT_SELF, "DYNAMIC_" + IntToString(nCurrentDynamic), oInvSelf);
        }

    // Destroy any items that were limited
    if (GetLocalInt(oInvSelf, "LIMITED"))
        {
        DestroyObject(oInvSelf);
        }

    // If store cleaning is enabled, check each item
    // to see how long its been there.
    int nClean = FindSubString(sParams, "CL");
    string sItemTime = GetLocalString(oInvSelf, "TIME");
    //if (nDebug) SendMessageToPC(GetFirstPC(), "Cleaning Switch: " + IntToString(nClean));
    if (nClean && sItemTime != "")
        {
        //if (nDebug) SendMessageToPC(GetFirstPC(), "Item TIme: " + sItemTime);
        string sClean = GetSubString(sParams, nClean + 2, 1);
        if (sClean != "_" && sClean != "")
            {
            nClean = GetValue(OBJECT_SELF, "CL", sParams);
            //if (nDebug) SendMessageToPC(GetFirstPC(), "Delay for " + GetName(oInvSelf) + " : " + sParams);
            string sItemGivenToStore = GetLocalString(oInvSelf, "TIME");
            struct cs_time ItemGivenToStore = cs_time_StringToTime(sItemGivenToStore);
            int nItemGivenToStore = cs_time_GetSecondsSinceEpoch(ItemGivenToStore);
            int nDeleteTime = GetLocalInt(oInvSelf, "DELETE_TIME");
            if (!nDeleteTime)
                {
                nDeleteTime = nClean + nItemGivenToStore;
                SetLocalInt(oInvSelf, "DELETE_TIME", nDeleteTime);
                if (nDebug) SendMessageToPC(GetFirstPC(), "Setting Delete Time: " + IntToString(nDeleteTime - nCurrentTime) + "   For item: " + GetName(oInvSelf));
                }
            int nItemTime = GetItemTime(oInvSelf);
            if (nDebug) SendMessageToPC(GetFirstPC(), "Delete Timer: " + IntToString(nCurrentTime - nItemGivenToStore));
            if (nCurrentTime > nDeleteTime) DestroyObject(oInvSelf);
            }
        else DestroyObject(oInvSelf);
        }

    oInvSelf = GetNextItemInInventory();
    }
nNeedToCreate = nNeedToCreate - nCurrentDynamic;

// Start a loop for each item.
int nInventory = 0;
int nNewItems;
int nRandom;
string sResRef;
object oNewItem;
int nDynamic = 1;
int nAlreadyThere;
object oCurrentDynamic;
object oInventory;
//int nCachePos = GetSubString
object oCache;
int nCaches;
int nChance;
string sCache;
int nUnique;
object oRandomObject;
//if (nDebug) SendMessageToPC(GetFirstPC(), "Pre-Loop");
//if (nDebug) SendMessageToPC(GetFirstPC(), "Item: " + IntToString(nNewItems) + " / " + IntToString(nNeedToCreate));
//if (nDebug) SendMessageToPC(GetFirstPC(), "Cache: " + IntToString(nCaches) + " / " + IntToString(nValidCaches));
//if (nDebug) SendMessageToPC(GetFirstPC(), "Name: " + sTag);
for (nNewItems = 0; nNewItems <= nNeedToCreate; nNewItems++)
    {
    nInventory = 0;
    //if (nDebug) SendMessageToPC(GetFirstPC(), "Item: " + IntToString(nNewItems) + " / " + IntToString(nNeedToCreate));
    int nShowAll;
    for (nCaches = 1; nCaches <= nValidCaches; nCaches++)
        {
        oCache = GetLocalObject(OBJECT_SELF, "CACHE_" + IntToString(nCaches));
        if (nNewItems == 0)
            {
            int nLimitsLinked = GetValue(OBJECT_SELF, "LL", GetTag(oCache));
            if (nLimitsLinked && CheckLinkedLimits(oPC, oCache))
                {
                nShowAll = TRUE;
                if (nDebug) SendMessageToPC(oPC, "Linked Limits returned true.");
                }
            else if (!nLimitsLinked && CheckLimits(oPC, oCache))
                {
                nShowAll = TRUE;
                if (nDebug) SendMessageToPC(oPC, "Normal Limits returned true.");
                }
            else
                {
                nShowAll = FALSE;
                if (nDebug) SendMessageToPC(oPC, "Limits returned false.");
                }
            if (nShowAll)
                {
                oInventory = GetFirstItemInInventory(oCache);
                while (oInventory != OBJECT_INVALID)
                    {
                    sResRef = GetResRef(oInventory);
                    oNewItem = CreateItemOnObject(sResRef, OBJECT_SELF, GetNumStackedItems(oInventory));
                    oInventory = GetNextItemInInventory(oCache);
                    SetLocalInt(oNewItem, "LIMITED", TRUE);
                    }
                SetLocalInt(oCache, "SHOWN", TRUE);
                }
            }
        else if (GetLocalInt(oCache, "SHOWN") != TRUE)
            {
            if (nDebug && oCache == OBJECT_INVALID) SendMessageToPC(oPC, "Cache Invalid.");
            sCache = GetStringUpperCase(GetTag(oCache));
            nChance = GetValue(oCache, "PR", sCache);
            if (nChance == 0) nChance = 100;
            //if (nDebug) SendMessageToPC(GetFirstPC(), "CHANCE: " + IntToString(nChance));
            nUnique = FALSE;
            if (GetValue(OBJECT_SELF, "UQ", sParams) || GetValue(oCache, "UQ", GetTag(oCache))) nUnique = TRUE;
            //if (nDebug) SendMessageToPC(GetFirstPC(), "UNIQUE: " + IntToString(nUnique));
            oInventory = GetFirstItemInInventory(oCache);
            while (oInventory != OBJECT_INVALID)
                {
                //if (nShowAll == TRUE)
                //if (nDebug) SendMessageToPC(GetFirstPC(), "Checking Name: " + GetTag(oInventory));
                if (d100() <= nChance)
                    {
                    nDynamic = 1;
                    nAlreadyThere = FALSE;
                    if (nUnique == TRUE)
                        {
                        oCurrentDynamic = GetLocalObject(OBJECT_SELF, "DYNAMIC_1");
                        while (oCurrentDynamic != OBJECT_INVALID)
                            {
                            if (GetResRef(oInventory) == GetResRef(oCurrentDynamic))
                                {
                                nAlreadyThere = TRUE;
                                //if (nDebug) SendMessageToPC(GetFirstPC(), "THERE");
                                }
                            nDynamic++;
                            oCurrentDynamic = GetLocalObject(OBJECT_SELF, "DYNAMIC_" + IntToString(nDynamic));
                            }
                        }
                    if (nAlreadyThere != TRUE)
                        {
                        nInventory++;
                        SetLocalObject(OBJECT_SELF, "ITEM_" + IntToString(nInventory), oInventory);
                        //if (nDebug) SendMessageToPC(GetFirstPC(), "Added item " + IntToString(nInventory));
                        }
                    }
                oInventory = GetNextItemInInventory(oCache);
                }
            }
        }
    nRandom = Random(nInventory) + 1;
    oRandomObject = GetLocalObject(OBJECT_SELF, "ITEM_" + IntToString(nRandom));
    sResRef = GetResRef(oRandomObject);
    oNewItem = CreateItemOnObject(sResRef, OBJECT_SELF, GetNumStackedItems(oRandomObject));
    //if (nDebug) SendMessageToPC(GetFirstPC(), "New Item: " + GetName(oNewItem));
    nCurrentDynamic++;
    SetLocalObject(OBJECT_SELF, "DYNAMIC_" + IntToString(nCurrentDynamic), oNewItem);
    SetLocalInt(oNewItem, "DYNAMIC", TRUE);
    int nDeleting;
    for (nDeleting = 1; nDeleting <= nInventory; nDeleting++)
        {
        DeleteLocalObject(OBJECT_SELF, "ITEM_" + IntToString(nDeleting));
        }
    for (nDeleting = 1; nDeleting <= nValidCaches; nDeleting++)
        {
        DeleteLocalInt(GetLocalObject(OBJECT_SELF, "CACHE_" + IntToString(nDeleting)), "SHOWN");
        }
    }

}


int CheckLimits(object oPC, object oCache)
{
string sParams = GetTag(oCache);
int nParamPos;
int nAlignPos = FindSubString(sParams, "LA");
nParamPos = nAlignPos + 2;
string sAlignment = GetSubString(sParams, nParamPos, 2);
while (sAlignment != "")
    {
    if (CheckAlignment(sAlignment, oPC))
        {
        if (nDebug) SendMessageToPC(oPC, "Normal Limits: Alignment returned true.");
        return TRUE;
        break;
        }
    else
        {
        if (GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sAlignment = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            sAlignment = "";
            }
        }
    }

int nClassPos = FindSubString(sParams, "LC");
nParamPos = nClassPos + 2;
string sClass = GetSubString(sParams, nParamPos, 2);
while (sClass != "")
    {
    if (CheckClass(sClass, oPC))
        {
        if (nDebug) SendMessageToPC(oPC, "Normal Limits: Class returned true.");
        return TRUE;
        break;
        }
    else
        {
        if (GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sClass = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            sClass = "";
            }
        }
    }

int nGenderPos = FindSubString(sParams, "LG");
string sGender = GetSubString(sParams, nGenderPos + 2, 1);
if (CheckGender(sGender, oPC))
    {
    if (nDebug) SendMessageToPC(oPC, "Normal Limits: Gender returned true.");
    return TRUE;
    }

int nRacePos = FindSubString(sParams, "LR");
nParamPos = nRacePos + 2;
string sRace = GetSubString(sParams, nParamPos, 2);
while (sRace != "")
    {
    if (CheckRace(sRace, oPC))
        {
        if (nDebug) SendMessageToPC(oPC, "Normal Limits: Race returned true.");
        return TRUE;
        break;
        }
    else
        {
        if (GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sRace = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            sRace = "";
            }
        }
    }

int nSubracePos = FindSubString(sParams, "LS");
nParamPos = nSubracePos + 2;
string sSubrace = GetSubString(sParams, nParamPos, 2);
while (sSubrace != "")
    {
    if (CheckSubrace(sSubrace, oPC))
        {
        if (nDebug) SendMessageToPC(oPC, "Normal Limits: Subrace returned true.");
        return TRUE;
        break;
        }
    else
        {
        if (GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sSubrace = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            sSubrace = "";
            }
        }
    }
return FALSE;
}


int CheckLinkedLimits(object oPC, object oCache)
{
int nReturn;
string sParams = GetTag(oCache);
int nAlignPos = FindSubString(sParams, "LA");
int nClassPos = FindSubString(sParams, "LC");
int nGenderPos = FindSubString(sParams, "LG");
int nRacePos = FindSubString(sParams, "LR");
int nSubracePos = FindSubString(sParams, "LS");

int nParamPos;
string sAlignment;
nParamPos = nAlignPos + 2;
if (nAlignPos != -1)
    {
    sAlignment = GetSubString(sParams, nParamPos, 2);
    }
while (sAlignment != "")
    {
    if (nDebug) SendMessageToPC(oPC, "Checking Alignment: " + sAlignment);
    if (CheckAlignment(sAlignment, oPC))
        {
        if (nDebug) SendMessageToPC(oPC, "Linked Limits: Alignment " + sAlignment + " returned true.");
        //nReturn = TRUE
        //break;
        sAlignment = "";
        }
    else if (!CheckAlignment(sAlignment, oPC))
        {
        if (nDebug) SendMessageToPC(oPC, "Linked Limits: Alignment " + sAlignment + " returned false.");
        if (GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sAlignment = GetSubString(sParams, nParamPos, 2);
            }
        else
            {
            //if (nDebug) SendMessageToPC(oPC, "Linked Limits: Alignment " + sAlignment + " returned false.");
            return FALSE;
            }
        }
    }

string sClass;
nParamPos = nClassPos + 2;
if (nClassPos != -1)
    {
    sClass = GetSubString(sParams, nParamPos, 2);
    }
while (sClass != "")
    {
    if (CheckClass(sClass, oPC))
        {
        if (nDebug) SendMessageToPC(oPC, "Linked Limits: Class returned true.");
        //break;
        sClass = "";
        }
    else
        {
        if (GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sClass = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            if (nDebug) SendMessageToPC(oPC, "Linked Limits: Class returned false.");
            return FALSE;
            }
        }
    }

string sGender;
if (nGenderPos != -1)
    {
    sGender = GetSubString(sParams, nGenderPos + 2, 1);
    }
if (sGender != "" && !CheckGender(sGender, oPC))
    {
    if (nDebug) SendMessageToPC(oPC, "Linked Limits: Gender returned false.");
    return FALSE;
    }

string sRace;
nParamPos = nRacePos + 2;
if (nRacePos != -1)
    {
    sRace = GetSubString(sParams, nParamPos, 2);
    }
while (sRace != "")
    {
    if (CheckRace(sRace, oPC))
        {
        if (nDebug) SendMessageToPC(oPC, "Linked Limits: Race " + sRace + "returned true.");
        break;
        //sRace = "";
        }
    else
        {
        if (GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sRace = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            if (nDebug) SendMessageToPC(oPC, "Linked Limits: Race returned false.");
            return FALSE;
            }
        }
    }


string sSubrace;
nParamPos = nSubracePos + 2;
if (nSubracePos != -1)
    {
    sSubrace = GetSubString(sParams, nParamPos, 2);
    }
while (sSubrace != "")
    {
    if (CheckSubrace(sSubrace, oPC))
        {
        if (nDebug) SendMessageToPC(oPC, "Linked Limits: Subrace returned true.");
        //break;
        sSubrace = "";
        }
    else
        {
        if (GetSubString(sParams, (nParamPos + 2), 1) == "A")
            {
            nParamPos = nParamPos + 3;
            sSubrace = GetSubString(sParams, (nParamPos), 2);
            }
        else
            {
            if (nDebug) SendMessageToPC(oPC, "Linked Limits: Subrace returned false.");
            return FALSE;
            }
        }
    }
return TRUE;
}


void ClearDynamics()
{
int nDelete;
object oDynamic = GetLocalObject(OBJECT_SELF, "DYNAMIC_1");
while (oDynamic != OBJECT_INVALID)
    {
    nDelete++;
    DeleteLocalObject(OBJECT_SELF, "DYNAMIC_" + IntToString(nDelete));
    //if (nDebug) SendMessageToPC(GetFirstPC(), "Clearing Dynamic Item: " + GetName(oDynamic));
    oDynamic = (GetLocalObject(OBJECT_SELF, "DYNAMIC_" + IntToString(nDelete + 1)));
    }
}

void DestroyDynamics(int nToDestroy)
{
int nDestroy;
int nNumItems;
int nDestroyRandom;
int nNth;
//object oDestroyed;
object oInvSelf;
for (nDestroy = 1; nDestroy <= nToDestroy; nDestroy++)
    {
    oInvSelf = GetFirstItemInInventory();
    nNumItems = 0;
    while (oInvSelf != OBJECT_INVALID)
        {
        if (GetLocalInt(oInvSelf, "DYNAMIC") && !GetLocalInt(oInvSelf, "DESTROYED"))
            {
            nNumItems++;
            }
        oInvSelf = GetNextItemInInventory();
        }
    //if (nDebug) SendMessageToPC(GetFirstPC(), "Loop: " + IntToString(nDestroy) + " Items Found: " + IntToString(nNumItems));

    nDestroyRandom = Random(nNumItems) + 1;
    nNth = 0;
    oInvSelf = GetFirstItemInInventory();
    while (oInvSelf != OBJECT_INVALID)
        {
        //if (nDebug) SendMessageToPC(GetFirstPC(), "Looking for Dynamic # " + IntToString(nDestroyRandom) + ". Current Item: " + IntToString(nNth + 1) + GetName(oInvSelf) + " Dynamic: " + IntToString(GetLocalInt(oInvSelf, "DYNAMIC")) + " Destroyed: " + IntToString(GetLocalInt(oInvSelf, "DESTROYED")));
        if (GetLocalInt(oInvSelf, "DYNAMIC") && !GetLocalInt(oInvSelf, "DESTROYED"))
            {
            nNth++;
            if (nDestroyRandom == nNth)
                {
                if (nDebug) SendMessageToPC(GetFirstPC(), "Destroying " + GetName(oInvSelf));
                //int nStack = GetNumStackedItems(oInvSelf);
                //if (nDebug) SendMessageToPC(GetFirstPC(), "Stack - " + IntToString(nStack));
                //oDestroyed = oInvSelf;
                DestroyObject(oInvSelf);
                SetLocalInt(oInvSelf, "DESTROYED", TRUE);
                //oInvSelf = OBJECT_INVALID;
                }
            }
        if (oInvSelf != OBJECT_INVALID) oInvSelf = GetNextItemInInventory();
        }
    //SetLocalInt(oInvSelf, "DESTROYED", TRUE);
    }
}
