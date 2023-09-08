//::///////////////////////////////////////////////
//:: OnHit Colddamage
//:: sp_onhitcold
//:://////////////////////////////////////////////
/*

   OnHit Castspell Cold Damage property for the
   flaming weapon spell (x2_s0_flmeweap).

   We need to use this property because we can not
   add random elemental damage to a weapon in any
   other way and implementation should be as close
   as possible to the book.


*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-17
//:://////////////////////////////////////////////

void main()
{
  // Get Caster Level
  int nLevel = GetCasterLevel(OBJECT_SELF);
  // Assume minimum caster level if variable is not found
  if (nLevel== 0)
  {
     nLevel =1;
  }

  int nDmg = d6();

  effect eDmg = EffectDamage(nDmg,DAMAGE_TYPE_COLD);
  effect eVis;
  if (nDmg<5) // if we are doing below 5 point of damage, use small flame
  {
    eVis =EffectVisualEffect(VFX_IMP_FROST_S);
  }
  else
  {
     eVis =EffectVisualEffect(VFX_IMP_FROST_L);
  }
  eDmg = EffectLinkEffects (eVis, eDmg);
  object oTarget = GetSpellTargetObject();

  if (GetIsObjectValid(oTarget))
  {
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget);
  }
}
