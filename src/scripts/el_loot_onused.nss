//::///////////////////////////////////////////////
//:: CUSTOM: on-used script
//:: el_loot_onused
//:: By: Emmanuel Lusinchi (Sentur Signe)
//:: 07/29/2002
//:://////////////////////////////////////////////
void main()
{
    object oCorpseOwner;
    object oInvItem;
    object oLootedBy;
    oCorpseOwner = GetLocalObject(OBJECT_SELF, "el_corpse_owner");
    oLootedBy = GetLastUsedBy();
    SetLocalObject(OBJECT_SELF, "el_corpse_looter", oLootedBy);
    object oSuperTaker = CreateObject(OBJECT_TYPE_CREATURE, "el_actionloot", GetLocation(oLootedBy), FALSE);
    SetLocalObject(oSuperTaker, "el_corpse_to_loot", oCorpseOwner);
    SignalEvent(oSuperTaker, EventUserDefined(2000));
    AssignCommand(oLootedBy,  ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 4.0));

return;
}
