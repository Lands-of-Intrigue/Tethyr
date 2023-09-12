#include "x3_inc_horse"
void main()
{
    object oPC   = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oCreature;

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
    SetLocalInt(oPC,"hrs_06",TRUE);
}
