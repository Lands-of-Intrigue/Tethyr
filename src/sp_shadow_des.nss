#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    effect eAura = EffectVisualEffect(34);
    object oCaster = OBJECT_SELF;
    object oArea = GetArea(oCaster);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAura, oCaster, 6.0);

    int nLocaleFailure = GetCampaignInt("Deadmagic", GetTag(oArea));
    SetCampaignInt("Deadmagic", GetTag(oArea), 100);
    DelayCommand(6.0f, SetCampaignInt("Deadmagic", GetTag(oArea), nLocaleFailure));
}
