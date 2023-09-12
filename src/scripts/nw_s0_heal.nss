//::///////////////////////////////////////////////
//:: Heal
//:: [NW_S0_Heal.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Heals the target to full unless they are undead.
//:: If undead they reduced to 1d4 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 12, 2001
//:://////////////////////////////////////////////
//:: Update Pass By: Preston W, On: Aug 1, 2001

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
  object oTarget = GetSpellTargetObject();
  effect eKill, eHeal;
  int nDamage, nHeal, nModify, nTouch;
  effect eSun = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eHealVis = EffectVisualEffect(VFX_IMP_HEALING_X);
  int nMetaMagic = GetMetaMagicFeat();
  int nCLVL = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());

  if (GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT){ return; }


    //Check to see if the target is an undead
    if ( (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD) || ( (GetIsPC(oTarget) == TRUE) && (GetLocalInt(GetItemPossessedBy(oTarget,"PC_Data_Object"),"iUndead") == 1 ) ))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL));
        //Make a touch attack
        if (TouchAttackMelee(oTarget))
        {
            //Make SR check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                //Figure out the amount of damage to inflict
                nDamage = GetCurrentHitPoints(oTarget) - 1;
                if (nDamage > nCLVL * 10){nDamage = nCLVL * 10;}
                if (MySavingThrow(SAVING_THROW_WILL, oTarget, TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()), SAVING_THROW_TYPE_POSITIVE)){
                    nDamage = nDamage / 2;
                }
                //Set damage
                eKill = EffectDamage(nDamage, DAMAGE_TYPE_POSITIVE);
                //Apply damage effect and VFX impact
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eSun, oTarget);
            }
        }

    }
    else
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEAL, FALSE));
        //Figure out how much to heal
        nHeal = GetMaxHitPoints(oTarget);
        if (nHeal > nCLVL * 10){nHeal = nCLVL * 10;}
        //Set the heal effect
        eHeal = EffectHeal(nHeal);
        //Apply the heal effect and the VFX impact
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHealVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
}
