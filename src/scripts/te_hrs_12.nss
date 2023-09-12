#include "x3_inc_horse"
void main()
{
    object oPC   = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oCreature;

    if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_lightbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_12",GetLocation(oPC),oPC,"",548);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_medbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_12",GetLocation(oPC),oPC,"",548);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_heabard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_12",GetLocation(oPC),oPC,"",548);
    }
    else
    {
        oCreature = HorseCreateHorse("hrs_12",GetLocation(oPC),oPC,"",549);
    }

    SetLocalInt(oCreature,"X3_HORSE_MOUNT_SPEED",55);

    SetLocalInt(oPC,"hrs_12",TRUE);
}
