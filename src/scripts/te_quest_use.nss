void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    int nVar1 = GetLocalInt(OBJECT_SELF,"QNum");
    string sVar2 = GetLocalString(OBJECT_SELF,"QTag");

    if(GetLocalInt(oItem,sVar2) < nVar1)
    {
        SetLocalInt(oItem,sVar2,nVar1);
        AddJournalQuestEntry(sVar2,nVar1,oPC,TRUE);
    }
}
