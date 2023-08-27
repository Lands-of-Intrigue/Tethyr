// Hemophiliacs Always Bleed to Death v0_03
// By Demtrious and OldManWhistler
//
// This file contains:
// - description
// - installation information
// - configuration settings
// - global constants
// - common functions

/*
INTRODUCTION

From the same fools who brought you PHB Familiars and UMD by the book, Supply Based
Resting, Party Loot Notification, Permanent Area Effect Spells, Speed Override,
Take Cover (PHB environment AC) and PHB Movement Skills (Balance, Climb, Jump,
Swim, Escape Artist).

The main intent of this system is that players never instantly die. Player death
will always be caused by player action -- because help didn't reach them in time
and never because of a bad roll of the dice. They will always go through bleeding
before reaching death. There are stabilization checks (10% chance) and bandages
can bring you back to life on a DC 15 heal skill check as per PHB, except that
when stabilized you instantly go to 1 HP.

One of the unfortunate side effect of playing a real-time game rather than a
turn-based game is that it can be very difficult to react to a player bleeding
in a timely matter. In turn-based play, your party members would know that you
are bleeding and be able to react within one or two round. This system seeks to
restore the ability for your party members to be aware and react.

With the default settings of this system it should be very rare for low level
players to die if they have party members with them for support. Once they reach
higher levels and have the means to afford Resurrection and Raise Dead then the
time to bleed to death decreases. The intention is to make death a rare
occurrence. After all, with all those local clerics tossing out rez like candy,
its any wonder there's still undead around left to fight.

The bleed/death system is intended for multiplayer use but CAN be used in solo
play. The respawn system is intended for multiplayer use only but can be used
for single party if the auto-raise feature is enabled. The auto-raise feature
can be configured to use up scrolls. The respawn system can be disabled or
easily replaced with a different system.

This system was originally built with single-party DMed play in mind, but it
should be able to scale to ANY kind of play. This is the Swiss Army knife of
death systems. The same bleeding/death/respawn system can be used for henchmen
AS WELL as players, removing additional complexity from your module.

If you want to want to support solo play with this script, then enable the fast
bleed option and set the solo auto-raise option to a very low value. That way
when a player bleeds/dies in solo play they do not have to wait long for help
that will never come.

THANKS
- HCR team, at one time or another we must have stolen some of your ideas.
- Lazybones for coming up with a name for the system.
- Typhonius, DickNervous, Feds, Ochobee and Blewz for help with the initial play-testing.

Apologies to anyone who is suffering, or knows someone who suffers with a
hereditary blood-coagulation disorder and takes offense at the name. We thought
it was a rather witty name for a system where players must always go through
bleeding before dying. No offense was intended.

OTHER WORKS BY SAME AUTHORS

Demetrious' Portfolio
http://nwvault.ign.com/portfolios/data/1055729301.shtml

OldManWhistler's Portfolio
http://nwvault.ign.com/portfolios/data/1054937958.shtml
FEATURES

IMPLEMENTATION NOTES

- 4 scripts, 3 player items, 2 DM items, 1 placeable. The only NWN content
modified is Raise Dead and Resurrection spells, and the henchmen death scripts
should be modified if you want to enable henchman bleeding/respawn as ghost.
- It uses DelayCommand events scheduled on the players instead of heartbeats.
It only uses CPU cycles when players are bleeding, dying, dead, respawned or
entering/leaving the module. This removes the overhead of searching through the
player list on the heartbeat.
- Delayed commands are rescheduled at the start of a chain to prevent stalled
states when the CPU is overloaded and events start getting dropped.
- DelayCommand is *NOT* a recursive function, so there is no worry about CPU
performance hits.
- All settings are CONST variables that are evaluated at compile time to speed up execution.
- Henchmen only bleed/respawn if they have a master. Potions can be used on
bleeding henchmen as well as any of the normal means of healing another creature.
Henchmen bleeding is implemented by "faking" to 0 to -9 HP bleed with 10 to 0 HP.
FEATURES NOT IMPLEMENTED
- We considered having an option for limiting raising and resurrecting to same
party only (to prevent death penalty griefers) but you cannot invite dead players
to your party so we decided against that.
- We considered storing player location persistently, but all persistent location
systems I have seen require some kind of workaround to store the player location
over a module reset (most common being an additional script in the exit event of
every area). We figured it was better to leave such complexity out of this system
and let the end user choose the persistent location system that is right for their
needs.
- We do not include any kind of bind stone system. But our respawn system can
easily be removed (changing one line in the configuration) so that you can
replace it with the respawn system of your choice.
- Dropped items are not automatically picked up. Dropping large inventories is
laggy enough without adding additional processing.
- There is no ability to change the settings while the module is running. This
is because all the settings are constants to speed up execution.
- It is not possible to make familiars or animal companions bleed because there
is no scripting command for making them rejoin the party as a familiar/companion.
ITEMS:
- All items are stored under Custom5 in the palette or Chooser.
- Automatically given out to players who do not possess them on log in.
- All items have no weight, are worth no money and cannot be sold.
- Items cannot be transferred to other players or dropped.
- There is a Skull item that displays the player's bleed/death/lost XP/lost GP
statistics.
- There is a Bandages item that can stabilize a bleeding player on a DC 15 heal
check or make a respawned ghost follow the player using the bandages.
- There is a Rulebook item that displays how this system is configured for the
module. It displays the penalties as they would currently apply to the PC reading the book.
- There is a DM statistic item that can display the bleed/death/lost XP/lost GP
statistics for an entire party.
- There is a DM force death item that can instant kill players/henchmen without
putting them through the bleeding state. You can tie this in with the prevent
death feature to make death only happen when the DM decides it should.

BLEEDING:
- Works for players as well as henchmen.
- 10% chance of self-stabilization to 1 HP.
- If going from living to -6 or lower you will be capped at -5 to give you a
good chance to be saved.
- If going from living to dead you will be set to -6 to -9 HP instead of dying.
- Free DC15 heal check bandages can be used to stabilize other players to 1 HP.
- Any healing will stabilize another player.
- Casting raise/rez on a bleeding player stabilizes them to 1 HP or more. (It is
a waste of a spell, but it works).
- Immune to damage while bleeding. You have to bleed to death.
- Regeneration items always stabilize players and keep them from ever dying.
(Defaults to leaving regeneration items on the player)
- Bleeding players are temporarily made invisible to make monsters change targets.
- Players can be made invisible for a configurable amount of time after bleeding
to give them a chance to heal or run away (default is 12 seconds).
- Possessed familiars die instead of bleeding.
- First bleed message tells the total time until death.
- Nearby party members are notified of the bleeding player every round, even
number of rounds between bleeding is greater than one.
- All DMs are notified of when players are bleeding/dying. (default on)
- Number of rounds between bleeding is based off of player level. (defaults to
giving low levels a long time between bleeding to reduce the chance of dying
since they can't afford Raise/Rez)
- Fast 1sec bleed when playing solo without a party. (default off)
- There is an option for preventing player death until they reach a certain
level. (default is 4). The DM Force Instant Death widget can bypass this setting.

DEATH:
- Force auto-respawn after being dead for a specified time. (default 3 min)
- Force auto-raise after being dead or respawned for a specific time. (default off)
- Auto-raise can be configured to only work if the player possesses raise dead /
resurrection scrolls that are consumed in the process. If this is enabled then
the dying can never cause raise dead/resurrection scrolls to be dropped or destroyed. (default off)
- Additional force auto-raise timer for solo players only. (default off)
- Henchmen have their own separate auto-respawn and auto-raise timers.
- DMs can bring dead players back to life with no penalty by using a DM heal.

HENCHMEN BLEEDING AND DEATH:
- The same bleeding/death/respawn system can be used for henchmen by modifying
your henchmen OnDeath scripts. Requires two additional lines to your henchmen
scripts and should be compatible with all henchmen AI provided that they use the
NW_ASC_BUSY condition properly.
- Henchmen support does not require any other modifications.

PENALTIES:
- Separate % GP/XP penalties for respawn, raise dead and resurrection.
- XP penalty can be configured to prevent level loss (default no level loss).
- GP penalty can be configured to have a maximum amount to take (default 10,000gp max).
- If dropping/destruction of all gold is enable, then no gold will be lost to the
penalty (since the player drops the items before the penalty is applied).
- There is no penalty for henchmen bleed/death.
- User defined functions called at bleed, respawn, raise and rez that can be
used to apply other penalties without having to go deep into the internals of our code.

ITEM DROPPING ON DEATH:
- Item dropping on player death can be configured as any combination of the
following options. Any options can be configured to do nothing (0), drop item (1)
or destroy item (2). The conditions are evaluated in an order of precedence.
  - Drop nothing. (default)
  - Drop all gold. (this will avoid any GP penalties since gold is dropped before
  penalty applied)
  - Drop equipped left-hand/right-hand items.
  - Drop a random equipped item.
  - Drop the most expensive equipped item.
  - Drop all equipped items.
  - Drop Raise Dead / Resurrection scrolls.
  - Drop a random backpack item.
  - Drop the most expensive backpack item.
  - Drop all backpack items.
- Dropped items are NOT automatically re-equipped or picked up.
- If players forget to pick up items they dropped, they are automatically
reminded every 30 seconds.
- The placeable created to store dropped items is automatically destroyed when it empties.
- If all of the drop settings are disabled then the placeable is not created.
- There is an option to destroy dropped items rather than store them in a placeable.

PERSISTENCE:
- Persistence can be disabled with a flag. (default enabled)
- Persistence only works with a multiplayer server. It has no effect in single
player (no OnClientLeave event in single player)
- Statistics to keep track of how many times the player has bled/died in total,
how many times since the server was restarted, and how much gold/XP the player
has lost in total from penalties.
- Persistent DB functions for storing bleed/death/respawn state.
- Auto-respawn and auto-raise timers are stored persistently at various increments.
- Players remain in the same state over module restarts, even with local vault
characters.
- Persistent data is stored with one DB write at OnClientLeave and one DB read
at OnClientEnter. It is very fast with minimal DB size (less than 1kb per player record).
- When bleed/death/respawn is restored at player log in, it does not reapply the
penalties or falsely increment the statistics.

RESPAWN:
- Can be used with other respawn systems (default uses our system)
- Option to disable death GUI to remove respawn. (Default GUI enabled)
- Option to disable respawn button but leave death GUI (Default respawn button enabled)
- Additional system to respawn as a ghost with no player control. (default enabled)
- Using bandages on respawned ghost makes them follow you if you are in the same
party (simulates carrying a corpse).
- Living players can barter with respawned ghosts (simulates search the players
corpse for scrolls, except corpse has a say in what is taken).
- Respawned ghosts cannot be DM moved by shift-click.
- Respawned ghosts cannot be recovered in single player by using the dm_heal console
command. So the respawn state could be used as permanent death in a single player
game by setting the auto-respawn timer to 0.1.
- Casting raise or rez brings respawn ghost back to life, but applies raise/rez
penalty on top of respawn penalty.
- DMs can bring the "ghosted" PC back to life by toggling invulnerability (no
penalty). Casting raise or rez also works, but DM heal does not.

*/


