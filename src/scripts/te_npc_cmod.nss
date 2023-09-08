#include "x3_inc_horse"
void main()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;

    if(HorseGetIsMounted(oPC) == TRUE)
    {
        SendMessageToPC(oPC,"You must not be mounted.");
        return;
    }

    if(GetGold(oPC) > 250)
    {
        TakeGoldFromCreature(250,oPC,TRUE);
        ActionCastSpellAtObject(SPELL_CURE_MODERATE_WOUNDS, oPC, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE);

    }
    else
    {
        SendMessageToPC(oPC,"You do not have enough gold.");
    }
}
