#include "x3_inc_horse"
void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    object oMount = OBJECT_SELF;
    string sTag = GetTag(oMount);

    SetLocalInt(oItem,sTag,1);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_UNSUMMON), oMount, 6.0);
    DestroyObject(oMount,4.0);
}
