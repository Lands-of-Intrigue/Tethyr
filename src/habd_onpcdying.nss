// Hemophiliacs Always Bleed to Death
// By Demtrious and OldManWhistler
//
// PLEASE READ "habd_include" FOR MORE INFORMATION.
//
// OnPlayerDying event handler.

#include "habd_include"
#include "subdual_inc"
#include "loi_functions"
#include "te_afflic_func"

// ****************************************************************************

// This function plays a random bleeding VoiceChat on a player.
//   oPC - the player to make play a bleed voice.
void PlayBleedVoice (object oPC);

void PlayBleedVoice (object oPC)
{
    switch (d6())
    {
        case 1: PlayVoiceChat (VOICE_CHAT_PAIN1, oPC); break;
        case 2: PlayVoiceChat (VOICE_CHAT_PAIN2, oPC); break;
        case 3: PlayVoiceChat (VOICE_CHAT_PAIN3, oPC); break;
        case 4: PlayVoiceChat (VOICE_CHAT_HEALME, oPC); break;
        case 5: PlayVoiceChat (VOICE_CHAT_NEARDEATH, oPC); break;
        case 6: PlayVoiceChat (VOICE_CHAT_HELP, oPC); break;
    }
    return;
}

// ****************************************************************************

// Heals players to 1 hp and to removes negative effects. In also calls the
// user defined bleed stabilization function.
//   oPC - the player to heal.
void HealTo1HP(object oPC);

void HealTo1HP(object oPC)
{
    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);
    // If player is already alive then abort.
    if (GetLocalInt(oMod, HABD_PLAYER_STATE+sID) == HABD_STATE_PLAYER_ALIVE) return;
    int iNPC = GetLocalInt(OBJECT_SELF, HABD_NPC_BLEED);

    // Give the player a chance to run away
    if (HABD_POST_BLEED_INVIS_DUR > 0.0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectInvisibility(INVISIBILITY_TYPE_NORMAL), oPC, HABD_POST_BLEED_INVIS_DUR);

    // Raises the player to 1 hp.
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(1 - (GetCurrentHitPoints(oPC))), oPC);
    SetLocalInt(oMod,HABD_PLAYER_STATE+sID, HABD_STATE_PLAYER_ALIVE); //set player state to alive
    // If this is a henchmen, then take them out of the busy state.
    if (iNPC)
    {
        HABDAssociateNotBusy();
    }

    // Keep the player from being attacked, stop nearby attackers
    AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectInvisibility(INVISIBILITY_TYPE_NORMAL), oPC, 6.0));
    // Make the player hostile again.
    SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, GetLocalInt(oPC, HABD_OLD_FACTION), oPC);
    DeleteLocalInt(oPC, HABD_OLD_FACTION_SET);
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 5.0));

    // Notify the player that they were healed.
    DelayCommand(0.5, SendMessageToPC(oPC, "You have healed."));

    // Apply user defined penalties.
    AssignCommand(oPC, HABDUserDefinedBleed());

    //Give a little visual effect for flare.
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPC);

    // If regeneration items were removed then reequip them.
    if (HABD_NERF_REGENERATION_ITEMS)
    {
        AssignCommand(oPC, HABDRegenerationItemsReEquip(oPC));
    }

    // Fixes the inital respawn issue with monsters not reattacking.
    //object oMonster = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPC, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    //DelayCommand(9.0, AssignCommand(oMonster, ActionAttack(oPC)));
}

// ****************************************************************************

// Returns TRUE if the player has stabilized by gaining any HP since the last
// time they bled.
int CheckForStabilization(object oPC);

int CheckForStabilization(object oPC)
{
    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);
    //Section deals with possiblity for healing by other players
    if (GetCurrentHitPoints(oPC) > GetLocalInt(oMod, HABD_LAST_HP+sID))  //if hitpoint have increased
    {
        DelayCommand(1.0, HealTo1HP(oPC));
        return TRUE;
    }
    return FALSE;
}

// ****************************************************************************

// Report the bleed count for OBJECT_SELF.
void ReportPlayerBleed();

