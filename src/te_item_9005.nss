//::///////////////////////////////////////////////
//:: Example Item Event Script
//:: x2_it_example
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is an example on how to use the
    new default module events for NWN to
    have all code concerning one item in
    a single file.

    Note that this system only works, if
    the following events set on your module

    OnEquip      - x2_mod_def_equ
    OnUnEquip    - x2_mod_def_unequ
    OnAcquire    - x2_mod_def_aqu
    OnUnAcqucire - x2_mod_def_unaqu
    OnActivate   - x2_mod_def_act

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-10
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "loi_functions"
#include "te_functions"

void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oTarget;
    object oFire;

    int nDamage = d6(2);

    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
        oTarget = GetItemActivatedTarget();

        if(GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
        {
            if(GetTag(oTarget) == "te_pl_fire")
            {
                SetLocalInt(oTarget,"Wet",1);
                return;
            }
        }

        int nAffliction = GetIsUndead(oTarget);

        if (nAffliction == TRUE)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_FLAME_M),oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nDamage,DAMAGE_TYPE_DIVINE,DAMAGE_POWER_NORMAL),oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSlow(),oTarget,RoundsToSeconds(2));
            SendMessageToPC(oTarget,"You feel enraged as the water burns inside of you, causing you to writhe in pain.");
        }
        else
        {
            if(GetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"ShoonAfflic") > 1)
            {
                SetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"ShoonAfflic",3);
                AddJournalQuestEntry("te_shoondisease",1,oPC);
            }
            SendMessageToPC(oTarget,"You feel somewhat calmed as you ingest the holy water.");
        }

    }
}
