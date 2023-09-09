void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(OBJECT_SELF ,"Material", 5);
AssignCommand(OBJECT_SELF, ActionStartConversation(oPC, "ceb_craftwood2"));
}
