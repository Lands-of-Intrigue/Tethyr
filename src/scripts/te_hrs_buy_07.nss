#include "x3_inc_horse"
void main()
{
    object oPC   = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oCreature;

    if(GetGold(oPC) >=400)
    {
        TakeGoldFromCreature(400,oPC,TRUE);
        SetLocalInt(oItem,"hrs_07",TRUE);
        SetLocalInt(oPC,"hrs_07",TRUE);

    if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_lightbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_07",GetLocation(oPC),oPC,"",538);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_medbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_07",GetLocation(oPC),oPC,"",539);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_heabard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_07",GetLocation(oPC),oPC,"",540);
    }
    else
    {
        oCreature = HorseCreateHorse("hrs_07",GetLocation(oPC),oPC,"",536);
    }

    SetLocalInt(oCreature,"X3_HORSE_MOUNT_SPEED",55);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_DWARF",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_GNOME",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFLING",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFORC",TRUE);
    }
}
