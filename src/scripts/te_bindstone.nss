int CheckIfHelpThing(object oHench);
string GetHelpTag(object oHench);

void main()
{
    object oPC = GetLastUsedBy();
    object oHench1 = GetHenchman(oPC,1);
    object oHench2 = GetHenchman(oPC,2);
    object oHench3 = GetHenchman(oPC,3);
    object oHench4 = GetHenchman(oPC,4);
    object oHench5 = GetHenchman(oPC,5);

    if(GetIsObjectValid(oHench1) && CheckIfHelpThing(oHench1) == TRUE)
    {
        SetLocalInt(oPC,GetHelpTag(oHench1),0);
        DestroyObject(oHench1);
    }
    if(GetIsObjectValid(oHench2) && CheckIfHelpThing(oHench2) == TRUE)
    {
        SetLocalInt(oPC,GetHelpTag(oHench2),0);
        DestroyObject(oHench2);
    }
    if(GetIsObjectValid(oHench3) && CheckIfHelpThing(oHench3) == TRUE)
    {
        SetLocalInt(oPC,GetHelpTag(oHench3),0);
        DestroyObject(oHench3);
    }
    if(GetIsObjectValid(oHench4) && CheckIfHelpThing(oHench4) == TRUE)
    {
        SetLocalInt(oPC,GetHelpTag(oHench4),0);
        DestroyObject(oHench4);
    }
    if(GetIsObjectValid(oHench5) && CheckIfHelpThing(oHench5) == TRUE)
    {
        SetLocalInt(oPC,GetHelpTag(oHench5),0);
        DestroyObject(oHench5);
    }
}

int CheckIfHelpThing(object oHench)
{
    if     (GetResRef(oHench) == "te_summons086") return TRUE;
    else if(GetResRef(oHench) == "te_summons087") return TRUE;
    else if(GetResRef(oHench) == "te_summons088") return TRUE;
    else if(GetResRef(oHench) == "te_summons089") return TRUE;
    else if(GetResRef(oHench) == "te_summons090") return TRUE;
    else if(GetResRef(oHench) == "te_summons091") return TRUE;
    else if(GetResRef(oHench) == "te_summons092") return TRUE;
    else if(GetResRef(oHench) == "te_summons093") return TRUE;
    else if(GetResRef(oHench) == "te_summons094") return TRUE;
    else if(GetResRef(oHench) == "te_summons095") return TRUE;
    else if(GetResRef(oHench) == "te_summons096") return TRUE;
    else if(GetResRef(oHench) == "te_summons097") return TRUE;
    else if(GetResRef(oHench) == "te_summons103") return TRUE;
    else if(GetResRef(oHench) == "te_summons104") return TRUE;
    else if(GetResRef(oHench) == "te_summons105") return TRUE;
    else if(GetResRef(oHench) == "te_summons106") return TRUE;
    else return FALSE;
}

string GetHelpTag(object oHench)
{
    if     (GetResRef(oHench) == "te_summons086") return "te_tok_001";
    else if(GetResRef(oHench) == "te_summons087") return "te_tok_002";
    else if(GetResRef(oHench) == "te_summons088") return "te_tok_003";
    else if(GetResRef(oHench) == "te_summons089") return "te_tok_004";
    else if(GetResRef(oHench) == "te_summons090") return "te_tok_005";
    else if(GetResRef(oHench) == "te_summons091") return "te_tok_006";
    else if(GetResRef(oHench) == "te_summons092") return "te_tok_007";
    else if(GetResRef(oHench) == "te_summons093") return "te_tok_008";
    else if(GetResRef(oHench) == "te_summons094") return "te_tok_009";
    else if(GetResRef(oHench) == "te_summons095") return "te_tok_010";
    else if(GetResRef(oHench) == "te_summons096") return "te_tok_011";
    else if(GetResRef(oHench) == "te_summons097") return "te_tok_012";
    else if(GetResRef(oHench) == "te_summons103") return "te_tok_013";
    else if(GetResRef(oHench) == "te_summons104") return "te_tok_014";
    else if(GetResRef(oHench) == "te_summons105") return "te_tok_015";
    else if(GetResRef(oHench) == "te_summons106") return "te_tok_016";
    else                                          return "";
}
