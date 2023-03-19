#include "loi_functions"

void main()
{
    object oPC = GetPCSpeaker();
    string sPCName = GetName(oPC);
    string sBodyID = ObjectToString(oPC)+"BODY";
    object oBody = GetObjectByTag(sBodyID);
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    //effect eSanct = EffectSanctuary(35);
    //int nHealed = GetMaxHitPoints(oPC);
    //effect eHeal = EffectHeal(nHealed + 10);

    //ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
    //ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oPC);
    //ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSanct,oPC,12.0f);

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
