int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "te_item_0006") == OBJECT_INVALID) return FALSE;

return TRUE;
}

