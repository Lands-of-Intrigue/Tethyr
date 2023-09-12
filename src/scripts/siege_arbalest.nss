////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_arbalest:
// Handles the arbalest item being activated.
////////////////////////////

#include "x2_inc_switches"
#include "gs_inc_fixture"
void main()
{
    int nEvent =GetUserDefinedItemEventNumber();

    if (nEvent !=  X2_ITEM_EVENT_ACTIVATE)
        return;

    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    location lPC = GetLocation(oPC);

    object oFixture = CreateObject(OBJECT_TYPE_PLACEABLE, "place_arbalest", lPC);
    DestroyObject(oItem);
    gsFXSaveFixture(GetTag(GetArea(oFixture)),oFixture);
}
