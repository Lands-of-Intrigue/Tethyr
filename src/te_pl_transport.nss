void main()
{
    object oPC = GetLastUsedBy();
    object oPlace = OBJECT_SELF;

    string sDest = GetLocalString(oPlace, "sDest");

    AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag(sDest))));

}