// ****************************************************************************
// INSTALLATION
// ****************************************************************************

/*
// If you are unsure of which scripts are currently associated with your module
event, go to your
// Module Properties and click on the Events tab.

// #1: Change your Module OnPlayerDying script to "habd_onpcdying".

// #2: Change your Module OnPlayerDeath script to "habd_onpcdeath".

// #3: (Optional) Change your Module OnPlayerRespawn script to "habd_onpcrespawn". If you wish
// to use a different respawn system then make sure the HABD_RESPAWN_SCRIPT variable in
// "habd_include" is set to the script you want to use.

// #4: Add the following line to your module OnActivateItem, OnClientEnter,
// OnClientLeave, OnUnAcquiredItem, nw_s0_raisdead, nw_s0_resserec scripts:
#include "habd_include"

// #5: Add the following line to your module OnActivateItem script:
if (HABDOnActivateItem(GetItemActivator(), GetItemActivatedTarget(), GetItemActivated()))
return;

// #6: Add the following lines to your module OnClientEnter script:
HABDGetDBOnClientEnter(GetEnteringObject());
DelayCommand(6.0, HABDItemsOnClientEnter(GetEnteringObject()));

// #7: Add the following line to your module OnClientLeave script:
HABDSetDBOnClientLeave(GetName(GetExitingObject()));

// #8: Add the following line to your module OnUnAcquiredItem script:
if (HABDOnUnAcquiredItem(GetModuleItemLostBy(), GetModuleItemLost())) return;

// #9&10 automatic: Imported the habd_nw_1_31.erf file to replace your nw_s0_raisdead
// and nw_s0_resserec scripts with SoU 1.31 compliant ones.

// #9 manual: Open nw_s0_raisdead. It should look like:
if(GetIsDead(oTarget))
{
//Apply raise dead effect and VFX impact
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
// HABD CODE START
// Apply the user defined effects.
HABDApplyPenaltyIfDead(oTarget, SPELL_RAISE_DEAD);
// HABD CODE END
}
// HABD CODE START
HABDCureRespawnGhost(oTarget, SPELL_RAISE_DEAD);
// HABD CODE END

// #10 manual: Open nw_s0_resserec. It should look like:
if (GetIsDead(oTarget))
{
//Declare major variables
int nHealed = GetMaxHitPoints(oTarget);
effect eRaise = EffectResurrection();
effect eHeal = EffectHeal(nHealed + 10);
effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
//Apply the heal, raise dead and VFX impact effect
ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
// HABD CODE START
HABDApplyPenaltyIfDead(oTarget, SPELL_RESURRECTION);
// HABD CODE END
}
// HABD CODE START
HABDCureRespawnGhost(oTarget, SPELL_RESURRECTION);
// HABD CODE END

// #11.1: Optional, for bleeding/respawning henchmen open up your henchmen OnDeath event scripts (ie: nw_ch_ac7) and add the following line to the top:
#include "habd_include"
// #11.2: Add the following line as the first line inside of the main function.
void main()
{
    // HABD CODE START
    if (HABDMakeHenchmanBleed()) return;
    // HABD CODE END

// #12: Open up "habd_include" and go to the configuration modification section.
// Change the configuration as it suits your needs. Make sure to save the include
// file and recompile your module to ensure that the settings take effect.

See PDF file for additional information.
*/


// ****************************************************************************
// CONFIGURATION - MODIFY THIS SECTION
// ****************************************************************************

// BLEEDING SETTINGS
//
// HABD_SOLO_FAST_BLEED
// If set to TRUE, then players without a party go through the bleeding stage
// VERY fast. This is useful for single player modules or when people are
// playing solo in a multiplayer module. They will still have the stabilization
// chances from bleeding to death without having to wait such a long time to die.
//
// HABD_NERF_REGENERATION_ITEMS
// Regeneration items will cause the player to never bleed to death. This is
// how AD&D intended them to work. Unfortunately that also means that characters
// with regeneration items will never die with this bleeding system. This is why
// regeneration items should be very rare, yet few people set up their campaigns
// that way.
// If you set this variable to TRUE, it will enable a workaround that unequips
// regeneration items when the player starts bleeding.
//
// HABD_NO_DEATH_BEFORE_LEVEL
// This will turn death off until the players have reached a certain level.
// Players are NEVER notified that this setting is turned on (to prevent abuses).
// From the player's perspective it will always look like they are stabilizing.
//
// HABD_POST_BLEED_INVIS_DUR
// Setting this value greater than 0.0 will give players invisibility for the
// specified period of time after they recover from bleeding. This is to give
// them a chance to heal or run away.
//
// HABD_ROUNDS_PER_BLEED_*
// These variables are used to set how many rounds it takes to bleed -1 HP
// based on the player level. If you set the value to 0, the player will
// instantly bleed to death. Do not set to a negative value.

const int HABD_SOLO_FAST_BLEED = FALSE;
const int HABD_NERF_REGENERATION_ITEMS = TRUE;
const int HABD_NO_DEATH_UNTIL_LEVEL = 5;
const float HABD_POST_BLEED_INVIS_DUR = 24.0;
const int HABD_ROUNDS_PER_BLEED_01 = 10;
const int HABD_ROUNDS_PER_BLEED_02 = 10;
const int HABD_ROUNDS_PER_BLEED_03 = 10;
const int HABD_ROUNDS_PER_BLEED_04 = 10;
const int HABD_ROUNDS_PER_BLEED_05 = 10;
const int HABD_ROUNDS_PER_BLEED_06 = 10;
const int HABD_ROUNDS_PER_BLEED_07 = 10;
const int HABD_ROUNDS_PER_BLEED_08 = 10;
const int HABD_ROUNDS_PER_BLEED_09 = 10;
const int HABD_ROUNDS_PER_BLEED_10 = 10;
const int HABD_ROUNDS_PER_BLEED_11 = 10;
const int HABD_ROUNDS_PER_BLEED_12 = 10;
const int HABD_ROUNDS_PER_BLEED_13 = 10;
const int HABD_ROUNDS_PER_BLEED_14 = 10;
const int HABD_ROUNDS_PER_BLEED_15 = 10;
const int HABD_ROUNDS_PER_BLEED_16 = 10;
const int HABD_ROUNDS_PER_BLEED_17 = 10;
const int HABD_ROUNDS_PER_BLEED_18 = 10;
const int HABD_ROUNDS_PER_BLEED_19 = 10;
const int HABD_ROUNDS_PER_BLEED_20 = 10;


// DM NOTIFICATION SETTINGS
//
// HABD_DM_NOTIFICATION_ON_BLEED
// If TRUE, it will SendMessageToAllDMs when a player bleeds.
// This can generate a lot of spam on the DM channel. It is only intended for
// use with single party games.
//
// HABD_DM_NOTIFICATION_ON_DEATH
// If TRUE, it will SendMessageToAllDMs when a player dies.
//
// HABD_DM_NOTIFICATION_ON_PENALTY
// If TRUE, it will SendMessageToAllDMs when a gets an XP/GP penalty from respawn/raise/rez.
//
// HABD_DM_DISPLAY_STATS_TO_ALL
// If TRUE, using the DM statistics item will display the statistics to all DMs.
// If FALSE, it will display only to the DM using the item.
// Setting it to TRUE is useful when you want to capture such info into your
// DM Client log file.
const int HABD_DM_NOTIFICATION_ON_BLEED = FALSE;
const int HABD_DM_NOTIFICATION_ON_DEATH = TRUE;
const int HABD_DM_NOTIFICATION_ON_PENALTY = FALSE;
const int HABD_DM_DISPLAY_STATS_TO_ALL = FALSE;

// TIMER SETTINGS
//
// All timers start counting from the moment the player dies.
//
// HABD_FORCE_RESPAWN_TIMER (AUTO-RESPAWN)
// HABD_NPC_FORCE_RESPAWN_TIMER (AUTO-RESPAWN)
// Set this to a value greater than 0.0 to force respawn after a certain amount
// of time has lapsed. If players remain lying dead for long enough, they will
// be forced to respawn. Auto-respawn timer must be less than the auto-raise timer
// if the auto-raise timer is enabled.
//
// HABD_FORCE_RAISE_TIMER (AUTO-RAISE)
// HABD_NPC_FORCE_RAISE_TIMER (AUTO-RAISE)
// Set this to a value greater than 0.0 to force raise after a certain amount
// of time has lapsed after death. If players remain lying dead or respawned
// for long enough, they will be forced raised. Autorepawn timer must be
// less than the autoraise timer if the autoraise timer is enabled.
//
// HABD_SOLO_FORCE_RAISE_TIMER (AUTO-RAISE FOR SOLO ONLY
// Set this to a value greater than 0.0 to force raise solo players after a
// certain amount of time has lapsed after death. If the player remain lying
// dead or respawned for long enough, they will be forced to respawn.
//
// HABD_FORCE_RAISE_USES_SCROLLS
// Set this value to TRUE to have force raise consume scrolls. If the player or
// henchmen does not possess any standard raise/rez scrolls then they will not
// be force raised. Note: this will keep raise/rez scrolls from being
// dropped on player death.
const float HABD_FORCE_RESPAWN_TIMER = 0.0;
const float HABD_FORCE_RAISE_TIMER = 0.0;
const float HABD_SOLO_FORCE_RAISE_TIMER = 0.0;
const float HABD_NPC_FORCE_RESPAWN_TIMER = 0.0;
const float HABD_NPC_FORCE_RAISE_TIMER = 0.0;
const int HABD_FORCE_RAISE_USES_SCROLLS = FALSE;

// PERSISTENCE SETTINGS
//
// HADB_DB_PERSISTENT
// If set to FALSE, persistent data won't be stored. If you are making a single
// player module, the persistent data won't be stored anyways because the
// OnClientLeave event shuts down the module before it writes to the database.
//
// HABD_DB_NAME
// The name of the database to store the persistent information. If you leave it
// with the default value then the same DB will be used for all modules you run.
// If you want to use different databases for different modules then change the
// name.
const int HADB_DB_PERSISTENT = TRUE;
const string HABD_DB_NAME = "HABD_DB";


