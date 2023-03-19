//Place this script on a placeable.
//Set the local string sLoc as the waypoint you want to go to.
#include "loi_functions"
void main()
{
    object oPlace = OBJECT_SELF;
    object oPC = GetLastUsedBy();
    string sLoc = GetLocalString(oPlace,"sLoc");
    object oWay = GetWaypointByTag(sLoc);
    location lDest = GetLocation(oWay);
    TeleportObjectToLocation(oPC,lDest);
}
