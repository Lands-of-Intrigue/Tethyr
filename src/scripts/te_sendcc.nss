void main()
{
    object oPC = GetLastUsedBy();
    location oLoc = GetLocation(GetWaypointByTag("WP_Starting_Area"));
    AssignCommand(oPC, JumpToLocation(oLoc));
}
