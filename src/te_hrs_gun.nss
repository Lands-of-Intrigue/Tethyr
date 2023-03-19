#include "x3_inc_horse"

void main()
{
    object oPC         = GetPCSpeaker();
    location lPC       = GetLocation(oPC);
    object oLightBard  = GetItemPossessedBy(oPC,"te_lightbard");
    object oMediumBard = GetItemPossessedBy(oPC,"te_medbard");
    object oHeavyBard  = GetItemPossessedBy(oPC,"te_heabard");
    object oItem       = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oMount;

    if(GetIsObjectValid(oHeavyBard) == TRUE)
    {
        oMount = HorseCreateHorse("te_hrs_gun",lPC,oPC,"",514);
    }
    else if(GetIsObjectValid(oMediumBard) == TRUE)
    {
        oMount = HorseCreateHorse("te_hrs_gun",lPC,oPC,"",513);
    }
    else if(GetIsObjectValid(oLightBard) == TRUE)
    {
        oMount = HorseCreateHorse("te_hrs_gun",lPC,oPC,"",512);
    }
    else
    {
        oMount = HorseCreateHorse("te_hrs_gun",lPC,oPC,"",510);
    }

    SetLocalInt(oItem,"te_hrs_gun",0);

}
