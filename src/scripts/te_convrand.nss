void main()
{
    object oPC = GetPCSpeaker();
    int iRand = Random(6);
    SetLocalInt(oPC,"ConvNum", iRand);
}
