#include "df_handler"
#include "x2_inc_spellhook"
#include "x2_inc_switches"

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

//declare variables
object oTarget = GetSpellTargetObject();
DF_RestoreOxygen(oTarget, 20);

}
