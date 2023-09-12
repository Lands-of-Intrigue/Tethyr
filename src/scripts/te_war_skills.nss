void main()
{
    int nSpell = GetSpellId();
    object oPC = GetSpellTargetObject();
    float fDur = HoursToSeconds(24);
    int nMetaMagic = GetMetaMagicFeat();
    effect eSkill1;
    effect eSkill2;
    effect eSkill3;
    string sString;
    effect eLink;

if (nMetaMagic == METAMAGIC_EXTEND)
    {
        fDur = fDur *2; //Duration is +100%
    }

switch (nSpell)
{
    case 850: //Artificer's Assistant
        {eSkill1 = EffectSkillIncrease(SKILL_CRAFT_ARMOR, 6);
        eSkill2 = EffectSkillIncrease(SKILL_CRAFT_WEAPON, 6);
        eSkill3 = EffectSkillIncrease(SKILL_CRAFT_TRAP, 6);
        eLink = EffectLinkEffects(eSkill2,eSkill1);
        eLink = MagicalEffect(EffectLinkEffects(eSkill3, eLink));
        sString = "Artificer's Assistant";}
        break;

    case 852: //Beguiling Influence
        {eSkill1 = EffectSkillIncrease(SKILL_BLUFF, 6);
        eSkill2 = EffectSkillIncrease(SKILL_INTIMIDATE, 6);
        eSkill3 = EffectSkillIncrease(SKILL_PERSUADE, 6);
        eLink = EffectLinkEffects(eSkill2,eSkill1);
        eLink = MagicalEffect(EffectLinkEffects(eSkill3, eLink));
        sString = "Beguiling Influence";}
        break;

    case 857: //Leaps and Bounds
        {eSkill1 = EffectSkillIncrease(SKILL_CONCENTRATION, 6);
        eSkill2 = EffectSkillIncrease(SKILL_DISCIPLINE, 6);
        eSkill3 = EffectSkillIncrease(SKILL_TUMBLE, 6);
        eLink = EffectLinkEffects(eSkill2,eSkill1);
        eLink = MagicalEffect(EffectLinkEffects(eSkill3, eLink));
        sString = "Leaps and Bounds";}
        break;

    case 859: //All-Seeing Eyes
        {eSkill1 = EffectSkillIncrease(SKILL_LISTEN, 6);
        eSkill2 = EffectSkillIncrease(SKILL_SPOT, 6);
        eSkill3 = EffectSkillIncrease(SKILL_SEARCH, 6);
        eLink = EffectLinkEffects(eSkill2,eSkill1);
        eLink = MagicalEffect(EffectLinkEffects(eSkill3, eLink));
        sString = "All-Seeing Eyes";}
        break;

    case 861: //Dark Arcana
        {eSkill1 = EffectSkillIncrease(SKILL_LORE, 6);
        eSkill2 = EffectSkillIncrease(SKILL_SPELLCRAFT, 6);
        eSkill3 = EffectSkillIncrease(SKILL_USE_MAGIC_DEVICE, 6);
        eLink = EffectLinkEffects(eSkill2,eSkill1);
        eLink = MagicalEffect(EffectLinkEffects(eSkill3, eLink));
        sString = "Dark Arcana";}
        break;

    case 862: //Cloak of Shadows
        {eSkill1 = EffectSkillIncrease(SKILL_HIDE, 6);
        eSkill2 = EffectSkillIncrease(SKILL_PICK_POCKET, 6);
        eSkill3 = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 6);
        eLink = EffectLinkEffects(eSkill2,eSkill1);
        eLink = MagicalEffect(EffectLinkEffects(eSkill3, eLink));
        sString = "Cloak of Shadows";}
        break;
}

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, fDur);
SendMessageToPC(oPC, sString);
    }
