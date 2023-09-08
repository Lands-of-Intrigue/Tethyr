void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    string sLoc1Tag = GetLocalString(oPC,"sLoc1Tag");
    location oLoc = GetLocation(GetWaypointByTag(sLoc1Tag));

    AssignCommand(oPC, JumpToLocation(oLoc));
}
