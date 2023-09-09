int StartingConditional()
{
    object oBody = OBJECT_SELF;
    if(GetLocalInt(oBody,"GoldSearch") == 1)
    {
        return FALSE;
    }
    return TRUE;
}
