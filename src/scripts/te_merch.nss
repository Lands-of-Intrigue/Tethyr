void main()
{
    object oPC = GetPCSpeaker();
    if(GetGold(oPC) >= 5000)
    {
        TakeGoldFromCreature(5000,oPC,TRUE);
        CreateItemOnObject("te_merchant",oPC,1);
    }
}
