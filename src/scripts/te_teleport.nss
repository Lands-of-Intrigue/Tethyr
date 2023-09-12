#include "loi_functions"
#include "x2_inc_spellhook"

void main()
{
/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook

    object oPC = OBJECT_SELF;
     if(GetPCDeadStatus(oPC) == 1 || GetLocalInt(GetArea(oPC),"DeathArea") == 1)
     {
        SendMessageToPC(oPC,"You are dead...");
     }
     else if(GetIsAreaAboveGround(GetArea(oPC)) == FALSE)
     {
       SendMessageToPC(oPC,"You are unsure why, but you are unable to teleport...");
     }
     else
     {ActionStartConversation(oPC,"te_teleport",TRUE,FALSE);}
}