// PENALTY SETTINGS
//
// Set values for the respawn/raise/rez penalties.
// The value is a percentage of the total XP to get to the next level or
// the total GP coinage the player possesses. Set a value of 0 if you do not
// want a penalty. Set a value of 100 if you want the player to lose a level or
// to lose all of their GPs.
// If HABD_DROP_GOLD is set to TRUE, then the gold penalties won't do anything
// because gold is dropped before the penalties are applied.
//
// HABD_RESPAWN_*_LOSS
// Penalty for respawning.
//
// HABD_RAISE_*_LOSS
// Penalty for being raised from the dead.
//
// HABD_REZ_*_LOSS
// Penalty for being resurrected.
//
// HABD_NO_LEVEL_LOSS_FROM_XP_PENALTY
// Set this to FALSE to allow XP penalty to cause level loss. If set to TRUE
// then the penalties can cause a player to lose a level.
//
// HABD_MAX_GP_LOSS_FROM_GP_PENALTY
// Set this to a value greater than 0 to set a maximum GP loss. Regardless of
// the percentage penalty they will will only lose a maximum of that amount.
const int HABD_RESPAWN_XP_LOSS = 500;
const int HABD_RESPAWN_GP_LOSS = 0;
const int HABD_RAISE_XP_LOSS = 500;
const int HABD_RAISE_GP_LOSS = 0;
const int HABD_REZ_XP_LOSS = 0;
const int HABD_REZ_GP_LOSS = 0;
const int HABD_NO_LEVEL_LOSS_FROM_XP_PENALTY = FALSE;
const int HABD_MAX_GP_LOSS_FROM_GP_PENALTY = 0;

// ITEM DROP ON DEATH SETTINGS
//
// Set these constants to 1 if you would like to drop specific things at
// time of death. Set the constant to 2 if you would like to have the dropped item destroyed.
// Plot items are NEVER dropped or destroyed. The is an order of prescendence to the
// operations.
//
// Dropped items are NOT automatically repossessed when the player returns
// to life. This is to reduce lag. The placeable that stores the dropped items
// with automatically notify the player if it still contains items and
// self-destructs when it is empty of items.
//
// HABD_DROP_GOLD
// Drop or destroy all gold the player possesses. This happens before any penalties are
// applied, so the GP penalties will not do anything if this is enabled.
//
// HABD_DROP_WEAPON_SHIELD
// Drop or destroy the items equipped in the left and right hand slots.
//
// HABD_DROP_RANDOM_EQUIPPED
// Drop or destroy a random item from the players inventory on death.
//
// HABD_DROP_MOST_EXPENSIVE_EQUIPPED
// Drop or destroy the most expensive item the player has.
//
// HABD_DROP_EQUIPPED
// Drop or destroy all equipped items (including left and right hand slots).
// This setting overrides HABD_DROP_WEAPON_SHIELD.
//
// HABD_DROP_RAISE_REZ
// Drop or destroy any Raise Dead or Resurrection scrolls in the backpack.
//
// HABD_DROP_RANDOM_BACKPACK
// Drop or destroy a random item from the players inventory on death.
//
// HABD_DROP_MOST_EXPENSIVE_BACKPACK
// Drop or destroy the most expensive item the player has.
//
// HABD_DROP_BACKPACK
// Drop or destroy any items in the backpack (including Raise Dead / Resurrection)
// This setting overrides HABD_DROP_RAISE_REZ.
//
// 0 - off
// 1 - drop
// 2 - destroy
const int HABD_DROP_GOLD = 1;
const int HABD_DROP_WEAPON_SHIELD = 0;
const int HABD_DROP_RANDOM_EQUIPPED = 0;
const int HABD_DROP_MOST_EXPENSIVE_EQUIPPED = 0;
const int HABD_DROP_EQUIPPED = 0;
const int HABD_DROP_RAISE_REZ = 1;
const int HABD_DROP_RANDOM_BACKPACK = 0;
const int HABD_DROP_MOST_EXPENSIVE_BACKPACK = 0;
const int HABD_DROP_BACKPACK = 0;


// RESPAWN SETTINGS:
//
// HABD_RESPAWN_SCRIPT
// This is the script called when respawn is forced. It should be the same
// script as in your module OnPlayerRespawn script. Change this value if you
// want to use the auto-respawn feature with a different respawn system.
//
// HABD_RESPAWN_ALLOWED
// Set this to FALSE to turn off the death GUI. Players will lie there dead
// until someone raises them.
//
// HABD_INSTANT_RESPAWN_ALLOWED
// Set this to FALSE to turn off the respawn option in death GUI (if the death
// GUI is enabled).
//
// HABD_HENCHMEN_GHOST_RESPAWN
// Set this to TRUE to allow henchmen to respawn as ghosts the same way players
// do. If set to FALSE, it will perform the default henchmen death code of
// whatever henchmen AI you are using.
const string HABD_RESPAWN_SCRIPT = "habd_onpcrespawn";
const int HABD_RESPAWN_ALLOWED = FALSE;
const int HABD_INSTANT_RESPAWN_ALLOWED = FALSE;
const int HABD_HENCHMEN_GHOST_RESPAWN = FALSE;

// USER DEFINED FUNCTIONS:
// Modify these following functions to add additional status penalties, hooks
// into other systems, or whatever you want. They will be called on the Bleed,
// Respawn, Raise and Resurrection events. IMPORTANT: Do not give CON penalties
// on any events which would have the player at 1 HP (bleeding or raise) because
// you will just make them start bleeding again if their CON goes to a negative
// value.
//
// HABD_USERDEFINED_*_DESC
// If these strings have a value, then the information will be sent to the
// player when the event happens. This description will also be displayed in the
// death rulebook.
//
// HABDUserDefinedBleed() - Called after a player starts bleeding.
// HABDUserDefinedRespawn() - Called after a player respawns with the HABD
//                            respawn system. Not called with other respawn systems.
// HABDUserDefinedRaise() - Called when the Raise Dead spell is cast on a dead
//                          or respawned player.
// HABDUserDefinedResurrection() - Called when the Resurrection spell is cast on
//                                 a dead or respawned player.
string HABD_USERDEFINED_BLEED_DESC = "";
void HABDUserDefinedBleed()
{
    if (HABD_USERDEFINED_BLEED_DESC != "") SendMessageToPC(OBJECT_SELF, "HABD_BLEED: "+HABD_USERDEFINED_BLEED_DESC);
// Do not give the player a CON penalty (by stat penalty or curse effect) after
// stabilizing from bleed since they will only have 1 HP and it will most likely
// just start them bleeding again.
}

string HABD_USERDEFINED_RESPAWN_DESC = "";
void HABDUserDefinedRespawn()
{
    if (HABD_USERDEFINED_RESPAWN_DESC != "") SendMessageToPC(OBJECT_SELF, "HABD_RESPAWN: "+HABD_USERDEFINED_RESPAWN_DESC);
// You may have to toggle the plot flag in order to apply negative effects
// depending on whether or not the negative effect would be prevented by the
// the plot flag.
//  int iPlotFlag = GetPlotFlag(OBJECT_SELF);
//  SetPlotFlag(OBJECT_SELF, FALSE);
    // Apply status effects here
//  SetPlotFlag(OBJECT_SELF, iPlotFlag);
}

string HABD_USERDEFINED_RAISE_DESC = "";
void HABDUserDefinedRaise()
{
    if (HABD_USERDEFINED_RAISE_DESC != "") SendMessageToPC(OBJECT_SELF, "HABD_RAISE: "+HABD_USERDEFINED_RAISE_DESC);
// Do not give the player a CON penalty (by stat penalty or curse effect) after
// they are raised since they will only have 1 HP and it will most likely
// just start them bleeding again.
}

string HABD_USERDEFINED_RESURRECTION_DESC = "";
void HABDUserDefinedResurrection()
{
    if (HABD_USERDEFINED_RESURRECTION_DESC != "") SendMessageToPC(OBJECT_SELF, "HABD_RESURRECTION: "+HABD_USERDEFINED_RESURRECTION_DESC);
}

// END OF CONFIGURATION

// ****************************************************************************
// GLOBALS - DO NOT MODIFY
// ****************************************************************************

// Item tags. We use constants for the item tags to prevent typos.
const string HABD_ITEM_TOKEN = "habd_deathtoken";
const string HABD_ITEM_BANDAGES = "habd_bandages";
const string HABD_ITEM_RULES = "habd_rules";
const string HABD_ITEM_DM_TOKEN = "habd_dmtoken";
const string HABD_ITEM_DM_DEATH = "habd_dmdeath";

// Placeable to store dropped items in.
const string HABD_PLACEABLE_BAG = "habd_deathbag";
// How often the bag will check to see if it is empty before destroying itself.
const float HABD_BAG_SELF_DESTRUCT_TIMER = 30.0;
// List of all resurrection/raise dead scrolls
const string HABD_SCROLL_TAGS = ":NW_IT_SPDVSCR501:NW_IT_SPSCROL139:NW_IT_SPSCROL141:NW_IT_SPDVSCR702:";

// Player States. These values must all be unique.
const int HABD_STATE_PLAYER_ALIVE = 0;
const int HABD_STATE_PLAYER_BLEEDING = 1;
const int HABD_STATE_RESPAWNED_GHOST = 2;
const int HABD_STATE_PLAYER_DEAD = 3;
const int HABD_STATE_PLAYER_INSTANT_DEATH = 4;

// Campaign database variable. The persistent information will be stored in the
// database with a 32 character variable name that consists of this variable +
// player's public CD key + character name. We use unique variable names per
// character rather than the built-in unique oPC parameter because oPC is not
// valid in the OnClientLeave event where we store the database.
const string HABD_PERSIST_NAME = "";

// Module level local variables.

