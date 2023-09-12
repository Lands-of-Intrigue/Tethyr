//
// NESS V8.0
// Spawn : Corpse Death Script
//
//
//   Do NOT Modify this File
//   See 'spawn__readme' for Instructions
//
//:: Modified: henesua (2016 jul 7) integration with PC corpse as well

#include "spawn_functions"
#include "te_functions"

void main()
{
    if(GetLocalInt(OBJECT_SELF,"CORPSE_NONE"))
        return;

    object oKiller = GetLastDamager();
    if (oKiller == OBJECT_INVALID)
        oKiller = GetLastKiller();

    // SUBDUAL DAMAGE has non-lethal results -----------------------------------
    object oRight   = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oKiller);
    object oLeft    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oKiller);
    if(     GetLocalInt(oRight,"WEAPON_NONLETHAL")
        ||  GetLocalInt(oLeft,"WEAPON_NONLETHAL")
        ||  GetLocalInt(oKiller,"COMBAT_NONLETHAL")// subdual mode
        ||  GetLocalInt(OBJECT_SELF,"DAMAGE_NONLETHAL")
      )
    {
        return;
    }
    // END SUBDUAL DAMAGE ------------------------------------------------------

    object oLootCorpse, oBlood;
    location lCorpseLoc     = GetLocation(OBJECT_SELF);
    float fCorpseDecay      = GetLocalFloat(OBJECT_SELF, "CorpseDecay");
    int nCorpseDecayType    = GetLocalInt(OBJECT_SELF, "CorpseDecayType");
    int bDropWielded        = GetLocalInt(OBJECT_SELF, "CorpseDropWielded");
    string sLootCorpseResRef= GetLocalString(OBJECT_SELF, "CorpseRemainsResRef");

    int strip_gold = TRUE, strip_invent = TRUE, strip_equip = TRUE;

    if (fCorpseDecay > 0.0)
    {
        SetLocalInt(OBJECT_SELF,"CORPSE_DECAY", TRUE);
        //Protect our corpse from decaying
        SetIsDestroyable(FALSE, FALSE, FALSE);

        switch (nCorpseDecayType)
        {
            // Type 0:
            // Inventory Items
            case 0:
                strip_gold  = FALSE;
                strip_invent= FALSE;
            break;

            // Type 1:
            // Inventory & Equipped Items
            case 1:
                strip_gold  = FALSE;
                strip_invent= FALSE;
                strip_equip = FALSE;
            break;

            // Type 2:
            // Inventory Items, if PC Killed
            case 2:
                if (GetIsPC(oKiller) == TRUE || GetIsPC(GetMaster(oKiller)) == TRUE)
                {
                    strip_gold  = FALSE;
                    strip_invent= FALSE;
                }
            break;

            // Type 3:
            // Inventory & Equipped Items, if PC Killed
            case 3:
                if (GetIsPC(oKiller) == TRUE || GetIsPC(GetMaster(oKiller)) == TRUE)
                {
                    strip_gold  = FALSE;
                    strip_invent= FALSE;
                    strip_equip = FALSE;
                }
            break;
        }


        StripInventory(OBJECT_SELF, strip_invent, strip_gold, strip_equip, TRUE);

        if(bDropWielded && !strip_equip)
            DropItems(OBJECT_SELF);

        string pcid = GetPCID(OBJECT_SELF);
        CreatePersistentInventory("INV_CORPSE_"+pcid, OBJECT_SELF, pcid, FALSE);

        // cleanup the corpse since it is no longer a holder
        StripInventory(OBJECT_SELF,TRUE,TRUE,FALSE,TRUE);

        oLootCorpse   = CreateCorpseNodeFromBody(OBJECT_SELF, lCorpseLoc, sLootCorpseResRef);

        // the body is already here, so there is no need to create it
        // however body and corpse node point to one another
        SetLocalObject(oLootCorpse, "CORPSE_BODY", OBJECT_SELF);
        SetLocalObject(OBJECT_SELF, "CORPSE_NODE", oLootCorpse);

        if(!strip_equip)
            CorpseDress(OBJECT_SELF, oLootCorpse, FALSE);

        // Set Corpse to Decay
        DelayCommand(fCorpseDecay - 0.1, SetLocalInt(OBJECT_SELF, "DecayTimerExpired", TRUE));
        DelayCommand(fCorpseDecay, ExecuteScript("spawn_corpse_dcy", OBJECT_SELF));
    }
}
