void main()
{
    object oPC = GetPCSpeaker();
    object oBody = OBJECT_SELF;
    SetLocalInt(oBody,"MsgSearch",1);
    string sMsg = GetLocalString(oBody,"Msg");

    if(GetIsSkillSuccessful(oPC,SKILL_SEARCH,5))
    {
        DelayCommand(6.5, AssignCommand(oPC, ActionGiveItem(CreateItemOnObject(sMsg, oPC), oPC)));
    }



    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, IntToFloat(6)));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oPC, IntToFloat(6));

}
