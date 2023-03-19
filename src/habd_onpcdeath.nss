// Hemophiliacs Always Bleed to Death
// By Demtrious and OldManWhistler
//
// PLEASE READ "habd_include" FOR MORE INFORMATION.
//
// OnPlayerDeath event handler.

#include "habd_include"

// ****************************************************************************

// This function is used to create a pseudo-heartbeat on the death bag placeable
// that contains all of the dropped items on player death.
void DeathBagHeartbeat ();

void DeathBagHeartbeat ()
{
    if (GetIsObjectValid(GetFirstItemInInventory()))
    {
        // Set up timer.
        DelayCommand(HABD_BAG_SELF_DESTRUCT_TIMER, DeathBagHeartbeat());
        // Try to alert the owner.
        object oPC = GetLocalObject(OBJECT_SELF, HABD_BAG_OWNER);
        if (GetIsObjectValid(oPC))
        {
            if (GetLocalInt(OBJECT_SELF, HABD_NPC_BLEED) == 1) FloatingTextStringOnCreature("OOC: Your henchman/companion still has items in its death bag.", GetMaster(oPC), FALSE);
            else FloatingTextStringOnCreature("OOC: You still have items in your death bag.", oPC, FALSE);
        } else {
            // No valid owner, so destroy the variable.
            DeleteLocalObject(OBJECT_SELF, HABD_BAG_OWNER);
        }
    } else {
        // No valid items left inside, so self-destruct.
        SetPlotFlag(OBJECT_SELF, FALSE);
        DestroyObject(OBJECT_SELF);
    }
}

// ****************************************************************************

// Creates a placeable object and drops all the items into it based on the
// configured options.
//   oPC - the dead player who is losing their items.
void DropItems (object oPC);

