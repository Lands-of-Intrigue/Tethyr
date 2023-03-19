void main()
{
    object oPC = GetLastUsedBy();

    location oLoc = GetLocation(GetWaypointByTag("BRCL_LadWPDown"));
    AssignCommand(oPC, JumpToLocation(oLoc));
}
