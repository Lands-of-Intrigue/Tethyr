void main()
{
object oPC = GetPCSpeaker();

SetLocalInt(OBJECT_SELF, "Stage", GetLocalInt(OBJECT_SELF, "Stage") + 1);
SetLocalString(OBJECT_SELF, "Recipe", GetLocalString(OBJECT_SELF, "Recipe") + "H");
SendMessageToPC(oPC, GetLocalString(OBJECT_SELF, "Recipe"));
AssignCommand(OBJECT_SELF, ActionStartConversation(oPC, "ceb_craftblack2"));
}
