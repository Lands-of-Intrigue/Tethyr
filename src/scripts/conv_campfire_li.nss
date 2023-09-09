int StartingConditional()
{
    if(GetLevelByClass(CLASS_TYPE_DRUID,GetPCSpeaker())>0||GetLevelByClass(CLASS_TYPE_RANGER,GetPCSpeaker())>0||GetLevelByClass(CLASS_TYPE_BARBARIAN,GetPCSpeaker())>0)
    {
        return TRUE;
    }
    return FALSE;
}
