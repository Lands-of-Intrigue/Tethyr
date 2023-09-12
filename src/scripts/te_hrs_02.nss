#include "x3_inc_horse"
void main()
{
    object oPC   = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oCreature;

    if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_lightbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_02",GetLocation(oPC),oPC,"",512);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_medbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_02",GetLocation(oPC),oPC,"",513);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_heabard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_02",GetLocation(oPC),oPC,"",514);
    }
    else
    {
        oCreature = HorseCreateHorse("hrs_02",GetLocation(oPC),oPC,"",510);
    }

    SetLocalInt(oCreature,"X3_HORSE_MOUNT_SPEED",65);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_DWARF",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_GNOME",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFLING",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFORC",TRUE);
    SetLocalInt(oPC,"hrs_02",TRUE);
}
