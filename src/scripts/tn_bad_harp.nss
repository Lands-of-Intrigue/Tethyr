#include "nw_i0_2q4luskan"
void main()
{
    object oPC = OBJECT_SELF;
    object oWaypoint = GetNearestObjectByTag("tn_dw_hahahand");
    object oWaypoint2 = GetNearestObjectByTag("tn_dw_hahahand2");
    effect eHand = EffectVisualEffect(VFX_FNF_DEMON_HAND);
    effect eDisappear = EffectDisappearAppear(GetLocation(oWaypoint2), 1);
    effect eDamage1 = EffectDamage(d4(1), DAMAGE_TYPE_NEGATIVE);
    effect eDamage2 = EffectDamage(d4(1), DAMAGE_TYPE_PIERCING);
    effect eBV = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD);
    effect eBB = EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE);
    location lSP1 = GetLocation(GetNearestObjectByTag("tn_zombiespot", OBJECT_SELF, 1));
    location lSP2 = GetLocation(GetNearestObjectByTag("tn_zombiespot", OBJECT_SELF, 2));
    location lSP3 = GetLocation(GetNearestObjectByTag("tn_zombiespot", OBJECT_SELF, 3));
    location lSP4 = GetLocation(GetNearestObjectByTag("tn_zombiespot", OBJECT_SELF, 4));
    location lSP5 = GetLocation(GetNearestObjectByTag("tn_zombiespot", OBJECT_SELF, 5));
    string sMob1 = "te_zombie001";
    string sMob2 = "te_zombie002";
    string sMob3 = "te_zombie003";
    string sMob4 = "te_zombie004";
    string sMob5 = "te_dwzomwar";
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(475), oPC);
    SpeakString("Aaaaaah HELP!", TALKVOLUME_TALK);
    DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage1, OBJECT_SELF));
    DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage2, OBJECT_SELF));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDisappear, OBJECT_SELF, 2.5);
    DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBV, lSP1));
    DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBV, lSP2));
    DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBV, lSP3));
    DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBV, lSP4));
    DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBV, lSP5));
    DelayCommand(3.25, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBB, lSP1));
    DelayCommand(3.25, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBB, lSP2));
    DelayCommand(3.25, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBB, lSP3));
    DelayCommand(3.25, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBB, lSP4));
    DelayCommand(3.25, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBB, lSP5));
    DelayCommand(3.5, CreateObjectVoid(OBJECT_TYPE_CREATURE, sMob1, lSP1, FALSE));
    DelayCommand(3.5, CreateObjectVoid(OBJECT_TYPE_CREATURE, sMob2, lSP2, FALSE));
    DelayCommand(3.5, CreateObjectVoid(OBJECT_TYPE_CREATURE, sMob3, lSP3, FALSE));
    DelayCommand(3.5, CreateObjectVoid(OBJECT_TYPE_CREATURE, sMob4, lSP4, FALSE));
    DelayCommand(3.5, CreateObjectVoid(OBJECT_TYPE_CREATURE, sMob4, lSP5, FALSE));



}

