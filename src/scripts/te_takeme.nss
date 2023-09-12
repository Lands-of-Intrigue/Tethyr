void main()
{
    object oPC = GetEnteringObject();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    location lLoc = GetLocalLocation(oItem, "lPCLoc");
    AssignCommand(oPC, JumpToLocation(lLoc)); //Put them in the Starting Area.
}