void DropItems (object oPC)
{
    object oItem;
    // Check that something is configured to drop.
    if ((HABD_DROP_GOLD == 0) &&
        (HABD_DROP_RAISE_REZ == 0) &&
        (HABD_DROP_BACKPACK == 0) &&
        (HABD_DROP_WEAPON_SHIELD == 0) &&
        (HABD_DROP_EQUIPPED == 0) &&
        (HABD_DROP_RANDOM_EQUIPPED == 0) &&
        (HABD_DROP_RANDOM_BACKPACK == 0) &&
        (HABD_DROP_MOST_EXPENSIVE_EQUIPPED == 0) &&
        (HABD_DROP_MOST_EXPENSIVE_BACKPACK == 0)
       ) return;

    object oBag;

    // Only build the placeable if something is configured to drop.
    if ((HABD_DROP_GOLD == 1) ||
        (HABD_DROP_RAISE_REZ == 1) ||
        (HABD_DROP_BACKPACK == 1) ||
        (HABD_DROP_WEAPON_SHIELD == 1) ||
        (HABD_DROP_EQUIPPED == 1) ||
        (HABD_DROP_RANDOM_EQUIPPED == 1) ||
        (HABD_DROP_RANDOM_BACKPACK == 1) ||
        (HABD_DROP_MOST_EXPENSIVE_EQUIPPED == 1) ||
        (HABD_DROP_MOST_EXPENSIVE_BACKPACK == 1)
       )
    {
        // Create the bag and set up a heartbeat on it.
        oBag = CreateObject(OBJECT_TYPE_PLACEABLE, HABD_PLACEABLE_BAG, GetLocation(oPC), TRUE);
        // Sanity test.
        if (!GetIsObjectValid(oBag)) return;
        SetLocalObject(oBag, HABD_BAG_OWNER, oPC);
        AssignCommand(oBag, DelayCommand(HABD_BAG_SELF_DESTRUCT_TIMER, DeathBagHeartbeat()));
    }

    // Should we drop all gold?
    if (HABD_DROP_GOLD != 0)
    {
        if (HABD_DROP_GOLD == 2) SendMessageToPC(oPC, "Destroying all gold.");
        else SendMessageToPC(oPC, "Dropping all gold.");
        if (HABD_DROP_GOLD == 2) TakeGoldFromCreature(GetGold(oPC), oPC, TRUE);
        else AssignCommand(oBag, TakeGoldFromCreature(GetGold(oPC), oPC));
    }
    // Should we only drop the right hand and left hand equipped items that aren't plot?
    if (HABD_DROP_WEAPON_SHIELD != 0)
    {
        if (HABD_DROP_WEAPON_SHIELD == 2) SendMessageToPC(oPC, "Destroying equipped weapon and shield.");
        else SendMessageToPC(oPC, "Dropping equipped weapon and shield.");
        oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
        if (GetIsObjectValid(oItem) && (!GetPlotFlag(oItem)))
        {
            if (HABD_DROP_WEAPON_SHIELD == 2) DestroyObject(oItem);
            else AssignCommand(oBag, ActionTakeItem(oItem, oPC));
        }
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
        if (GetIsObjectValid(oItem) && (!GetPlotFlag(oItem)))
        {
            if (HABD_DROP_WEAPON_SHIELD == 2) DestroyObject(oItem);
            else AssignCommand(oBag, ActionTakeItem(oItem, oPC));
        }
    }
    // Should we drop a random equipped item?
    if ((HABD_DROP_RANDOM_EQUIPPED != 0) || (HABD_DROP_MOST_EXPENSIVE_EQUIPPED != 0 ))
    {
        int iRandomEquipped;
        int i;
        int iRandomCount = 0;
        int iGP = 0;
        int iHighestGP = 0;
        int iHighestGPPos = 0;
        if (HABD_DROP_RANDOM_EQUIPPED == 2) SendMessageToPC(oPC, "Destroying a random equipped items.");
        else if (HABD_DROP_RANDOM_EQUIPPED == 1) SendMessageToPC(oPC, "Dropping a random equipped items.");
        if (HABD_DROP_MOST_EXPENSIVE_EQUIPPED == 2) SendMessageToPC(oPC, "Destroying most expensive equipped items.");
        else if (HABD_DROP_MOST_EXPENSIVE_EQUIPPED == 1) SendMessageToPC(oPC, "Dropping most expensive equipped items.");
        // Find the random item.
        for (i=0; i<NUM_INVENTORY_SLOTS; i++)
        {
            oItem = GetItemInSlot(i, oPC);
            if (GetIsObjectValid(oItem) && (!GetPlotFlag(oItem)))
            {
                iRandomCount++;
                if (HABD_DROP_MOST_EXPENSIVE_EQUIPPED != 0)
                {
                    // Increment the number of random items and check
                    // for the highest GP item.
                    iGP = GetGoldPieceValue(oItem);
                    if (iGP > iHighestGP)
                    {
                        iHighestGP = iGP;
                        iHighestGPPos = iRandomCount;
                    }
                }
            }
        }
        iRandomEquipped = Random(iRandomCount)+1;
        iRandomCount = 0;
        // Drop the item.
        for (i=0; i<NUM_INVENTORY_SLOTS; i++)
        {
            oItem = GetItemInSlot(i, oPC);
            if (GetIsObjectValid(oItem) && (!GetPlotFlag(oItem)))
            {
                iRandomCount++;
                // If this is the random item then drop it.
                if ((HABD_DROP_RANDOM_EQUIPPED != 0) && (iRandomCount == iRandomEquipped))
                {
                    if (HABD_DROP_RANDOM_EQUIPPED == 2) DestroyObject(oItem);
                    else AssignCommand(oBag, ActionTakeItem(oItem, oPC));
                }
                // If this is the most expensive item then drop it.
                if ((HABD_DROP_MOST_EXPENSIVE_EQUIPPED != 0) && (iRandomCount == iHighestGPPos))
                {
                    if (HABD_DROP_MOST_EXPENSIVE_EQUIPPED == 2) DestroyObject(oItem);
                    else AssignCommand(oBag, ActionTakeItem(oItem, oPC));
                }
            }
        }
    }
    // Should we drop all equiped items that aren't plot?
    if (HABD_DROP_EQUIPPED != 0)
    {
        int i;
        if (HABD_DROP_EQUIPPED == 2) SendMessageToPC(oPC, "Destroying all equipped items.");
        else SendMessageToPC(oPC, "Dropping all equipped items.");
        for (i=0; i<NUM_INVENTORY_SLOTS; i++)
        {
            oItem = GetItemInSlot(i, oPC);
            if (GetIsObjectValid(oItem) && (!GetPlotFlag(oItem)))
            {
                if (HABD_DROP_EQUIPPED == 2) DestroyObject(oItem);
                else AssignCommand(oBag, ActionTakeItem(oItem, oPC));
            }
        }
    }

    // Should we only drop raise/rez scrolls in inventory?
    if ((HABD_DROP_RAISE_REZ != 0) && (!HABD_FORCE_RAISE_USES_SCROLLS))
    {
        if (HABD_DROP_RAISE_REZ == 2) SendMessageToPC(oPC, "Destroying all Raise Dead/Resurrection scrolls.");
        else SendMessageToPC(oPC, "Dropping all Raise Dead/Resurrection scrolls.");
        int iBaseItemType;
        oItem = GetFirstItemInInventory(oPC);
        while (GetIsObjectValid(oItem))
        {
            // Search through the scrolls
            iBaseItemType = GetBaseItemType(oItem);
            if ((iBaseItemType == BASE_ITEM_SCROLL) ||
                (iBaseItemType == BASE_ITEM_SPELLSCROLL))
            {
                // Default scrolls cannot be made plot so don't worry about it.
                // See if it matches the tags we are looking for.
                if (FindSubString(HABD_SCROLL_TAGS, ":"+GetTag(oItem)+":") != -1)
                {
                    if (HABD_DROP_RAISE_REZ == 2) DestroyObject(oItem);
                    else AssignCommand(oBag, ActionTakeItem(oItem, oPC));
                }
            }
            oItem = GetNextItemInInventory(oPC);
        }
    }
    // Should we drop a random backpack item?
    if ((HABD_DROP_RANDOM_BACKPACK != 0) || (HABD_DROP_MOST_EXPENSIVE_BACKPACK != 0))
    {
        int iRandomBackpack;
        int iGP = 0;
        int iHighestGP = 0;
        int iHighestGPPos = 0;
        if (HABD_DROP_RANDOM_BACKPACK == 2) SendMessageToPC(oPC, "Destroying a random backpack item.");
        else if (HABD_DROP_RANDOM_BACKPACK == 1) SendMessageToPC(oPC, "Dropping a random backpack item.");
        if (HABD_DROP_MOST_EXPENSIVE_BACKPACK == 2) SendMessageToPC(oPC, "Destroying most expensive backpack item.");
        else if (HABD_DROP_MOST_EXPENSIVE_BACKPACK == 1) SendMessageToPC(oPC, "Dropping most expensive backpack item.");
        int iRandomCount = 0;
        int iBaseItemType;
        // Find the random item.
        oItem = GetFirstItemInInventory(oPC);
        while (GetIsObjectValid(oItem))
        {
            if (HABD_FORCE_RAISE_USES_SCROLLS)
            {
                // Search through the scrolls and skill the raise/rez scrolls
                iBaseItemType = GetBaseItemType(oItem);
                if ((iBaseItemType == BASE_ITEM_SCROLL) ||
                    (iBaseItemType == BASE_ITEM_SPELLSCROLL))
                {
                    // Default scrolls cannot be made plot so don't worry about it.
                    // See if it matches the tags we are looking for.
                    if (FindSubString(HABD_SCROLL_TAGS, ":"+GetTag(oItem)+":") == -1)
                    {
                        // Increment the number of random items and check
                        // for the highest GP item.
                        iRandomCount++;
                        if (HABD_DROP_MOST_EXPENSIVE_BACKPACK != 0)
                        {
                            iGP = GetGoldPieceValue(oItem);
                            if (iGP > iHighestGP)
                            {
                                iHighestGP = iGP;
                                iHighestGPPos = iRandomCount;
                            }
                        }
                    }
                } else {
                    // Increment the number of random items and check
                    // for the highest GP item.
                    iRandomCount++;
                    if (HABD_DROP_MOST_EXPENSIVE_BACKPACK != 0)
                    {
                        iGP = GetGoldPieceValue(oItem);
                        if (iGP > iHighestGP)
                        {
                            iHighestGP = iGP;
                            iHighestGPPos = iRandomCount;
                        }
                    }
                }
            }
            oItem = GetNextItemInInventory(oPC);
        }
        iRandomBackpack = Random(iRandomCount)+1;
        iRandomCount = 0;
        // Drop the random item.
        // Find the random item.
        oItem = GetFirstItemInInventory(oPC);
        while (GetIsObjectValid(oItem))
        {
            if (HABD_FORCE_RAISE_USES_SCROLLS)
            {
                // Search through the scrolls and skill the raise/rez scrolls
                iBaseItemType = GetBaseItemType(oItem);
                if ((iBaseItemType == BASE_ITEM_SCROLL) ||
                    (iBaseItemType == BASE_ITEM_SPELLSCROLL))
                {
                    // Default scrolls cannot be made plot so don't worry about it.
                    // See if it matches the tags we are looking for.
                    if (FindSubString(HABD_SCROLL_TAGS, ":"+GetTag(oItem)+":") == -1)
                    {
                        iRandomCount++;
                        // If this is the random item then drop it.
                        if ((HABD_DROP_RANDOM_BACKPACK != 0) && (iRandomCount == iRandomBackpack))
                        {
                            if (HABD_DROP_RANDOM_BACKPACK == 2) DestroyObject(oItem);
                            else AssignCommand(oBag, ActionTakeItem(oItem, oPC));
                        }
                        // If this is the most expensive item then drop it.
                        if ((HABD_DROP_MOST_EXPENSIVE_BACKPACK != 0) && (iRandomCount == iHighestGPPos))
                        {
                            if (HABD_DROP_MOST_EXPENSIVE_BACKPACK == 2) DestroyObject(oItem);
                            else AssignCommand(oBag, ActionTakeItem(oItem, oPC));
                        }
                    }
                } else {
                    iRandomCount++;
                    // If this is the random item then drop it.
                    if ((HABD_DROP_RANDOM_BACKPACK != 0) && (iRandomCount == iRandomBackpack))
                    {
                        if (HABD_DROP_RANDOM_BACKPACK == 2) DestroyObject(oItem);
                        else AssignCommand(oBag, ActionTakeItem(oItem, oPC));
                    }
                    // If this is the most expensive item then drop it.
                    if ((HABD_DROP_MOST_EXPENSIVE_BACKPACK != 0) && (iRandomCount == iHighestGPPos))
                    {
                        if (HABD_DROP_MOST_EXPENSIVE_BACKPACK == 2) DestroyObject(oItem);
                        else AssignCommand(oBag, ActionTakeItem(oItem, oPC));
                    }
                }
            }
            oItem = GetNextItemInInventory(oPC);
        }
    }
    // Should we drop everything in the backpack that isn't plot?
    if (HABD_DROP_BACKPACK != 0)
    {
        int iBaseItemType;
        if (HABD_DROP_BACKPACK == 2) SendMessageToPC(oPC, "Destroying all backpack items.");
        else SendMessageToPC(oPC, "Dropping all backpack items.");
        oItem = GetFirstItemInInventory(oPC);
        while (GetIsObjectValid(oItem))
        {
            if (HABD_FORCE_RAISE_USES_SCROLLS)
            {
                // Search through the scrolls and skill the raise/rez scrolls
                iBaseItemType = GetBaseItemType(oItem);
                if ((iBaseItemType == BASE_ITEM_SCROLL) ||
                    (iBaseItemType == BASE_ITEM_SPELLSCROLL))
                {
                    // Default scrolls cannot be made plot so don't worry about it.
                    // See if it matches the tags we are looking for.
                    if (FindSubString(HABD_SCROLL_TAGS, ":"+GetTag(oItem)+":") == -1)
                        if (GetIsObjectValid(oItem) && (!GetPlotFlag(oItem)))
                        {
                            if (HABD_DROP_BACKPACK == 2) DestroyObject(oItem);
                            else AssignCommand(oBag, ActionTakeItem(oItem, oPC));
                        }
                } else {
                    if (GetIsObjectValid(oItem) && (!GetPlotFlag(oItem)))
                    {
                        if (HABD_DROP_BACKPACK == 2) DestroyObject(oItem);
                        else AssignCommand(oBag, ActionTakeItem(oItem, oPC));
                    }
                }
            }
            oItem = GetNextItemInInventory(oPC);
        }
    }
    return;
}

