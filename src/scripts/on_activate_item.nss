void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    ExecuteScript(GetTag(oItem),oPC);
}
