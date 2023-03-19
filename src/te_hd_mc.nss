int StartingConditional()
{
    object oBody = OBJECT_SELF;
    if(GetLocalInt(oBody,"MsgSearch") == 1)
    {
        return FALSE;
    }
    return TRUE;
}
