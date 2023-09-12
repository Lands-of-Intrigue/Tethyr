#include "x3_inc_horse"
void main()
{
    object oPC   = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oCreature;

    if(GetGold(oPC) >=100)
    {
        TakeGoldFromCreature(100,oPC,TRUE);
        SetLocalInt(oItem,"hrs_09",TRUE);
        SetLocalInt(oPC,"hrs_09",TRUE);

    if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_lightbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_09",GetLocation(oPC),oPC,"",525);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_medbard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_09",GetLocation(oPC),oPC,"",526);
    }
    else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_heabard")) == TRUE)
    {
        oCreature = HorseCreateHorse("hrs_09",GetLocation(oPC),oPC,"",527);
    }
    else
    {
        oCreature = HorseCreateHorse("hrs_09",GetLocation(oPC),oPC,"",523);
    }

    SetLocalInt(oCreature,"X3_HORSE_MOUNT_SPEED",50);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HUMAN",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_ELF",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFELF",TRUE);
    SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFORC",TRUE);
    }
}
