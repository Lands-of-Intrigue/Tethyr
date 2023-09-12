int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "te_item_0009") == OBJECT_INVALID) return FALSE;

return TRUE;
}

