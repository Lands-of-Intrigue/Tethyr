void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",8);
}
