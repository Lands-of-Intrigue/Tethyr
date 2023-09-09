void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    SetObjectVisualTransform(oPC,OBJECT_VISUAL_TRANSFORM_SCALE,1.0f);
    SetLocalFloat(oItem,"fScale",1.0f);
}
