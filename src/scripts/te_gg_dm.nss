void main()
{
    object oPC = GetPCSpeaker();
    string sGrove = GetLocalString(OBJECT_SELF,"Grove");
    int nGroveState = GetLocalInt(GetModule(),sGrove);

    SetCustomToken(7870,IntToString(nGroveState));
}
