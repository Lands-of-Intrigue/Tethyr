//::///////////////////////////////////////////////
//:: aid_light
//:://////////////////////////////////////////////
/*
    script for lighting a torch/sconce
*/
//:://////////////////////////////////////////////
//:: Created By: The Magus (2012 apr 30)
//:: Modified:
//:://////////////////////////////////////////////

#include "aid_inc_fcns"

#include "te_functions"

void TurnLightOn();
void TurnLightOn()
{
    object oArea= GetArea(OBJECT_SELF);
    string sRef = GetLocalString(OBJECT_SELF, "LIGHT_REF");
    vector vPos = GetPosition(OBJECT_SELF);

    float fX    = GetLocalFloat(OBJECT_SELF, "LIGHT_X");
    if(fX==0.0)
        fX      = vPos.x;
    float fY    = GetLocalFloat(OBJECT_SELF, "LIGHT_Y");
    if(fY==0.0)
        fY      = vPos.y;
    float fZ    = GetLocalFloat(OBJECT_SELF, "LIGHT_Z");
    float fZadj;
    if(fZ==0.0)
    {
        fZ      = vPos.z;
        if(sRef=="flame_small")
            fZadj= 0.25;// the flame is set low on the spawn point and so must be adjusted upwards.
        else if(sRef=="flame_large")
            fZadj= 0.5;
    }
    float fF    = GetLocalFloat(OBJECT_SELF, "LIGHT_F");
    if(fF==0.0)
        fF      = GetFacing(OBJECT_SELF);

    object oLight   = CreateObject(OBJECT_TYPE_PLACEABLE, sRef, Location(oArea, Vector(fX, fY, fZ+fZadj), fF));
    object oFlame;
    if(sRef=="flame_small"||sRef=="flame_large")
        // these flames neither emit light nor receive a light VFX so... create a placeable light
        oFlame      = CreateObject(OBJECT_TYPE_PLACEABLE, "light_orange", Location(oArea, Vector(fX, fY, fZ), fF));
    else
        oFlame      = oLight;
    int nBrightness = GetLocalInt(OBJECT_SELF, "LIGHT_BRIGHTNESS");
    string sType    = GetLocalString(OBJECT_SELF, "LIGHTABLE_TYPE");

    SetLocalInt(oLight, LIGHT_VALUE, nBrightness);
    SetLocalInt(oLight, "LIGHTABLE", TRUE);
    SetLocalString(oLight, "LIGHTABLE_TYPE", sType);

    SetLocalObject(OBJECT_SELF, "LIGHT_OBJECT", oLight);
    SetLocalObject(oLight, "LIGHT_OBJECT", OBJECT_SELF);
    SetLocalObject(oLight, "PAIRED", oFlame);
    SetLocalInt(OBJECT_SELF,"NW_L_AMION",TRUE);

    DelayCommand(0.5, RecomputeStaticLighting(oArea));
}


void main()
{
    object oPC      = GetLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT);
    DeleteLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT); // Garbage collection

    int bState      = GetLocalInt(OBJECT_SELF,"NW_L_AMION");
    if(bState)
        return;

    if(!PCCanLight(OBJECT_SELF, oPC))
        return;

    float fDelay    = FindDelay(oPC, OBJECT_SELF);

    DoManipulate(oPC, OBJECT_SELF, ANIMATION_LOOPING_GET_MID, 1.0);

    DelayCommand(fDelay, TurnLightOn());
}
