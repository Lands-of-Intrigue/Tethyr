void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");

    int iEnter = GetLocalInt(oItem,"iPCEntered");
    location oLoc = GetLocation(GetWaypointByTag("WP_LocationRoom"));

    if(iEnter == 1)
    {
        AssignCommand(oPC, JumpToLocation(oLoc));
    }
    else
    {
        SendMessageToPC(oPC,"You have not yet entered Brost County, and therefore cannot fast-travel.");
    }

}
