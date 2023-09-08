void main()
{
    object oPC = GetLastUsedBy();
    object oPlaceable = OBJECT_SELF;
    string sHisMessage = GetLocalString(oPlaceable,"sHistory");
    string sDecMessage = GetLocalString(oPlaceable,"sDecipher");

    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 6.0f));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oPC, 6.0f);

    if(sHisMessage != "")
    {
        if(GetHasFeat(1426,oPC) == TRUE)
        {
            DelayCommand(12.0,SendMessageToPC(oPC,sHisMessage));
        }
        else
        {
            DelayCommand(12.0,SendMessageToPC(oPC,"You do not have the proficiency required to decipher this."));
        }
    }

    if(sDecMessage != "")
    {
        if(GetHasFeat(1428,oPC) == TRUE )
        {
            DelayCommand(12.0,SendMessageToPC(oPC,sDecMessage));
        }
        else
        {
            DelayCommand(12.0,SendMessageToPC(oPC,"You do not have the proficiency required to have a historical insight into this."));
        }
    }
}
