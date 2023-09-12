void main()
{
    object oWater = GetNearestObjectByTag("te_waterlevel",OBJECT_SELF);
    int nDrain = GetLocalInt(oWater,"nDrain");

    if(nDrain == 0)
    {
        SetObjectVisualTransform(oWater,OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z,-5.0);
        SetLocalInt(oWater,"nDrain",1);
    }
    else
    {
        SetObjectVisualTransform(oWater,OBJECT_VISUAL_TRANSFORM_TRANSLATE_Z,5.0);
        SetLocalInt(oWater,"nDrain",0);
    }

}
