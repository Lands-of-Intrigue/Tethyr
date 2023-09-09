#include "nwnx_time"
void main()
{
    object oPlace = OBJECT_SELF;
    int nTimeStamp = GetLocalInt(oPlace,"nTimeStamp");
    int nTimeNow = NWNX_Time_GetTimeStamp();
    if(nTimeStamp+60 <= nTimeNow)
    {
        DestroyObject(oPlace,0.1);
    }
}
