void main()
{
object oPC=GetPCSpeaker();
AssignCommand(OBJECT_SELF, ActionStartConversation(oPC, "ceb_craftwood2", TRUE));
}