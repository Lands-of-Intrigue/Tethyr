//::///////////////////////////////////////////////
//:: Premonition
//:: NW_S0_Premo
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the gives the creature touched 30/+5
    damage reduction.  This lasts for 1 hour per
    caster level or until 10 * Caster Level
    is dealt to the person.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: March 16 , 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
#include "nw_i0_spells"

#include "x2_inc_spellhook"

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

    object oTarget = GetSpellTargetObject();

    //Declare major variables
    int nDuration = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    int nMetaMagic = GetMetaMagicFeat();
    effect eSneakImm = EffectImmunity(IMMUNITY_TYPE_SNEAK_ATTACK);
    effect eReflex = EffectSavingThrowIncrease(SAVING_THROW_REFLEX,2,SAVING_THROW_TYPE_ALL);
    int nDodge = 2;
    effect eAC = EffectACIncrease(nDodge, AC_DODGE_BONUS);
    effect eVis = EffectVisualEffect(VFX_DUR_PROT_PREMONITION);
    //Link the visual and the damage reduction effect
    effect eLink = EffectLinkEffects(eSneakImm, eVis);
    eLink = EffectLinkEffects(eLink, eReflex);
    eLink = EffectLinkEffects(eLink, eSneakImm);
    eLink = EffectLinkEffects(eLink, eAC);
    //Enter Metamagic conditions
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_PREMONITION, FALSE));
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }

    RemoveEffectsFromSpell(oTarget, SPELL_PREMONITION);
    //Apply the linked effect
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, HoursToSeconds(nDuration));
}
