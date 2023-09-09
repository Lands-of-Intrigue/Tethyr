void main()
{
    //effect eGhost = EffectVisualEffect(VFX_DUR_GLOW_GREY);
    effect eDispel = EffectVisualEffect(VFX_FNF_DISPEL);
    object oBASE = GetNearestObjectByTag("tn_dw_furn_BASE");
    object oPC = GetExitingObject();
    if (GetIsPC(oPC) == FALSE){return;}
    if (GetLocalInt(OBJECT_SELF, "Active") == 0)
    {
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDispel, GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 1)));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDispel, GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 2)));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDispel, GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 3)));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDispel, GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 4)));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDispel, GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 5)));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDispel, GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 6)));
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eDispel, GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 7)));
    SetPlotFlag(GetNearestObjectByTag("tn_dw_bed", oBASE, 1), FALSE);
    SetPlotFlag(GetNearestObjectByTag("tn_dw_chest", oBASE, 1), FALSE);
    SetPlotFlag(GetNearestObjectByTag("tn_dw_nightstand", oBASE, 1), FALSE);
    SetPlotFlag(GetNearestObjectByTag("tn_dw_mirror", oBASE, 1), FALSE);
    SetPlotFlag(GetNearestObjectByTag("tn_dw_dresser", oBASE, 1), FALSE);
    SetPlotFlag(GetNearestObjectByTag("tn_dw_case", oBASE, 1), FALSE);
    SetPlotFlag(GetNearestObjectByTag("tn_dw_case", oBASE, 2), FALSE);
    DestroyObject(GetNearestObjectByTag("tn_dw_bed", oBASE, 1));
    DestroyObject(GetNearestObjectByTag("tn_dw_chest", oBASE, 1));
    DestroyObject(GetNearestObjectByTag("tn_dw_nightstand", oBASE, 1));
    DestroyObject(GetNearestObjectByTag("tn_dw_mirror", oBASE, 1));
    DestroyObject(GetNearestObjectByTag("tn_dw_dresser", oBASE, 1));
    DestroyObject(GetNearestObjectByTag("tn_dw_case", oBASE, 1));
    DestroyObject(GetNearestObjectByTag("tn_dw_case", oBASE, 2));
    SetLocalInt(OBJECT_SELF, "Active", 1);
    }
}
