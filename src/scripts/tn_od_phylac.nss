//:: [Phylactery On Death]
//:: [tn_od_phylac.nss]
//:://////////////////////////////////////////////
//:: Identify Pentagram and 6 Light Pillars
//:: Remove Plot Flags on the Pgram and Pillars
//:: Apply Death Spell effect on the lights
//:: Destroy Pentagram and 6 Pillars
//:: Create the Boss Shadow in a blood vortex VFX
//:://////////////////////////////////////////////
//:: Created By: Tsurani.Nevericy
//:: Created On: 1/31/2018
//:: Created For: Knights of Noromath
//:://////////////////////////////////////////////

void main()
{
    object oPGram = GetNearestObjectByTag("tn_dpgram");
    object oLight1 = GetNearestObjectByTag("tn_redlight", OBJECT_SELF, 1);
    object oLight2 = GetNearestObjectByTag("tn_redlight", OBJECT_SELF, 2);
    object oLight3 = GetNearestObjectByTag("tn_redlight", OBJECT_SELF, 3);
    object oLight4 = GetNearestObjectByTag("tn_redlight", OBJECT_SELF, 4);
    object oLight5 = GetNearestObjectByTag("tn_redlight", OBJECT_SELF, 5);
    object oLight6 = GetNearestObjectByTag("tn_redlight", OBJECT_SELF, 6);
    object oBossSpawn = GetNearestObjectByTag("tn_shadowspawn2");
    effect eBS = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD);
    SetPlotFlag(oPGram, FALSE);
    DelayCommand(0.01,SetPlotFlag(oLight1, FALSE));
    DelayCommand(0.02,SetPlotFlag(oLight2, FALSE));
    DelayCommand(0.03,SetPlotFlag(oLight3, FALSE));
    DelayCommand(0.04,SetPlotFlag(oLight4, FALSE));
    DelayCommand(0.05,SetPlotFlag(oLight5, FALSE));
    DelayCommand(0.06,SetPlotFlag(oLight6, FALSE));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oLight1));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oLight2));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oLight3));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oLight4));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oLight5));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oLight6));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBS, GetLocation(oBossSpawn));
    DestroyObject(oPGram);
    DelayCommand(0.07,DestroyObject(oLight1));
    DelayCommand(0.08,DestroyObject(oLight2));
    DelayCommand(0.09,DestroyObject(oLight3));
    DelayCommand(0.10,DestroyObject(oLight4));
    DelayCommand(0.11,DestroyObject(oLight5));
    DelayCommand(0.12,DestroyObject(oLight6));
    CreateObject(OBJECT_TYPE_CREATURE, "te_shad4b", GetLocation(GetNearestObjectByTag("tn_shadowspawn2", OBJECT_SELF)), FALSE);
    DelayCommand(5.0, SetLocalInt(GetNearestObjectByTag("StartHeartbeat"), "Active", 1));
}
