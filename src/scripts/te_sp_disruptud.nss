//::///////////////////////////////////////////////
//:: Disrupt Undead
//:://////////////////////////////////////////////
/*
1d6 points of positive damage to an undead target.
*/
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
// End of Spell Cast Hook

   //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    int nTouch = TouchAttackRanged(oTarget,TRUE);

    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eFail = EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE);

    if (nTouch > 0)
    {
        if(!GetIsReactionTypeFriendly(oTarget) && GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 1016));
            
            //Make SR Check
            if(!MyResistSpell(OBJECT_SELF, oTarget))
            {
                //Set damage effect
                effect eBad = EffectDamage(MaximizeOrEmpower(6, 1, GetMetaMagicFeat()), DAMAGE_TYPE_POSITIVE);
                if (nTouch == 2)
                {
                    eBad = EffectDamage(MaximizeOrEmpower(6, 2, GetMetaMagicFeat()), DAMAGE_TYPE_POSITIVE);
                    effect eVis = EffectVisualEffect(VFX_IMP_DEATH_L);
                }
                //Apply the VFX impact and damage effect
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eBad, oTarget);
            }
        }
        else
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eFail, oTarget);
        }
    }
    else
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eFail, oTarget);
    }
}