int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_004") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_004") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
