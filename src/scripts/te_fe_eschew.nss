void main()
{
    object oPC = OBJECT_SELF;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");

    if(GetLocalInt(oItem,"nEschew") == 0)
    {
        SetLocalInt(oItem,"nEschew",1);
        SendMessageToPC(oPC,"Note: You are now eschewing materials in favor of XP. If you have spell components, they will be consumed first.");
    }
    else
    {
        SetLocalInt(oItem,"nEschew",0);
        SendMessageToPC(oPC,"Note: You are no longer eschewing materials in favor of XP. If you do not have spell components, your spell will fail at no cost.");
    }



}
