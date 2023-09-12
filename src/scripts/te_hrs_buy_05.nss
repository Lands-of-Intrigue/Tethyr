#include "x3_inc_horse"
void main()
{
    object oPC   = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oCreature;

    if(GetGold(oPC) >=75)
    {
        TakeGoldFromCreature(75,oPC,TRUE);
        SetLocalInt(oItem,"hrs_05",TRUE);
        SetLocalInt(oPC,"hrs_05",TRUE);

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
}
