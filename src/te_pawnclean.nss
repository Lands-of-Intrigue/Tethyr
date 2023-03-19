#include "nwnx_time"
void main()
{
    object oStore = OBJECT_SELF;

    object oItem = GetFirstItemInInventory(oStore);
    int nTimeNow = NWNX_Time_GetTimeStamp();
    int nPawnTime;

    while (GetIsObjectValid(oItem))
    {
        nPawnTime = GetLocalInt(oItem,"nPawn");
        if(abs(nPawnTime-nTimeNow) <= 864000 && abs(nPawnTime-nTimeNow) >= 43200)
        {
            DestroyObject(oItem);
        }
        else if(abs(nPawnTime-nTimeNow) > 864000 || nPawnTime == 0)
        {
            SetLocalInt(oItem,"nPawn",nTimeNow);
        }
        oItem = GetNextItemInInventory(oStore);
    }
}
