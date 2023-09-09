int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "x2_it_cmat_oakw") == OBJECT_INVALID) return FALSE;

return TRUE;
}