// ****************************************************************************

// Report that a player died. OBJECT_SELF is the dead player.
void ReportPlayerDeath();

void ReportPlayerDeath()
{
    object oPC = OBJECT_SELF;

    // Abort is not a player
    if (!GetIsPC(oPC)) return;

    int iHPs = GetCurrentHitPoints(oPC);
    // Abort if player isn't dying
    if (iHPs > 0) return;

    // Display notification.
    FloatingTextStringOnCreature(GetName(oPC)+" HAS DIED!", oPC);
    // Vocal notification.
    AssignCommand(oPC, PlayVoiceChat(VOICE_CHAT_DEATH, oPC));
    if (HABD_DM_NOTIFICATION_ON_DEATH) SendMessageToAllDMs("DEAD: "+GetName(oPC)+" HAS DIED");
    DelayCommand(0.2,FloatingTextStringOnCreature("OOC: YOU HAVE JUST DIED, SO BE QUIET UNTIL YOU ARE RAISED. -DM", oPC, FALSE));
}

// ****************************************************************************

// Recover a player from instant death. This is one of the key functions of
// this death system. Instant death isn't possible, you always bleed.
//   oPC - the player who instantly died.
void RecoverInstantDeath(object oPC);

void RecoverInstantDeath(object oPC)
{
    // Should regeneration items be removed from bleeding players?
    if (HABD_NERF_REGENERATION_ITEMS)
    {
        AssignCommand(oPC, HABDRegenerationItemsUnequip(oPC));
    }

    // Bring the player back from death and make them bleed.
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
    int iBleed = 6+Random(4);
    //SetPlotFlag(oPC, FALSE);
    // Will leave player at -6 to -9
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(iBleed, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE), oPC);
    //SetPlotFlag(oPC, TRUE);
    FloatingTextStringOnCreature("You nearly died! Bleeding starts at -"+IntToString(iBleed), oPC, FALSE);
}

