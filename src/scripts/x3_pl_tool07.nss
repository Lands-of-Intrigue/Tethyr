//::///////////////////////////////////////////////
//:: Player Tool 5 Instant Feat
//:: x3_pl_tool05
//:: Copyright (c) 2007 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is a blank feat script for use with the
    10 Player instant feats provided in NWN v1.69.

    Look up feats.2da, spells.2da and iprp_feats.2da

*/
//:://////////////////////////////////////////////
//:: Created By: Brian Chung
//:: Created On: 2007-12-05
//:://////////////////////////////////////////////
void CreatePortal(location lLocation,int nType);
void main()
{
    object oPC = OBJECT_SELF;
    location lLocation = GetSpellTargetLocation();
    effect eLightning = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eImplosion = EffectVisualEffect(VFX_FNF_IMPLOSION);
    effect eQuake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eHellfire = EffectVisualEffect(769);
    int nType = 1;

    if(GetIsPC(oPC) == TRUE)
    {
        if(GetHasFeat(1137,oPC) == TRUE) //Abyssal
        {
            nType = 1;
        }
        else
        {
            nType = 0;
        }
    }
    else
    {
        nType = 0;
    }

    nType = 1;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLightning,lLocation);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eQuake,lLocation);
    DelayCommand(2.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLightning,lLocation));
    DelayCommand(6.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLightning,lLocation));

    DelayCommand(12.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eQuake,lLocation));
    DelayCommand(12.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLightning,lLocation));

    DelayCommand(15.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eQuake,lLocation));
    DelayCommand(15.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLightning,lLocation));

    DelayCommand(18.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eQuake,lLocation));
    DelayCommand(18.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eLightning,lLocation));

    DelayCommand(18.5f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eHellfire,lLocation));
    DelayCommand(19.0f,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eImplosion,lLocation));
    DelayCommand(19.0f,CreatePortal(lLocation,nType));
}

void CreatePortal(location lLocation,int nType)
{
    object oPortalBottom = CreateObject(OBJECT_TYPE_PLACEABLE,"portalbase",lLocation);
    object oPortalTop;
    SetLocalInt(oPortalBottom,"Portal",1);
    if(nType = 1){oPortalTop = CreateObject(OBJECT_TYPE_PLACEABLE,"te_port_top1",lLocation);} //Abyss
    else         {oPortalTop = CreateObject(OBJECT_TYPE_PLACEABLE,"te_port_top2",lLocation);} //Infer
    SetLocalInt(oPortalTop,"Portal",1);
    SetLocalInt(oPortalTop,"Type",nType);
    SetLocalInt(oPortalTop,"Level",1);
}
