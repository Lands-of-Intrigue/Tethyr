int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iHD = GetHitDice(oPC);

    if (iHD >=10)
    {   return FALSE;}
    else
    {   return TRUE;}
}