// ****************************************************************************
// Check to see if the player has any raise or resurrection scrolls on them.
// If they do have them then a local object will be set pointing to that item.
//   oPC - the dead player.
// Returns the number of scrolls that they possess.
int CheckForRaiseRezScrolls(object oPC);

int CheckForRaiseRezScrolls(object oPC)
{
    DeleteLocalObject(oPC, HABD_STORED_SCROLL);
    int iStoredCost = 1000000;
    int iCost = 0;
    int iBaseItemType;
    int iNumFound = 0;
    object oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem))
    {
        // Search through the scrolls
        iBaseItemType = GetBaseItemType(oItem);
        if ((iBaseItemType == BASE_ITEM_SCROLL) ||
            (iBaseItemType == BASE_ITEM_SPELLSCROLL))
        {
            // Default scrolls cannot be made plot so don't worry about it.
            // See if it matches the tags we are looking for.
            if (FindSubString(HABD_SCROLL_TAGS, ":"+GetTag(oItem)+":") != -1)
            {
                // Use the least expensive scroll the player has.
                iCost = GetGoldPieceValue(oItem) / GetItemStackSize(oItem);
                iNumFound = iNumFound + GetItemStackSize(oItem);
                if (iCost < iStoredCost)
                {
                    iStoredCost = iCost;
                    // Store the item because this is what we want to use to
                    // bring them back from the dead.
                    SetLocalObject(oPC, HABD_STORED_SCROLL, oItem);
                }
            }
        }
        oItem = GetNextItemInInventory(oPC);
    }
    return (iNumFound);
}

