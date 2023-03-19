//::///////////////////////////////////////////////
//:: campfire_spawn
//:://////////////////////////////////////////////
/*
    Put into: placeable "campfire" Event
    Idea is that when the event executes, the campfire is created.
    This enables a DM or builder to place a campfire and for it to behave as those created by a PC.

*/
//:://////////////////////////////////////////////
//:: Created:   Henesua (2014 feb 8)
//:: Modified:
//:://////////////////////////////////////////////

#include "camp_include"

void main()
{
    location lCampSite  = GetLocation(OBJECT_SELF);

    int nFuel = (CAMPFIRE_FUEL_MINIMUM)*2;

    // intialize type of fire
    string sCampRef = GetLocalString(OBJECT_SELF, "CAMPFIRE_RESREF");
    int nState      = StringToInt(GetStringRight(sCampRef,1));
    if(nState<1||nState>3)
    {
        nState      = 1;
        sCampRef    = REF_CAMPFIRE_1;
    }

    // Fire - usable placeable
    object oFire        = CreateObject(OBJECT_TYPE_PLACEABLE, sCampRef, lCampSite, FALSE);   // has usable event
    object oCampSite    = CreateObject(OBJECT_TYPE_PLACEABLE, REF_CAMPSITE+"nohb", lCampSite, FALSE); // has no heartbeat event

    SetLocalObject(oFire, "PAIRED", oCampSite);
    SetLocalObject(oCampSite, "PAIRED", oFire);

    SetLocalInt(oCampSite, "CAMPFIRE_STATE", nState);
    SetLocalInt(oCampSite, FUEL_REMAINING, nFuel);
    //SetLocalString(oCampSite, "SOUND", "al_cv_firepit1");

    // campfire is lit?
    if(GetLocalInt(OBJECT_SELF, "CAMPFIRE_LIGHT"))
        AssignCommand(oCampSite, CampfireLight());

    DestroyObject(OBJECT_SELF, 1.0f);
}
