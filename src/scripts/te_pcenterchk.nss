void main()
{
    object oUser = GetEnteringObject();
    object oItem = GetItemPossessedBy(oUser, "PC_Data_Object");

            SetLocalInt(oItem,"iPCEntered",1);
}
