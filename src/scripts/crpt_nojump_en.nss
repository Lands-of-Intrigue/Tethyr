void main()
{
    object oPC = GetEnteringObject();
    int nJump = GetLocalInt(oPC, "JUMP_INVALID");
    if(nJump == 1)
        SetLocalInt(oPC, "JUMP_INVALID", 0);
    else
        SetLocalInt(oPC, "JUMP_INVALID", 1);
}
