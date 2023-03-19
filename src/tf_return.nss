void main()
{
    object oPC = GetEnteringObject();
    location lTReturn = GetLocalLocation(oPC, "tf_stored_loc");
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionJumpToLocation(lTReturn));
}
