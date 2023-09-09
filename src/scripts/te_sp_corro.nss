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


    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();


    int nCasterLevel = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    int nMetaMagic = GetMetaMagicFeat();
    int nTouch = TouchAttackMelee(oTarget,TRUE);
    int nDuration = nCasterLevel;


    if(nDuration > 5)
    {
        nDuration = 5;
    }


    if (nTouch == 2)
    {
         nCasterLevel = nCasterLevel * 2;
    }

    int nDamage = 1+d6(nCasterLevel);

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 6 * nCasterLevel;//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
    }

    effect eLink = EffectVisualEffect(VFX_COM_HIT_ACID);
    eLink = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_ACID,DAMAGE_POWER_NORMAL),eLink);

    if(nTouch != 0)
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ACID_SPLASH));
        if (!MyResistSpell(OBJECT_SELF, oTarget)|| GetTag(oTarget) == "te_gol_clay")
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget);
            if(nDuration <= 5) DelayCommand(30.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget));
            if(nDuration <= 4) DelayCommand(24.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget));
            if(nDuration <= 3) DelayCommand(18.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget));
            if(nDuration <= 2) DelayCommand(12.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget));
            if(nDuration <= 1) DelayCommand( 6.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget));
        }
    }

}
