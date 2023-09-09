//
// SpawnBanner : Sample OnActivateItem Script
//
#include "spawnb_main"
#include "x2_inc_switches"
void main()
{
    int nEvent =GetUserDefinedItemEventNumber();

    if (nEvent !=  X2_ITEM_EVENT_ACTIVATE)
        return;

    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    location lTarget = GetItemActivatedTargetLocation();

    // Rod of Spawn Banners
    if (GetTag(oItem) == "RodofSpawnBanners")
    {
        SpawnBanner(oPC, oItem, oTarget, lTarget);
    }
}
