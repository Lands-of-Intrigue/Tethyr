int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(),"te_tok_005") == FALSE && GetItemPossessedBy(GetPCSpeaker(),"te_tok_005") != OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
