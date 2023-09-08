int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_009") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_009") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
