#include "te_afflic_func"
#include "x0_i0_spells"
void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nCHA = GetAbilityModifier(ABILITY_CHARISMA, oPC);
    effect eAB = EffectAttackIncrease(nCHA, ATTACK_BONUS_MISC);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, oPC, 6.0f);
    int nTouch = TouchAttackMelee(oTarget);
    int nDAM;
    int nPAL = GetLevelByClass(CLASS_TYPE_PALADIN, oPC);
    int nBLK = GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPC);
    int nCLER = GetLevelByClass(CLASS_TYPE_CLERIC, oPC);
    int nBLC = GetLevelByClass(51,oPC);
    int nDIV = GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, oPC);
    int nMYS = GetLevelByClass(56, oPC);
    int nCL = (nPAL + nBLK + nCLER + nDIV + nBLC + nMYS);
    int nFDAM;

    if (nCL < 2)
    {
        nDAM = ((d6(2) + nCHA) * nTouch);
    }
    else if ((nCL >= 2)&&(nCL < 4))
    {
        nDAM = ((d6(3) + nCHA) * nTouch);
    }
    else if ((nCL >= 4)&&(nCL <6))
    {
        nDAM = ((d6(4) + nCHA) * nTouch);
    }
    else if ((nCL >=6)&&(nCL<8))
    {
        nDAM = ((d6(5) + nCHA) * nTouch);
    }
    else
    {
        nDAM = ((d6(6) + nCHA) * nTouch);
    }

    if(GetIsUndead(oPC) == TRUE)
    {
        nDAM = (nDAM + (nDAM/2));
    }

    if(GetRacialType(oTarget) == RACIAL_TYPE_OUTSIDER)
    {
        nDAM = (nDAM + (nDAM/2));
    }

    if(GetIsPC(oTarget) == TRUE)
    {
        if((GetHasFeat(1186,oTarget) == TRUE) || (GetHasFeat(1187,oTarget) == TRUE))
            {
                nDAM = (nDAM + (nDAM/2));
            }
    }

    effect eVis = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);

    if (nTouch >= 1)
    {
        effect eDam = EffectDamage(nDAM, DAMAGE_TYPE_DIVINE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDam, oTarget);
    if (nMYS >= 1) {
        nFDAM = ((nMYS*2)+nCHA);
        effect eDam = EffectDamage(nFDAM, DAMAGE_TYPE_FIRE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDam, oTarget);
        spellsDispelMagic(oTarget, 3, EffectVisualEffect(VFX_IMP_HEAD_SONIC), EffectVisualEffect(VFX_FNF_LOS_NORMAL_20));
    }

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        AdjustReputation(oPC, oTarget, 0);
    }
    else
    {
        AdjustReputation(oPC, oTarget, 0);
    }
}
