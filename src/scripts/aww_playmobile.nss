// aww_playmobile
// has the caller play mobile ambient animations
// useful as a AWW_WP_SCRIPT with LAX_POST
#include "nw_i0_generic"

void main()
{
     SendMessageToPC(GetFirstPC(), "aww_playmobile called for " + GetTag(OBJECT_SELF));
     PlayMobileAmbientAnimations();
}
