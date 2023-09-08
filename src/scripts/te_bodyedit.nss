int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if(GetTag(GetArea(oPC)) == "CharacterCreationRoom")
    {
        return TRUE;
    }
    else if(GetHasFeat(1203,oPC) == TRUE || GetHasFeat(1458,oPC) == TRUE || GetLevelByClass(CLASS_TYPE_DRUID,oPC) >= 13)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
