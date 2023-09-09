//::///////////////////////////////////////////////
//:: CUSTOM: on-death script
//:: el_loot_ondth
//:: By: Emmanuel Lusinchi (Sentur Signe)
//:: 07/29/2002
//:://////////////////////////////////////////////
void main()
{
    object oCorpseOwner;
    object oInvItem;
    oCorpseOwner = GetLocalObject(OBJECT_SELF, "el_corpse_owner");
    SetPlotFlag(oCorpseOwner, FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL),oCorpseOwner);
    AssignCommand(oCorpseOwner, SetIsDestroyable(TRUE, FALSE, FALSE));
}
