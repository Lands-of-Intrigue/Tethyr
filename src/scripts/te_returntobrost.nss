void main()
{
     object oUser = GetClickingObject();
     location lLoc1 = GetLocation(GetObjectByTag("WP_Brost_Second"));
     location lLoc2 = GetLocation(GetObjectByTag("WP_Brost_Enter"));

    if (GetLocalInt(GetItemPossessedBy(oUser,"PC_Data_Object"),"iHasEntered") == 1)
    {
        ActionJumpToLocation(lLoc1);
    }
    else
    {
        ActionJumpToLocation(lLoc2);
    }
}
