//::///////////////////////////////////////////////
//:: aid_extinguish
//:://////////////////////////////////////////////
/*
    script for extinguishing a torch/sconce
*/
//:://////////////////////////////////////////////
//:: Created By: The Magus (2012 apr 30)
//:: Modified:
//:://////////////////////////////////////////////

#include "aid_inc_fcns"

void TurnLightOff(object oSource);

void TurnLightOff(object oSource)
{
    object oArea    = GetArea(oSource);
    object oLight   = GetLocalObject(oSource, "LIGHT_OBJECT");
    object oFlame   = GetLocalObject(oLight, "PAIRED");

    DestroyObject(oLight);
    DestroyObject(oFlame);
    DeleteLocalInt(oSource,"NW_L_AMION");
    DeleteLocalObject(oSource, "LIGHT_OBJECT");

    DelayCommand(3.0, RecomputeStaticLighting(oArea));
}


void main()
{
    object oPC      = GetLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT);
    DeleteLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT); // Garbage collection

    int bState      = GetLocalInt(OBJECT_SELF,"NW_L_AMION");
    if(!bState)
        return;

    float fDelay    = FindDelay(oPC, OBJECT_SELF);

    DoManipulate(oPC, OBJECT_SELF, ANIMATION_LOOPING_GET_MID, 1.0);

    DelayCommand(fDelay, TurnLightOff(OBJECT_SELF));
}
