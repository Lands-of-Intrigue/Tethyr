//::///////////////////////////////////////////////
//:: Falselife
//::te_sp_falselfe.nss
//:://////////////////////////////////////////////
/*
    Caster gains d10 temporary HP +1 per casterlevel max 10.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Sept 6, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001

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
    int nCasterLVL = TE_GetCasterLevel(OBJECT_SELF, GetLastSpellCastClass());
    int nDuration = nCasterLVL;
    int nBonus = nCasterLVL;
    int nHealthRoll = d10(1);
    int nMetaMagic = GetMetaMagicFeat();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    if (nBonus >= 10)
    {
        nBonus = 10;
    }
    int nHealth = nHealthRoll +  nBonus;

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nHealth = 10 + nBonus;//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nHealth = nHealth + (nHealth/2); //Damage/Healing is +50%
    }
    else if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }


    effect eHP = EffectTemporaryHitpoints(nBonus);

    effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID);
    object oTarget = OBJECT_SELF;



    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_AID, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, TurnsToSeconds(nDuration));
}

