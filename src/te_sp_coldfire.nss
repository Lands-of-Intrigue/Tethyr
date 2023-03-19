//:://////////////////////////////////////////////////
//:: Tethyr's Warlock Eldritch Blast Evocation
//:: Cold edition
//:: TE_EB_COLD
//:: Copyright (c) 2015 Function(D20)
//:///////////////////////////////////////////////////

/*
   Warlock uses eldritch blast feat to attack player
   Rolls ranged touch attack to see if hit.
   Attack does 1d6 damage per character level
*/
//:///////////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: October 17, 2015
//:///////////////////////////////////////////////////
#include "loi_functions"
#include "te_afflic_func"
#include "nw_i0_spells"
#include "x2_i0_spells"
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

    //Declare Major Variables
    object oTarget = GetSpellTargetObject();
    object oMyWeapon = IPGetTargetedOrEquippedMeleeWeapon();

    object oPC = OBJECT_SELF;
    int CL = GetHitDice(oPC);
    float fDuration = 1.0f;
    float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
    float fDelay = fDist/(3.0 * log(fDist) + 2.0);

    //Effect Options
    effect eMissile = EffectVisualEffect(1007);
    effect eVis = EffectVisualEffect(1141);
    //End Effect Options

    if (GetSpellTargetObject() != OBJECT_SELF)
    {
        //Roll for Touch Attack Success

        effect eDam = EffectDamage(d10(3),DAMAGE_TYPE_NEGATIVE,DAMAGE_POWER_NORMAL);

        //Make SR Check
        if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
        }
    }
    else
    {
        if(GetObjectType(GetSpellTargetObject()) == OBJECT_TYPE_ITEM)
        {
            oMyWeapon = GetSpellTargetObject();
        }

        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), GetItemPossessor(oMyWeapon));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE), GetItemPossessor(oMyWeapon), TurnsToSeconds(CL));
        IPSafeAddItemProperty(oMyWeapon,ItemPropertyEnhancementBonus(1), TurnsToSeconds(CL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
        IPSafeAddItemProperty(oMyWeapon,ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE,IP_CONST_DAMAGEBONUS_2d6), TurnsToSeconds(CL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
        IPSafeAddItemProperty(oMyWeapon,ItemPropertyVisualEffect(ITEM_VISUAL_COLD), TurnsToSeconds(CL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
    }
}
