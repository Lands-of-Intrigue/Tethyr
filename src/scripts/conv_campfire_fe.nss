#include "so_inc_tradeskil"

int StartingConditional()
{
    int nActivated=GetLocalInt(OBJECT_SELF,CAMP_CAMPFIRE_FIRE);
    if(nActivated!=0&&nActivated<4)
    {
        return TRUE;
    }
    return FALSE;

}