void ReportPlayerBleed()
{
    object oPC = OBJECT_SELF;
    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);
    int iHPs = GetCurrentHitPoints(oPC);
    int iNPC = GetLocalInt(OBJECT_SELF, HABD_NPC_BLEED);
    if (iNPC) iHPs = iHPs - 10;

    if (
        (GetLocalInt(oMod, HABD_PLAYER_STATE+sID) != HABD_STATE_PLAYER_BLEEDING) || // check if player is still bleeding
        (iHPs > 0) || // player has healed
        (iHPs <= -25) || // player is a goner, let the death script kick in
        (CheckForStabilization(oPC)) // check if player has gained any HP
        )
    {
        DeleteLocalInt(oPC, HABD_REPORT_BLEED_RUNNING);
        return;
    }
    // The delay will effect how often players are vocal about bleeding.
    DelayCommand(HABDGetBleedTimer(oPC), AssignCommand(oPC, ReportPlayerBleed()));

    // Prevent calling this function multiple times
    SetLocalInt(oPC, HABD_REPORT_BLEED_RUNNING, 1);

    DelayCommand(0.1, FloatingTextStringOnCreature(GetName(oPC)+" is bleeding to death! At "+IntToString(iHPs)+" hitpoints.", oPC));
    if (HABD_DM_NOTIFICATION_ON_BLEED) SendMessageToAllDMs(GetName(oPC)+" is bleeding to death! At "+IntToString(iHPs)+" hitpoints.");
    PlayBleedVoice(oPC);
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 6.0));
}

// ****************************************************************************

// Protect the player from damage while they are at negative HP for OBJECT_SELF.
void ProtectFromDamage(float fSafetyTimer);

void ProtectFromDamage(float fSafetyTimer)
{
    object oPC = OBJECT_SELF;
    SetPlotFlag(oPC, FALSE);
    int iHPs = GetCurrentHitPoints(oPC);
    // pc is bleeding out, so keep them safe
    if (iHPs < 1)
    {
        // get the next timer check ready
        AssignCommand(oPC, DelayCommand(fSafetyTimer, ProtectFromDamage(fSafetyTimer)));
        // make invulnerable until the next check
        SetPlotFlag(oPC, TRUE); 
        // apply Etherial for a second to drop AI agro
        AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEthereal(), oPC, 6.0f));

        // AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSanctuary(1), oPC, fSafetyTimer));
    }
}

// ****************************************************************************

// This function exists to fix the problem that occurs in bleeding scripts
// when the summoned familiar is being possessed by the player (sorc or wiz).
// That creates a condition where GetIsPC returns true for the familiar.
// What usually happens is that when the possessed familiar dies, the player
// is trapped in its body until the DM manually kills the player.
// While stuck in the dead familiar, the player is unable to run the unpossess
// action and the bleed count on the familiar usually does not work properly.

// This function DOES NOT kill the familiar when the player is bleeding if the player
// is not possessing the familiar. The familiar will be able to continue fighting
// for its unconcious and bleeding master.
//   oTarget - the possibly "possessed" player.
int KillPet(object oTarget, int nEffect = TRUE, int nVisualEffectId = VFX_IMP_UNSUMMON);

int KillPet(object oTarget, int nEffect = TRUE, int nVisualEffectId = VFX_IMP_UNSUMMON)
{
    // Usage: place in your bleeding script with a call that looks something like
    // if (KillPet(oPC)) return; // abort from the bleed script, oPC no longer exists

    effect eDeath = EffectDeath(FALSE, FALSE);
    effect eVis = EffectVisualEffect(nVisualEffectId);
    object oCreature = oTarget;
    if(GetIsObjectValid(oCreature))
    {
        object oMaster = GetMaster(oCreature);
        if(GetIsObjectValid(oMaster))
        {
            //Is the creature a summoned associate
            if(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oMaster) == oCreature)
            {
                //Apply the VFX and delay the destruction of the summoned monster so
                //that the script and VFX can play.
                if(nEffect)
                    DelayCommand(0.001,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eVis,GetLocation(oCreature),1.0f));
                SetPlotFlag(oCreature, FALSE);
                DelayCommand(0.002,FloatingTextStringOnCreature(GetName(oMaster)+" HAS LOST FAMILIAR '"+GetName(oCreature)+"'", oCreature));
                if (HABD_DM_NOTIFICATION_ON_BLEED) SendMessageToAllDMs(GetName(oMaster)+" HAS LOST FAMILIAR '"+GetName(oCreature)+"'");
                DelayCommand(0.003, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDeath, oCreature));
                return TRUE;
            }
        }
    }
    return FALSE;
}

