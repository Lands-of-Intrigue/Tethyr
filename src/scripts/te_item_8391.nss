//::///////////////////////////////////////////////
//:: Ghostly Visage
//:: NW_S0_MirrImage.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Caster gains 5/+1 Damage reduction and immunity
    to 1st level spells.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2001
//:://////////////////////////////////////////////

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


    //Declare major variables
    object oTarget = GetItemActivatedTarget();

    effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect eConceal = EffectConcealment(20);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eVis, eConceal);
    eLink = EffectLinkEffects(eLink, eDur);
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = 3;
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 993, FALSE));

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, TurnsToSeconds(nDuration));
}

