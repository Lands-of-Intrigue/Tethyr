//////////////////////////////////////////////////////////////////////
// Created by Valerie Runge for the Spellplague: The Rebirth Server //
// Attunement Script for Enchanted items.                           //
// If an item has an enchantment max value of > 3, it requires      //
// attunement.                                                      //
//                                                                  //
//                                                                  //
//////////////////////////////////////////////////////////////////////


/* siobhan this script looks broken, delete?

object oDest = GetPCItemLastEquipped();
object oPC = GetItemPossessor(oDest);
object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");

void main()
{
    if (GetLocalInt(oDest, "WeaponCap")>=3 || GetLocalInt(oDest, "ArmorCap")>=3 || GetLocalInt(oDest, "AccessoryCap")>=3)
    {
        if (GetLocalInt(oItem, "iPCAttunement") == OBJECT_INVALID)
        {
            SetLocalInt(oItem, "iPCAttunement", 1);
        }
        else
        {
            if(GetLocalInt(oItem, "IPCAttunement")>=3 && TE_GetCasterLevel(oPC, CLASS_TYPE_ARTIFICER)<6)
            {
    `
            }
        }
    }
}
*/
