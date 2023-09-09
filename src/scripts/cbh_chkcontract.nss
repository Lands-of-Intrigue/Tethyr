int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "cbh_Contract") == OBJECT_INVALID) return FALSE;

return TRUE;
}
