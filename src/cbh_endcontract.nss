void main()
{
object oPC = GetPCSpeaker();
object oContract = GetItemPossessedBy(oPC, "cbh_Contract");
DestroyObject(oContract);
DestroyObject(GetItemPossessedBy(oPC, "cbh_HenchInv1"));
DestroyObject(GetItemPossessedBy(oPC, "cbh_HenchInv2"));
if (GetHenchman(oPC)!=OBJECT_INVALID) RemoveHenchman(oPC, GetHenchman(oPC));
}
