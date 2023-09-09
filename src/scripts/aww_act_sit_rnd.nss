// Make the NPC sit at a nearby chair to this WP
// for some amount of time and then resume walking WPs. 

// aww_act_sit_rnd
//
//

#include "aww_inc_walkway"

void activitySit() {
    int iChairs = 1;
    object oMyChair = GetNearestObjectByTag("Chair",OBJECT_SELF,1);
    if (GetCurrentAction(OBJECT_SELF) != ACTION_SIT) {
        while (((!GetIsObjectValid(oMyChair))
        ||(GetIsObjectValid(GetSittingCreature(oMyChair))))
        &&(iChairs <= 4)) {
            iChairs++;
            oMyChair = GetNearestObjectByTag("Chair",OBJECT_SELF,iChairs);
        }
        AssignCommand(OBJECT_SELF,ActionSit(oMyChair));
    }
}

void main () {


	int nCount = GetLocalInt(OBJECT_SELF, "aww_activity_counter") ;

	// Check for a change 
	if (++nCount >= 4) {
		SetLocalInt(OBJECT_SELF, "aww_activity_counter", 0) ;
		if (Random(100) <= 25) {
			// Stop activity and start walking again
			DeleteLocalString(OBJECT_SELF, "AWW_DO_ACTIVITY_SCRIPT");
			aww_SetWalkPaused(FALSE, OBJECT_SELF);	
		} else {
			activitySit();
			
		}
	} else {
		SetLocalInt(OBJECT_SELF, "aww_activity_counter", nCount) ;	
	}
	
	

}
