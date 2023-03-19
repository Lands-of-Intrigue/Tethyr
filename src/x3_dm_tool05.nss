void main()
{
    object oTarget = GetSpellTargetObject();
    object oItem = GetItemPossessedBy(oTarget,"PC_Data_Object");

    int iDead = GetLocalInt(oItem, "iPCDead");

    if (iDead == 1)
    {
        SetLocalInt(oItem, "iPCDead", 0);
        SendMessageToPC(OBJECT_SELF,"The player is now listed as not dead!");
    }
    else
    {
        SendMessageToPC(OBJECT_SELF,"This player is not listed as dead!");
    }
}







