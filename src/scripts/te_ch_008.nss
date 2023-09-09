int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_008") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_008") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
