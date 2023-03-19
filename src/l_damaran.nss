void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    SetLocalInt(oItem,"BG_Select",5);
    //Undercommon
    SetLocalInt(oItem,"56",1);
    int nInt = GetLocalInt(oItem,"nLangSelect");
    SetLocalInt(oItem,"nLangSelect", nInt-1);
}

