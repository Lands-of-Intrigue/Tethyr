#include "x0_i0_partywide"
//oPC == Object you wish to give XP to. Only PCs have multiclassing penalty.
//nXPToGive == Amount of XP Reward. If negative, multiclassing penalty will never be calculated or looked at.
//nMulticlass == TRUE for assessing multiclassing penalty. Default = 0/False.
void GiveTrueXPToCreature(object oPC, int nXPToGive, int nMulticlass);

//oPC == Object you wish to give XP to. Only PCs have multiclassing penalty.
//nXPToGive == Amount of XP Reward. If negative, multiclassing penalty will never be calculated or looked at.
//nMulticlass == TRUE for assessing multiclassing penalty. Default = 0/False.
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

void main()
{
    object oPC = GetPCSpeaker();
    if (GetLocalInt(GetItemPossessedBy(oPC, "PC_Data_Object"), "QuestDWHarp") == 0)
    {
        CreateItemOnObject("tn_dw_eliharp", oPC);
        CreateItemOnObject("tn_dw_elisong", oPC);
        DestroyObject(GetItemPossessedByParty(oPC, "tn_dw_necklace"));
        GiveTrueXPToCreature(oPC, 250,FALSE);
        SetLocalInt(GetItemPossessedBy(oPC, "PC_Data_Object"), "QuestDWHarp", 1);
    }
}
