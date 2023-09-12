void main()
{
    effect eStatue = EffectVisualEffect(VFX_DUR_PETRIFY);
    effect eStop = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
    effect eStone = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);

    if (GetLocalString(OBJECT_SELF, "Natural Effect") == "Stopped")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eStop, OBJECT_SELF);}
    if (GetLocalString(OBJECT_SELF, "Skin") == "Statue")
    {ApplyEffectToObject(DURATION_TYPE_PERMANENT, eStatue, OBJECT_SELF);}
    {SetObjectVisualTransform(OBJECT_SELF,OBJECT_VISUAL_TRANSFORM_SCALE,1.7f);}
}