// ****************************************************************************

// Applies -1 HP to the player and checks for stabilization.
//   fBleedTimer - the time duration between bleeding -1 HP.
void BleedToDeath(float fBleedTimer)
{
    object oMod = GetModule();
    object oPC = OBJECT_SELF;
    SetPlotFlag(oPC, FALSE); // remove Plot flag, in case it hasn't already been cleared
    string sID = GetPCPlayerName(oPC)+GetName(oPC);
    int iNPC = GetLocalInt(OBJECT_SELF, HABD_NPC_BLEED);
    if (HABD_DEBUG) SpeakString("DEBUG: HABD OnBleed, "+GetName(oPC)+", HP: "+IntToString(GetCurrentHitPoints(oPC))+", master: "+GetName(GetMaster(oPC))+", state:"+HABDGetPlayerStateName(oPC), TALKVOLUME_SHOUT);

    int iPlayerState = GetLocalInt(oMod, HABD_PLAYER_STATE+sID);
    if (iPlayerState != HABD_STATE_PLAYER_BLEEDING) return;
    if (CheckForStabilization(oPC)) return;

    // if you get here - you are dying and have not been healed
    // so you need to roll to see if you stablize
    int nSavingRoll = d100();
    int nConMod = GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
    int nDeathCheck = nSavingRoll + nConMod;
    SendMessageToPC(oPC,"Death Saving Throw (DC90): d100 + Constitution Modifier = "+IntToString(nDeathCheck));

    if (nDeathCheck >= 90)
    {
        SendMessageToPC(oPC,"Succeeded Death Saving Throw!");
        FloatingTextStringOnCreature(GetName(oPC)+" has self-stabilized.", oPC);
        DelayCommand(6.0, HealTo1HP(oPC));
        DelayCommand(6.0, SendMessageToPC(oPC, "In a life or death effort you have survived, alive but barely."));
        return;
    }
    //if you get here, you have not been healed and did not successfully stabilize
    else
    {
        // Most important, keep the bleeding chain going.
        DelayCommand(fBleedTimer, AssignCommand(oPC, BleedToDeath(fBleedTimer)));

        SendMessageToPC(oPC,"Failed Death Saving Throw. You will continue to bleed out.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_COM_CHUNK_RED_BALLISTA),oPC);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamage(1,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_FIVE), oPC);

        // Update local variable with hitpoints for healing option.
        SetLocalInt(oMod,HABD_LAST_HP+sID, GetCurrentHitPoints(oPC));

        // if this is true then the player has died to massive damage
        if (GetCurrentHitPoints(oPC) <= -25)
        {
            SendMessageToPC(oPC,"You have died.");
            // Set up the hostile faction again.
            SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, GetLocalInt(oPC, HABD_OLD_FACTION), oPC);
            DeleteLocalInt(oPC, HABD_OLD_FACTION_SET);
            // Set playerstate to dead not dying
            SetLocalInt(oMod,HABD_PLAYER_STATE+sID, HABD_STATE_PLAYER_DEAD);
            // OnPlayerDead script will be called after this.
            // BleedToDeath will be called one more time, but it will instantly
            // abort because the player is not in the bleeding state.
            return;
        }
    }
}

// ****************************************************************************

