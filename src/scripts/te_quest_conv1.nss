void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    int nVar1 = GetLocalInt(OBJECT_SELF,"QNum1");
    string sVar2 = GetLocalString(OBJECT_SELF,"QTag1");

    SetLocalInt(oItem,sVar2,nVar1);
}
