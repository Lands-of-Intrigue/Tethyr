//::///////////////////////////////////////////////
//:: _corpse_dist
//:://////////////////////////////////////////////
/*
    // NESS V8.0
    // Spawn Disturbed Corpse
    //
    // Brought into the NESS distribution for Version 8.0 and beyond.  Original
    // header below.  This file has been modified from its original form.

    ////////////////////////////////////////////////////////////////////////////////
    //                                                  //                        //
    //  _kb_ondist_loot                                 //      VERSION 1.1       //
    //                                                  //                        //
    //  by Keron Blackfeld on 07/17/2002                ////////////////////////////
    //                                                                            //
    //  email Questions and Comments to: keron@broadswordgaming.com or catch me   //
    //  in Bioware's NWN Community - Builder's NWN Scripting Forum                //
    //                                                                            //
    ////////////////////////////////////////////////////////////////////////////////
    //                                                                            //
    //  This is an OnDisturbed Script to go with my _kb_loot_corpse script for    //
    //  LOOTABLE MONSTER/NPC CORPSES. If you were using my _kb_ohb_lootable, be   //
    //  sure to remove that script from the onHeartbeat of your lootable, the     //
    //  "invis_corpse_obj" placeable.                                             //
    //                                                                            //
    //  PLACE THIS SCRIPT IN THE ONDISTURBED EVENT OF YOUR "invis_corpse_obj"     //
    //  BLUEPRINT. This script checks the inventory of OBJECT_SELF, and when it   //
    //  is empty, it checks the LocalInt to see if the now empty corpse should    //
    //  be Destroyed along with the Lootable Corpse Object. This script will also //
    //  checks to see if it should clear its own inventory prior to fading in     //
    //  order to prevent a lootbag from appearing. If the inventory is NOT empty, //
    //  it checks to see if the ARMOUR is removed from itself, and if so, it      //
    //  destroys the Original Armour on the corpse.                               //
    //                                                                            //
    //  The _kb_loot_corpse script must have this line:                           //
    //  int nKeepEmpties = FALSE;                                                 //
    //  in order for the Empty Corpse to Destroy itself in this script.           //
    //                                                                            //
    ////////////////////////////////////////////////////////////////////////////////

    // ALFA NESS
    // Spawn : Loot Corpse Disturbed Script v1.2
    //
    //
    //   Do NOT Modify this File
    //   See 'spawn__readme' for Instructions
    //
*/
//:://////////////////////////////////////////////
//:: Created:  Keron Blackfeld (2002 july 17)
//:: Modified: The Magus (2012 nov 4)   modified to prevent clean up when empty.
//::                                    corpses should stick around for Skinning, Raising, and Animating
//:: Modified: henesua (2016 jul 7) integration with PC corpse as well
//:://////////////////////////////////////////////

    #include "spawn_functions"

    /*******************************************
    ** Here is our main script, which is     **
    ** fired if the Inventory is disturbed.  **
    ** It then checks to see if it needs to  **
    ** either clean up the corpse or Destroy **
    ** the original suit of armor still on   **
    ** the corpse.                           **
    *******************************************/


void main()
{
    if(GetLocalInt(OBJECT_SELF,"SUPPRESS_DISTURB")){return;}

    //Get item that was disturbed to trigger event
    object oInvDisturbed = GetInventoryDisturbItem();
    //Get type of inventory disturbance
    int nInvDistType = GetInventoryDisturbType();
    object oPC = GetLastDisturbed();

    if(GetResRef(oInvDisturbed)=="x2_it_emptyskin")
    {
        DestroyObject(oInvDisturbed);
        return;
    }

    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 1.2f));

    if (GetFirstItemInInventory(OBJECT_SELF) == OBJECT_INVALID) //If no inventory found
    {
        // Get Values set by spawn_corpse_dth at creation
        /* // removed so that only NESS's decay will handle cleanup
        object oHostCorpse = GetLocalObject(OBJECT_SELF, "CORPSE_BODY");
        if(!GetLocalInt(OBJECT_SELF, "UNIQUE"))
        {
            NESS_CleanCorpse(oHostCorpse);
            AssignCommand(oHostCorpse,SetIsDestroyable(TRUE,FALSE,FALSE)); //Set actual corpse to destroyable
            DestroyObject(oHostCorpse); //Delete the actual Creature Corpse
            DelayCommand(1.0f,DestroyObject(OBJECT_SELF)); //Delete Lootable Object (Self)
        }
        */
     }

    // does this object have a persistent inventory?
    object oInventory = GetLocalObject(OBJECT_SELF, "PERSISTENT_INVENTORY");
    int nOrigGold   = GetLocalInt(OBJECT_SELF,"INVENTORY_GOLD");
    int nGold = GetGold();

    if(nGold!=nOrigGold)
    {
        int nDeltaGold = nGold-nOrigGold;
        SetLocalInt(OBJECT_SELF,"INVENTORY_GOLD",nGold);
        if(nDeltaGold>0)
            GiveGoldToCreature(oInventory,nDeltaGold);
        else
            TakeGoldFromCreature(abs(nDeltaGold),oInventory,TRUE);
    }
    else if(nInvDistType == INVENTORY_DISTURB_TYPE_REMOVED)
    {
        // if there is a paired object (two objects representing the one)
        // then we need to destroy it
        object oPaired  = GetLocalObject(oInvDisturbed,"PAIRED");
        if (GetIsObjectValid(oPaired))
        {
            DestroyObject(oPaired);
            DeleteLocalObject(oInvDisturbed,"PAIRED");

            // check to see if this item has dressing equipped on the visible corpse
            if(GetLocalInt(oInvDisturbed,"EQUIPPED_SLOT"))
            {
                DeleteLocalInt(oInvDisturbed,"EQUIPPED_SLOT");
                object oCorpseDressing  = GetLocalObject(oInvDisturbed,"CORPSE_DRESSING");
                if (GetIsObjectValid(oCorpseDressing))
                {
                    DestroyObject(oCorpseDressing);
                    DeleteLocalObject(oInvDisturbed,"CORPSE_DRESSING");
                }
            }
        }
    }
    else if(nInvDistType == INVENTORY_DISTURB_TYPE_ADDED)
    {
        object oAdd = CopyItem(oInvDisturbed,oInventory,TRUE);
        SetLocalObject(oAdd, "PAIRED",oInvDisturbed);
        SetLocalObject(oInvDisturbed, "PAIRED",oAdd);
    }



    if(GetIsObjectValid(oInventory))
    {
        // everytime a container with persistent inventory is disturbed we need to signal a commit to the DB
        //SignalEvent(    oInventory,EventUserDefined(EVENT_COMMIT_OBJECT_TO_DB));
    }
}
