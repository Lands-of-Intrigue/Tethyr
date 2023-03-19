void main()
{
    object oPC = GetPCSpeaker();
    object oBody = OBJECT_SELF;
    SetLocalInt(oBody,"GoldSearch",1);

    if(GetIsSkillSuccessful(oPC,SKILL_SEARCH,15))
    {
        DelayCommand(6.5f, AssignCommand(oBody, GiveGoldToCreature(oPC, d100(1))));
    }



    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, IntToFloat(6)));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oPC, IntToFloat(6));

}
