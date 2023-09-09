int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_007") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_007") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
