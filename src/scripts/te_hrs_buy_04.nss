#include "x3_inc_horse"
void main()
{
    object oPC   = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oCreature;

    if(GetGold(oPC) >=200)
    {
        TakeGoldFromCreature(200,oPC,TRUE);
        SetLocalInt(oItem,"hrs_04",TRUE);
        SetLocalInt(oPC,"hrs_04",TRUE);

    if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_lightbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_04",GetLocation(oPC),oPC,"",538);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_medbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_04",GetLocation(oPC),oPC,"",539);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_heabard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_04",GetLocation(oPC),oPC,"",540);
    }
    else
    {
        oCreature = HorseCreateHorse("hrs_04",GetLocation(oPC),oPC,"",536);
    }

    SetLocalInt(oCreature,"X3_HORSE_MOUNT_SPEED",50);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_DWARF",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_GNOME",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFLING",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFORC",TRUE);
    }
}
