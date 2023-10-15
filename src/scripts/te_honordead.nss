#include "loi_xp"

void main()
{
    // Remove items from the player's inventory
    object oPC = GetPCSpeaker();
    object oMod = GetModule();
    int nXP = 0;
    object oItemToTake = GetFirstItemInInventory(oPC);

    while (oItemToTake != OBJECT_INVALID)
    {
        if(GetTag(oItemToTake) == "te_hd_1001")
        {
            nXP += 25;
            DestroyObject(oItemToTake);
        }

        oItemToTake = GetNextItemInInventory(oPC);
    }

    AwardXP(oPC,nXP);
}
