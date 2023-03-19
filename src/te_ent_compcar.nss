void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");

    location oLoc1 = GetLocation(GetWaypointByTag("WP_START_BROST"));

    AssignCommand(oPC, JumpToLocation(oLoc1));
    SendMessageToPC(oPC, "<cþ  >You ride one of the rear wagons to Brost - gaping in awe as you pass through the ruined Tejarn Gate and the smaller Fort Briarwood. When you arrive at Brost, you help unload the cargo and are finally released to your own devices.");
}
