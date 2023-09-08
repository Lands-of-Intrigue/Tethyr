// aww_act_do_anim.nss
// aww activity script to perform the animation specified in
// the variable AWW_ACT_ANIM on either the WP or the NPC, with
// the waypoint having precedence.

#include "aww_inc_walkway"

void main() {

        object oNPC = OBJECT_SELF;

        if (GetIsInCombat(oNPC) || IsInConversation(oNPC))
                return;


        object oWP = GetLocalObject(oNPC, "AWW_CURWP");
        if (!GetIsObjectValid(oWP)) {
                aww_debug(GetTag(oNPC) + " No current WP set?");
                return;
        }

        int nAnim = GetLocalInt(oWP, "AWW_ACT_ANIM");
        if (!nAnim)
                nAnim = GetLocalInt(oWP, "AWW_ACT_ANIM");

        if (!nAnim) {
                aww_debug(GetTag(oNPC) + " No animation set.");
                return;
        }

        aww_debug(GetTag(oNPC) + " Doing activity animation " + IntToString(nAnim));
        ClearAllActions();
        ActionPlayAnimation(nAnim, 1.0, 9.0);

}
