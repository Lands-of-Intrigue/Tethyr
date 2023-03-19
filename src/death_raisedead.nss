#include "loi_functions"

void main()
{
object oPC;
object oTarget;
if (GetLastSpell() == SPELL_RAISE_DEAD)
    {
        oPC = GetLastSpellCaster();
        oTarget = OBJECT_SELF;
        EventRevivePCBody(oTarget, oPC);
    }
else
    {
    return;
    }
}
