// -----------------------------------------------------------------------------
//  sj_suppress_ent
// -----------------------------------------------------------------------------
/*
    OnEnter area/trigger event script for Sunjammer's Footprint System to start
    suppressing the entering object's footprints.
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
    SJ_Footprint_SetState(GetEnteringObject(), SJ_FOOTPRINT_STATE_SUPPRESSED);
}
