void main()
{
    object oPC = GetPCSpeaker();
    object oBody = OBJECT_SELF;

    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, IntToFloat(10)));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oPC, IntToFloat(10));
    DelayCommand(IntToFloat(10), DestroyObject(OBJECT_SELF));
    DelayCommand(IntToFloat(10), AssignCommand(oPC, ActionGiveItem(CreateItemOnObject("te_hd_1001", oPC), oPC)));

}
