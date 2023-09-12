// sas_activate
// Michael G. Janicki
// 05 February 2003
/*
    Used as a module-wide OnItemActivate script to allow
    for handling of addictive items.  If you wish to use
    this within an existing script, you only need the
    checks for an addictive or curative item.
*/

#include "sas_include"

void main()
{
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();

    if (GetIsPC(oPC))
    {
        int nAddictiveItemIdx = GetAddictiveItem(oItem);
        if (nAddictiveItemIdx != 0)
        {
            ProcessAddict(oPC, nAddictiveItemIdx);
        }

        int nCurativeItemIdx = GetCurativeItem(oItem);
        if (nCurativeItemIdx != 0)
        {
            CureAddict(oPC, nCurativeItemIdx);
        }
    }

    return;
}

