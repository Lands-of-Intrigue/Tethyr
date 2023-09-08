int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_010") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_010") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
