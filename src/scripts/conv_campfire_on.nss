#include "so_inc_tradeskil"

int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF,CAMP_CAMPFIRE_FIRE))
    {
        return TRUE;
    }
    return FALSE;

}
