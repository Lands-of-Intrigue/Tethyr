//::///////////////////////////////////////////////
//:: Stoneskin
//:: NW_S0_Stoneskin
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the creature touched 10/+5
    damage reduction.  This lasts for 1 hour per
    caster level or until 10 * Caster Level (100 Max)
    is dealt to the person.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: March 16 , 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
#include "nw_i0_spells"

#include "x2_inc_spellhook"
#include "nwnx_time"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "te_functions"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

    effect eVis2 = EffectVisualEffect(2140);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eBad1 = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL,10);
    effect eBad2 = EffectDamageResistance(DAMAGE_TYPE_COLD,10);
    effect eBad3 = EffectDamageResistance(DAMAGE_TYPE_ACID,10);
    effect eBad4 = EffectAbilityIncrease(ABILITY_CHARISMA,4);
    object oTarget = OBJECT_SELF;

    //Declare major variables
    int nDuration = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    float fDelay;

    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
    {
        nDuration *= 2;
    }

    effect eLink = EffectLinkEffects(eVis2,eDur);
    eLink = EffectLinkEffects(eBad1,eLink);
    eLink = EffectLinkEffects(eBad2,eLink);
    eLink = EffectLinkEffects(eBad3,eLink);
    eLink = EffectLinkEffects(eBad4,eLink);

    RemoveEffectsFromSpell(oTarget,1021);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,RoundsToSeconds(nDuration));

}
