int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    int nVar1 = GetLocalInt(OBJECT_SELF,"QNum1");
    string sVar2 = GetLocalString(OBJECT_SELF,"QTag1");

    if(GetLocalInt(oItem,sVar2) > 1)
    {
        return FALSE;
    }

    return TRUE;
}
