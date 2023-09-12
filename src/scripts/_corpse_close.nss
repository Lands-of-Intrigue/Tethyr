//::///////////////////////////////////////////////
//:: _corpse_close
//:://////////////////////////////////////////////
/*
    Close Event of corpse object

    // NESS V8.1
    // Spawn On Close Corpse  (spawn_oncloscrp)
    //
    // Brought into the NESS distribution for Version 8.0 and beyond.  Original
    // header below.  Added code to cause immediate decay when emptied.

    ////////////////////////////////////////////////////////////////////////////////
    //                                                  //                        //
    // _kb_corpse_sound                                 //      VERSION 1.0       //
    //                                                  //                        //
    //  by Keron Blackfeld on 07/17/2002                ////////////////////////////
    //                                                                            //
    //  email Questions and Comments to: keron@broadswordgaming.com or catch me   //
    //  in Bioware's NWN Community - Builder's NWN Scripting Forum                //
    //                                                                            //
    ////////////////////////////////////////////////////////////////////////////////
    //                                                                            //
    //  This script is a simple, albeit weak, attempt to mask the default DOOR    //
    //  sounds tied to the invisible lootable object. Please this in both the     //
    //  onOpened and onClosed Events of the "invis_corpse_obj" described in my    //
    //  _kb_lootable_corpse script.                                               //
    //                                                                            //
    ////////////////////////////////////////////////////////////////////////////////

*/
//:://////////////////////////////////////////////
//:: Created:  Keron Blackfeld (2002 july 17)
//:: Modified: The Magus (2012 nov 4)   prevent clean up of UNIQUE NPCs
//::                                    AND corpses should stick around for Skinning, Raising, and Animating
//:: Modified: henesua (2016 jul 7) integration with PC corpse as well
//:://////////////////////////////////////////////

#include "spawn_functions"

void main()
{
    effect eQuiet = EffectSilence();
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eQuiet, OBJECT_SELF, 120.0f);
    PlaySound("as_sw_clothop1");
/*
    object oHostCorpse  = GetLocalObject(OBJECT_SELF, "CORPSE_BODY");

    // NESS's decay will handle cleanup, unless the corpse has been skinned
    if(     GetLocalInt(OBJECT_SELF,"CORPSE_DECAY")
        &&  GetLocalInt(OBJECT_SELF,"SKINNED")
        &&  GetLocalString(OBJECT_SELF, "SKIN_TYPE")!=""
        &&  GetLocalInt(OBJECT_SELF, "SKIN_MEAT")
        //&&  GetFirstItemInInventory(OBJECT_SELF)==OBJECT_INVALID  //If no inventory found
      )
    {
        // handle garbage collection for the persistent inventory
        string pcid = GetLocalString(OBJECT_SELF,"CORPSE_PCID");
        object oInventory   = GetPersistentInventory("INV_CORPSE_"+pcid, pcid);

        if(!GetLocalInt(oInventory,"STORE_IN_DB"))
            SetLocalInt(oInventory,"PERMANENT_DELETION", TRUE);
        SignalEvent(oInventory, EventUserDefined(EVENT_GARBAGE_COLLECTION));

        DestroyObject(GetLocalObject(OBJECT_SELF,"PAIRED"), 12.0); //Delete paired objects - bloodstain

        // Destroy the invis corpse and drop a loot bag (if any loot left)
        SetPlotFlag(OBJECT_SELF, FALSE);
        //DestroyObject(GetLocalObject(oLootCorpse, "PAIRED")); // MAGUS - destroy paired objects - blood left behind from skinning
        DestroyObject(OBJECT_SELF, 0.2);

        // To avoid potential memory leaks, we clean everything that might be left on the original creatures body
        NESS_CleanCorpse(oHostCorpse);
        // Destroy the visible corpse
        SetObjectIsDestroyable(oHostCorpse, TRUE, FALSE, FALSE);
        DestroyObject(oHostCorpse, 0.1);
    }
*/
}
