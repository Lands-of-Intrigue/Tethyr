void main()
{
    object oPC = GetPCSpeaker();
    object oSign = OBJECT_SELF;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    object oArea = GetArea(oPC);
    string sLocation2 = GetLocalString(oItem, "sSaveLocation2");
    string sNewLocation = GetLocalString(oArea, "sSavePointTag");
    string sSaveLoc2Name = GetLocalString(oItem, "sSaveLoc2Name");

    SendMessageToPC(oPC, "Current Location Set:");
    SendMessageToPC(oPC, sSaveLoc2Name);
    SendMessageToPC(oPC, sLocation2);

    SetLocalString(oItem, "sSaveLocation2", sNewLocation);
    SetLocalString(oItem, "sSaveLoc2Name",GetName(oArea));
    SendMessageToPC(oPC, "New Location Set:");
    SendMessageToPC(oPC, "sSaveLoc2Name");
    SendMessageToPC(oPC, GetLocalString(oItem, "sSaveLocation2"));

}
