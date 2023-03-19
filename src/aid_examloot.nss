//::///////////////////////////////////////////////
//:: aid_examloot
//:://////////////////////////////////////////////
/*
    script for handling examination or inspection of a lootable
    use:
    specify "passthrough" in local string examine or touch
    and specify this script in onexamine or ontouch

    local string "examine_loot"
        description given when loot container is present
    local string "examine_loot_empty"
        description given when no loot is spawned

    see v2_inc_loot for list of local variables used by LOOT SYSTEM

*/
//:://////////////////////////////////////////////
//:: Created:   henesua (2014 mar 2)
//:: Modified:
//:://////////////////////////////////////////////

#include "aid_inc_fcns"

#include "te_functions"


void main()
{
    object oPC      = GetLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT);
    DeleteLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT); // Garbage collection

    int bLootFull   = FALSE;

    object oContainer   = GetLocalObject(OBJECT_SELF, "LOOT_CONTAINER");
    if(GetIsObjectValid(oContainer))
    {
        AssignCommand(oPC, ActionInteractObject(oContainer));
        AssignCommand(oPC, DelayCommand(0.3, PlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0, 6.0)));
        bLootFull = TRUE;
    }
    // spawns treasure
    else if(GetLocalInt(OBJECT_SELF, "LOOT"))
    {
        // create loot container
        oContainer  = CreateObject(OBJECT_TYPE_PLACEABLE,"container_invis",GetLocation(OBJECT_SELF));
        SetName(oContainer,GetName(OBJECT_SELF));
        SetDescription(oContainer,GetDescription(OBJECT_SELF));
        SetLocalInt(oContainer,"DESTROY_WHEN_EMPTY", TRUE);
        SetLocalObject(OBJECT_SELF, "LOOT_CONTAINER",oContainer);
        SetLocalObject(oContainer, "PAIRED",OBJECT_SELF);

        AssignCommand(oPC,ActionInteractObject(oContainer));
        AssignCommand(oPC, DelayCommand(0.3, PlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0, 6.0)));
        bLootFull = TRUE;
    }

    // generate description ....................................................
    string sDesc;
    if(bLootFull)
        sDesc   = GetLocalString(OBJECT_SELF, "examine_loot");
    else
        sDesc   = GetLocalString(OBJECT_SELF, "examine_loot_empty");

    if(sDesc!="")
    {
        DelayCommand(0.1, SendMessageToPC(oPC, COLOR_MESSAGE+"Upon close inspection:") );
        DelayCommand(0.11, SendMessageToPC(oPC, "  "+DoColorize(sDesc,TRUE)) );
    }
}
