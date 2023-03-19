void main()
{
    object oPC =  GetEnteringObject();
    object oArea = OBJECT_SELF;

    if(GetIsPC(oPC) == TRUE)
    {
        SetLocalInt(GetItemPossessedBy(oPC, "PC_Data_Object"),"iHasEntered", 1);}

    int iPop = GetLocalInt(OBJECT_SELF, "iPop");
    int iHB = GetLocalInt(OBJECT_SELF, "iHB");
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(oArea, "iEntryMsg") == 1)
        {
            SendMessageToPC(oPC, GetLocalString(oArea, "sEntryMsg"));
        }
        //SendMessageToPC(oPC, "You entered a trigger"); // for debugging
        iPop++;
        SetLocalInt(OBJECT_SELF, "iPop", iPop);
        if (iPop == 1)
        {
            SetLocalInt(OBJECT_SELF, "iHB", 1);
            ExecuteScript("te_pseudohb", OBJECT_SELF);
        }
    }
}
