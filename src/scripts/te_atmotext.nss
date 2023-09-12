void main()

{
    object oTrig = OBJECT_SELF;
    object oPC = GetEnteringObject();
    string sString = GetLocalString(oTrig, "sText");

    if (GetIsPC(oPC) == TRUE)
    {
        SendMessageToPC(oPC, sString);
    }
    else
    {}
}
