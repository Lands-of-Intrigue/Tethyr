void main()
{
    object oPC = GetLastUsedBy();

    location oLoc = GetLocation(GetWaypointByTag("BRIL_LadWPDown"));
    AssignCommand(oPC, JumpToLocation(oLoc));
}
