//::///////////////////////////////////////////////
//:: FileName te_ltailor
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/30/2018 11:04:01 AM
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{

	// Either open the store with that tag or let the user know that no store exists.
	object oStore = GetNearestObjectByTag("te_ltailor");
	if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
		gplotAppraiseOpenStore(oStore, GetPCSpeaker());
	else
		ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