// OnPlayerDying event handler.
void main()
{
    if(CheckSubdual(GetLastPlayerDying())) return;

    object oMod = GetModule();
    object oPC = GetLastPlayerDying();
    int iNPC = GetLocalInt(OBJECT_SELF, HABD_NPC_BLEED);
    if (iNPC == 1) oPC = OBJECT_SELF;
    string sID = GetPCPlayerName(oPC)+GetName(oPC);

    if (GetPCAffliction(oPC) == 3 || GetPCAffliction(oPC) == 5 || GetPCAffliction(oPC) == 4 || GetPCAffliction(oPC) == 7 || GetPCAffliction(oPC) == 8)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(20,DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY),oPC);
        return;
    }

    // If an NPC is running this script, then set up its master. The master was
    // automatically wiped out when the henchman died.
    if (iNPC)
    {
        if (!GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetLocalObject(OBJECT_SELF, HABD_NPC_MASTER))))
            AddHenchman(GetLocalObject(OBJECT_SELF, HABD_NPC_MASTER), oPC);
    }

    if (HABD_DEBUG) SpeakString("DEBUG: HABD OnDying, "+GetName(oPC)+", HP: "+IntToString(GetCurrentHitPoints(oPC))+", master: "+GetName(GetMaster(oPC))+", state:"+HABDGetPlayerStateName(oPC), TALKVOLUME_SHOUT);

    // Check if bleeding is running on DM or DM possessed, then abort.
    if(GetIsDM(oPC) || GetIsDM(GetMaster(oPC))) return;

    // whistler: if this is a player in a possessed familiar, then just kill it.
    // Familiar penalties will kick in when familiar dies.
    if (KillPet(oPC)) return;

    int iState = GetLocalInt(oMod,HABD_PLAYER_STATE+sID);
    if ((iState == HABD_STATE_PLAYER_DEAD) || (iState == HABD_STATE_RESPAWNED_GHOST)) return;

    // Most important, issue the commands to start the bleeding chain.
    float fBleedTimer = HABDGetBleedTimer(oPC);
    AssignCommand(oPC, DelayCommand(fBleedTimer, BleedToDeath(fBleedTimer)));
    if (GetLocalInt(oPC, HABD_REPORT_BLEED_RUNNING) == 0) DelayCommand(6.0, AssignCommand(oPC, ReportPlayerBleed()));

    int iHPs = GetCurrentHitPoints(oPC);
    // Force friendly to hostile faction.
    if (!GetLocalInt(oPC, HABD_OLD_FACTION_SET))
    {
        SetLocalInt(oPC, HABD_OLD_FACTION, GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oPC));
        SetLocalInt(oPC, HABD_OLD_FACTION_SET, 1);
    }
    SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 100, oPC);

    // Prevent the player from taking further damage for 1 round
    SetPlotFlag(oPC, TRUE);
    float fSafetyTimer = 12.0;
    AssignCommand(oPC, DelayCommand(fSafetyTimer, ProtectFromDamage(fSafetyTimer)));
    // apply Etherial for a second to drop AI agro
    AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEthereal(), oPC, 6.0f));

    // Allow a good chance for healing - will limit HP to -5 on a bleed level hit.
    if (
        (iHPs<-5) &&
        (iState == HABD_STATE_PLAYER_ALIVE)
        )
    {
        int nHeal = -5 - iHPs;   //should heal player to -5
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHeal), oPC);
    }

    // Set the state variables.
    iHPs = GetCurrentHitPoints(oPC);
    SetLocalInt(oMod,HABD_PLAYER_STATE+sID, HABD_STATE_PLAYER_BLEEDING);
    SetLocalInt(oMod,HABD_LAST_HP+sID, GetCurrentHitPoints(oPC));

    // Check if we are re-entering this state from persistence.
    if (GetLocalInt(oPC, HABD_PERSISTANT_REAPPLY) != 1)
    {
        // Increment the counters.
        SetLocalInt(oMod, HABD_CURRENT_BLEED_COUNT+sID, GetLocalInt(oMod, HABD_CURRENT_BLEED_COUNT+sID) + 1);
        SetLocalInt(oMod, HABD_BLEED_COUNT+sID, GetLocalInt(oMod, HABD_BLEED_COUNT+sID) + 1);
    } else {
        DeleteLocalInt(oPC, HABD_PERSISTANT_REAPPLY);
    }

    // Nerf regeneration items.
    if (HABD_NERF_REGENERATION_ITEMS)
    {
        AssignCommand(oPC, HABDRegenerationItemsUnequip(oPC));
    }

    // Notify that bleeding has started.
    if (iNPC) iHPs = iHPs - 10;
    string sMsg = GetName(oPC)+" is bleeding to death! At "+IntToString(iHPs)+" hitpoints. Will die in "+FloatToString((10 + iHPs)*fBleedTimer, 3, 0)+" seconds.";
    if (HABD_DM_NOTIFICATION_ON_BLEED) SendMessageToAllDMs(sMsg);
    FloatingTextStringOnCreature(sMsg, oPC);
}

