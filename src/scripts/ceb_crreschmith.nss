int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "te_item_0008") == OBJECT_INVALID) return FALSE;

return TRUE;
}

