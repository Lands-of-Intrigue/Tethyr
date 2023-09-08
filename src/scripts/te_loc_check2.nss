void main()
{
    object oPC = GetPCSpeaker();
    object oSign = OBJECT_SELF;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    object oArea = GetArea(oPC);
    string sLocation2 = GetLocalString(oItem, "sSaveLocation2");
    string sLocName = GetLocalString(oItem, "sSaveLoc2Name");

    SendMessageToPC(oPC, "Currently saved location:");
    SendMessageToPC(oPC, sLocName);
    SendMessageToPC(oPC, sLocation2);
}
