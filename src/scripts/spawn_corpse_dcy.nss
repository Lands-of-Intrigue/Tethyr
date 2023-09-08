//
// NESS V8.0
// Spawn: Corpse Decay Script
//
//
//   Do NOT Modify this File
//   See 'spawn__readme' for Instructions
//
//:: Modified: The Magus (2012 nov 4) prevent decay of UNIQUE NPCs
//:: Modified: henesua (2016 jul 7) integration with PC corpse as well

#include "spawn_functions"

void main()
{
    object oHostBody    = OBJECT_SELF;
    object oLootCorpse  = GetLocalObject(oHostBody, "CORPSE_NODE");

    if(!GetLocalInt(oLootCorpse,"CORPSE_DECAY"))
        return; // we've cancelled the corpse decay

    // Don't Decay while Someone is Looting or messing with the corpse
    if(     GetIsOpen(oLootCorpse)
        ||  GetLocalString(oLootCorpse,"IN_USE_BY")!=""
      )
    {
        // try again
        DelayCommand(   GetLocalFloat(oHostBody, "CorpseDecay"),
                        ExecuteScript("spawn_corpse_dcy", oHostBody)
                    );
        return;
    }

    // Don't Decay if Timer not Expired
    //object oItem = GetFirstItemInInventory(oLootCorpse);
    int nDecayTimerExpired = GetLocalInt(oHostBody, "DecayTimerExpired");

    // Don't think this should ever happen, since nDecayTimerExpired should
    // be set to try by the command immediately beforethe one invoking this
    // script!
    if (    //oItem != OBJECT_INVALID &&
            nDecayTimerExpired == FALSE
        )
    {
        float fCorpseDecay = GetLocalFloat(oHostBody, "CorpseDecay");
        DelayCommand(fCorpseDecay  - 0.1, SetLocalInt(oHostBody, "DecayTimerExpired", TRUE));
        DelayCommand(fCorpseDecay, ExecuteScript("spawn_corpse_dcy", oHostBody));
        return;
    }

    // handle garbage collection for the persistent inventory
    string pcid = GetLocalString(oLootCorpse,"CORPSE_PCID");
    DestroyObject(oHostBody,0.1);
    DestroyCorpse(pcid);

}
