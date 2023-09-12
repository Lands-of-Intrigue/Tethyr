void main()
{
object oHench = OBJECT_SELF;
object oPC = GetPCSpeaker();
int nPCLvl = GetHitDice(oPC);
int nCost = nPCLvl * (nPCLvl - 1 )* 100;
AssignCommand(oHench, ActionSpeakString("Naturally, the more training a henchman has, the more it will cost you. A Henchman will cost you " + IntToString(nCost) + " gold.", TALKVOLUME_TALK));
}
