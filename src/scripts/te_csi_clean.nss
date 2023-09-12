#include "nwnx_item"
void DoHalfClean(object oPC, object oItem);
void DoFullClean(object oPC, object oItem);

void main()
{
    object oPC = GetLastUsedBy();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CHEST,oPC)) == TRUE)
    {
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(),oPC,30.0f);
         AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 30.0f));
         DelayCommand(30.0f,DoHalfClean(oPC,oItem));
    }
    else
    {
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(),oPC,30.0f);
         AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 30.0f));
         DelayCommand(30.0f,DoFullClean(oPC,oItem));
    }

}

void DoHalfClean(object oPC, object oItem)
{
    if(GetLocalInt(oItem,"nBlood") >= 50)  {SetLocalInt(oItem,"nBlood",50);}
    else{}
    if(GetLocalInt(oItem,"nSticky") >= 50) {SetLocalInt(oItem,"nSticky",50);}
    else{}
    if(GetLocalInt(oItem,"nMud") >= 30) {SetLocalInt(oItem,"nMud",0);}
    else{}
    if(GetLocalInt(oItem,"nDust") >= 50) {SetLocalInt(oItem,"nDust",50);}
    else{}
    if(GetLocalInt(oItem,"nPlan") >= 50) {SetLocalInt(oItem,"nPlan",50);}
    else{}
    if(GetLocalInt(oItem,"nWet") <= 50) {SetLocalInt(oItem,"nWet",50);}
    else{}

    SendMessageToPC(oPC,"You take a moment to clean yourself off, but only manage to remove some of the grime that clings to you. You must remove your clothing/armor to fully clean yourself.");
}

void DoFullClean(object oPC, object oItem)
{
    SetLocalInt(oItem,"nBlood",0);
    SetLocalInt(oItem,"nSticky",0);
    SetLocalInt(oItem,"nMud",0);
    SetLocalInt(oItem,"nDust",0);
    SetLocalInt(oItem,"nPlan",0);
    SetLocalInt(oItem,"nWet",100);

    SendMessageToPC(oPC,"You take a moment to clean yourself off, and succeed in cleaning the grime of your travels from your body.");
}
