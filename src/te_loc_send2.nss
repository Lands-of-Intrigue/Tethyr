#include "loi_functions"
void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    object oArea = GetArea(oPC);
    string sLocation2 = GetLocalString(oItem, "sSaveLocation2");

    SendMessageToPC(oPC, "Currently saved location:");
    SendMessageToPC(oPC, sLocation2);

    object oWaypoint = GetWaypointByTag(sLocation2);
    TeleportObjectToObject(oPC, oWaypoint);
}
