// All XP awarding and removal MUST go through this script.

const int SOFT_XP_CAP = 91000; // level 14

// Adds XP to a player character
// Only as high as the soft cap
// Does nothing if nXP <= 0
void AwardXP(object oPC, int nXP);

// Removes XP from a player character
// Cannot take them below 1 XP
// Does nothing if nXP <= 0
void RemoveXP(object oPC, int nXP);

// Set PC to the soft cap and return lost XP
int DelevelToSoftCap(object oPC);

// Set the PC to 50 xp, then back to their regular XP
// Useful for remaking build decisions
// Should only be used sparingly
void FullRelevel(object oPC);

//oPC == Object you wish to give XP to. Only PCs have multiclassing penalty.
//nXPToGive == Amount of XP Reward. If negative, multiclassing penalty will never be calculated or looked at.
//nMulticlass == TRUE for assessing multiclassing penalty. Default = 0/False.
void GiveTrueXPToCreature(object oPC, int nXPToGive, int nMulticlass);



void AwardXP(object oPC, int nXP)
{
    if (nXP <= 0)
        return;

    int nBeforeXP = GetXP(oPC);
    if (nBeforeXP == SOFT_XP_CAP)
        return;

    int nNewXP = nBeforeXP + nXP;
    if (nNewXP > SOFT_XP_CAP)
    {
        nNewXP = SOFT_XP_CAP;
    }
    SetXP(oPC, nNewXP);
}

void RemoveXP(object oPC, int nXP)
{
    if (nXP <= 0)
        return;

    int nBeforeXP = GetXP(oPC);
    int nNewXP = nBeforeXP - nXP;
    if (nNewXP < 1)
    {
        nNewXP = 1;
    }
    SetXP(oPC, nNewXP);
}

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


void GiveTrueXPToCreature(object oPC, int nXPToGive, int nMulticlass)
{
    if(nXPToGive < 0)
    {
        SetXP(oPC,GetXP(oPC)+(nXPToGive));
    }
    else
    {
        if(nMulticlass == TRUE)
        {
            object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
            if(GetLocalInt(oItem,"iMulticlass") == TRUE)
            {
                nXPToGive = (nXPToGive - FloatToInt(IntToFloat(nXPToGive)*0.20));
                SetXP(oPC,GetXP(oPC)+nXPToGive);
            }
            else
            {
                SetXP(oPC,GetXP(oPC)+(nXPToGive));
            }
        }
        else
        {
            SetXP(oPC,GetXP(oPC)+(nXPToGive));
        }
    }
}