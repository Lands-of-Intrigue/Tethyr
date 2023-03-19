void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MBreaker",0);
}