// Player HP while bleeding.
const string HABD_LAST_HP = "HABDLastHP";
// Player state.
const string HABD_PLAYER_STATE = "HABDPCState";
// Number of times player bled.
const string HABD_BLEED_COUNT = "HABDBleedCnt";
// Number of times player died.
const string HABD_DEATH_COUNT = "HABDDeathCnt";
// Amount of XP lost from the penalties.
const string HABD_LOST_XP_COUNT = "HABDLostXPCnt";
// Amount of GP lost from the penalties.
const string HABD_LOST_GP_COUNT = "HABDLostGPCnt";
// Number of times player bled since module load.
const string HABD_CURRENT_BLEED_COUNT = "HABDCBleedCnt";
// Number of times player died since module load.
const string HABD_CURRENT_DEATH_COUNT = "HABDCDeathCnt";
// Amount of XP lost from the penalties since module load.
const string HABD_CURRENT_LOST_XP_COUNT = "HABDCLostXPCnt";
// Amount of GP lost from the penalties since module load.
const string HABD_CURRENT_LOST_GP_COUNT = "HABDCLostGPCnt";
// 1 if the player was forced to respawn from DB (so that penalty isn't reapplied).
const string HABD_FORCED_RESPAWN = "HABDFRespawn";
// Used to store a local array of the items the player was forced to unequipped
// because the item had the regeneration property.
const string HABD_UNEQUIPED_ITEMS = "HABDUneqdItems";
// Used to track the object the respawned ghost is made to follow.
const string HABD_GHOST_AUTOFOLLOW = "HABDAutofollow";
// Used to prevent updating the statistics when the states are reapplied from the DB.
const string HABD_PERSISTANT_REAPPLY = "HABDPReapply";
// Used to store the player's CD key in the OnClientEnter event.
const string HABD_PERSISTANT_ID = "HABDPCID";
// Used to store the player's respawn timer.
const string HABD_RESPAWN_TIMER = "HABDPRespawnT";
// Used to store the player's raise timer.
const string HABD_RAISE_TIMER = "HABDPRaiseT";
// Used to store the player's old relationship with Hostile faction.
const string HABD_OLD_FACTION = "HABDOldF";
// Used to store the player's old relationship with Hostile faction.
const string HABD_OLD_FACTION_SET = "HABDOldFSet";
// Who owns the items in the loot bag?
const string HABD_BAG_OWNER = "HABDBagOwn";
// Is bleed notification already running?
const string HABD_REPORT_BLEED_RUNNING = "HABDBleedRep";
// Is this a non-PC bleeding?
const string HABD_NPC_BLEED = "HABDNPCB";
// Temporarily store the NPCs master
const string HABD_NPC_MASTER = "HABDNPCM";
// Store the scroll that will be used to bring the player back if
// HABD_FORCE_RAISE_USES_SCROLLS is set to TRUE.
const string HABD_STORED_SCROLL = "HABDSRez";

// Turns on developer debugging information. Should not be used.
const int HABD_DEBUG = FALSE;

// The name and version of this script.
const string HABD_VERSION = "Hemophiliacs Always Bleed to Death v0.03 ALPHA";

// ****************************************************************************
// COMMON FUNCTIONS
// ****************************************************************************

string HABDGetPlayerStateName (object oPC)
{
    int iState = GetLocalInt(GetModule(), HABD_PLAYER_STATE+GetPCPlayerName(oPC)+GetName(oPC));
    switch(iState)
    {
        case HABD_STATE_PLAYER_ALIVE: return "alive";
        case HABD_STATE_PLAYER_BLEEDING: return "bleeding to death";
        case HABD_STATE_RESPAWNED_GHOST: return "respawned as a ghost";
        case HABD_STATE_PLAYER_DEAD: return "dead";
        case HABD_STATE_PLAYER_INSTANT_DEATH: return "instant death";
    }
    return "Unknown State "+IntToString(iState);
}

// ****************************************************************************

// Applies XP/GP penalty to the player. Increments global statistics.
//   oPC - the player to apply the penalty to.
//   iPercXP - percentage of XP to remove (100% = 1 level)
//   iPercGP - percentage of GP to remove (100% = all gold)
void HABDApplyPenalty(object oPC, int iPercXP, int iPercGP);

void HABDApplyPenalty(object oPC, int iPercXP, int iPercGP)
{
    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);

    // Do nothing if no penalty should be applied.
    if ((iPercXP == 0) && (iPercGP == 0) || (!GetIsPC(oPC))) return;

    int nXP = GetXP(oPC);
    int nPenalty = iPercXP * 10 * GetHitDice(oPC); //1000 = 100% penalty.
    int nHD = GetHitDice(oPC);
    int nMin = ((nHD * (nHD - 1)) / 2) * 1000;

    // Should we prevent the player from losing a level?
    int nNewXP = nXP - nPenalty;
    if (HABD_NO_LEVEL_LOSS_FROM_XP_PENALTY)
    {
        if (nNewXP < nMin) nNewXP = nMin;
    }
    // Should we limit the amount of gold taken from the player?
    int nGoldToTake = FloatToInt(iPercGP * GetGold(oPC) / 100.0);  //0.75 = 75% of players gold
    if (
        (HABD_MAX_GP_LOSS_FROM_GP_PENALTY > 0) &&
        (nGoldToTake > HABD_MAX_GP_LOSS_FROM_GP_PENALTY)
        )
    {
        nGoldToTake = HABD_MAX_GP_LOSS_FROM_GP_PENALTY;
        SendMessageToPC(oPC, "OOC: GP loss has reached maximum cap of "+IntToString(nGoldToTake)+" GP.");
    }
    // Increment statistics.
    SetLocalInt(oMod, HABD_LOST_XP_COUNT+sID, GetLocalInt(oMod, HABD_LOST_XP_COUNT+sID)+nXP-nNewXP);
    SetLocalInt(oMod, HABD_LOST_GP_COUNT+sID, GetLocalInt(oMod, HABD_LOST_GP_COUNT+sID)+nGoldToTake);
    SetLocalInt(oMod, HABD_CURRENT_LOST_XP_COUNT+sID, GetLocalInt(oMod, HABD_CURRENT_LOST_XP_COUNT+sID)+nXP-nNewXP);
    SetLocalInt(oMod, HABD_CURRENT_LOST_GP_COUNT+sID, GetLocalInt(oMod, HABD_CURRENT_LOST_GP_COUNT+sID)+nGoldToTake);

    // Apply XP penalty.
    if (nNewXP < nXP) SetXP(oPC, nNewXP);
    else
    {
        SendMessageToPC(oPC, "OOC: XP loss has reached minimum cap to prevent level loss.");
        nPenalty = 0;
    }
    // Apply GP penalty.
    AssignCommand(oPC, TakeGoldFromCreature(nGoldToTake, oPC, TRUE));
    // Notification.
    string sMsg = "DEATH PENALTY APPLIED: " +GetName(oPC) + " " + IntToString(nPenalty) + " XP ("+IntToString(iPercXP)+"%), " + IntToString(nGoldToTake) + " GP ("+IntToString(iPercGP)+"%).";
    if (HABD_DM_NOTIFICATION_ON_PENALTY) SendMessageToAllDMs(sMsg);
    SendMessageToPC(oPC, sMsg);
    return;
}

// ****************************************************************************

// If the player is bleeding, it will stabilize them with no penalties. If the
// player is dead it will restore them to alive state and apply the penalty
// based on the spell used to restore them. This function does not guard against
// casting on living players because the raise/rez spells already do that.
//   oPC - the dead/bleeding player.
//   nSpell - SPELL_RAISE_DEAD or SPELL_RESURRECTION
void HABDApplyPenaltyIfDead(object oPC, int nSpell);

void HABDApplyPenaltyIfDead(object oPC, int nSpell)
{
    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);
    // Check if casting raise/rez on a bleeding player
    if (GetLocalInt(oMod, HABD_PLAYER_STATE+sID) == HABD_STATE_PLAYER_BLEEDING)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(1), oPC);
        FloatingTextStringOnCreature("SUCCESS: stabilized "+GetName(oPC)+".", oPC);
        return;
    }
    // Set player back to alive, assumed that the player is NOT in the alive
    // state. Otherwise potential exploit of casting on living players to give
    // them penalties.
    SetLocalInt(oMod, HABD_PLAYER_STATE+sID, HABD_STATE_PLAYER_ALIVE);
    if (nSpell == SPELL_RAISE_DEAD)
    {
        HABDApplyPenalty(oPC, HABD_RAISE_XP_LOSS, HABD_RAISE_GP_LOSS);
        AssignCommand(oPC, HABDUserDefinedRaise());
    }
    if (nSpell == SPELL_RESURRECTION)
    {
        HABDApplyPenalty(oPC, HABD_REZ_XP_LOSS, HABD_REZ_GP_LOSS);
        AssignCommand(oPC, HABDUserDefinedResurrection());
    }
}

// ****************************************************************************

// Returns the party size of oPC's party. Party size does not include non-PCs.
int HABDGetPartySize (object oPC);

int HABDGetPartySize (object oPC)
{
    int i = 0;
    object oParty = GetFirstFactionMember(oPC);
    while (GetIsObjectValid(oParty))
    {
        i++;
        oParty = GetNextFactionMember(oPC);
    }
    return (i);
}

// ****************************************************************************

// Returns the time interval in seconds that it takes for a player to bleed
// -1 HP.
//   oPC - player to get the bleed duration for.
//   iNotify - if TRUE and the player is solo then they will receive a warning
//             that they are bleeding to death very fast because they do not
//             have a party.
float HABDGetBleedTimer (object oPC, int iNotify = TRUE);

float HABDGetBleedTimer (object oPC, int iNotify = TRUE)
{
    // Is fast bleeding for solo players enabled?
    if (HABD_SOLO_FAST_BLEED)
    {
        // Is the player solo?
        if (HABDGetPartySize(oPC) == 1)
        {
            // Should we warn them?
            if (iNotify == TRUE) SendMessageToPC(oPC, "With no one around you to help, your heartrate increases...Causing you to bleed out faster.");
            return (1.0);
        }
    }
    // Get the scaled bleed duration based on the player's level.
    int iLevel = GetHitDice(oPC);
    int iRounds = 1;
    switch (iLevel)
    {
        case 01: iRounds = HABD_ROUNDS_PER_BLEED_01; break;
        case 02: iRounds = HABD_ROUNDS_PER_BLEED_02; break;
        case 03: iRounds = HABD_ROUNDS_PER_BLEED_03; break;
        case 04: iRounds = HABD_ROUNDS_PER_BLEED_04; break;
        case 05: iRounds = HABD_ROUNDS_PER_BLEED_05; break;
        case 06: iRounds = HABD_ROUNDS_PER_BLEED_06; break;
        case 07: iRounds = HABD_ROUNDS_PER_BLEED_07; break;
        case 08: iRounds = HABD_ROUNDS_PER_BLEED_08; break;
        case 09: iRounds = HABD_ROUNDS_PER_BLEED_09; break;
        case 10: iRounds = HABD_ROUNDS_PER_BLEED_10; break;
        case 11: iRounds = HABD_ROUNDS_PER_BLEED_11; break;
        case 12: iRounds = HABD_ROUNDS_PER_BLEED_12; break;
        case 13: iRounds = HABD_ROUNDS_PER_BLEED_13; break;
        case 14: iRounds = HABD_ROUNDS_PER_BLEED_14; break;
        case 15: iRounds = HABD_ROUNDS_PER_BLEED_15; break;
        case 16: iRounds = HABD_ROUNDS_PER_BLEED_16; break;
        case 17: iRounds = HABD_ROUNDS_PER_BLEED_17; break;
        case 18: iRounds = HABD_ROUNDS_PER_BLEED_18; break;
        case 19: iRounds = HABD_ROUNDS_PER_BLEED_19; break;
        case 20: iRounds = HABD_ROUNDS_PER_BLEED_20; break;
    }
    if (HABD_DEBUG) return (6.0);
    else return (iRounds * 6.0);
}

