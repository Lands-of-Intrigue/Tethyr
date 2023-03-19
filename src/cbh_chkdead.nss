int StartingConditional()
{
object oPC = GetPCSpeaker();
object oContract = GetItemPossessedBy(oPC, "cbh_Contract");
if (GetLocalInt(oContract, "Status") != 4) return FALSE;
return TRUE;
}
