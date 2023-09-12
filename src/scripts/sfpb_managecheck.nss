int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetIsDM(oPC) == TRUE) return TRUE;
if (GetItemPossessedBy(oPC, "KeytotheCity") == OBJECT_INVALID) return FALSE;
if (GetLocalString(GetItemPossessedBy(oPC, "KeytotheCity"), "Town") != GetLocalString(OBJECT_SELF, "Town")) return FALSE;
return TRUE;
}
