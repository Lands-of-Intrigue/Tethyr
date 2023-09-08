int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_011") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_011") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
