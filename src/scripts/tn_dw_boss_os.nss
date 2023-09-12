void main()
{
    effect eAppear = EffectAppear();
    if (GetTag(OBJECT_SELF) == "te_npc_2001")
    {
        SpeakString("By the power of my ancestors... I will make you all pay!");
    }
    else if (GetTag(OBJECT_SELF) == "tn_dw_miniboss")
    {
        SpeakString("How dare you invade my estate! You'll never leave this place alive!");
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eAppear, OBJECT_SELF);
    ExecuteScript("nw_c2_default9", OBJECT_SELF);
    DelayCommand(5.0, ExecuteScript("tn_dw_phbboss2", OBJECT_SELF));
}
