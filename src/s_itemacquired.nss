//::///////////////////////////////////////////////
//:: Name s_itemacquired
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

This script is intended to be called by or incorporated into the
Module:OnAcquireItem event (script). It works in conjuction with
s_cleartrash by clearing the destruct time on items picked up by PC's
so they will not near-instantly be destroyed if dropped. Once dropped,
however, they will be marked for destruction by s_cleartrash.

*/
//:://////////////////////////////////////////////
//:: Created By: Scott Thorne (Thornex2@wans.net)
//:: Created On: July 27, 2002
//:://////////////////////////////////////////////
void main()
{
    object oItem = GetModuleItemAcquired();

    if (GetIsPC(GetItemPossessor(oItem))) {
        DeleteLocalInt(oItem, "CT_DESTRUCT_TIME");
    }
}