// ****************************************************************************

// Warn player that they will auto-respawn in fTime seconds.
//   oPC - the dead player.
//   fTime - the amount of time until auto-respawn.
void AutoRespawnWarning(object oPC, float fTime);

void AutoRespawnWarning(object oPC, float fTime)
{
    // If the player is no longer dead then kill the warning.
    if (!GetIsDead(oPC)) return;
    if (GetLocalInt(GetModule(), HABD_PLAYER_STATE+GetPCPlayerName(oPC)+GetName(oPC)) != HABD_STATE_PLAYER_DEAD) return;
    // Store
    SetLocalInt(GetModule(), HABD_RESPAWN_TIMER+GetPCPlayerName(oPC)+GetName(oPC), FloatToInt(fTime));
    // Warn the player.
    if(fTime > 1.0) FloatingTextStringOnCreature("OOC: "+GetName(oPC)+" will automatically respawn in "+FloatToString(fTime,4,1)+" seconds.", oPC, TRUE);
    return;
}

// ****************************************************************************

// Warn player that they will auto-raise in fTime seconds.
//   oPC - the dead player.
//   fTime - the amount of time until auto-raise.
void AutoRaiseWarning(object oPC, float fTime);

void AutoRaiseWarning(object oPC, float fTime)
{
    // If the player is no longer dead then kill the warning.
    if (!GetIsDead(oPC)) return;
    if (GetLocalInt(GetModule(), HABD_PLAYER_STATE+GetPCPlayerName(oPC)+GetName(oPC)) != HABD_STATE_PLAYER_DEAD) return;
    // Store
    SetLocalInt(GetModule(), HABD_RAISE_TIMER+GetPCPlayerName(oPC)+GetName(oPC), FloatToInt(fTime));
    // Warn the player.
    if(fTime > 1.0) FloatingTextStringOnCreature("OOC: "+GetName(oPC)+" will automatically raise in "+FloatToString(fTime,4,1)+" seconds.", oPC, TRUE);
    return;
}

