// Hemophiliacs Always Bleed to Death
// By Demtrious and OldManWhistler
//
// PLEASE READ "habd_include" FOR MORE INFORMATION.
//
// OnPlayerRespawn event handler.

#include "habd_include"

// Change this value if it is causing server lag.
const float GHOST_LOOP_TIMER = 6.0f;

// ****************************************************************************

// This function acts as a player heartbeat while the player is under the
// "respawn effect".
//   oOldFollow - is the last object the player was told to follow.

void Ghost(object oOldFollow = OBJECT_INVALID)
{
    object oMod = GetModule();
    object oPC = OBJECT_SELF;
    string sID = GetPCPlayerName(oPC)+GetName(oPC);

    if (HABD_DEBUG) SpeakString("DEBUG: HABD OnGhostHB, "+GetName(oPC)+", PlotFlag:"+IntToString(GetPlotFlag(OBJECT_SELF))+", CommandableFlag:"+IntToString(GetCommandable())+", HP: "+IntToString(GetCurrentHitPoints(oPC))+", master: "+GetName(GetMaster(oPC))+", state:"+HABDGetPlayerStateName(oPC), TALKVOLUME_SHOUT);

    if (
        (GetPlotFlag(OBJECT_SELF)) &&
        (GetLocalInt(oMod, HABD_PLAYER_STATE+sID) == HABD_STATE_RESPAWNED_GHOST)
        )
    {
        // Is there someone to follow?
        object oFollow = GetLocalObject(oPC, HABD_GHOST_AUTOFOLLOW);
        HABDAssociateBusy();
        SetCommandable(TRUE);
        // Most important, schedule the next iteration of the heartbeat.
        DelayCommand(GHOST_LOOP_TIMER, Ghost(oFollow));
        if (GetIsObjectValid(oFollow))
        {
            if (oFollow != oOldFollow) FloatingTextStringOnCreature(GetName(OBJECT_SELF)+" is now following "+ GetName(oFollow), oPC, TRUE);
            if (GetArea(OBJECT_SELF) != GetArea(oFollow))
            {
                SendMessageToPC(oPC, "Jumping to "+GetName(oFollow));
                // Not in same area, jump them there
                ClearAllActions();
                ActionJumpToObject(oFollow);
            } else {
                // In same area, move them there
                ClearAllActions();
                DelayCommand(0.5, ActionForceFollowObject(oFollow, 6.0f));
            }
        }
        // Remove their ability to control themselves
        SetCommandable(FALSE);
    } else {
        // Respawn state has been removed. Restore the player to normal.
        SetCommandable(TRUE);
        //SetPlotFlag(OBJECT_SELF, FALSE);
        // Set playerstate to alive.
        SetLocalInt(oMod, HABD_PLAYER_STATE+sID, HABD_STATE_PLAYER_ALIVE);
        FloatingTextStringOnCreature("OOC: You shake off the ghostly effects.", OBJECT_SELF, FALSE);
        // Restore the player's reputation with HOSTILE faction.
        SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, GetLocalInt(oPC, HABD_OLD_FACTION), oPC);
        DeleteLocalInt(oPC, HABD_OLD_FACTION_SET);
        effect eEffect = GetFirstEffect(OBJECT_SELF);
        while(GetIsEffectValid(eEffect))
        {
            // They are rezzed, remove sanctuary visual effects.
            if (GetEffectType(eEffect) == EFFECT_TYPE_CONCEALMENT)
            {
                RemoveEffect(OBJECT_SELF, eEffect);
            }
            eEffect = GetNextEffect(OBJECT_SELF);
        }
        HABDAssociateNotBusy();
        AssignCommand(OBJECT_SELF, ClearAllActions());
        // Fixes the inital respawn issue with monsters not reattacking.
        object oMonster = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY,oPC, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
        DelayCommand(9.0, AssignCommand(oMonster, ActionAttack(oPC)));
    }
}

// ****************************************************************************

// OnPlayerRespawn event handler.

void main()
{
    // Check to see if the system is supposed to run this script, otherwise
    // it may be configured improperly.
    if (HABD_RESPAWN_SCRIPT != "habd_onpcrespawn")
    {
        ExecuteScript(HABD_RESPAWN_SCRIPT, OBJECT_SELF);
        return;
    }

    object oPC;
    // Catch if the script was forced to executed.
    if (GetLocalInt(OBJECT_SELF, HABD_FORCED_RESPAWN) == 1)
    {
        oPC = OBJECT_SELF;
        HABDAssociateBusy();
    } else {
        oPC = GetLastRespawnButtonPresser();
    }
    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);

    if (HABD_DEBUG) SpeakString("DEBUG: HABD OnRespawn, "+GetName(oPC)+", HP: "+IntToString(GetCurrentHitPoints(oPC))+", master: "+GetName(GetMaster(oPC))+", state:"+HABDGetPlayerStateName(oPC), TALKVOLUME_SHOUT);

    // Set the player state to respawn.
    SetLocalInt(oMod, HABD_PLAYER_STATE+sID, HABD_STATE_RESPAWNED_GHOST); //set playerstate to DM raised.

    // Make it look like something happened.
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DOOM), oPC);
    // Raise the player.
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);

    // Most important, schedule the ghost heartbeat.
    AssignCommand(oPC, DelayCommand(3.0, Ghost()));

    // If they have a master, set up the master as the autofollow.
    if (GetIsObjectValid(GetMaster(oPC))) SetLocalObject(oPC, HABD_GHOST_AUTOFOLLOW, GetMaster(oPC));
    else
    {
        // Remove any old autofollow objects.
        DeleteLocalObject(oPC, HABD_GHOST_AUTOFOLLOW);
    }

    // Apply the user defined effects.
    AssignCommand(oPC, HABDUserDefinedRespawn());

    // Check if we are re-entering this state from persistence.
    if (GetLocalInt(oPC, HABD_PERSISTANT_REAPPLY) != 1)
    {
        // Apply the respawn penalty.
        HABDApplyPenalty(oPC, HABD_RESPAWN_XP_LOSS, HABD_RESPAWN_GP_LOSS);
    } else {
        DeleteLocalInt(oPC, HABD_PERSISTANT_REAPPLY);
    }

    // Make them invulnerable
    // SetPlotFlag(oPC, TRUE);

    // Apply effects to make them a ghost.
    // Don't set the concealment too high just incase they find a way to abuse the system.
    effect eBad = EffectConcealment(1);
    eBad = EffectLinkEffects(EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR), eBad);
    eBad = EffectLinkEffects(EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE), eBad);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBad, oPC);

    FloatingTextStringOnCreature("OOC: You are a ghost. Do not interact with the other players.", oPC, FALSE);
    SetCommandable(FALSE, oPC);
}