// ****************************************************************************

// Bring a respawned ghost back to life.
//   oTarget - the respawned ghost player.
//   nSpell - SPELL_RAISE_DEAD or SPELL_RESURRECTION
void HABDCureRespawnGhost(object oTarget, int nSpell);

void HABDCureRespawnGhost(object oTarget, int nSpell)
{
    // Do nothing if cast on a player who is still dead.
    if(!GetIsDead(oTarget))
    {
        object oMod = GetModule();
        string sID = GetPCPlayerName(oTarget)+GetName(oTarget);
        // If the player state wasn't respawned then do nothing.
        if (GetLocalInt(GetModule(), HABD_PLAYER_STATE+sID) == HABD_STATE_RESPAWNED_GHOST)
        {
            FloatingTextStringOnCreature("OOC: You have been brought back to life.", oTarget, FALSE);
            // Allow the player to take damage.
            SetPlotFlag(oTarget, FALSE);
            // Set the player back to alive.
            SetLocalInt(GetModule(), HABD_PLAYER_STATE+sID, HABD_STATE_PLAYER_ALIVE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_RAISE_DEAD), oTarget);
            if (nSpell == SPELL_RAISE_DEAD)
            {
                HABDApplyPenalty(oTarget, HABD_RAISE_XP_LOSS, HABD_RAISE_GP_LOSS);
                AssignCommand(oTarget, HABDUserDefinedRaise());
            }
            if (nSpell == SPELL_RESURRECTION)
            {
                HABDApplyPenalty(oTarget, HABD_REZ_XP_LOSS, HABD_REZ_GP_LOSS);
                AssignCommand(oTarget, HABDUserDefinedResurrection());
            }
        }
    }
 }

// ****************************************************************************

// Unequip all regeneration items that a player is wearing. Items are stored
// as a local array so that they can be re-equipped later.
//   oPC - the player to unequip the items for.
void HABDRegenerationItemsUnequip(object oPC);

void HABDRegenerationItemsUnequip(object oPC)
{
    // If the player already has unequiped items they never had a re-equip
    // call for then do nothing. WARNING: this could potential cause an
    // exploit if players can find a way to come back to life without initiating
    // the corresponding equip items call.
    if (GetLocalInt(oPC, HABD_UNEQUIPED_ITEMS) != 0) return;

    // Go through the players inventory and unequip all of their regeneration
    // items.
    int iCount = 0;
    int i;
    object oItem;
    object oNewItem;
    for (i=0; i<NUM_INVENTORY_SLOTS; i++)
    {
        oItem = GetItemInSlot(i, oPC);
        if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_REGENERATION))
        {
            iCount++;
            // Stupid work around to ActionUnequip item not working in a timely manner.
            oNewItem = CopyItem(oItem, oPC);
            DestroyObject(oItem);
            SendMessageToPC(oPC, "Unequipping "+GetName(oItem));
            SetLocalObject(oPC, HABD_UNEQUIPED_ITEMS+IntToString(iCount), oNewItem);
            SetLocalInt(oPC, HABD_UNEQUIPED_ITEMS+"Slot"+IntToString(iCount), i);
        }
    }
    SetLocalInt(oPC, HABD_UNEQUIPED_ITEMS, iCount);
}

// ****************************************************************************

// Re-equip all regeneration items that a player is wearing. Items to be
// re-equipped were stored as a local array.
//   oPC - the player to re-equip the items for.
void HABDRegenerationItemsReEquip(object oPC);

void HABDRegenerationItemsReEquip(object oPC)
{
    int iNumItems = GetLocalInt(oPC, HABD_UNEQUIPED_ITEMS);
    // If the player has no unequipped regeneration items then do nothing.
    if (iNumItems == 0) return;
    int iCount;
    int iSlot;
    object oItem;
    // Go through the local array and equip all of the items if the player
    // still possesses them.
    for (iCount=1; iCount<=iNumItems; iCount++)
    {
        oItem = GetLocalObject(oPC, HABD_UNEQUIPED_ITEMS+IntToString(iCount));
        iSlot = GetLocalInt(oPC, HABD_UNEQUIPED_ITEMS+"Slot"+IntToString(iCount));
        if (GetItemPossessor(oItem) == oPC)
        {
            SendMessageToPC(oPC, "Equipping "+GetName(oItem));
            AssignCommand(oPC, ActionEquipItem(oItem, iSlot));
        }
        DeleteLocalObject(oPC, HABD_UNEQUIPED_ITEMS+IntToString(iCount));
        DeleteLocalInt(oPC, HABD_UNEQUIPED_ITEMS+"Slot"+IntToString(iCount));
    }
    DeleteLocalInt(oPC, HABD_UNEQUIPED_ITEMS);
}

// ****************************************************************************

// Give the player any of the HABD items they are missing.
//   oPC - player entering the module.
void HABDItemsOnClientEnter(object oPC);

void HABDItemsOnClientEnter(object oPC)
{
    // Check for death token.
    if(!GetIsObjectValid(GetItemPossessedBy(oPC, HABD_ITEM_TOKEN)))
    {
        CreateItemOnObject(HABD_ITEM_TOKEN, oPC, 1);
    }
    // Check forsbandage.
    if(!GetIsObjectValid(GetItemPossessedBy(oPC, HABD_ITEM_BANDAGES)))
    {
        CreateItemOnObject(HABD_ITEM_BANDAGES, oPC, 1);
    }
    // Check for rule book.
    if(!GetIsObjectValid(GetItemPossessedBy(oPC, HABD_ITEM_RULES)))
    {
        CreateItemOnObject(HABD_ITEM_RULES, oPC, 1);
    }
}

// ****************************************************************************

// Prevent the player from transfering their HABD items. Not strictly necessary
// since players will automatically get the items when they enter the module,
// but can prevent some headaches later on for players who are new to the system.
int HABDOnUnAcquiredItem(object oPC, object oItem);

int HABDOnUnAcquiredItem(object oPC, object oItem)
{
    string sTag = GetTag(oItem);
    // Check to see if the unacquired item has a tag that we recognize.
    if (
        (sTag == HABD_ITEM_TOKEN) ||
        (sTag == HABD_ITEM_BANDAGES) ||
        (sTag == HABD_ITEM_RULES)
        )
    {
        CopyItem(oItem, oPC);
        DestroyObject(oItem);
        FloatingTextStringOnCreature(GetName(oItem)+" cannot be dropped.", oPC);
        return TRUE;
    }
    return FALSE;
}

// ****************************************************************************

// Use the bandage item on oTarget. If oTarget is bleeding then they will be
// stabilized if oPC passes a DC=15 Heal skill check. If oTarget is a respawned
// ghost then they will be made to follow oPC.
//   oPC - the player using the item.
//   oTarget - the target to use the item on.
void HABDItemBandages(object oPC, object oTarget);

void HABDItemBandages(object oPC, object oTarget)
{
    // Make sure that the bandage is being used on a valid player.
    if (!GetIsObjectValid(oTarget) || !(GetIsPC(oTarget) || GetLocalInt(oTarget, HABD_NPC_BLEED)))
    {
        FloatingTextStringOnCreature("FAILURE: bandages can only be used on players and henchmen.", oPC, FALSE);
        return;
    }
    // Make them run to the target.
    AssignCommand(oPC, ActionForceMoveToObject(oTarget, TRUE, 0.5, 6.0));
    // Check the state of the target.
    int iState = GetLocalInt(GetModule(), HABD_PLAYER_STATE+GetPCPlayerName(oTarget)+GetName(oTarget));
    if (iState == HABD_STATE_PLAYER_BLEEDING)
    {
        string sMsg;
        int nDC = 15;
        if(GetHasFeat(1161,oPC))
        {
            nDC = 5;
        }

        // The target is bleeding, try to heal them.
        if (GetIsSkillSuccessful(oPC, SKILL_HEAL, nDC))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(1), oTarget);
            sMsg = "SUCCESS: bandaged "+GetName(oTarget)+".";
        } else {
            sMsg = "FAILURE: could not bandage "+GetName(oTarget)+". Try again.";
        }
        // If oPC and oTarget are in the same party, then use a floating text string
        if (GetFactionEqual(oPC, oTarget))
        {
            FloatingTextStringOnCreature(sMsg, oPC);
        } else if (!GetIsDM(oPC))
        {
            AssignCommand(oPC, ActionSpeakString(sMsg));
        }
        return;
    }
    else if (iState == HABD_STATE_RESPAWNED_GHOST)
    {
        // The target is a ghost,
        if (
            (GetIsDM(oPC)) || // DMs always succeed
            (GetIsDM(GetMaster(oPC))) || // DM possessed NPCs always succeed
            (GetFactionEqual(oPC, oTarget)) // Party members always succeed
            )
        {
            FloatingTextStringOnCreature("SUCCESS: "+GetName(oTarget)+" will follow "+GetName(oPC)+".", oPC);
            SetLocalObject(oTarget, HABD_GHOST_AUTOFOLLOW, oPC);
        } else {
            AssignCommand(oPC, ActionSpeakString("FAILURE: "+GetName(oTarget)+" must be in the same party for you to move them."));
        }
        return;
    }
    // Could not handle the target's state.
    AssignCommand(oPC, ActionSpeakString("Bandages did nothing to "+GetName(oTarget)+" because they are "+HABDGetPlayerStateName(oPC)+"."));
}

// ****************************************************************************

// Display the HABD statistics to the DM.
//   oDM - the person innitating the statistics display.
//   oPC - a player in the party you want to to report the statistics on.
//   oItem - the item that activated this function.
void HABDItemDMToken (object oDM, object oPC, object oItem);

