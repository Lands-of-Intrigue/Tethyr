#include "NW_I0_SPELLS"
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
    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(oCaster);
    int nDamage;
    int nMax;
    float fDur = 12.0;
    effect eDam;
    effect eBlind = EffectBlindness();
    effect eVis = EffectVisualEffect(VFX_IMP_DAZED_S);
    effect eRay = EffectBeam(VFX_BEAM_BLACK, OBJECT_SELF, BODY_NODE_HAND);
    effect eRay2 = EffectBeam(VFX_BEAM_BLACK, OBJECT_SELF, BODY_NODE_HAND, TRUE);

    if (nMetaMagic == METAMAGIC_EXTEND)
            {
                fDur = fDur * 2;
            }
    int nTouch = TouchAttackRanged(oTarget, TRUE);

    if (nTouch > 0)
    {
        if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
        {
            nDamage = 0;
            nMax = 0;
        }
        else
        {
            if (!MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_NONE, OBJECT_SELF))
            {
                nDamage = d8(5) * nTouch;
                nMax = 40 * nTouch;
            }

        }
        //Make metamagic checks
        if (nMetaMagic == METAMAGIC_MAXIMIZE)
        {
            nDamage = nMax * nCasterLevel;
        }
        if (nMetaMagic == METAMAGIC_EMPOWER)
        {
            nDamage = nDamage + (nDamage/2);
        }
        //Set the damage effect
        eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
        //Apply the damage effect and VFX impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);

        if (!MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_NONE, OBJECT_SELF))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oTarget, fDur);
            DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);

        //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.0);

        }
    else
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
    }
}
