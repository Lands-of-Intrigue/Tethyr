int StartingConditional()
{
    object oPC = GetPCSpeaker();
    // Make sure the player has the required feats
    if(
        (GetLevelByClass(CLASS_TYPE_DRUID,oPC) >=3)||
        ((GetLevelByClass(CLASS_TYPE_RANGER,oPC) >=6)&&(GetAbilityScore(oPC, ABILITY_WISDOM,TRUE)>=13))||
        (GetLevelByClass(CLASS_TYPE_CLERIC,oPC) >=3)||
        ((GetLevelByClass(CLASS_TYPE_WIZARD,oPC) >=3)&&(GetAbilityScore(oPC, ABILITY_WISDOM,TRUE)>=13))||
        ((GetLevelByClass(CLASS_TYPE_SORCERER,oPC) >=3)&&(GetAbilityScore(oPC, ABILITY_WISDOM,TRUE)>=13))||
        ((GetLevelByClass(CLASS_TYPE_BARD,oPC) >=3)&&(GetAbilityScore(oPC, ABILITY_WISDOM,TRUE)>=13))||
        (GetLevelByClass(47,oPC) >=1)||
        (GetLevelByClass(31,oPC) >=1)
      )
    {
        return TRUE;
    }

    return FALSE;
}
