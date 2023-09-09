void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    location oLoc = GetLocalLocation(oItem, "lPCLoc");
    AssignCommand(oPC, JumpToLocation(oLoc));
}
