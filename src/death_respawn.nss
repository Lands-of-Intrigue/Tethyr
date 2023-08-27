#include "loi_functions"

void main()
{
    object oPC = GetPCSpeaker();
    string sPCName = GetName(oPC);
    string sBodyID = ObjectToString(oPC)+"BODY";
    object oBody = GetObjectByTag(sBodyID);
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    if(GetIsObjectValid(oBody) == TRUE)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect( EffectCutsceneGhost()),oPC);
        SetLocalInt(oItem,"nRespawn",GetLocalInt(oItem,"nRespawn")+1);
        EventRespawnSafePCBody(oBody, oPC);
    }
    else
    {
        EventRespawnSafeNoBody(oPC);
    }
}
