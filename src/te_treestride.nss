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
    object oUser = OBJECT_SELF;
     if(GetPCDeadStatus(oUser) == 1 || GetLocalInt(GetArea(oUser),"DeathArea") == 1)
     {
        SendMessageToPC(oUser,"You are dead...");
     }
     else if(GetIsAreaAboveGround(GetArea(oUser)) == FALSE)
     {
       SendMessageToPC(oUser,"There are no nearby plants...");
     }
     else
     {


        if (GetLevelByClass(50,oUser) >=1 )
         {
            ActionJumpToLocation(GetLocation(GetObjectByTag("WP_Blightstride")));
         }
         else
         {
            ActionJumpToLocation(GetLocation(GetObjectByTag("WP_Treestride")));
         }
     }
}
