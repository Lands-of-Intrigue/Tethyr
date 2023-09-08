// -----------------------------------------------------------------------------
//  sj_suppress_ext
// -----------------------------------------------------------------------------
/*
    OnExit area/trigger event script for Sunjammer's Footprint System to stop
    suppressing the exiting object's footprints.
*/
// -----------------------------------------------------------------------------
/*
    Version 1.00 - 03 Mar 2006 - Sunjammer
    - created
*/
// -----------------------------------------------------------------------------
#include "sj_footprint_i"

void main()
{
    SJ_Footprint_ClearState(GetExitingObject(), SJ_FOOTPRINT_STATE_SUPPRESSED);
}
