#include "x3_inc_horse"
void main()
{
    object oPC   = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oCreature;

    if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_lightbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_11",GetLocation(oPC),oPC,"",3902);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_medbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_11",GetLocation(oPC),oPC,"",3903);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_heabard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_11",GetLocation(oPC),oPC,"",3901);
    }
    else
    {
        oCreature = HorseCreateHorse("hrs_11",GetLocation(oPC),oPC,"",3901);
    }

    SetLocalInt(oCreature,"X3_HORSE_MOUNT_SPEED",70);

    SetLocalInt(oPC,"hrs_11",TRUE);
}
