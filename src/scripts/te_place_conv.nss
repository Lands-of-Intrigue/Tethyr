void main()
{
    object oPlace = OBJECT_SELF;
    object oUser = GetLastUsedBy();
    string sConv = GetLocalString(oPlace,"sConv");

    ActionStartConversation(oUser,sConv,FALSE,FALSE);
}
