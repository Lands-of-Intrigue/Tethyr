//::///////////////////////////////////////////////
//:: FileName te_zinner_gen2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1/5/2019 5:07:07 AM
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{

	// Either open the store with that tag or let the user know that no store exists.
	object oStore = GetNearestObjectByTag("te_zinner_gen2");
	if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
		gplotAppraiseOpenStore(oStore, GetPCSpeaker());
	else
		ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
