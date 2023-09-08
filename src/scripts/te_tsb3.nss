void main()
{
     object oUser = GetLastUsedBy();
     AssignCommand(oUser, JumpToLocation(GetLocation(GetObjectByTag("WP_Blightstride3"))));
}
