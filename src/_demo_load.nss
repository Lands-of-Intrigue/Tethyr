//::///////////////////////////////////////////////
//:: _demo_load
//:://////////////////////////////////////////////
/*
    MAGUS LOOT SYSTEM

    example load event function.
    this is most likely useful in area enter or module load
    if it is in area enter, remove the the area object in LootInitAreaMerchants, and allow it to use itself as the area
*/
//:://////////////////////////////////////////////
//:: Created:   magus (2016 mar 4)
//:: Modified:
//:://////////////////////////////////////////////

#include "_inc_loot"

void main()
{
    // MAGUS LOOT SYSTEM
    // intialize all the merchants within an area for loot system
    object area_with_merchants_and_loot = GetObjectByTag(LOOT_STORE_AREA_TAG);
    LootInitAreaMerchants(area_with_merchants_and_loot);
    // end MAGUS LOOT SYSTEM
}
