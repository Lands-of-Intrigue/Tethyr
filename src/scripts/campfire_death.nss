//::///////////////////////////////////////////////
//:: campfire_death
//:://////////////////////////////////////////////
/*
    Put into: placeable "campsite" or "campfire" OnDeath Event

    This script handles garbage collection
*/
//:://////////////////////////////////////////////
//:: Created:   The Magus (2013 july 14)
//:: Modified:
//:://////////////////////////////////////////////

#include "camp_include"

void main()
{
    if(GetLocalInt(OBJECT_SELF, "IGNORE_DEATH"))
        return;

    CampfireGarbageCollection();
}
