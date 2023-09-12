int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_003") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_003") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
