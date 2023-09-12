int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_012") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_012") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
