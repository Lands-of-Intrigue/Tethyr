int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "te_cebcraft024") == OBJECT_INVALID) return FALSE;

return TRUE;
}

