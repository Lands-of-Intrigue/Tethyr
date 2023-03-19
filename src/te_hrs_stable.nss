#include "x3_inc_horse"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    object oHorse = HorseGetMyHorse(oPC);
    string sRes = GetResRef(oHorse);

    if(GetLocalInt(oPC,sRes) == TRUE && GetLocalInt(oItem,sRes) == TRUE)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }

}
