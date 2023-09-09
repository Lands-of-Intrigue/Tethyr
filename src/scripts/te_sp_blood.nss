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

    effect eLink1 = EffectLinkEffects(EffectVisualEffect(1100),EffectDamage(20,DAMAGE_TYPE_DIVINE,DAMAGE_POWER_PLUS_TWENTY));
    effect eLink0 = EffectLinkEffects(EffectVisualEffect(1100),EffectHeal(20));

    ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink1,oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink0,oTarget);

}
