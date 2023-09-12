void main()
{
    object oPC = GetPCSpeaker();
    object oSign = OBJECT_SELF;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    object oArea = GetArea(oPC);
    string sLocation1 = GetLocalString(oItem, "sSaveLocation1");
    string sLocName = GetLocalString(oItem, "sSaveLoc1Name");

    SendMessageToPC(oPC, "Currently saved location:");
    SendMessageToPC(oPC, sLocName);
    SendMessageToPC(oPC, sLocation1);
}
