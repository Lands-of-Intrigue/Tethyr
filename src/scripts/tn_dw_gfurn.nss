void main()
{
    effect eGhost = EffectVisualEffect(VFX_DUR_GLOW_GREY);
    object oBASE = GetNearestObjectByTag("tn_dw_furn_BASE");
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC) == FALSE){return;}
    if (GetLocalInt(OBJECT_SELF, "Active") == 1)
    {
    CreateObject(OBJECT_TYPE_PLACEABLE, "tn_dw_bed", GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 2)));
    CreateObject(OBJECT_TYPE_PLACEABLE, "tn_dw_chest", GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 7)));
    CreateObject(OBJECT_TYPE_PLACEABLE, "tn_dw_nightstand", GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 6)));
    //CreateObject(OBJECT_TYPE_PLACEABLE, "tn_dw_quest_neck", GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 6)));
    CreateObject(OBJECT_TYPE_PLACEABLE, "tn_dw_mirror", GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 1)));
    CreateObject(OBJECT_TYPE_PLACEABLE, "tn_dw_case", GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 4)));
    CreateObject(OBJECT_TYPE_PLACEABLE, "tn_dw_case", GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 5)));
    CreateObject(OBJECT_TYPE_PLACEABLE, "tn_dw_dresser", GetLocation(GetNearestObjectByTag("tn_dw_furnaturespot", oBASE, 3)));
    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, GetNearestObjectByTag("tn_dw_bed")));
    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, GetNearestObjectByTag("tn_dw_chest")));
    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, GetNearestObjectByTag("tn_dw_nightstand")));
    //DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, GetNearestObjectByTag("tn_dw_quest_neck")));
    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, GetNearestObjectByTag("tn_dw_mirror")));
    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, GetNearestObjectByTag("tn_dw_case", OBJECT_SELF, 1)));
    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, GetNearestObjectByTag("tn_dw_case", OBJECT_SELF, 2)));
    DelayCommand(0.1, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, GetNearestObjectByTag("tn_dw_dresser")));
    SetLocalInt(OBJECT_SELF, "Active", 0);
    }
}
