void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    float fScale = GetLocalFloat(oItem,"fScale");

    if (fScale == 0.0f) {fScale = 1.0f;}

    if(fScale <= 0.96f)
    {
        SendMessageToPC(oPC,"You may not decrease your size beyond this point.");
    }
    else
    {
        SetLocalFloat(oItem,"fScale",fScale-0.01f);
        SetObjectVisualTransform(oPC,OBJECT_VISUAL_TRANSFORM_SCALE,fScale-0.01f);
    }
}
