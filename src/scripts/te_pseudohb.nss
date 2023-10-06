#include "te_afflic_func"
#include "te_functions"
#include "so_inc_weather"
#include "nwnx_creature"
#include "loi_mythicxp"

void main()
{
    float fInterval = 360.0; // number of seconds to repeat
    int iHB = GetLocalInt(OBJECT_SELF, "iHB");
    int iPop = GetLocalInt(OBJECT_SELF, "iPop");
    int iHBOn = GetLocalInt(OBJECT_SELF, "iHBOn");

    if ((iHB == TRUE)&&(iPop >= 1))
    {
        // start actual heartbeat code
        object oArea = OBJECT_SELF;
        object oMod = GetModule();
        object oPC = GetFirstObjectInArea(OBJECT_SELF);

        int iXPArea = GetLocalInt(OBJECT_SELF, "iXPRate");
        int iXP = DetermineXPRate(iXPArea);
        int iXPBonus = 0;
        object oItem;

        while (oPC != OBJECT_INVALID)
        {
            if (GetIsPC(oPC) == TRUE)
            {
                oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
                if(GetLevelByClass(49, oPC) >= 1 || GetLevelByClass(48, oPC) >= 1)
                {
                    int nManaMax = 50;
                    SetLocalInt(oItem,"nManaMax", nManaMax);
                    int nMana = GetLocalInt(oItem,"nMana");

                    if((GetLocalInt(oItem,"nMana") < nManaMax)&&(iXPArea == 13))
                    {
                        SetLocalInt(oItem,"nMana",nMana +1);
                        SendMessageToPC(oPC, "You have managed to recover another use of your Spellfire Powers...");
                    }
                    else if ((GetLocalInt(oItem,"nMana") == 50)&&(iXPArea == 13))
                    {
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(1),DAMAGE_TYPE_FIRE),oPC);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(1),DAMAGE_TYPE_MAGICAL),oPC);
                    }
                }
                iXPBonus = 0;
                if (GetLocalInt(oPC,"nXPReward") == 1)
                {
                    SetLocalInt(oPC,"nXPReward",0);
                    iXPBonus = GetXPBonus(oPC);
                    iXP = (iXP + iXPBonus);
                    GiveTrueXPToCreature(oPC, iXP,FALSE);
                    TickMythicXp(oPC, ABILITY_CHARISMA, 5);
                }
                ExecuteScript("te_save",oPC);
            }
            else
            {
                if(GetIsDM(oPC))
                {
                    SendMessageToPC(oPC,GetWeatherFeedback(oPC));
                }
            }
            oPC = GetNextObjectInArea(OBJECT_SELF);
        }

        // end actual heartbeat code
        DelayCommand(fInterval, AssignCommand(OBJECT_SELF, ExecuteScript("te_pseudohb", OBJECT_SELF)));

    }
    else
    {
        SetLocalInt(OBJECT_SELF, "iHBOn", 0);
    }
}
