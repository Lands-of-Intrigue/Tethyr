//::///////////////////////////////////////////////
//:: _demo_event_loot
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created: The Magus (2016 mar 1)
//:: Modified:
//:://////////////////////////////////////////////

// magus loot system
#include "_inc_loot"

void main()
{
    object oLooter  = GetLastOpenedBy();
    if(!GetIsObjectValid(oLooter))
    {
        oLooter  = GetLastKiller();
        int nLoot = GetLocalInt(OBJECT_SELF,"LOOT_MIN");
        object oPlace = CreateObject(OBJECT_TYPE_PLACEABLE,"te_chestdeath",GetLocation(OBJECT_SELF),FALSE);
        CreateItemOnObject("nw_it_gold001",oPlace,Random(nLoot));
    }
    else
    {
        // MAGUS LOOT SYSTEM
        // this can be placed in an on open event or death event
        // recommend that you paste this into your own event scripts
        if(GetLocalInt(OBJECT_SELF,"LOOT"))
        {
            LootGenerate(oLooter, OBJECT_SELF);
        }
        // end - magus loot system
    }
}
