#include "nw_i0_plot"


int StartingConditional()
{
    // Get the PC who is involved in this conversation
    object oPC = GetPCSpeaker();

    // The PC must have exactly 0 copies of BrostCountyRegistration.
    if ( GetNumItems(oPC, "BrostCountyRegistration") != 0 )
        return FALSE;

    // If we make it this far, we have passed all tests.
    return TRUE;
}
