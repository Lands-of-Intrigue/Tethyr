//::///////////////////////////////////////////////
//:: Remove Curse
//:: NW_S0_RmvCurse.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Goes through the effects on a character and removes
    all curse effects.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 7, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 22, 2001
#include "loi_functions"
#include "te_afflic_func"
#include "nwnx_creature"

void main()
{
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nType;
    effect eRemove = GetFirstEffect(oTarget);
    effect eVis = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_REMOVE_CURSE, FALSE));

    object oItem;

    if(GetIsPC(oTarget)== TRUE)
    {
        SetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"ShoonAfflic",0);

        if(GetPCAffliction(oTarget) == 2)
        {
            NWNX_Creature_RemoveFeat(oTarget,1413);
            Affliction_Items(oTarget, 0);
            SetPCAffliction(oTarget, 0);
            SetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"iUndead",0);
            SendMessageToPC(oTarget, "You are no longer afflicted with the vampiric disease.");
        }
    }

    //Get the first effect on the target
    while(GetIsEffectValid(eRemove))
    {
        //Check if the current effect is of correct type
        if (GetEffectType(eRemove) == EFFECT_TYPE_CURSE)
        {
            //Remove the effect and apply VFX impact
            RemoveEffect(oTarget, eRemove);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
        //Get the next effect on the target
        GetNextEffect(oTarget);
    }
}
