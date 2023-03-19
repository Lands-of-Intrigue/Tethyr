void main()
{
    object oPC = GetLastUsedBy();

    location oLoc = GetLocation(GetWaypointByTag("BRCL_LadWPUp"));
    AssignCommand(oPC, JumpToLocation(oLoc));
}
