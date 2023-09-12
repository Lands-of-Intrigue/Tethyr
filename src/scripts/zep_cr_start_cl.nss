#include "zep_inc_craft"

void main() {
    object oPC = GetPCSpeaker();
    object oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    ZEP_StartCraft(oPC, oCloak);
    ZEP_SetPart(oPC, ZEP_CR_CLOAK, 2220);
}
