//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT7
/*
  Default OnDeath event handler for NPCs.

  Adjusts killer's alignment if appropriate and
  alerts allies to our death.
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////
//:://////////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified On: April 1st, 2008
//:: Added Support for Dying Wile Mounted
//:://///////////////////////////////////////////////

#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "x3_inc_horse"
#include "_inc_loot"
#include "te_bountyhandle"

void main()
{
    object oKiller = GetLastKiller();
    if(GetLocalInt(OBJECT_SELF,"DiedOnce"))
    {
        // This should make the last killer us.
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(GetMaxHitPoints()), OBJECT_SELF);
    }
    else
    {
        // Set have died once, stops giving out mulitple amounts of XP.
        SetLocalInt(OBJECT_SELF,"DiedOnce",TRUE);

    /*/////////////////////// [Experience] /////////////////////////////////////////
        THIS is the place for it, below this comment.

        It is useful to use GetFirstFactionMember (and Next), GiveXPToCreature,
        GetXP, SetXP, GetChallengeRating (of self) all are really useful.

        Bug note: GetFirstFactionMember/Next with the PC parameter means either ONLY PC,
        and so NPC henchmen, unless FALSE is used, will not be even recognised.
    ///////////////////////// [Experience] ///////////////////////////////////////*/
    // Do XP things (Use object "oKiller" for who killed us).
        ExecuteScript("sf_xp", OBJECT_SELF);
/*/////////////////////// [Experience] ///////////////////////////////////////*/
    }
    if (GetLocalInt(GetModule(),"X3_ENABLE_MOUNT_DB")&&GetIsObjectValid(GetMaster(OBJECT_SELF))) SetLocalInt(GetMaster(OBJECT_SELF),"bX3_STORE_MOUNT_INFO",TRUE);

    TE_DeathHandle(OBJECT_SELF,oKiller);

    // Call to allies to let them know we're dead
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

    // NOTE: the OnDeath user-defined event does not
    // trigger reliably and should probably be removed
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
         SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }
    LootCreatureDeath(OBJECT_SELF,oKiller);
}

