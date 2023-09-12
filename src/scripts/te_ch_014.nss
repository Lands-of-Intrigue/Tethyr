int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_014") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_014") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