// ****************************************************************************

// Forces a dead player to automatically respawn.
//   oPC - the dead player who is being forced to respawn.
void ForceAutoRespawn(object oPC);

void ForceAutoRespawn(object oPC)
{
    // Make sure the player is dead.
    if (!GetIsDead(oPC) ||
      (GetLocalInt(GetModule(), HABD_PLAYER_STATE+GetPCPlayerName(oPC)+GetName(oPC)) != HABD_STATE_PLAYER_DEAD))
    {
    DeleteLocalInt(GetModule(), HABD_RESPAWN_TIMER+GetPCPlayerName(oPC)+GetName(oPC));
        return;
    }

    // Force the player to respawn.
    SetLocalInt(oPC, HABD_FORCED_RESPAWN, 1);
    AssignCommand(oPC, ExecuteScript(HABD_RESPAWN_SCRIPT, oPC));
    DeleteLocalInt(GetModule(), HABD_RESPAWN_TIMER+GetPCPlayerName(oPC)+GetName(oPC));
    FloatingTextStringOnCreature("OOC: Automatically respawning "+GetName(oPC)+" because timer elapsed.", oPC, TRUE);
    return;
}

// ****************************************************************************

// Forces a dead player to automatically raise.
//   oPC - the dead player who is being forced to raise.
void ForceAutoRaise(object oPC);

void ForceAutoRaise(object oPC)
{
    // Make sure the player is dead.
    int iState = GetLocalInt(GetModule(), HABD_PLAYER_STATE+GetPCPlayerName(oPC)+GetName(oPC));
    if ((iState != HABD_STATE_PLAYER_DEAD) &&
        (iState != HABD_STATE_RESPAWNED_GHOST))
    {
        DeleteLocalInt(GetModule(), HABD_RAISE_TIMER+GetPCPlayerName(oPC)+GetName(oPC));
        return;
    }
    DeleteLocalInt(GetModule(), HABD_RAISE_TIMER+GetPCPlayerName(oPC)+GetName(oPC));
    // If force raise uses up scrolls, then do so.
    if (HABD_FORCE_RAISE_USES_SCROLLS)
    {
        object oScroll = GetLocalObject(oPC, HABD_STORED_SCROLL);
        if (GetItemPossessor(oScroll) == oPC)
        {
            int iStackSize = GetItemStackSize(oScroll);
            // Only one item so destroy it, this is why it should only use scrolls.
            // If it uses a charged item, then this could be wasted.
            if (iStackSize == 1) DestroyObject(oScroll);
            else SetItemStackSize(oScroll, iStackSize - 1);
        } else {
            FloatingTextStringOnCreature("OOC: Auto-raise aborted for "+GetName(oPC)+" because could not find any scrolls.", oPC, TRUE);
            return;
        }
        DeleteLocalObject(oPC, HABD_STORED_SCROLL);
    }
    // Copy of Raise Dead spell script since you can't make a dead player cast raise at themself.
    if (GetIsDead(oPC))
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_RAISE_DEAD), GetLocation(oPC));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);
        HABDApplyPenaltyIfDead(oPC, SPELL_RAISE_DEAD);
    } else {
        HABDCureRespawnGhost(oPC, SPELL_RAISE_DEAD);
    }
    // Force the player to respawn.
    FloatingTextStringOnCreature("OOC: Automatically raising "+GetName(oPC)+" because timer elapsed.", oPC, TRUE);
    return;
}

// ****************************************************************************

// Check if a player has spontaneously come back to life.
//   oPC - the dead player.
//   fTime - the duration to wait until the next health check.

