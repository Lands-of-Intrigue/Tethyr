#include "so_inc_tradeskil"

void main()
{
    int nFireDamage=GetDamageDealtByType(DAMAGE_TYPE_FIRE);
    int nElectricDamage=GetDamageDealtByType(DAMAGE_TYPE_ELECTRICAL);
    if(nFireDamage>1||nElectricDamage>2)
    {
        if(GetLocalInt(OBJECT_SELF,"Activated"))
        {
           FeedCampfire(OBJECT_SELF);
        }
        else
        {
           LightCampfire(OBJECT_SELF);
        }
    }
}
