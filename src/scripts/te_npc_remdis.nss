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

    if(GetGold(oPC) > 500)
    {
        TakeGoldFromCreature(500,oPC,TRUE);
        ActionCastSpellAtObject(SPELL_REMOVE_DISEASE, oPC, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE);

    }
    else
    {
        SendMessageToPC(oPC,"You do not have enough gold.");
    }
}
