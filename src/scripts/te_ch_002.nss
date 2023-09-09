int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_002") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_002") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
