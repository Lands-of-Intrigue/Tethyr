int StartingConditional()
{
    string sGold = GetLocalString(OBJECT_SELF, "GOLD");
    // Check if amount spoken is valid
    return (StringToInt(sGold) < 50 && StringToInt(sGold) > 0);
}

