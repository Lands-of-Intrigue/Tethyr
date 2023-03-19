//::///////////////////////////////////////////////
//:: CUSTOM:onUserDef
//:: el_take_usdf
//:: By: Emmanuel Lusinchi (Sentur Signe)
//:://////////////////////////////////////////////
void LootStuff(int nInventorySlot, object oToLoot)
{
    ActionTakeItem(GetItemInSlot(nInventorySlot,oToLoot), oToLoot);
}
void main()
{
   int nUser = GetUserDefinedEventNumber();
   if (  nUser == 2000  )
   {

        object oTargeToLoot =   GetLocalObject(OBJECT_SELF, "el_corpse_to_loot");
        // and in case you need it:
        // object oLooter =     GetLocalObject(OBJECT_SELF, "el_corpse_looter");
        LootStuff(INVENTORY_SLOT_LEFTHAND, oTargeToLoot);
        LootStuff(INVENTORY_SLOT_RIGHTHAND, oTargeToLoot);
        LootStuff(INVENTORY_SLOT_HEAD, oTargeToLoot);
        LootStuff(INVENTORY_SLOT_CHEST, oTargeToLoot);
        int nAmtGold = GetGold(oTargeToLoot);
        if(nAmtGold)
        {
              TakeGoldFromCreature(nAmtGold,oTargeToLoot,FALSE);
        }
        object oInvItem = GetFirstItemInInventory(oTargeToLoot);
        while (oInvItem != OBJECT_INVALID)
        {
            ActionTakeItem(oInvItem, oTargeToLoot);
            oInvItem = GetNextItemInInventory(oTargeToLoot);
        }

        LootStuff(INVENTORY_SLOT_ARMS, oTargeToLoot);
        LootStuff(INVENTORY_SLOT_ARROWS, oTargeToLoot);
        LootStuff(INVENTORY_SLOT_BELT, oTargeToLoot);
        LootStuff(INVENTORY_SLOT_BOLTS, oTargeToLoot);
        LootStuff(INVENTORY_SLOT_BOOTS, oTargeToLoot);
        LootStuff(INVENTORY_SLOT_BULLETS, oTargeToLoot);
        LootStuff(INVENTORY_SLOT_CLOAK, oTargeToLoot);
        LootStuff(INVENTORY_SLOT_LEFTRING, oTargeToLoot);
        LootStuff(INVENTORY_SLOT_NECK, oTargeToLoot);
        LootStuff(INVENTORY_SLOT_RIGHTRING, oTargeToLoot);
        ActionDoCommand( ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(2000), OBJECT_SELF) );
    }

return;
}
