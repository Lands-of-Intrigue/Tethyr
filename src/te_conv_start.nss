void main()
{
    object oPlace = OBJECT_SELF;
    object oUser = GetLastUsedBy();
    string sConv = GetLocalString(GetArea(oPlace),"CONVERSATION");

    ActionStartConversation(oUser,sConv,FALSE,FALSE);
}
