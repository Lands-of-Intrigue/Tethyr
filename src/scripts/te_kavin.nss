//::///////////////////////////////////////////////
//:: FileName te_kavin
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 10/21/2018 2:53:38 AM
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    object oPC           = GetPCSpeaker();
    object oItem         = GetItemPossessedBy(oPC,"PC_Data_Object");
    int    nPiety        = GetLocalInt(oItem,"nPiety");

    if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC) >= 1)
    {
        SetLocalInt(oItem,"nPiety",nPiety-5);
        SendMessageToPC(oPC,"Your actions are not in accordance with your vows and your piety has fallen as a result.");
        SendMessageToPC(oPC,"Your piety has fallen to "+IntToString(nPiety-5)+" out of 100.");
        if(GetLocalInt(oItem,"nPiety") < 0)     {SetLocalInt(oItem,"nPiety",0);}
        if(GetLocalInt(oItem,"nPiety") > 100)   {SetLocalInt(oItem,"nPiety",100);}
    }
    // Either open the store with that tag or let the user know that no store exists.
    object oStore = GetNearestObjectByTag("te_kavin");
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
