#include "loi_functions"

void main()
{
    object oPC = GetLastUsedBy(); //Get Last User
    object oTarget = OBJECT_SELF; //Target Caller
    EventUsePlaceable(oPC, oTarget, "mal_refine_conv");
}
