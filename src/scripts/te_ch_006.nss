int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_006") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_006") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
