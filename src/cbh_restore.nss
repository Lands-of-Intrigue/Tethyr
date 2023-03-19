void main()
{
object oPC = GetPCSpeaker();
int nPCLvl = GetHitDice(oPC);
int nCost = (nPCLvl * (nPCLvl -1 ) * 400);
if (GetHitDice(oPC) < 5) nCost = GetHitDice(oPC)*(GetHitDice(oPC)-1)*80;
object oContract = GetItemPossessedBy(oPC, "cbh_Contract");
if (GetGold(oPC)>=nCost)
{
AssignCommand(oPC, TakeGoldFromCreature(nCost, oPC, TRUE));
SetLocalInt(oContract, "Status", 1);
} else {
AssignCommand(OBJECT_SELF, ActionSpeakString("You cannot afford to restore your henchman.", TALKVOLUME_TALK));
}
}
