//::///////////////////////////////////////////////
//:: Example XP2 OnItemEquipped
//:: x2_mod_def_unequ
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnUnEquip Event
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified On: April 15th, 2008
//:: Added Support for Mounted Archery Feat penalties
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "x2_inc_intweapon"
#include "x3_inc_horse"

void main()
{
    object oItem = GetPCItemLastUnequipped();
    object oPC   = GetPCItemLastUnequippedBy();
    effect eBad;

    switch(GetBaseItemType(oItem))
    {
        case BASE_ITEM_ARMOR:
            if(GetLocalInt(oPC, "X2_L_CRAFT_MODIFY_MODE") == TRUE) return; //Kick out if crafting
            eBad = GetFirstEffect(oPC);
            while(GetIsEffectValid(eBad)) // This 'while' loop removes the effects of any prior armor,
            {                             // so as not to make the effects cumulative.
                                          // Makes sure any current slowing effects came from armor, and not a spell, etc.
                if(GetEffectCreator(eBad) == GetModule() &&
                   GetEffectType(eBad) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE &&
                   GetEffectSubType(eBad) == SUBTYPE_SUPERNATURAL)
                {
                    RemoveEffect(oPC, eBad);
                }
                eBad = GetNextEffect(oPC);
            }
            break;
        /*/////////////////////////////////////////////////////////////////////////////////////////
        //Everything between the dividers below is just some code I'm leaving in if someone wants//
        //to play with it.  If you don't know what you're doing, you can just delete it or leave //
        //it alone.  It's all commented out so it doesn't do anythign anyway.                    //
        ///////////////////////////////////////////////////////////////////////////////////////////
        case BASE_ITEM_LARGESHIELD:
            FloatingTextStringOnCreature("*Dropping shield*", oPC, TRUE);
            if(GetDroppableFlag(oItem)))
            {
                CopyObject(oItem, GetLocation(oPC));
                DestroyObject(oItem);
            }
            break;

        case BASE_ITEM_SMALLSHIELD:
            FloatingTextStringOnCreature("*Slinging shield*", oPC, TRUE);
            if(GetDroppableFlag(oItem))
            {
                CopyObject(oItem, GetLocation(oPC));
                DestroyObject(oItem);
            }
            break;

        case BASE_ITEM_TOWERSHIELD:
            FloatingTextStringOnCreature("*Dropping shield*", oPC, TRUE);
            if(GetDroppableFlag(oItem))
            {
                CopyObject(oItem, GetLocation(oPC));
                DestroyObject(oItem);
            }
            break;

        case BASE_ITEM_HELMET:
            FloatingTextStringOnCreature("*Removing helm*", oPC, TRUE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eChangingarmor, oPC, 3.0);  //Freeze the PC.
            AssignCommand(oPC, DelayCommand(1.0, ActionDoCommand(ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0))));
            break;
        /////////////////////////////////////////////////////////////////////////////////////////*/

    }
    itemproperty ipLoop=GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(ipLoop))
    {
        if(GetItemPropertyTag(ipLoop) == "MageBreaker")
            RemoveItemProperty(oItem, ipLoop);
        ipLoop=GetNextItemProperty(oItem);
    }
    // -------------------------------------------------------------------------
    //  Intelligent Weapon System
    // -------------------------------------------------------------------------
    if (IPGetIsIntelligentWeapon(oItem))
    {
            IWSetIntelligentWeaponEquipped(oPC,OBJECT_INVALID);
            IWPlayRandomUnequipComment(oPC,oItem);
    }

    // -------------------------------------------------------------------------
    // Mounted benefits control
    // -------------------------------------------------------------------------
    if (GetWeaponRanged(oItem))
    {
        DeleteLocalInt(oPC,"bX3_M_ARCHERY");
        HORSE_SupportAdjustMountedArcheryPenalty(oPC);
    }

    // -------------------------------------------------------------------------
    // Generic Item Script Execution Code
    // If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
    // it will execute a script that has the same name as the item's tag
    // inside this script you can manage scripts for all events by checking against
    // GetUserDefinedItemEventNumber(). See x2_it_example.nss
    // -------------------------------------------------------------------------
    if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
    {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_UNEQUIP);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }
    }
}
