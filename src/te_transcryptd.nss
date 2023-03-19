void main()
{
    object oPC = GetLastUsedBy();

    location oLoc = GetLocation(GetWaypointByTag("BRIL_LadWPUp"));
    AssignCommand(oPC, JumpToLocation(oLoc));
}
