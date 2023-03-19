void main()
{
    object oPC = GetEnteringObject();
    object oArea = OBJECT_SELF;
    object oItem = GetFirstItemInInventory(oPC);
    if( !GetIsPC(oPC))
        return;

    if(GetHitDice(oPC) <=1)
        {
            while (oItem != OBJECT_INVALID)
                {
                    DestroyObject(oItem);
                    oItem = GetNextItemInInventory(oPC);
                }
            AssignCommand(oPC, TakeGoldFromCreature(GetGold(oPC), oPC, TRUE));
        }
}
