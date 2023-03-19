//::///////////////////////////////////////////////
//:: Name:      Bedlamson's Dynamic Merchant System
//::            Conversation 'Text Appears When...'
//:: FileName:  bdm_cnv_steal
//:: Copyright (c) 2003 Stephen Spann
//::///////////////////////////////////////////////
//:: Created By: Bedlamson
//:: Created On: 1/23/2003
//::///////////////////////////////////////////////

#include "bdm_include"

int StartingConditional()
{
object oPC = GetPCSpeaker();
object oShopkeeper = OBJECT_SELF;
object oStore = GetLocalObject(oShopkeeper, "STORE");
string sParams = GetLocalString(oShopkeeper, "PARAMS");

int nSteal = GetValue(OBJECT_SELF, "ST", sParams);
if (nSteal && GetHasSkill(SKILL_PICK_POCKET, GetPCSpeaker()))
    {
    return TRUE;
    }
return FALSE;
}
