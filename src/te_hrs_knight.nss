//Buying Horse
//Copyright Function(D20)
//By David Novotny
// 7/17/2016

#include "x3_inc_horse"
void main()
{

    object oPC   = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oCreature;

    if(GetRacialType(oPC) != RACIAL_TYPE_HALFLING ||  GetRacialType(oPC) != RACIAL_TYPE_GNOME || GetRacialType(oPC) != RACIAL_TYPE_DWARF)
    {
        if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_lightbard")) == TRUE)
        {
            oCreature = HorseCreateHorse("hrs_05",GetLocation(oPC),oPC,"",525);
        }
        else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_medbard")) == TRUE)
        {
            oCreature = HorseCreateHorse("hrs_05",GetLocation(oPC),oPC,"",526);
        }
        else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_heabard")) == TRUE)
        {
            oCreature = HorseCreateHorse("hrs_05",GetLocation(oPC),oPC,"",527);
        }
        else
        {
            oCreature = HorseCreateHorse("hrs_05",GetLocation(oPC),oPC,"",523);
        }
        SetLocalInt(oCreature,"X3_HORSE_MOUNT_SPEED",50);
        SetLocalInt(oCreature,"X3_HORSE_RESTRICT_DWARF",TRUE);
        SetLocalInt(oCreature,"X3_HORSE_RESTRICT_GNOME",TRUE);
        SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFLING",TRUE);
        SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFORC",TRUE);
    }
    else
    {
        if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_lightbard")) == TRUE)
        {
            oCreature = HorseCreateHorse("hrs_06",GetLocation(oPC),oPC,"",499);
        }
        else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_medbard")) == TRUE)
        {
            oCreature = HorseCreateHorse("hrs_06",GetLocation(oPC),oPC,"",500);
        }
        else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_heabard")) == TRUE)
        {
            oCreature = HorseCreateHorse("hrs_06",GetLocation(oPC),oPC,"",501);
        }
        else
        {
            oCreature = HorseCreateHorse("hrs_06",GetLocation(oPC),oPC,"",497);
        }

        SetLocalInt(oCreature,"X3_HORSE_MOUNT_SPEED",50);
        SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HUMAN",TRUE);
        SetLocalInt(oCreature,"X3_HORSE_RESTRICT_ELF",TRUE);
        SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFELF",TRUE);
        SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFORC",TRUE);
    }

}
