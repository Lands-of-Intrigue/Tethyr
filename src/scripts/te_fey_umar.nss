void main()
{
     object oPC = GetPCSpeaker();
     location lLoc = GetLocation(GetObjectByTag("WP_UmarFeywild"));
     ActionJumpToLocation(lLoc);
}
