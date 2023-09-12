#include "nw_i0_spells"

#include "x2_inc_spellhook"
#include "nwnx_time"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "te_functions"

void SecondaryEffect(object oPC, object oTarget,int nCasterLevel,int nDC);

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
    int nDC = TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass());
    effect eLink = EffectLinkEffects(EffectVisualEffect(1111),EffectStunned());

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oPC);
    SendMessageToPC(oTarget,"You are overcome with excruciating pain as your bones begin to twist and writh, threatening to break!");
    DelayCommand(6.0,SecondaryEffect(oPC,oTarget,nCasterLevel,nDC));
}

void SecondaryEffect(object oPC, object oTarget,int nCasterLevel,int nDC)
{
    if(!FortitudeSave(oTarget,nDC,SAVING_THROW_TYPE_NONE,oPC))
    {
        SendMessageToPC(oTarget,"CRACK! You feel bones break with a snap, and you are overcome with pain and nausea.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL),oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(nCasterLevel),DAMAGE_TYPE_BLUDGEONING,DAMAGE_POWER_NORMAL),oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDazed(),oTarget,RoundsToSeconds(d4(1)+2));
    }
}
