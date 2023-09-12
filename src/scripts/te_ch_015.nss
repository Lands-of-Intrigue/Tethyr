int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_015") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_015") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
