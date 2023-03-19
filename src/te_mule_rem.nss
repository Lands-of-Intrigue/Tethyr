void main()
{
object oItem = GetFirstItemInInventory();
if(GetIsObjectValid(oItem))
    {
    while(GetIsObjectValid(oItem))
        {
        SetLocalString(oItem, "OwningPCName", "");
        SetLocalString(oItem, "OwningCDKey", "");
        oItem = GetNextItemInInventory();
        }
    }
}
