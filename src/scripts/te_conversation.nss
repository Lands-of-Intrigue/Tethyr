void main()
{
    object oPlace = OBJECT_SELF;
    string sConv = GetLocalString(oPlace,"sConv");
    object oPC = GetLastUsedBy();
    ActionStartConversation(oPC ,sConv,FALSE);
}
