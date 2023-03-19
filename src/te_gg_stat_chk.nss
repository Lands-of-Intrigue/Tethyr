int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Make sure the player has the required feats
    if(
        (GetLevelByClass(CLASS_TYPE_DRUID,oPC) >=1)||
        ((GetLevelByClass(CLASS_TYPE_RANGER,oPC) >=6)&&(GetAbilityScore(oPC, ABILITY_WISDOM,TRUE)>=13))||
        (GetLevelByClass(CLASS_TYPE_CLERIC,oPC) >=5)||
        ((GetLevelByClass(CLASS_TYPE_WIZARD,oPC) >=5)&&(GetAbilityScore(oPC, ABILITY_WISDOM,TRUE)>=13))||
        ((GetLevelByClass(CLASS_TYPE_SORCERER,oPC) >=5)&&(GetAbilityScore(oPC, ABILITY_WISDOM,TRUE)>=13))||
        ((GetLevelByClass(CLASS_TYPE_BARD,oPC) >=1)&&(GetAbilityScore(oPC, ABILITY_WISDOM,TRUE)>=13))||
        ((GetLevelByClass(51,oPC) >=1)&&(GetAbilityScore(oPC, ABILITY_WISDOM,TRUE)>=13))||
        ((GetLevelByClass(47,oPC) >=7)&&(GetAbilityScore(oPC, ABILITY_WISDOM,TRUE)>=13))||
        (GetHasFeat(1393,oPC))
      )
    {
        return TRUE;
    }

    return FALSE;
}
