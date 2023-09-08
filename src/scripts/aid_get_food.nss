//::///////////////////////////////////////////////
//:: aid_get_food
//:://////////////////////////////////////////////
/*
    script for taking food in aid system
*/
//:://////////////////////////////////////////////
//:: Created By: The Magus (2012 mar 30)
//:: Modified:
//:://////////////////////////////////////////////

#include "aid_inc_fcns"

void main()
{
    object oPC      = GetLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT);
    DeleteLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT); // Garbage collection
    string sFoodRef = GetLocalString(OBJECT_SELF, "FOOD_ITEM");
    int nRations    = GetLocalInt(OBJECT_SELF, "RATIONS");
    object oItem;
    string sRef     = GetResRef(OBJECT_SELF);
    string sVerb    = "takes";

    DoManipulate(oPC, OBJECT_SELF, ANIMATION_LOOPING_GET_MID, 1.0);
    if(sRef=="meat_cooking")
    {
        if(!GetIsPossessedFamiliar(oPC))
            oItem   = CreateItemOnObject("meat", oPC);
        else
        {
            --nRations;
            sVerb   = "eats some of";
            oItem   = CreateObject(OBJECT_TYPE_ITEM, "meat", GetLocation(oPC), TRUE);
        }
        SetLocalInt(oItem, "RATIONS", nRations);
    }
    else if(sRef=="meat_cooked")
    {
        if(!GetIsPossessedFamiliar(oPC))
        {
            oItem   = CreateItemOnObject("rations_trail", oPC, nRations);
        }
        else
        {
            --nRations;
            sVerb   = "eats some of";
            oItem   = CreateObject(OBJECT_TYPE_ITEM, "rations_trail", GetLocation(oPC), TRUE);
            SetItemStackSize(oItem, nRations);
        }

    }
    else if(sRef=="meat_charred")
    {
        if(!GetIsPossessedFamiliar(oPC))
        {
            oItem   = CreateItemOnObject("rations_char", oPC, nRations);
        }
        else
        {
            sVerb   = "tastes and rejects";
            oItem   = CreateObject(OBJECT_TYPE_ITEM, "rations_char", GetLocation(oPC), TRUE);
            SetItemStackSize(oItem, nRations);
        }
    }

    FloatingTextStringOnCreature(LIME+GetName(oPC)+" "+sVerb+" the "+GREEN+GetName(OBJECT_SELF)+LIME+".", oPC);
    DestroyObject(OBJECT_SELF, 0.1);
}
