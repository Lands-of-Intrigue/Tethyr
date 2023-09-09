//::///////////////////////////////////////////////
//:: campfire_distrb
//:://////////////////////////////////////////////
/*
    Put into: placeable "campfire_pot" OnDisturbed Event

    This script handles firside crafting
*/
//:://////////////////////////////////////////////
//:: Created:   The Magus (2012 oct 26)
//:: Modified:
//:://////////////////////////////////////////////

#include "camp_include"

void main()
{
    object oPC      = GetLastDisturbed();
    if(oPC==OBJECT_INVALID){return;}

    object oItem    = GetInventoryDisturbItem();
    int nType       = GetInventoryDisturbType();


    if(nType==INVENTORY_DISTURB_TYPE_ADDED)
    {

    }
    else if(nType==INVENTORY_DISTURB_TYPE_REMOVED)
    {
        if(GetLocalInt(OBJECT_SELF, "NW_L_AMION"))
        {
            // Hot!

        }
    }
    else if(nType==INVENTORY_DISTURB_TYPE_STOLEN)
    {
        // is this even possible?

    }
}