void HABDItemDMToken (object oDM, object oPC, object oItem)
{
    object oMod = GetModule();

    // Check if used by DM.
    if (
        (!GetIsDM(oDM) &&
        (!GetIsDM(GetMaster(oDM))) &&
        (!GetLocalInt(oMod, "dmfi_Admin" + GetPCPublicCDKey(oDM))))
        )
    {
        // This item is not usable by players.
        FloatingTextStringOnCreature("You cannot use this item." , oDM, FALSE);
        DestroyObject(oItem);
        return;
    }

    // Check if used on player.
    if ((!GetIsPC(oPC)) || GetIsDM(GetMaster(oPC)) || (GetIsDM(oPC)))
    {
        FloatingTextStringOnCreature("Can only be used on players. "+GetName(oPC)+" is not a player.", oDM, FALSE);
        return;
    }

    // Display stats for party.
    string sMsg;
    string sID;
    object oParty = GetFirstFactionMember(oPC, FALSE);
    while (GetIsObjectValid(oParty))
    {
        sID = GetPCPlayerName(oParty)+GetName(oParty);
        sMsg = GetName(oParty)+": bleeding "
            +IntToString(GetLocalInt(oMod, HABD_CURRENT_BLEED_COUNT+sID))
            +", died "+IntToString(GetLocalInt(oMod, HABD_CURRENT_DEATH_COUNT+sID))
            +", lost "+IntToString(GetLocalInt(oMod, HABD_CURRENT_LOST_XP_COUNT+sID))+" XP, lost "
            +IntToString(GetLocalInt(oMod, HABD_CURRENT_LOST_GP_COUNT+sID))+" GP since server restart.";
        if (HABD_DM_DISPLAY_STATS_TO_ALL) SendMessageToAllDMs(sMsg);
        else SendMessageToPC(oDM, sMsg);
        sMsg = GetName(oParty)+": bleeding "
            +IntToString(GetLocalInt(oMod, HABD_BLEED_COUNT+sID))
            +", died "+IntToString(GetLocalInt(oMod, HABD_DEATH_COUNT+sID))
            +", lost "+IntToString(GetLocalInt(oMod, HABD_LOST_XP_COUNT+sID))+" XP, lost "
            +IntToString(GetLocalInt(oMod, HABD_LOST_GP_COUNT+sID))+" GP in total.";
        if (HABD_DM_DISPLAY_STATS_TO_ALL) SendMessageToAllDMs(sMsg);
        else SendMessageToPC(oDM, sMsg);
        oParty = GetNextFactionMember(oPC, FALSE);
    }
    return;
}

// Instantly kill a player/henchman without going through bleed. Will also kill
// any NPC you point it at.
//   oDM - the person using this item.
//   oPC - a player/henchman you want to kill.
//   oItem - the item that activated this function.
void HABDItemDMDeath (object oDM, object oPC, object oItem);

void HABDItemDMDeath (object oDM, object oPC, object oItem)
{
    object oMod = GetModule();

    // Check if used by DM.
    if (
        (!GetIsDM(oDM) &&
        (!GetIsDM(GetMaster(oDM))) &&
        (!GetLocalInt(oMod, "dmfi_Admin" + GetPCPublicCDKey(oDM))))
        )
    {
        // This item is not usable by players.
        FloatingTextStringOnCreature("You cannot use this item." , oDM, FALSE);
        DestroyObject(oItem);
        return;
    }

    // Kill 'em.
    SetLocalInt(GetModule(), HABD_PLAYER_STATE+GetPCPlayerName(oPC)+GetName(oPC), HABD_STATE_PLAYER_DEAD);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oPC);

    return;
}

// ****************************************************************************

// Display the HABD statistics to the player.
//   oPC - the player to report the statistics on.
void HABDItemToken (object oPC);

void HABDItemToken (object oPC)
{
    object oMod = GetModule();
    string sID = GetPCPlayerName(oPC)+GetName(oPC);
    FloatingTextStringOnCreature("You have died "+IntToString(GetLocalInt(oMod, HABD_CURRENT_DEATH_COUNT+sID))+" times since server restart.", oPC, FALSE);
    FloatingTextStringOnCreature("You have started bleeding "+IntToString(GetLocalInt(oMod, HABD_CURRENT_BLEED_COUNT+sID))+" times since server restart.", oPC, FALSE);
    FloatingTextStringOnCreature("You have lost "+IntToString(GetLocalInt(oMod, HABD_CURRENT_LOST_XP_COUNT+sID))+" XP from dying since server restart.", oPC, FALSE);
    FloatingTextStringOnCreature("You have lost "+IntToString(GetLocalInt(oMod, HABD_CURRENT_LOST_GP_COUNT+sID))+" GP from dying since server restart.", oPC, FALSE);
    FloatingTextStringOnCreature("You have died "+IntToString(GetLocalInt(oMod, HABD_DEATH_COUNT+sID))+" times in total.", oPC, FALSE);
    FloatingTextStringOnCreature("You have started bleeding "+IntToString(GetLocalInt(oMod, HABD_BLEED_COUNT+sID))+" times in total.", oPC, FALSE);
    FloatingTextStringOnCreature("You have lost "+IntToString(GetLocalInt(oMod, HABD_LOST_XP_COUNT+sID))+" XP from dying.", oPC, FALSE);
    FloatingTextStringOnCreature("You have lost "+IntToString(GetLocalInt(oMod, HABD_LOST_GP_COUNT+sID))+" GP from dying.", oPC, FALSE);
}

// ****************************************************************************

string HABDGetDropType(int iSetting)
{
    switch (iSetting)
    {
        case 0: return "not dropped or destroyed";
        case 1: return "dropped";
        case 2: return "destroyed";
    }
    return "ERROR: unknown setting";
}


// Display the HABD rules to the player.
//   oPC - the player to show the rules to.
void HABDItemRules (object oPC);

