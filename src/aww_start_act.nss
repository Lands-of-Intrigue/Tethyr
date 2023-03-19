// Make this NPC start doing activities in/around this waypoint
// until the waypoint set changes (if it does) or for an optional amount of time.

// aww_start_act.nss
//
//
#include "aww_inc_walkway"
void main () {

    object oWay = GetLocalObject(OBJECT_SELF, "AWW_CURWP");
    string sScript;
    int nAct = 0;
    float fTimeout = 0.0;

  // first check the NPC
    sScript = GetLocalString(OBJECT_SELF, "AWW_CUSTOM_ACTIVITY_SCRIPT");
    nAct = GetLocalInt(OBJECT_SELF, "AWW_CUSTOM_ACTIVITY");
    fTimeout = GetLocalFloat(OBJECT_SELF, "AWW_CUSTOM_ACTIVITY_DURATION");

    // then check the waypoint
    if (GetIsObjectValid(oWay)) {
        if (sScript == "")
            sScript = GetLocalString(oWay, "AWW_CUSTOM_ACTIVITY_SCRIPT");

        if (nAct <= 0)
            nAct = GetLocalInt(oWay, "AWW_CUSTOM_ACTIVITY");

        if (fTimeout <= 0.0)
            fTimeout = GetLocalFloat(oWay, "AWW_CUSTOM_ACTIVITY_DURATION");
    }
    // if no custom script see if there is an activity set, if not use ts_putter
    if (sScript == "") {
        if (nAct <= 0)
            sScript = "ts_putter";
        else
            sScript = "aww_do_activity";
    }

    aww_SetWalkPaused();
    SetLocalString(OBJECT_SELF, "AWW_DO_ACTIVITY_SCRIPT", sScript);
    SetLocalInt(OBJECT_SELF, "AWW_DO_ACTIVITY", nAct);

    if (fTimeout > 0.0) {
        aww_debug(GetTag(OBJECT_SELF) + "starting activity " + IntToString(nAct)
            +  " with Script " + sScript + " for " + FloatToString(fTimeout));
        DelayCommand(fTimeout, DeleteLocalString(OBJECT_SELF, "AWW_DO_ACTIVITY_SCRIPT"));
        DelayCommand(fTimeout, aww_SetWalkPaused(FALSE, OBJECT_SELF));
    } else {
        aww_debug(GetTag(OBJECT_SELF) + "starting activity " + IntToString(nAct) +  "With Script " + sScript);
    }
}
