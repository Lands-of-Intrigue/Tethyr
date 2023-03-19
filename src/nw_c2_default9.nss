//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT9
/*
 * Default OnSpawn handler with XP1 revisions.
 * This corresponds to and produces the same results
 * as the default OnSpawn handler in the OC.
 *
 * This can be used to customize creature behavior in three main ways:
 *
 * - Uncomment the existing lines of code to activate certain
 *   common desired behaviors from the moment when the creature
 *   spawns in.
 *
 * - Uncomment the user-defined event signals to cause the
 *   creature to fire events that you can then handle with
 *   a custom OnUserDefined event handler script.
 *
 * - Add new code _at the end_ to alter the initial
 *   behavior in a more customized way.
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/11/2002
//:://////////////////////////////////////////////////
//:: Updated 2003-08-20 Georg Zoeller: Added check for variables to active spawn in conditions without changing the spawnscript


#include "x0_i0_anims"
// #include "x0_i0_walkway" - in x0_i0_anims
#include "x0_i0_treasure"

#include "x2_inc_switches"

// meaglyn
#include "aww_inc_walkway"

#include "te_functions"

void main()
{
    if(GetIsInCombat(OBJECT_SELF) != TRUE)
    {
        object oArea = GetArea(OBJECT_SELF);
        object oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,OBJECT_SELF);
        object oTorchEquip;
        int    nTorch;

        if((GetIsAreaInterior(oArea) && !GetIsAreaAboveGround(oArea)) || (!GetIsAreaInterior(oArea) && GetIsNight()))
        {
            if(GetBaseItemType(oTorch) == BASE_ITEM_TORCH)
            {}
            else
            {
                oTorchEquip = GetFirstItemInInventory(OBJECT_SELF);
                while (GetIsObjectValid(oTorchEquip) == TRUE)
                {
                    if(GetBaseItemType(oTorchEquip) == BASE_ITEM_TORCH)
                    {
                        ActionEquipItem(oTorchEquip,INVENTORY_SLOT_LEFTHAND);
                        break;
                    }

                    oTorchEquip = GetNextItemInInventory(OBJECT_SELF);
                }
            }
        }
        else
        {
            if(GetBaseItemType(oTorch) == BASE_ITEM_TORCH)
            {
                ActionUnequipItem(oTorch);
            }
        }
    }


    // ***** Spawn-In Conditions ***** //

    // * REMOVE COMMENTS (// ) before the "Set..." functions to activate
    // * them. Do NOT touch lines commented out with // *, those are
    // * real comments for information.

    // * This causes the creature to say a one-line greeting in their
    // * conversation file upon perceiving the player. Put [NW_D2_GenCheck]
    // * in the "Text Seen When" field of the greeting in the conversation
    // * file. Don't attach any player responses.
    // *
    // SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION);

    // * Same as above, but for hostile creatures to make them say
    // * a line before attacking.
    // *
    // SetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION);

    // * This NPC will attack when its allies call for help
    // *
    // SetSpawnInCondition(NW_FLAG_SHOUT_ATTACK_MY_TARGET);

    // * If the NPC has the Hide skill they will go into stealth mode
    // * while doing WalkWayPoints().
    // *
    // SetSpawnInCondition(NW_FLAG_STEALTH);

    //--------------------------------------------------------------------------
    // Enable stealth mode by setting a variable on the creature
    // Great for ambushes
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (GetLocalInt(OBJECT_SELF, "X2_L_SPAWN_USE_STEALTH"))
    {
        SetSpawnInCondition(NW_FLAG_STEALTH);
        SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, TRUE);
    }
    // * Same, but for Search mode
    // *
    // SetSpawnInCondition(NW_FLAG_SEARCH);

    //--------------------------------------------------------------------------
    // Make creature enter search mode after spawning by setting a variable
    // Great for guards, etc
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (GetLocalInt(OBJECT_SELF, "X2_L_SPAWN_USE_SEARCH"))
    {
        SetSpawnInCondition(NW_FLAG_SEARCH);
        SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, TRUE);
    }
    // * This will set the NPC to give a warning to non-enemies
    // * before attacking.
    // * NN -- no clue what this really does yet
    // *
    // SetSpawnInCondition(NW_FLAG_SET_WARNINGS);

    // * Separate the NPC's waypoints into day & night.
    // * See comment on WalkWayPoints() for use.
    // *
    SetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING);

    // * If this is set, the NPC will appear using the "EffectAppear"
    // * animation instead of fading in, *IF* SetListeningPatterns()
    // * is called below.
    // *
    //SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);

    // * This will cause an NPC to use common animations it possesses,
    // * and use social ones to any other nearby friendly NPCs.
    // *
    // SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);

    //--------------------------------------------------------------------------
    // Enable immobile ambient animations by setting a variable
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (    GetLocalInt(OBJECT_SELF,"ANIMATION_IMMOBILE_AMBIENT")
        ||  GetLocalInt(OBJECT_SELF, "X2_L_SPAWN_USE_AMBIENT_IMMOBILE")
        )
        SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);

    // * Same as above, except NPC will wander randomly around the
    // * area.
    // *
    SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);


    //--------------------------------------------------------------------------
    // Enable mobile ambient animations by setting a variable
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    /*
    if (GetLocalInt(OBJECT_SELF, "X2_L_SPAWN_USE_AMBIENT"))
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
    */
    // **** Animation Conditions **** //
    // * These are extra conditions you can put on creatures with ambient
    // * animations.

    // * Civilized creatures interact with placeables in
    // * their area that have the tag "NW_INTERACTIVE"
    // * and "talk" to each other.
    // *
    // * Humanoid races are civilized by default, so only
    // * set this flag for monster races that you want to
    // * behave the same way.
    // SetAnimationCondition(NW_ANIM_FLAG_IS_CIVILIZED);

    // * If this flag is set, this creature will constantly
    // * be acting. Otherwise, creatures will only start
    // * performing their ambient animations when they
    // * first perceive a player, and they will stop when
    // * the player moves away.
    // SetAnimationCondition(NW_ANIM_FLAG_CONSTANT);

    // * Civilized creatures with this flag set will
    // * randomly use a few voicechats. It's a good
    // * idea to avoid putting this on multiple
    // * creatures using the same voiceset.
    // SetAnimationCondition(NW_ANIM_FLAG_CHATTER);

    // * Creatures with _immobile_ ambient animations
    // * can have this flag set to make them mobile in a
    // * close range. They will never leave their immediate
    // * area, but will move around in it, frequently
    // * returning to their starting point.
    // *
    // * Note that creatures spawned inside interior areas
    // * that contain a waypoint with one of the tags
    // * "NW_HOME", "NW_TAVERN", "NW_SHOP" will automatically
    // * have this condition set.
    // SetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE);


    // **** Special Combat Tactics *****//
    // * These are special flags that can be set on creatures to
    // * make them follow certain specialized combat tactics.
    // * NOTE: ONLY ONE OF THESE SHOULD BE SET ON A SINGLE CREATURE.

    // * Ranged attacker
    // * Will attempt to stay at ranged distance from their
    // * target.
    // SetCombatCondition(X0_COMBAT_FLAG_RANGED);

    // * Defensive attacker
    // * Will use defensive combat feats and parry
    // SetCombatCondition(X0_COMBAT_FLAG_DEFENSIVE);

    // * Ambusher
    // * Will go stealthy/invisible and attack, then
    // * run away and try to go stealthy again before
    // * attacking anew.
    // SetCombatCondition(X0_COMBAT_FLAG_AMBUSHER);

    // * Cowardly
    // * Cowardly creatures will attempt to flee
    // * attackers.
    // SetCombatCondition(X0_COMBAT_FLAG_COWARDLY);


    // **** Escape Commands ***** //
    // * NOTE: ONLY ONE OF THE FOLLOWING SHOULD EVER BE SET AT ONE TIME.
    // * NOTE2: Not clear that these actually work. -- NN

    // * Flee to a way point and return a short time later.
    // *
    // SetSpawnInCondition(NW_FLAG_ESCAPE_RETURN);

    // * Flee to a way point and do not return.
    // *
    // SetSpawnInCondition(NW_FLAG_ESCAPE_LEAVE);

    // * Teleport to safety and do not return.
    // *
    // SetSpawnInCondition(NW_FLAG_TELEPORT_LEAVE);

    // * Teleport to safety and return a short time later.
    // *
    // SetSpawnInCondition(NW_FLAG_TELEPORT_RETURN);



    // ***** CUSTOM USER DEFINED EVENTS ***** /
    // * EVENT_BLOCKED
    // SetLocalInt(OBJECT_SELF, "USERDEF_BLOCKED", TRUE);

    // * 1001 - EVENT_HEARTBEAT
        if(GetLocalString(OBJECT_SELF, "USERDEF_HEARTBEAT")!="")
            SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
    // * 1002 - EVENT_PERCEIVE
        if(GetLocalString(OBJECT_SELF, "USERDEF_PERCEIVE")!="")
            SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);
    // * 1005 - EVENT_ATTACKED
        if(GetLocalString(OBJECT_SELF, "USERDEF_ATTACKED")!="")
            SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);

    /*
    // * 1003 - EVENT_END_COMBAT_ROUND
        if(GetLocalInt(OBJECT_SELF, "USERDEF_COMBAT"))
            SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT);
    // * 1004 - EVENT_DIALOGUE
        if(GetLocalInt(OBJECT_SELF, "USERDEF_DIALOGUE"))
            SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);
    // * 1006 - EVENT_DAMAGED
        if(GetLocalInt(OBJECT_SELF, "USERDEF_DAMAGED"))
            SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);
    // * 1008 - EVENT_DISTURBED
        if(GetLocalInt(OBJECT_SELF, "USERDEF_DISTURBED"))
            SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);
    // * EVENT_SPELL_CAST_AT
        if(GetLocalInt(OBJECT_SELF, "USERDEF_SPELLCAST"))
            SetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT);
    // * EVENT_RESTED
        if(GetLocalInt(OBJECT_SELF, "USERDEF_REST"))
            SetSpawnInCondition(NW_FLAG_RESTED_EVENT);
    */



    // ***** DEFAULT GENERIC BEHAVIOR (DO NOT TOUCH) ***** //

    // * Goes through and sets up which shouts the NPC will listen to.
    // *
    SetListeningPatterns();

    // HENESUA - additional listening patterns for AI
    CreatureSetCommonListeningPatterns();

    // * Walk among a set of waypoints.
    // * 1. Find waypoints with the tag "WP_" + NPC TAG + "_##" and walk
    // *    among them in order.
    // * 2. If the tag of the Way Point is "POST_" + NPC TAG, stay there
    // *    and return to it after combat.
    //
    // * Optional Parameters:
    // * void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)
    //
    // * If "NW_FLAG_DAY_NIGHT_POSTING" is set above, you can also
    // * create waypoints with the tags "WN_" + NPC Tag + "_##"
    // * and those will be walked at night. (The standard waypoints
    // * will be walked during the day.)
    // * The night "posting" waypoint tag is simply "NIGHT_" + NPC tag.
    // original
    //WalkWayPoints();

    // meaglyn
    if(!GetLocalInt(OBJECT_SELF, "AI_NOT_WALKER"))    // henesua - I added this as a means to turn this off
        SetWalkCondition(NW_WALK_FLAG_CONSTANT);
    aww_WalkWayPoints(FALSE, 0.5);


    /*
    // Create a small amount of treasure on the creature
    if ((GetLocalInt(GetModule(), "X2_L_NOTREASURE") == FALSE)  &&
        (GetLocalInt(OBJECT_SELF, "X2_L_NOTREASURE") == FALSE)   )
    {
        CTG_GenerateNPCTreasure(TREASURE_TYPE_MONSTER, OBJECT_SELF);
    }
    */

    // ***** ADD ANY SPECIAL ON-SPAWN CODE HERE ***** //


    // social NPCs shouldn't have wayfinding issues. allow them to move about in crowds.
    if(     GetLocalInt(OBJECT_SELF,"SPAWN_EFFECT_GHOST")
        ||  GetPhenoType(OBJECT_SELF)==40
        ||  GetLocalInt(OBJECT_SELF,"X2_L_IS_INCORPOREAL") == 1
      )
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(),OBJECT_SELF);
    }


    // Name
    SpawnInitializeName();


    // Random appearance -----------------
    if(GetLocalInt(OBJECT_SELF,"APPEARANCE_TYPE"))
        DelayCommand(0.1,ExecuteScript("_npc_rnd_apear",OBJECT_SELF));
    if(GetLocalInt(OBJECT_SELF,"EQUIPMENT_TYPE"))
        DelayCommand(0.2,ExecuteScript("_npc_rnd_equip",OBJECT_SELF));
}