void HABDItemRules (object oPC)
{
    int iXP = GetXP(oPC);
    int iGP = GetGold(oPC);
    int iTime = FloatToInt(HABDGetBleedTimer(oPC, FALSE));

    string sMsg = HABD_VERSION+"\n";
    SendMessageToPC(oPC, sMsg);

    if (GetIsDM(oPC) || (GetIsDM(GetMaster(oPC))))
    {
        sMsg = "SPECIAL DM RULES:\n";
        sMsg = sMsg + "- players cannot die until they are level "+IntToString(HABD_NO_DEATH_UNTIL_LEVEL)+"\n";
        if (HABD_DM_NOTIFICATION_ON_BLEED) sMsg = sMsg + "- DM channel notification on player/henchman bleed.\n";
        if (HABD_DM_NOTIFICATION_ON_DEATH) sMsg = sMsg + "- DM channel notification on player/henchman death.\n";
        if (HABD_DM_NOTIFICATION_ON_PENALTY) sMsg = sMsg + "- DM channel notification on player/henchman XP/GP penalty.\n";
        if (HABD_DM_DISPLAY_STATS_TO_ALL) sMsg = sMsg + "- DM channel notification when checking persistent stats for a party.\n";
        SendMessageToPC(oPC, sMsg);
    }

    sMsg = "PERSISTENCE:\n";
    if (HADB_DB_PERSISTENT) sMsg = sMsg + "- bleeding/death/respawn/autotimer state is saved over server restart, as well as statistics\n";
    SendMessageToPC(oPC, sMsg);

    sMsg = "BLEEDING RULES:\n";
    sMsg = sMsg + "- players bleed from 0 to -9 HP before death.\n";
    sMsg = sMsg + "- instant bleed of -6 to -9 will start at -5 HP.\n";
    sMsg = sMsg + "- instant death will start at -6 to -9 HP.\n";
    if (HABD_SOLO_FAST_BLEED) sMsg = sMsg + "- soloing without a party will take 1 second to bleed -1 HP.\n";
    sMsg = sMsg + "- it will take you "+IntToString(iTime)+" seconds to bleed -1 HP.\n";
    sMsg = sMsg + "- stabilization makes you recover to 1 HP.\n";
    sMsg = sMsg + "- there is a 10% chance of stabilization when you bleed a HP.\n";
    sMsg = sMsg + "- bandages can be used to stabilize a player on a DC=15 Heal skill check.\n";
    sMsg = sMsg + "- any healing, raise, or rez will stabilize a player.\n";
    if (HABD_NERF_REGENERATION_ITEMS) sMsg = sMsg + "- regeneration items are unequipped so that they do not prevent you from dying.\n";
    else sMsg = sMsg + "- regeneration items keep you from ever dying.\n";
    if (HABD_POST_BLEED_INVIS_DUR > 0.0) sMsg = sMsg + "- you have "+FloatToString(HABD_POST_BLEED_INVIS_DUR,3,1)+" seconds of free movement after stabilization.\n";
    else sMsg = sMsg + "- monsters can see you to attack you as soon as you stabilize.\n";
    SendMessageToPC(oPC, sMsg);

    sMsg = "DEATH RULES:\n";
    if (HABD_SOLO_FORCE_RAISE_TIMER > 0.0) sMsg = sMsg + "- raise dead is forced for solo players when dead for more than "+FloatToString(HABD_SOLO_FORCE_RAISE_TIMER, 3,0)+" seconds.\n";
    else sMsg = sMsg + "- there is no solo player forced raise.\n";
    if (HABD_FORCE_RAISE_TIMER > 0.0) sMsg = sMsg + "- raise dead is forced when dead for more than "+FloatToString(HABD_FORCE_RAISE_TIMER, 3,0)+" seconds.\n";
    else sMsg = sMsg + "- there is no party player forced raise.\n";
    if (HABD_NPC_FORCE_RAISE_TIMER > 0.0) sMsg = sMsg + "- raise dead is forced for henchmen when dead for more than "+FloatToString(HABD_NPC_FORCE_RAISE_TIMER, 3,0)+" seconds.\n";
    else sMsg = sMsg + "- there is no henchmen forced raise.\n";
    if (HABD_FORCE_RAISE_USES_SCROLLS) sMsg = sMsg + "- forced raise uses raise dead/resurrection scrolls. If you run out you will not be raised.\n";
    if (HABD_FORCE_RESPAWN_TIMER > 0.0) sMsg = sMsg + "- respawn is forced when dead for more than "+FloatToString(HABD_FORCE_RESPAWN_TIMER, 3,0)+" seconds.\n";
    else sMsg = sMsg + "- there is no forced respawn.\n";
    if (HABD_NPC_FORCE_RESPAWN_TIMER > 0.0) sMsg = sMsg + "- respawn is forced for henchmen when dead for more than "+FloatToString(HABD_NPC_FORCE_RESPAWN_TIMER, 3,0)+" seconds.\n";
    else sMsg = sMsg + "- there is no henchmen forced respawn.\n";
    SendMessageToPC(oPC, sMsg);

    sMsg = "PENALTIES:\n";
    sMsg = sMsg + "- respawn has a "+IntToString(HABD_RESPAWN_XP_LOSS)+"% XP and "+IntToString(HABD_RESPAWN_GP_LOSS)+"% GP penalty ("+IntToString(HABD_RESPAWN_XP_LOSS*iXP/100)+" XP and "+IntToString(HABD_RESPAWN_GP_LOSS*iGP/100)+" GP for you).\n";
    sMsg = sMsg + "- raise dead has a "+IntToString(HABD_RAISE_XP_LOSS)+"% XP and "+IntToString(HABD_RAISE_GP_LOSS)+"% GP penalty ("+IntToString(HABD_RAISE_XP_LOSS*iXP/100)+" XP and "+IntToString(HABD_RAISE_GP_LOSS*iGP/100)+" GP for you).\n";
    sMsg = sMsg + "- resurrection has a "+IntToString(HABD_REZ_XP_LOSS)+"% XP and "+IntToString(HABD_REZ_GP_LOSS)+"% GP penalty ("+IntToString(HABD_REZ_XP_LOSS*iXP/100)+" XP and "+IntToString(HABD_REZ_GP_LOSS*iGP/100)+" GP for you).\n";
    if (HABD_NO_LEVEL_LOSS_FROM_XP_PENALTY) sMsg = sMsg + "- XP penalty CANNOT cause level loss.\n";
    else sMsg = sMsg + "- XP penalty CAN cause level loss.\n";
    if (HABD_MAX_GP_LOSS_FROM_GP_PENALTY > 0) sMsg = sMsg + "- GP penalty is capped at "+IntToString(HABD_MAX_GP_LOSS_FROM_GP_PENALTY)+" GP.\n";
    else sMsg = sMsg + "- is NOT capped.\n";
    SendMessageToPC(oPC, sMsg);

    sMsg = "ITEM DROPPING ON DEATH:\n";
    if ((HABD_DROP_GOLD == 0) &&
        (HABD_DROP_RAISE_REZ == 0) &&
        (HABD_DROP_BACKPACK == 0) &&
        (HABD_DROP_WEAPON_SHIELD == 0) &&
        (HABD_DROP_EQUIPPED == 0) &&
        (HABD_DROP_RANDOM_EQUIPPED == 0) &&
        (HABD_DROP_RANDOM_BACKPACK == 0) &&
        (HABD_DROP_MOST_EXPENSIVE_EQUIPPED == 0) &&
        (HABD_DROP_MOST_EXPENSIVE_BACKPACK == 0)
       ) sMsg = sMsg + "- there is no item dropping/destruction on death.\n";
    if (HABD_DROP_GOLD > 0) sMsg = sMsg + "- all gold is "+HABDGetDropType(HABD_DROP_GOLD)+" on death.\n";
    if (HABD_DROP_WEAPON_SHIELD > 0) sMsg = sMsg + "- equipped left and right hand items are "+HABDGetDropType(HABD_DROP_WEAPON_SHIELD)+" on death.\n";
    if (HABD_DROP_RANDOM_EQUIPPED > 0) sMsg = sMsg + "- a random equipped item is "+HABDGetDropType(HABD_DROP_RANDOM_EQUIPPED)+" on death.\n";
    if (HABD_DROP_MOST_EXPENSIVE_EQUIPPED > 0) sMsg = sMsg + "- most expensive equipped item is "+HABDGetDropType(HABD_DROP_MOST_EXPENSIVE_EQUIPPED)+" on death.\n";
    if (HABD_DROP_EQUIPPED > 0) sMsg = sMsg + "- all equipped items are "+HABDGetDropType(HABD_DROP_EQUIPPED)+" on death.\n";
    if (HABD_DROP_RAISE_REZ > 0) sMsg = sMsg + "- raise dead/resurrection scrolls are "+HABDGetDropType(HABD_DROP_RAISE_REZ)+" on death.\n";
    if (HABD_DROP_RANDOM_BACKPACK > 0) sMsg = sMsg + "- a random backpack item is "+HABDGetDropType(HABD_DROP_RANDOM_BACKPACK)+" on death.\n";
    if (HABD_DROP_MOST_EXPENSIVE_BACKPACK > 0) sMsg = sMsg + "- most expensive backpack item is "+HABDGetDropType(HABD_DROP_MOST_EXPENSIVE_BACKPACK)+" on death.\n";
    if (HABD_DROP_BACKPACK > 0) sMsg = sMsg + "- all backpack items are "+HABDGetDropType(HABD_DROP_BACKPACK)+" on death.\n";
    SendMessageToPC(oPC, sMsg);

    sMsg = "RESPAWN:\n";
    if (HABD_RESPAWN_ALLOWED)
    {
        if (HABD_INSTANT_RESPAWN_ALLOWED) sMsg = sMsg + "- player controlled respawn IS allowed.\n";
        else sMsg = sMsg + "- player controlled respawn NOT allowed.\n";
        if (HABD_RESPAWN_SCRIPT == "habd_onpcrespawn")
        {
            sMsg = sMsg + "- on respawn you will become a ghost and lose control of your player.\n";
            sMsg = sMsg + "- other players can use bandages on your ghost to lead you to help.\n";
            sMsg = sMsg + "- raise or rez will bring the ghost back to life.\n";
            if (HABD_HENCHMEN_GHOST_RESPAWN) sMsg = sMsg + "- same respawn system is used for henchmen.\n";
            else sMsg = sMsg + "- custom respawn system used for henchmen (unknown).\n";
        } else sMsg = sMsg + "- custom respawn system used (unknown).\n";
    } else sMsg = sMsg + "- respawn is NOT allowed.\n";
    SendMessageToPC(oPC, sMsg);

    if (
        (HABD_USERDEFINED_BLEED_DESC != "") ||
        (HABD_USERDEFINED_RESPAWN_DESC != "") ||
        (HABD_USERDEFINED_RAISE_DESC != "") ||
        (HABD_USERDEFINED_RESURRECTION_DESC != "")
        )
    {
        sMsg = "ADDITIONAL:\n";
        if (HABD_USERDEFINED_BLEED_DESC != "") sMsg = sMsg+"OnBleedStabilized: "+HABD_USERDEFINED_BLEED_DESC+"\n";
        if (HABD_RESPAWN_SCRIPT == "habd_onpcrespawn")
        {
            if (HABD_USERDEFINED_RESPAWN_DESC != "") sMsg = sMsg+"OnRespawned: "+HABD_USERDEFINED_RESPAWN_DESC+"\n";
        }
        if (HABD_USERDEFINED_RAISE_DESC != "") sMsg = sMsg+"OnRaised: "+HABD_USERDEFINED_RAISE_DESC+"\n";
        if (HABD_USERDEFINED_RESURRECTION_DESC != "") sMsg = sMsg+"OnRezzed: "+HABD_USERDEFINED_RESURRECTION_DESC+"\n";
        SendMessageToPC(oPC, sMsg);
    }
}

// ****************************************************************************

// OnActivateItem event handler. Runs the corresponding functionality based on
// the item's tag.
//   oPC - the player activating the item.
//   oTarget - the player's target.
//   oItem - the item they activated.
int HABDOnActivateItem(object oPC, object oTarget, object oItem);

int HABDOnActivateItem(object oPC, object oTarget, object oItem)
{
    string sTag = GetTag(oItem);
    // Have bandages at the top since they are usually time critical.
    if (sTag == HABD_ITEM_BANDAGES)
    {
        HABDItemBandages(oPC, oTarget);
        return TRUE;
    }
    if (sTag == HABD_ITEM_DM_DEATH)
    {
        HABDItemDMDeath(oPC, oTarget, oItem);
        return TRUE;
    }
    if (sTag == HABD_ITEM_TOKEN)
    {
        HABDItemToken(oPC);
        return TRUE;
    }
    if (sTag == HABD_ITEM_DM_TOKEN)
    {
        HABDItemDMToken(oPC, oTarget, oItem);
        return TRUE;
    }
    if (sTag == HABD_ITEM_RULES)
    {
        HABDItemRules(oPC);
        return TRUE;
    }
    return FALSE;
}

// ****************************************************************************

// Returns the ith element in a comma-separated-value string. If the element
// does not exist it returns an empty string.
//   sStr - the CSV string.
//   i - the ith element.
string HABDStrTok(string sStr, int i);

string HABDStrTok(string sStr, int i)
{
    int iIndex = 1;
    int iLast = 0;
    int iPos = GetStringLength(sStr);
    int iDelimiter = FindSubString(sStr, ",");
    while (iDelimiter != -1)
    {
        if (iIndex == i) return GetStringLeft(GetStringRight(sStr, iPos), iDelimiter);
        iIndex++;
        iPos = iPos - iDelimiter - 1;
        iDelimiter = FindSubString(GetStringRight(sStr, iPos), ",");
    }
    return "";
}

// ****************************************************************************

// OnClientEnter event handler. Used to restore the information from the
// persistent DB. It also resets the bleeding/death/respawn state over
// server resets.
//   oPC - player to restore information to.
void HABDGetDBOnClientEnter(object oPC);

