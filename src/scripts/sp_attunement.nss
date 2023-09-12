//////////////////////////////////////////////////////////////////////
// Created by Valerie Runge for the Spellplague: The Rebirth Server //
// Attunement Script for Enchanted items.                           //
// If an item has an enchantment max value of > 3, it requires      //
// attunement.                                                      //
//                                                                  //
//                                                                  //
//////////////////////////////////////////////////////////////////////

#include "te_functions"

void main()
{
    object oDest = GetPCItemLastEquipped();
    object oPC = GetItemPossessor(oDest);
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    if (GetLocalInt(oDest, "WeaponCap")>=3 || GetLocalInt(oDest, "ArmorCap")>=3 || GetLocalInt(oDest, "AccessoryCap")>=3)
    {
        if (GetLocalInt(oItem, "iPCAttunement") == 0)
        {
            SetLocalInt(oItem, "iPCAttunement", 1);
        }
        else
        {
            int classTypeArtificer = 57;
            if(GetLocalInt(oItem, "IPCAttunement")>=3 && TE_GetCasterLevel(oPC, classTypeArtificer)<6)
            {
    `
            }
        }
    }
}
