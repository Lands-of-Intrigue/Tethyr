void main()
{
    object oPC = GetPCSpeaker(); //Get PC Speaker
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object"); //Fetch PC Data Item
    object oTarget = GetLocalObject(oItem, "oPick"); //Get Temp Var
    string sSound1 = GetLocalString(oTarget, "CEP_L_SOUND1");
    string sSound2 = GetLocalString(oTarget, "CEP_L_SOUND2");

    if (GetLocalInt(oTarget,"CEP_L_AMION") == 0)
    {
        DelayCommand(0.1, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        SetLocalInt(oTarget,"CEP_L_AMION",1);
    }
    else
    {
        DelayCommand(0.1, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        SetLocalInt(oTarget,"CEP_L_AMION",0);
    }
    DeleteLocalObject(oItem, "oPick");
    RecomputeStaticLighting(GetArea(oPC));
}