void HABDGetDBOnClientEnter(object oPC)
{
    // Remove any accidental states that might have been stored on the player
    // file.
    //SetPlotFlag(oPC, FALSE);
    SetCommandable(TRUE, oPC);
    // This might screw things up if you are messing around with the faction
    // system a lot.
    SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 0, oPC);

    if (!HADB_DB_PERSISTENT) return;

    string sID = GetPCPlayerName(oPC)+GetName(oPC);
    object oMod = GetModule();

    // Store the player's public CD key. That information is needed for writing
    // to the database in the OnClientLeave event (because you can't determine
    // the player's CD key after they have left).
    SetLocalString(oMod, HABD_PERSISTANT_ID+GetName(oPC), GetPCPlayerName(oPC));

    // We use packed strings in the database to reduce database access since
    // its slow. Database index is limited to 32 characters.
    string sData = GetCampaignString(HABD_DB_NAME, GetStringLeft(HABD_PERSIST_NAME+sID, 32));
    // Load statistics
    int iDCount = StringToInt(HABDStrTok(sData, 1));
    int iBCount = StringToInt(HABDStrTok(sData, 2));
    int iXCount = StringToInt(HABDStrTok(sData, 3));
    int iGCount = StringToInt(HABDStrTok(sData, 4));
    // Restore the counters.
    SetLocalInt(oMod, HABD_DEATH_COUNT+sID, iDCount);
    SetLocalInt(oMod, HABD_BLEED_COUNT+sID, iBCount);
    SetLocalInt(oMod, HABD_LOST_XP_COUNT+sID, iXCount);
    SetLocalInt(oMod, HABD_LOST_GP_COUNT+sID, iGCount);
    // Load state
    int iHP = StringToInt(HABDStrTok(sData, 5));
    int iState = StringToInt(HABDStrTok(sData, 6));
    int iRespawn = StringToInt(HABDStrTok(sData, 7));
    int iRaise = StringToInt(HABDStrTok(sData, 8));
    // Restore state.
    SetLocalInt(oMod, HABD_PLAYER_STATE+sID, iState);
    SetLocalInt(oMod, HABD_LAST_HP+sID, iHP);
    // Only apply timers if they are enabled. Module settings could have changed.
    if (HABD_FORCE_RESPAWN_TIMER > 0.0) SetLocalInt(oMod, HABD_RESPAWN_TIMER+sID, iRespawn);
    if ((HABD_FORCE_RAISE_TIMER > 0.0) || (HABD_SOLO_FORCE_RAISE_TIMER > 0.0)) SetLocalInt(oMod, HABD_RAISE_TIMER+sID, iRaise);
    // Reapply bleeding.
    if (iState == HABD_STATE_PLAYER_BLEEDING)
    {
        SetLocalInt(oPC, HABD_PERSISTANT_REAPPLY, 1);
        int iDmg = GetCurrentHitPoints(oPC) - iHP;
        SendMessageToPC(oPC, "HABD_DB: Restoring bleeding by doing "+IntToString(iDmg)+" HP damage.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(iDmg, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE), oPC);
        //SetPlotFlag(oPC, TRUE);
    }
    // Reapply death.
    if (iState == HABD_STATE_PLAYER_DEAD)
    {
        SetLocalInt(oPC, HABD_PERSISTANT_REAPPLY, 1);
        SendMessageToPC(oPC, "HABD_DB: Restoring death.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oPC);
    }
    // Reapply respawn.
    if (iState == HABD_STATE_RESPAWNED_GHOST)
    {
        SetLocalInt(oPC, HABD_PERSISTANT_REAPPLY, 1);
        SendMessageToPC(oPC, "HABD_DB: Restoring ghost respawn.");
        SetLocalInt(oPC, HABD_FORCED_RESPAWN, 1);
        AssignCommand(oPC, ExecuteScript(HABD_RESPAWN_SCRIPT, oPC));
    }

    // Log stuff to the server log for debugging purposes. Remove this later
    // to speed things up even more.
    PrintString("HABD_DB: Restoring "+sID+" gives "+sData);
    PrintString("HABD_DB: Restoring "+sID+" Death="+IntToString(iDCount)+" Bleed="+IntToString(iBCount)+" XPLost="+IntToString(iXCount)+" GPLost="+IntToString(iGCount));
    // Log stuff to the server log for debugging purposes. Remove this later
    // to speed things up even more.
    PrintString("HABD_DB: Restoring "+sID+" gives "+sData);
    PrintString("HABD_DB: Restoring "+sID+" iHP="+IntToString(iHP)+" iState="+IntToString(iState)+" iRespawnTimer="+IntToString(iRespawn)+" iRaiseTimer="+IntToString(iRaise));
}

// ****************************************************************************

// OnClientLeave event handler. Used to store the information from the
// persistent DB. It also resets the bleeding/death/respawn state over
// server resets.
//   sName - name of the player to store information about.
void HABDSetDBOnClientLeave(string sName);

void HABDSetDBOnClientLeave(string sName)
{
    if (!HADB_DB_PERSISTENT) return;

    object oMod = GetModule();
    // Note: GetPCPlayerName does not function in the OnClientLeave event.
    // So use the player's name to get the shadowed version we stored in the
    // OnClientEnter.
    string sID = GetLocalString(oMod, HABD_PERSISTANT_ID+sName)+sName;
    // Shadow module level variables to local variables.
    int iHP = GetLocalInt(oMod, HABD_LAST_HP+sID);
    int iState = GetLocalInt(oMod, HABD_PLAYER_STATE+sID);
    int iRespawn = GetLocalInt(oMod, HABD_RESPAWN_TIMER+sID);
    int iRaise = GetLocalInt(oMod, HABD_RAISE_TIMER+sID);
    int iDCount = GetLocalInt(oMod, HABD_DEATH_COUNT+sID);
    int iBCount = GetLocalInt(oMod, HABD_BLEED_COUNT+sID);
    int iXCount = GetLocalInt(oMod, HABD_LOST_XP_COUNT+sID);
    int iGCount = GetLocalInt(oMod, HABD_LOST_GP_COUNT+sID);

    // Pack data into a string to reduce database accesses.
    string sData = IntToString(iDCount)+","+IntToString(iBCount)+","+IntToString(iXCount)+","+IntToString(iGCount)+","+IntToString(iHP)+","+IntToString(iState)+","+IntToString(iRespawn)+","+IntToString(iRaise)+",0";
    // Database index is limited to 32 characters.
    SetCampaignString(HABD_DB_NAME, GetStringLeft(HABD_PERSIST_NAME+sID,32), sData);

    // Log stuff to the server log for debugging purposes. Remove this later
    // to speed things up even more.
    PrintString("HABD_DB: Storing "+sID+" iHP="+IntToString(iHP)+" iState="+IntToString(iState)+" iRespawnTimer="+IntToString(iRespawn)+" iRaiseTimer="+IntToString(iRaise));
    PrintString("HABD_DB: Storing "+sID+" Death="+IntToString(iDCount)+" Bleed="+IntToString(iBCount)+" XPLost="+IntToString(iXCount)+" GPLost="+IntToString(iGCount));
    PrintString("HABD_DB: Storing "+sID+" "+sData);
}

// ****************************************************************************

const int HABD_NW_ASC_IS_BUSY = 0x40000000;

void HABDAssociateBusy()
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_ASSOCIATE_MASTER");
    nPlot = nPlot | HABD_NW_ASC_IS_BUSY;
    SetLocalInt(OBJECT_SELF, "NW_ASSOCIATE_MASTER", nPlot);
}

void HABDAssociateNotBusy()
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_ASSOCIATE_MASTER");
    nPlot = nPlot & ~HABD_NW_ASC_IS_BUSY;
    SetLocalInt(OBJECT_SELF, "NW_ASSOCIATE_MASTER", nPlot);
}

void HABDRecoverHenchmanInstantDeath()
{
    // Should regeneration items be removed from bleeding players?
    if (HABD_NERF_REGENERATION_ITEMS)
    {
        AssignCommand(OBJECT_SELF, HABDRegenerationItemsUnequip(OBJECT_SELF));
    }

    // Keep the player from taking additional damage while bleeding.
    //SetPlotFlag(OBJECT_SELF, TRUE);
    // Bring the player back from death and make them bleed.
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), OBJECT_SELF);
    int iBleed = 1+Random(4);
    // Give them back their master.
    //AddHenchman(GetLocalObject(oPC, HABD_NPC_MASTER), oPC);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectTemporaryHitpoints(10), OBJECT_SELF);
    // Ten minutes should be enough for the NPC to bleed to death.
    AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 6.0));
    //SetPlotFlag(OBJECT_SELF, FALSE);
    // Will leave player at -6 to -9
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iBleed, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE), OBJECT_SELF);
    //SetPlotFlag(OBJECT_SELF, TRUE);
    // stop nearby attackers
    AssignCommand(OBJECT_SELF, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectInvisibility(INVISIBILITY_TYPE_NORMAL), OBJECT_SELF, 6.0));
}

int HABDMakeHenchmanBleed()
{
    // Only run on henchmen.
    if (GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetMaster()) != OBJECT_SELF) return FALSE;
    string sID = GetPCPlayerName(OBJECT_SELF)+GetName(OBJECT_SELF);
    object oMod = GetModule();
    if (HABD_DEBUG) SpeakString("DEBUG: HABD OnHenchmanDeath, "+GetName(OBJECT_SELF)+", HP: "+IntToString(GetCurrentHitPoints(OBJECT_SELF))+", master: "+GetName(GetMaster(OBJECT_SELF))+", state:"+HABDGetPlayerStateName(OBJECT_SELF), TALKVOLUME_SHOUT);

    // Check to see if they have bled at all - if not then give them a chance to bleed.
    int iState = GetLocalInt(oMod, HABD_PLAYER_STATE+sID);
    if ((iState == HABD_STATE_PLAYER_DEAD) || (iState == HABD_STATE_PLAYER_BLEEDING))
    {
        // The henchmen is supposed to be dead.
        if (HABD_HENCHMEN_GHOST_RESPAWN)
        {
            // Run the ghost respawn on the henchman.
            DelayCommand(1.0, ExecuteScript("habd_onpcdeath", OBJECT_SELF));
            SetLocalInt(OBJECT_SELF, HABD_NPC_BLEED, 1);
            SetLocalObject(OBJECT_SELF, HABD_NPC_MASTER, GetMaster(OBJECT_SELF));
        } else {
            // Run the normal death stuff.
            SetIsDestroyable(TRUE, TRUE, TRUE);
            HABDAssociateNotBusy();
            return FALSE;
        }
    }
    else
    {
        // Player died without going through bleeding.
        // Special state for this circumstance.
        SetLocalInt(oMod, HABD_PLAYER_STATE+sID, HABD_STATE_PLAYER_INSTANT_DEATH);
        // The henchman is supposed to be bleeding.
        DelayCommand(1.0, ExecuteScript("habd_onpcdying", OBJECT_SELF));
        DelayCommand(0.5, HABDRecoverHenchmanInstantDeath());
    }
    // Keep the associate from healing themselves. Stay dead, dammit!
    HABDAssociateBusy();
    // Keep the corpse from fading because we have to bring it back from death.
    SetIsDestroyable(FALSE, TRUE, TRUE);
    // Check to see if they have bled at all - if not then give them a chance to bleed.
    if (GetLocalInt(oMod, HABD_PLAYER_STATE+sID) != HABD_STATE_PLAYER_DEAD)
    {
        // Player died without going through bleeding.
        // Special state for this circumstance.
        SetLocalInt(oMod, HABD_PLAYER_STATE+sID, HABD_STATE_PLAYER_INSTANT_DEATH);
    }
    SetLocalInt(OBJECT_SELF, HABD_NPC_BLEED, 1);
    SetLocalObject(OBJECT_SELF, HABD_NPC_MASTER, GetMaster(OBJECT_SELF));
    return TRUE;
}