void CheckForDMHeal(object oPC, float fTime)
{
    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);
    // Check to see if the player is still alive.
    int iState = GetLocalInt(oMod, HABD_PLAYER_STATE+sID);
    if (
        (iState == HABD_STATE_RESPAWNED_GHOST) ||
        (iState == HABD_STATE_PLAYER_ALIVE)
        ) return;

    // Quick little timer to check that PCs recover from a DM heal properly.
    if (GetIsDead(oPC))
    {
        DelayCommand(fTime, CheckForDMHeal(oPC, fTime));
    } else {
        // Player has been DM healed.
        //SetPlotFlag(oPC, FALSE);
        SetLocalInt(oMod, HABD_PLAYER_STATE+sID, HABD_STATE_PLAYER_ALIVE);
    }
}

// ****************************************************************************

// This is the OnPlayerDeath event handler.

void main()
{
    object oMod = GetModule();
    object oPC = GetLastPlayerDied();
    int iNPC = GetLocalInt(OBJECT_SELF, HABD_NPC_BLEED);
    if (iNPC == 1) oPC = OBJECT_SELF;
    string sID = GetPCPlayerName(oPC)+GetName(oPC);

    // If an NPC is running this script, then set up its master. The master was
    // automatically wiped out when the henchman died.
    if (iNPC)
    {
        if (!GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetLocalObject(OBJECT_SELF, HABD_NPC_MASTER))))
            AddHenchman(GetLocalObject(OBJECT_SELF, HABD_NPC_MASTER), oPC);
    }

    if (HABD_DEBUG) SpeakString("DEBUG: HABD OnDeath, "+GetName(oPC)+", HP: "+IntToString(GetCurrentHitPoints(oPC))+", master: "+GetName(GetMaster(oPC))+", state:"+HABDGetPlayerStateName(oPC), TALKVOLUME_SHOUT);

    // Check to see if they have bled at all - if not then give them a chance to bleed.
    if (GetLocalInt(oMod, HABD_PLAYER_STATE+sID) != HABD_STATE_PLAYER_DEAD)
    {
        // Player died without going through bleeding.

        // Keep the player from taking additional damage while bleeding.
        // SetPlotFlag(oPC, TRUE);
        // Special state for this circumstance.
        SetLocalInt(oMod, HABD_PLAYER_STATE+sID, HABD_STATE_PLAYER_INSTANT_DEATH);
        // Bring the player to near-death.
        AssignCommand(oPC, RecoverInstantDeath(oPC));
        // Force friendly to hostile faction.
        if (!GetLocalInt(oPC, HABD_OLD_FACTION_SET))
        {
            SetLocalInt(oPC, HABD_OLD_FACTION, GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oPC));
            SetLocalInt(oPC, HABD_OLD_FACTION_SET, 1);
        }
        SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 100, oPC);
        // stop nearby attackers
        AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectInvisibility(INVISIBILITY_TYPE_NORMAL), oPC, 6.0));
        return;
    }

    // Player has properly died.

    //AWARD XP!
    ExecuteScript("pwfxp",OBJECT_SELF);

    // Check for a DM Heal.
    AssignCommand(oPC, DelayCommand(6.0, CheckForDMHeal(oPC, 6.0)));

    // Ensure that plot is not still set.
    //SetPlotFlag(oPC, FALSE);
    // Set playerstate to dead not dying.
    SetLocalInt(oMod, HABD_PLAYER_STATE+sID, HABD_STATE_PLAYER_DEAD);
    // Alert that the player died.
    AssignCommand(oPC, ReportPlayerDeath());

    // Check if we are re-entering this state from persistence.
    if (GetLocalInt(oPC, HABD_PERSISTANT_REAPPLY) != 1)
    {
        // Set the auto-respawn/raise timers to maximum.
        SetLocalInt(oMod, HABD_RESPAWN_TIMER+sID, FloatToInt(HABD_FORCE_RESPAWN_TIMER));
        if ((HABD_SOLO_FORCE_RAISE_TIMER > 0.0) && (HABDGetPartySize(oPC)))
        {
            SetLocalInt(oMod, HABD_RAISE_TIMER+sID, FloatToInt(HABD_SOLO_FORCE_RAISE_TIMER));
        } else {
            SetLocalInt(oMod, HABD_RAISE_TIMER+sID, FloatToInt(HABD_FORCE_RAISE_TIMER));
        }
        // Increment the counters.
        SetLocalInt(oMod, HABD_CURRENT_DEATH_COUNT+sID, GetLocalInt(oMod, HABD_CURRENT_DEATH_COUNT+sID) + 1);
        SetLocalInt(oMod, HABD_DEATH_COUNT+sID, GetLocalInt(oMod, HABD_DEATH_COUNT+sID) + 1);
    } else {
        // State was reapplied, do not increment the counters.
        DeleteLocalInt(oPC, HABD_PERSISTANT_REAPPLY);
        // Autoraise timers will use their persistent values.
    }

    // Should we reequip any regeneraton items?
    if (HABD_NERF_REGENERATION_ITEMS)
    {
        AssignCommand(oPC, HABDRegenerationItemsReEquip(oPC));
    }

    // Drop items
    AssignCommand(oPC, DropItems(oPC));

    // Respawn option can be disabled.
    if (HABD_RESPAWN_ALLOWED)
    {
        PopUpDeathGUIPanel (oPC, HABD_INSTANT_RESPAWN_ALLOWED, TRUE, 0, "Press the Respawn button to respawn as a DM controlled ghost. "+IntToString(HABD_RESPAWN_XP_LOSS)+"% XP & "+IntToString(HABD_RESPAWN_GP_LOSS)+"% GP penalty applies.");
    } else {
        FloatingTextStringOnCreature("OOC: Respawn is turned off. You must wait for your party to help you, DM intervention or automatic respawn/raise.", oPC, FALSE);
    }

    // Handle the auto-respawn and auto-raise timers.
    float fRespawn = IntToFloat(GetLocalInt(oMod, HABD_RESPAWN_TIMER+sID));
    float fRaise = IntToFloat(GetLocalInt(oMod, HABD_RAISE_TIMER+sID));
    if (iNPC)
    {
        // The respawn timer must be less than the raise timer for it to execute.
        if ((fRespawn > 0.0) && ((fRespawn < fRaise) || (fRaise == 0.0)))
        {
            AssignCommand(oPC, DelayCommand(HABD_NPC_FORCE_RESPAWN_TIMER, ForceAutoRespawn(oPC)));
        }
        if (fRaise > 0.0)
        {
            if (HABD_FORCE_RAISE_USES_SCROLLS)
            {
                if (CheckForRaiseRezScrolls(oPC) <= 0)
                {
                    return;
                }
            }
            AssignCommand(oPC, DelayCommand(HABD_NPC_FORCE_RAISE_TIMER, ForceAutoRaise(oPC)));
        }
    } else {
        // The respawn timer must be less than the raise timer for it to execute.
        if ((fRespawn > 0.0) && ((fRespawn < fRaise) || (fRaise == 0.0)))
        {
            AssignCommand(oPC, AutoRespawnWarning(oPC, fRespawn));
            AssignCommand(oPC, DelayCommand(0.5 * fRespawn, AutoRespawnWarning(oPC, 0.5 * fRespawn)));
            AssignCommand(oPC, DelayCommand(0.75*fRespawn, AutoRespawnWarning(oPC, 0.25*fRespawn)));
            AssignCommand(oPC, DelayCommand(9*fRespawn, AutoRespawnWarning(oPC, 0.1*fRespawn)));
            AssignCommand(oPC, DelayCommand(fRespawn, ForceAutoRespawn(oPC)));
        }
        if (fRaise > 0.0)
        {
            if (HABD_FORCE_RAISE_USES_SCROLLS)
            {
                if (CheckForRaiseRezScrolls(oPC) <= 0)
                {
                    FloatingTextStringOnCreature("OOC: Out of scrolls. You have to wait for help.", oPC, FALSE);
                    return;
                }
            }
            AssignCommand(oPC, AutoRaiseWarning(oPC, fRaise));
            AssignCommand(oPC, DelayCommand(0.5 * fRaise, AutoRaiseWarning(oPC, 0.5 * fRaise)));
            AssignCommand(oPC, DelayCommand(0.75*fRaise, AutoRaiseWarning(oPC, 0.25*fRaise)));
            AssignCommand(oPC, DelayCommand(9*fRaise, AutoRaiseWarning(oPC, 0.1*fRaise)));
            AssignCommand(oPC, DelayCommand(fRaise, ForceAutoRaise(oPC)));
        }
    }
    // DO NOT ADD ANY CODE HERE. IT MIGHT NOT BE EXECUTED.
}




