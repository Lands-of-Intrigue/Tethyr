//::///////////////////////////////////////////////
//:: FileName te_wyndelleu
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/21/2019 4:47:18 PM
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{

    // Either open the store with that tag or let the user know that no store exists.
    object oStore = GetNearestObjectByTag("te_whipinn");
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
