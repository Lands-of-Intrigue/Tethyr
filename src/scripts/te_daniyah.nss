//::///////////////////////////////////////////////
//:: FileName te_daniyah
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 12/25/2018 12:08:53 AM
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{

    // Either open the store with that tag or let the user know that no store exists.
    object oStore = GetNearestObjectByTag("te_daniyah");
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
