int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_016") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_016") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
