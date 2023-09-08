#include "x3_inc_horse"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oHorse = HorseGetMyHorse(oPC);
    string sRes = GetResRef(oHorse);

    if(HorseGetIsMounted(oPC) == FALSE)
    {
        if(GetLocalInt(oPC,sRes) == TRUE && GetLocalInt(oItem,sRes) == TRUE)
        {
            SetLocalInt(oPC,sRes,FALSE);
        }
        DestroyObject(oHorse,0.1);
    }
    else
    {
        SendMessageToPC(oPC,"You are unable to stable your horse while you are on it!");
    }
}
