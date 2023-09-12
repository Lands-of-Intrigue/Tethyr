int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_013") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_013") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
