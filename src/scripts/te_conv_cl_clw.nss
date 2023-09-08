#include "nw_i0_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oNPC = GetLastSpeaker();
    int nSplLvl = 6;
    int nPrice = (nSplLvl*10*GetCasterLevel(oNPC));

    TakeGold(nPrice, oPC,TRUE);
    ActionCastSpellAtObject(SPELL_CURE_MINOR_WOUNDS,oPC,METAMAGIC_ANY,TRUE,GetCasterLevel(oNPC),PROJECTILE_PATH_TYPE_DEFAULT,FALSE);
}
