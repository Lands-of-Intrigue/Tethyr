#include "nw_i0_2q4luskan"
void main()
{
    string sMob1;
    string sMob2;
    string sMob3;
    string sMob4;
    string sMob5;
    string sMob6;
    effect eBV = EffectVisualEffect(VFX_FNF_SUMMON_EPIC_UNDEAD);
    effect eBB = EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE);
    location lSP1 = GetLocation(GetNearestObjectByTag("tn_zombiespot", OBJECT_SELF, 1));
    location lSP2 = GetLocation(GetNearestObjectByTag("tn_zombiespot", OBJECT_SELF, 2));
    location lSP3 = GetLocation(GetNearestObjectByTag("tn_zombiespot", OBJECT_SELF, 3));
    location lSP4 = GetLocation(GetNearestObjectByTag("tn_zombiespot", OBJECT_SELF, 4));
    location lSP5 = GetLocation(GetNearestObjectByTag("tn_zombiespot", OBJECT_SELF, 5));
    location lSP6 = GetLocation(GetNearestObjectByTag("tn_zombiespot", OBJECT_SELF, 6));

        switch (Random(5)+1)
    {
        case 1: sMob1 = "te_zombie001";
        break;
        case 2: sMob1 = "te_zombie002";
        break;
        case 3: sMob1 = "te_zombie003";
        break;
        case 4: sMob1 = "te_zombie004";
        break;
        case 5: sMob1 = "te_dwzomwar";
        break;
    }
        switch (Random(5)+1)
    {
        case 1: sMob2 = "te_zombie001";
        break;
        case 2: sMob2 = "te_zombie002";
        break;
        case 3: sMob2 = "te_zombie003";
        break;
        case 4: sMob2 = "te_zombie004";
        break;
        case 5: sMob2 = "te_dwzomwar";
        break;
    }
        switch (Random(5)+1)
    {
        case 1: sMob3 = "te_zombie001";
        break;
        case 2: sMob3 = "te_zombie002";
        break;
        case 3: sMob3 = "te_zombie003";
        break;
        case 4: sMob3 = "te_zombie004";
        break;
        case 5: sMob3 = "te_dwzomwar";
        break;
    }
        switch (Random(5)+1)
    {
        case 1: sMob4 = "te_zombie001";
        break;
        case 2: sMob4 = "te_zombie002";
        break;
        case 3: sMob4 = "te_zombie003";
        break;
        case 4: sMob4 = "te_zombie004";
        break;
        case 5: sMob4 = "te_dwzomwar";
        break;
    }
        switch (Random(5)+1)
    {
        case 1: sMob5 = "te_zombie001";
        break;
        case 2: sMob5 = "te_zombie002";
        break;
        case 3: sMob5 = "te_zombie003";
        break;
        case 4: sMob5 = "te_zombie004";
        break;
        case 5: sMob5 = "te_dwzomwar";
        break;
    }
        switch (Random(5)+1)
    {
        case 1: sMob6 = "te_zombie001";
        break;
        case 2: sMob6 = "te_zombie002";
        break;
        case 3: sMob6 = "te_zombie003";
        break;
        case 4: sMob6 = "te_zombie004";
        break;
        case 5: sMob6 = "te_dwzomwar";
        break;
    }
    if (GetLocalInt(OBJECT_SELF, "Active") == 1)
    {
        DelayCommand(0.50, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBV, lSP1));
        DelayCommand(0.50, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBV, lSP2));
        DelayCommand(0.50, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBV, lSP3));
        DelayCommand(0.50, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBV, lSP4));
        DelayCommand(0.50, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBV, lSP5));
        DelayCommand(0.50, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBV, lSP6));
        DelayCommand(0.75, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBB, lSP1));
        DelayCommand(0.75, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBB, lSP2));
        DelayCommand(0.75, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBB, lSP3));
        DelayCommand(0.75, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBB, lSP4));
        DelayCommand(0.75, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBB, lSP5));
        DelayCommand(0.75, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBB, lSP6));
        DelayCommand(1.25, CreateObjectVoid(OBJECT_TYPE_CREATURE, sMob1, lSP1, FALSE));
        DelayCommand(1.25, CreateObjectVoid(OBJECT_TYPE_CREATURE, sMob2, lSP2, FALSE));
        DelayCommand(1.25, CreateObjectVoid(OBJECT_TYPE_CREATURE, sMob3, lSP3, FALSE));
        DelayCommand(1.25, CreateObjectVoid(OBJECT_TYPE_CREATURE, sMob4, lSP4, FALSE));
        DelayCommand(1.25, CreateObjectVoid(OBJECT_TYPE_CREATURE, sMob5, lSP5, FALSE));
        DelayCommand(1.25, CreateObjectVoid(OBJECT_TYPE_CREATURE, sMob6, lSP6, FALSE));
        SetLocalInt(OBJECT_SELF, "Active", 0);
     }
     else {}

}
