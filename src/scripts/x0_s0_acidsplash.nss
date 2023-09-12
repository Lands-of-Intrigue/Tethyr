//::///////////////////////////////////////////////
//:: Acid Splash
//:: [X0_S0_AcidSplash.nss]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
1d3 points of acid damage to one target.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 17 2002
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

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
    int nDamage = 0;


    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
    if (nTouch > 0)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 424));
            //Make SR Check
            if(!MyResistSpell(OBJECT_SELF, oTarget)|| GetTag(oTarget) == "te_gol_clay")
            {
                //Set damage effect
                if(nTouch == 2)
                {
                    nDamage =  MaximizeOrEmpower(3, 2, GetMetaMagicFeat());
                }
                else
                {
                    nDamage =  MaximizeOrEmpower(3, 1, GetMetaMagicFeat());
                }
                effect eBad = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
                //Apply the VFX impact and damage effect
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eBad, oTarget);
            }
        }
    }
    else
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
}



