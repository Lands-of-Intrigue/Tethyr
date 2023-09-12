//Script: te_od_mane
//Author: DM Djinn - Knights of Noromath
//Usage: Caller explodes after a delay and damages nearby objects for 1d6 acid
//  damage (Reflex save DC 15)
//Notes:
// v1.0: Release version
//
#include "x0_i0_corpses"

void ExplodeAtLocation(location lTarget, int nDamage, int nSaveDC = 15, float fRadius = 3.) {
  ApplyEffectAtLocation( DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID), lTarget);
  object oObject = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lTarget);
  do {
    int nDamageAfterSave = GetReflexAdjustedDamage(nDamage, oObject, nSaveDC);
    ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectDamage(nDamageAfterSave, DAMAGE_TYPE_ACID), oObject);
   } while ((oObject = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lTarget)) != OBJECT_INVALID);
}
//
void main()
{
    ExecuteScript("sf_xp", OBJECT_SELF);
    location lSource = GetLocation(OBJECT_SELF);
    DelayCommand(3., ExplodeAtLocation(lSource, d6(1)));
}
