int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "ceb_crresdarkwood") == OBJECT_INVALID) return FALSE;

return TRUE;
}

