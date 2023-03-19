#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "te_functions"
#include "te_afflic_func"
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
    location lLoc = GetSpellTargetLocation();
    location lLoc1 = GetLocation(oPC);

    ActionJumpToLocation(lLoc);
    if(GetLastSpell() == 941)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(777), lLoc);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(776), lLoc1);
    }
    else
    {
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,EffectVisualEffect(767),lLoc,3.0f);
    }
}
