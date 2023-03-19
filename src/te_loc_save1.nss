void main()
{
    object oPC = GetPCSpeaker();
    object oSign = OBJECT_SELF;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    object oArea = GetArea(oPC);
    string sLocation1 = GetLocalString(oItem, "sSaveLocation1");
    string sNewLocation = GetLocalString(oArea, "sSavePointTag");
    string sSaveLoc1Name = GetLocalString(oItem, "sSaveLoc1Name");

    SendMessageToPC(oPC, "Current Location Set:");
    SendMessageToPC(oPC, sSaveLoc1Name);
    SendMessageToPC(oPC, sLocation1);

    SetLocalString(oItem, "sSaveLocation1", sNewLocation);
    SetLocalString(oItem, "sSaveLoc1Name",GetName(oArea));
    SendMessageToPC(oPC, "New Location Set:");
    SendMessageToPC(oPC, "sSaveLoc1Name");
    SendMessageToPC(oPC, GetLocalString(oItem, "sSaveLocation1"));

}
