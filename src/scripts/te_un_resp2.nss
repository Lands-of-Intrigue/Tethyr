void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");

    SetLocalInt(oItem,"UndeadRespawn",0);

     location lLoc = GetLocation(GetObjectByTag("WP_UndeadRevive2"));
     AssignCommand(oPC, JumpToLocation(lLoc));
}
