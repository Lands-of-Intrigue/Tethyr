#include "x3_inc_horse"
void main()
{
    object oPC   = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oCreature;

    if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_lightbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_10",GetLocation(oPC),oPC,"",512);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_medbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_10",GetLocation(oPC),oPC,"",513);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_heabard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_10",GetLocation(oPC),oPC,"",514);
    }
    else
    {
        oCreature = HorseCreateHorse("hrs_10",GetLocation(oPC),oPC,"",510);
    }

    SetLocalInt(oCreature,"X3_HORSE_MOUNT_SPEED",70);

    SetLocalInt(oPC,"hrs_10",TRUE);
}
