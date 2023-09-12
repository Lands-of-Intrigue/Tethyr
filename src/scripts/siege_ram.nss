////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_ram:
// Handles the ram item being used.
////////////////////////////
// This script added in v1.1

#include "x2_inc_switches"
#include "siege_include"
#include "gs_inc_fixture"
void main()
{
    int nEvent =GetUserDefinedItemEventNumber();

    if (nEvent !=  X2_ITEM_EVENT_ACTIVATE)
        return;

    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    location lPC = GetLocation(oPC);
    object oDoor = GetNearestObject(OBJECT_TYPE_DOOR, oPC);

    //Check to see if there is a door nearby.
    if(GetDistanceBetweenLocations(lPC, GetLocation(oDoor)) > RANGE_RAM)
    {
        //If not, say so and exit.
        SendMessageToPC(oPC, "No door within range.");
        return;
    }

    object oFixture = CreateObject(OBJECT_TYPE_PLACEABLE, "place_ram", lPC, FALSE, "siege_ram");
    DestroyObject(oItem);
    gsFXSaveFixture(GetTag(GetArea(oFixture)),oFixture);
    object oRam = GetNearestObjectByTag("siege_ram", oPC);

    //Set the target for future use so we dont have to guess it again.
    SetLocalObject(oRam, "door_target", oDoor);

    //Face the door.
    TurnToFaceObject(oDoor, oRam);
    AssignCommand(oRam, SetFacing(GetOppositeDirection(GetFacing(oRam)))); //Turn it around: Apparently the rams are backwards.

}
