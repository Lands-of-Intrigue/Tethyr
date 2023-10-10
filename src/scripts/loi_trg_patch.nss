#include "loi_patches"

void main()
{
    object oPC = GetEnteringObject();

    if (!GetIsPC(oPC) || GetIsDM(oPC)) 
    {
        return;
    }
    
    ApplyPatchesTo(oPC);
}