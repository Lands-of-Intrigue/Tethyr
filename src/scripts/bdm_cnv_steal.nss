//::///////////////////////////////////////////////
//:: Name:      Bedlamson's Dynamic Merchant System
//::            Conversation 'Actions Taken'
//:: FileName:  bdm_cnv_steal
//:: Copyright (c) 2003 Stephen Spann
//::///////////////////////////////////////////////
//:: Created By: Bedlamson
//:: Created On: 1/23/2003
//::///////////////////////////////////////////////

#include "bdm_include"

int GetFavoredEnemy();

void main()
{
// Get variables.
object oPC = GetPCSpeaker();
object oShopkeeper = OBJECT_SELF;
int nSpotBonus;
string sParams = GetLocalString(oShopkeeper, "PARAMS");
object oStore = GetLocalObject(oShopkeeper, "STORE");

// Get parameters.
int nCircumstancePos = FindSubString(sParams, "SC");
int nReactionHostile = GetValue(OBJECT_SELF, "RH", sParams);
int nTimeLimit = GetValue(OBJECT_SELF, "SL", sParams);
//int nTimeDelay = GetValue(OBJECT_SELF, "TM", sParams);
int nStealAll = GetValue(OBJECT_SELF, "SA", sParams);

// Apply bonuses to the shopkeeper's Spot skill.
if (GetRacialType(oShopkeeper) == RACIAL_TYPE_ELF) nSpotBonus = nSpotBonus + 2;
if (GetRacialType(oShopkeeper) == RACIAL_TYPE_HALFELF) nSpotBonus = nSpotBonus + 1;
if (GetFavoredEnemy() == GetRacialType(oPC)) nSpotBonus = nSpotBonus + 1;
if (GetHasFeat(FEAT_ALERTNESS)) nSpotBonus = nSpotBonus + 2;

int nPCSkill = GetSkillRank(SKILL_PICK_POCKET, oPC) + GetAbilityModifier(ABILITY_DEXTERITY, oPC);
if (nCircumstancePos != -1)
    {
    string sCircumstance = GetSubString(sParams, nCircumstancePos + 2, 2);
    if (GetStringLeft(sCircumstance, 1) == "P")
        {
        nPCSkill = nPCSkill + StringToInt(GetStringRight(sCircumstance, 1));
        }
    if (GetStringLeft(sCircumstance, 1) == "N")
        {
        nPCSkill = nPCSkill - StringToInt(GetStringRight(sCircumstance, 1));
        }
    }
int nShopSkill = GetSkillRank(SKILL_SPOT, oShopkeeper) + GetAbilityModifier(ABILITY_WISDOM, oShopkeeper) + nSpotBonus;
int nPCRoll = d20();
int nShopRoll = d20();
int nPCTotal = nPCSkill + nPCRoll;
int nShopTotal = nShopRoll + nShopSkill;

string sMessage = "(" + IntToString(nPCSkill) + " + "
        + IntToString(nPCRoll) + " = "
        + IntToString(nPCTotal) + " vs. "
        + IntToString(nShopSkill) + " + "
        + IntToString(nShopRoll) + " = "
        + IntToString(nShopTotal) + ")";

if (nPCTotal == nShopTotal)
    {
    nPCRoll = GetAbilityModifier(ABILITY_DEXTERITY, oPC);
    nShopRoll = GetAbilityModifier(ABILITY_WISDOM, oShopkeeper);
    sMessage = "Pick Pocket : *tie* : "
        + sMessage + " : ("
        + IntToString(nPCRoll) + " vs. "
        + IntToString(nShopRoll) + ")";
    }

if (nPCTotal == nShopTotal)
    {
    sMessage = sMessage + " : *tie* : ";
    switch(d2())
        {
        case 1:
            nPCTotal = 1;
            nShopTotal = 0;
            sMessage = sMessage + "PC wins.";
            break;
        case 2:
            nPCTotal = 0;
            nShopTotal = 1;
            sMessage = sMessage + "Shopkeeper wins.";
            break;
        }
    }

if (nShopTotal > nPCTotal)
    {
    SendMessageToPC(oPC, "Pick Pocket : *failure* : " + sMessage);
    SendMessageToPC(oPC, "The merchant has spotted you!");
    if (nReactionHostile)
        {
        AdjustReputation(oPC, OBJECT_SELF, -100);
        ActionAttack(oPC);
        }
    return;
    }
if (nShopTotal < nPCTotal)
    {
    SendMessageToPC(oPC, "Pick Pocket : *success* : " + sMessage);
    }
object oStealStore = CreateObject(OBJECT_TYPE_STORE, "stealstore", GetLocation(oPC));
if (nTimeLimit) DelayCommand(IntToFloat(nTimeLimit), DestroyObject(oStealStore));
object oStoreInv = GetFirstItemInInventory(oStore);
if (nDebug) SendMessageToPC(GetFirstPC(), "Steal All: " + IntToString(nStealAll));
while (oStoreInv != OBJECT_INVALID)
    {
    //if (nTimeDelay && GetItemTime(oStoreInv) > nTimeDelay)
    //    {
    //    DestroyObject(oStoreInv);
    //    }
    int nType = GetBaseItemType(oStoreInv);
    if (!nStealAll)
        {
        if (nType == BASE_ITEM_AMULET ||
            nType == BASE_ITEM_ARROW ||
            nType == BASE_ITEM_BELT ||
            nType == BASE_ITEM_BOLT ||
            nType == BASE_ITEM_BOOK ||
            nType == BASE_ITEM_BOOTS ||
            nType == BASE_ITEM_BRACER ||
            nType == BASE_ITEM_BULLET ||
            nType == BASE_ITEM_DAGGER ||
            nType == BASE_ITEM_DART ||
            nType == BASE_ITEM_GEM ||
            nType == BASE_ITEM_GLOVES ||
            nType == BASE_ITEM_HANDAXE ||
            nType == BASE_ITEM_HEALERSKIT ||
            nType == BASE_ITEM_KEY ||
            nType == BASE_ITEM_LIGHTHAMMER ||
            nType == BASE_ITEM_MAGICWAND ||
            nType == BASE_ITEM_MISCSMALL ||
            nType == BASE_ITEM_MISCTHIN ||
            nType == BASE_ITEM_MISCWIDE ||
            nType == BASE_ITEM_POTIONS ||
            nType == BASE_ITEM_RING ||
            nType == BASE_ITEM_SCROLL ||
            nType == BASE_ITEM_SHORTSWORD ||
            nType == BASE_ITEM_SHURIKEN ||
            nType == BASE_ITEM_SLING ||
            nType == BASE_ITEM_SPELLSCROLL ||
            nType == BASE_ITEM_THIEVESTOOLS ||
            nType == BASE_ITEM_THROWINGAXE)
            {
            object oNewItem = CreateItemOnObject(GetResRef(oStoreInv), oStealStore, GetNumStackedItems(oStoreInv));
            SetLocalInt(oNewItem, "STOLEN", TRUE);
            SetLocalObject(oNewItem, "STEALSTORE", oStealStore);
            if (nDebug) SendMessageToPC(GetFirstPC(), "steal small");
            }
        }
    else
        {
        object oNewItem = CreateItemOnObject(GetResRef(oStoreInv), oStealStore, GetNumStackedItems(oStoreInv));
        SetLocalInt(oNewItem, "STOLEN", TRUE);
        SetLocalObject(oNewItem, "STEALSTORE", oStealStore);
        if (nDebug) SendMessageToPC(GetFirstPC(), "steal all");
        }
    oStoreInv = GetNextItemInInventory(oStore);
    }
GiveGoldToCreature(oPC, 1);
if (nDebug && oStealStore == OBJECT_INVALID) SendMessageToPC(oPC, "No store to open.");
OpenStore(oStealStore, oPC, -1, -1);
}

int GetFavoredEnemy()
{
int nFavoredEnemy;
if (GetHasFeat(FEAT_FAVORED_ENEMY_DWARF)) return RACIAL_TYPE_DWARF;
if (GetHasFeat(FEAT_FAVORED_ENEMY_ELF)) return RACIAL_TYPE_ELF;
if (GetHasFeat(FEAT_FAVORED_ENEMY_GNOME)) return RACIAL_TYPE_GNOME;
if (GetHasFeat(FEAT_FAVORED_ENEMY_HALFELF)) return RACIAL_TYPE_HALFELF;
if (GetHasFeat(FEAT_FAVORED_ENEMY_HALFLING)) return RACIAL_TYPE_HALFLING;
if (GetHasFeat(FEAT_FAVORED_ENEMY_HALFORC)) return RACIAL_TYPE_HALFORC;
if (GetHasFeat(FEAT_FAVORED_ENEMY_HUMAN)) return RACIAL_TYPE_HUMAN;
return FALSE;
}
