#include "loi_functions"

void main()
{
    object oPC = GetPCSpeaker();
    object oPlace = OBJECT_SELF;
    string sLoc = GetLocalString(oPlace,"sLoc");
    object oWay = GetWaypointByTag(sLoc);
    location lDest = GetLocation(oWay);
    TeleportObjectToLocation(oPC,lDest);
}
