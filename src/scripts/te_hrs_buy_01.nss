#include "x3_inc_horse"
void main()
{
    object oPC   = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oCreature;

    if(GetGold(oPC) >=1650)
    {
        TakeGoldFromCreature(1650,oPC,TRUE);
        SetLocalInt(oItem,"hrs_01",TRUE);
        SetLocalInt(oPC,"hrs_01",TRUE);

        if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_lightbard")) == TRUE)
        {
            oCreature = HorseCreateHorse("hrs_01",GetLocation(oPC),oPC,"",499);
        }
        else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_medbard")) == TRUE)
        {
            oCreature = HorseCreateHorse("hrs_01",GetLocation(oPC),oPC,"",500);
        }
        else if(GetIsObjectValid(GetItemPossessedBy(oPC,"te_heabard")) == TRUE)
        {
            oCreature = HorseCreateHorse("hrs_01",GetLocation(oPC),oPC,"",501);
        }
        else
        {
            oCreature = HorseCreateHorse("hrs_01",GetLocation(oPC),oPC,"",497);
        }

        SetLocalInt(oCreature,"X3_HORSE_MOUNT_SPEED",85);
        SetLocalInt(oCreature,"X3_HORSE_RESTRICT_DWARF",TRUE);
        SetLocalInt(oCreature,"X3_HORSE_RESTRICT_GNOME",TRUE);
        SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFLING",TRUE);
        SetLocalInt(oCreature,"X3_HORSE_RESTRICT_HALFORC",TRUE);
    }
}
