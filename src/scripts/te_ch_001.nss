int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_001") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_001") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
