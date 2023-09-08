void main()
{
object oHench = OBJECT_SELF;
object oPC = GetPCSpeaker();
int nPCLvl = GetHitDice(oPC);
int nCost = nPCLvl * (nPCLvl - 1 )* 150;
AssignCommand(oHench, ActionSpeakString("A Henchman will cost you " + IntToString(nCost) + " gold.", TALKVOLUME_TALK));
}
