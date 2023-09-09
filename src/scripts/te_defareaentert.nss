void main() {
    object oPC = GetEnteringObject();
    int iPop = GetLocalInt(OBJECT_SELF, "iPop");
    int iHB = GetLocalInt(OBJECT_SELF, "iHB");
    if (GetIsPC(oPC)) {
        SendMessageToPC(oPC, "A dark cloud hovers over the Tejarn Tower, this area innately feels wrong and you are overcome with the feeling that you are being watched."); // for debugging
        iPop++;
        SetLocalInt(OBJECT_SELF, "iPop", iPop);

        if (iPop == 2) {
            SetLocalInt(OBJECT_SELF, "iHB", 1);
            ExecuteScript("te_pseudohb", OBJECT_SELF);
        }
    }
}
