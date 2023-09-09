void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");

    AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag("WP_START_BROST"))));
    SendMessageToPC(oPC, "<cþ  >It isn't long after you enter the carriage that the caravan begins to move once more. You pass the time idly, noting that you pass through the gates of several fortifications before finally arriving in the Village of Brost.");
}
