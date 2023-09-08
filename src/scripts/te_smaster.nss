void main()
{
    object oPC = OBJECT_SELF;
    float fDur = HoursToSeconds(1);

    effect eSkill1 = EffectSkillIncrease(SKILL_HIDE, 10);
    effect eSkill2 = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 10);
    effect eLink = EffectLinkEffects(eSkill1, eSkill2);
    eLink = EffectLinkEffects(eLink, EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE));

    if ( (GetIsAreaInterior(GetArea(oPC))== TRUE) || (GetIsNight() == TRUE))
    {ApplyEffectToObject(DURATION_TYPE_TEMPORARY, MagicalEffect(eLink), oPC, fDur);}
    else
    {
        SendMessageToPC(oPC, "This ability may only be used where or when the shadows are strongest.");
    }
}

