#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    object oPC = OBJECT_SELF;
    int nCasterLvl = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    int nMetaMagic = GetMetaMagicFeat();
    effect eSlow = EffectSlow();
    object oTarget = GetSpellTargetObject();
    int nDuration = (1+d4(1));

    if(nCasterLvl > 15)
    {
        nCasterLvl = 15;
    }
    nCasterLvl = (nCasterLvl + 1) / 2;
    int nDamage = d4(nCasterLvl);

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 4 * nCasterLvl;//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
    }

    int nTouch = TouchAttackMelee(oTarget,TRUE);
    effect eDamage = EffectDamage(nDamage,DAMAGE_TYPE_COLD,DAMAGE_POWER_NORMAL);

    if(nTouch >= 1)
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 990));
        if (!MyResistSpell(OBJECT_SELF, oTarget))
        {
            //Make a saving throw check
            if(/*Will Save*/ MySavingThrow(SAVING_THROW_FORT, oTarget, TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()), SAVING_THROW_TYPE_NEGATIVE))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSlow,oTarget,RoundsToSeconds(nDuration));
            }
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
        }
    }
}
