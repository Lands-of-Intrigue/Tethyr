//::///////////////////////////////////////////////
//:: Default On Attacked
//:: NW_C2_DEFAULT5
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If already fighting then ignore, else determine
    combat round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified On: Jan 4th, 2008
//:: Added Support for Mounted Combat Feat Support
//:://////////////////////////////////////////////
//:: Modified: henesua (2016 jan 1) hooks to combat XP

#include "nw_i0_generic"

#include "te_functions"

void main()
{
    object oAttacker = GetLastAttacker();

    // henesua - flag attacker as a combatant with self and timestamp for combat xp tracking
    if(GetIsPC(oAttacker))
        SetLocalInt(OBJECT_SELF, "COMBATANT_"+ObjectToString(oAttacker), GetTimeCumulative());
    else if(GetAssociateType(oAttacker)!=ASSOCIATE_TYPE_NONE)
        SetLocalInt(OBJECT_SELF, "COMBATANT_"+ObjectToString(GetMaster(oAttacker)), GetTimeCumulative());

    if(!GetLocalInt(GetModule(),"X3_NO_MOUNTED_COMBAT_FEAT"))
    { // set variables on target for mounted combat
        SetLocalInt(OBJECT_SELF,"bX3_LAST_ATTACK_PHYSICAL",TRUE);
        SetLocalInt(OBJECT_SELF,"nX3_HP_BEFORE",GetCurrentHitPoints(OBJECT_SELF));
    } // set variables on target for mounted combat

    if(GetFleeToExit())
    {
        // Run away!
        ActivateFleeToExit();
    }
    else if (GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
        // We give an attacker one warning before we attack
        // This is not fully implemented yet
        SetSpawnInCondition(NW_FLAG_SET_WARNINGS, FALSE);

        //Put a check in to see if this attacker was the last attacker
        //Possibly change the GetNPCWarning function to make the check
    }
    else
    {

        if (!GetIsObjectValid(oAttacker))
        {
            // Don't do anything, invalid attacker

        }
        else if (!GetIsFighting(OBJECT_SELF))
        {
            // henesua - exit stealth when attacked
            if(GetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH))
                SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, FALSE);
            if(GetActionMode(OBJECT_SELF, ACTION_MODE_DETECT))
                SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, FALSE);

            // good location to check for subdual and alter shouts
            // subdual damage?
            if(     GetLocalInt(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oAttacker),"WEAPON_NONLETHAL")
                ||  GetLocalInt(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oAttacker),"WEAPON_NONLETHAL")
                ||  GetLocalInt(oAttacker,"COMBAT_NONLETHAL")// subdual mode
              )
            {
                //Shout that I was attacked
                SpeakString(SHOUT_SUBDUAL_ATTACK, TALKVOLUME_SILENT_TALK);

                if(CreatureGetIsCivilized())
                {
                    if(!GetLocalInt(OBJECT_SELF,"COMBAT_NONLETHAL"))
                    {
                        SetLocalInt(OBJECT_SELF,"COMBAT_NONLETHAL",TRUE);
                        DelayCommand(60.0,DeleteLocalInt(OBJECT_SELF,"COMBAT_NONLETHAL"));
                    }
                }

            }
            else
            {
                //Shout Attack my target, only works with the On Spawn In setup
                SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
                //Shout that I was attacked
                SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
            }

            // We're not fighting anyone else, so start fighting the attacker
            SetSummonHelpIfAttacked();

            // We're not fighting anyone else, so start fighting the attacker
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
                DetermineSpecialBehavior(oAttacker);
            else //if(GetArea(oAttacker) == GetArea(OBJECT_SELF))
                DetermineCombatRound(oAttacker);

        }
    }


    if(GetSpawnInCondition(NW_FLAG_ATTACK_EVENT))
    {
        SetLocalObject(OBJECT_SELF, "ATTACKED", oAttacker);
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_ATTACKED));
    }
}
