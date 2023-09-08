void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    float fScale = GetLocalFloat(oItem,"fScale");

    SetLocalFloat(oItem,"fScale",fScale-0.5f);
    SetObjectVisualTransform(oPC,OBJECT_VISUAL_TRANSFORM_SCALE,fScale-0.5f);
}
