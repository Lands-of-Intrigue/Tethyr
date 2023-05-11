void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    int nVar1 = GetLocalInt(OBJECT_SELF,"QNum");
    string sVar2 = GetLocalString(OBJECT_SELF,"QTag");

    SetLocalInt(oItem,sVar2,nVar1);

    // Give "brostcountyregis" to the PC.
    CreateItemOnObject("brostcountyregis", oPC);
}
