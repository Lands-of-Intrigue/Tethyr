#include "loi_functions"
void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    object oArea = GetArea(oPC);
    string sLocation1 = GetLocalString(oItem, "sSaveLocation1");

    SendMessageToPC(oPC, "Currently saved location:");
    SendMessageToPC(oPC, sLocation1);

    object oWaypoint = GetWaypointByTag(sLocation1);
    TeleportObjectToObject(oPC, oWaypoint);
}
