// All XP awarding MUST go through this script.

const int SOFT_XP_CAP = 91000; // level 14

// Set PC to the soft cap and return lost XP
int DelevelToSoftCap(object oPC);

// Set the PC to 50 xp, then back to their regular XP
// Useful for remaking build decisions
// Should only be used sparingly
void FullRelevel(object oPC);


int DelevelToSoftCap(object oPC)
{
    int nLostXP = 0;
    int nXP = GetXP(oPC);
    if (nXP > SOFT_XP_CAP)
    {
        int nLostXP = nXP - SOFT_XP_CAP;
        SetXP(oPC, SOFT_XP_CAP);
    }
    return nLostXP;
}

void FullRelevel(object oPC)
{
    int nXP = GetXP(oPC);
    SetXP(oPC, 50);
    SetXP(oPC, nXP);
}