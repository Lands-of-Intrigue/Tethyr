void main()
{
    object oItem = GetFirstItemInInventory(OBJECT_SELF);

    while (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem,0.1f);
        oItem = GetNextItemInInventory(OBJECT_SELF);
    }
}
