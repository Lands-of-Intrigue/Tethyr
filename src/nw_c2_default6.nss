//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT6
//:: Default OnDamaged handler
/*
    If already fighting then ignore, else determine
    combat round
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////
//:://////////////////////////////////////////////////
//:: Modified By: Deva Winblood
//:: Modified On: Jan 17th, 2008
//:: Added Support for Mounted Combat Feat Support
//:://////////////////////////////////////////////////
//:: Modified: henesua (2015 jan 1)

#include "nw_i0_generic"
#include "x3_inc_horse"

#include "te_functions"

void main()
{
    object oDamager = GetLastDamager();
    object oMod     = GetModule();
    int nCurrentHP  = GetCurrentHitPoints(OBJECT_SELF);
    int nMaxHP      = GetMaxHitPoints(OBJECT_SELF);
    int nHPBefore;

    int nDealt      = GetTotalDamageDealt();

    // subdual damage?
    object oRight   = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oDamager);
    object oLeft    = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oDamager);
    int nWeaponDam  = GetDamageDealtByType(DAMAGE_TYPE_BASE_WEAPON);
    if(nWeaponDam)
    {
        if(     GetLocalInt(oRight,"WEAPON_NONLETHAL")
            ||  GetLocalInt(oLeft,"WEAPON_NONLETHAL")
            ||  GetLocalInt(oDamager,"COMBAT_NONLETHAL")// subdual mode
          )
        {
            int nSubdualDamage  = GetLocalInt(OBJECT_SELF,"DAMAGE_NONLETHAL")+nWeaponDam;
            int nDamageTotal    = nMaxHP - nCurrentHP;
            if(nSubdualDamage>nDamageTotal)
                nSubdualDamage  = nDamageTotal;
            SetLocalInt(OBJECT_SELF,"DAMAGE_NONLETHAL",nSubdualDamage);
        }
    }

    // henesua - anyone who participates in combat is flagged as a particpant (for the reward of XP later)
    if(GetIsPC(oDamager))
        SetLocalInt(OBJECT_SELF, "COMBATANT_"+ObjectToString(oDamager), GetTimeCumulative());
    else if(GetAssociateType(oDamager)!=ASSOCIATE_TYPE_NONE)
        SetLocalInt(OBJECT_SELF, "COMBATANT_"+ObjectToString(GetMaster(oDamager)), GetTimeCumulative());

    // MAGUS --- Certain Damage types ruin skins
    if(GetLocalString(OBJECT_SELF, "SKIN_TYPE")!="")
    {
        int nSlashDam;
        if(GetIsSlashingWeapon(oRight)||GetIsSlashingWeapon(oLeft))
            nSlashDam   = nWeaponDam;

        //= GetDamageDealtByType(DAMAGE_TYPE_SLASHING);
        int nAcidDam    = GetDamageDealtByType(DAMAGE_TYPE_ACID);
        int nFireDam    = GetDamageDealtByType(DAMAGE_TYPE_FIRE);
        int nSkinDam    = nSlashDam+nAcidDam+nFireDam;
        if(nSkinDam)
        {
            int nSkinTotalDam   = GetLocalInt(OBJECT_SELF, "SKIN_DAMAGE")+nSkinDam;
            if( (nMaxHP-nCurrentHP)<nSkinTotalDam )
                nSkinTotalDam   = nSkinDam;
            SetLocalInt(OBJECT_SELF, "SKIN_DAMAGE", nSkinTotalDam);
            FloatingTextStringOnCreature(LIME+GetName(oDamager)+" damages the creature's hide.", oDamager);
        }
    }

    if(     !GetLocalInt(oMod, "X3_NO_MOUNTED_COMBAT_FEAT")
        &&  GetHasFeat(FEAT_MOUNTED_COMBAT)
        &&  HorseGetIsMounted(OBJECT_SELF)
        &&  GetLocalInt(OBJECT_SELF,"bX3_LAST_ATTACK_PHYSICAL")
      )
    {
            nHPBefore=GetLocalInt(OBJECT_SELF,"nX3_HP_BEFORE");
            if (!GetLocalInt(OBJECT_SELF,"bX3_ALREADY_MOUNTED_COMBAT"))
            { // haven't already had a chance to use this for the round
                SetLocalInt(OBJECT_SELF,"bX3_ALREADY_MOUNTED_COMBAT",TRUE);
                int nAttackRoll=GetBaseAttackBonus(oDamager)+d20();
                int nRideCheck=GetSkillRank(SKILL_RIDE,OBJECT_SELF)+d20();
                if (nRideCheck>=nAttackRoll&&!GetIsDead(OBJECT_SELF))
                { // averted attack
                    if (GetIsPC(oDamager)) SendMessageToPC(oDamager,GetName(OBJECT_SELF)+GetStringByStrRef(111991));
                    //if (GetIsPC(OBJECT_SELF)) SendMessageToPCByStrRef(OBJECT_SELF,111992");
                    if (nCurrentHP<nHPBefore)
                    { // heal
                        effect eHeal=EffectHeal(nHPBefore-nCurrentHP);
                        object oMe      = OBJECT_SELF;
                        AssignCommand(oMod, ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,oMe));
                    } // heal
                } // averted attack
            } // haven't already had a chance to use this for the round
    } // see if can negate some damage

    if(GetFleeToExit())
    {
        // We're supposed to run away, do nothing
    }
    else if (GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
        // don't do anything?
    }
    else
    {
        if (!GetIsObjectValid(oDamager))
        {
            // don't do anything, we don't have a valid damager
        }
        else if (!GetIsFighting(OBJECT_SELF))
        {
            // If we're not fighting, determine combat round
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
            {
                DetermineSpecialBehavior(oDamager);
            }
            else
            {
                if(!GetObjectSeen(oDamager)
                   && GetArea(OBJECT_SELF) == GetArea(oDamager))
                {
                    // We don't see our attacker, go find them
                    ActionMoveToLocation(GetLocation(oDamager), TRUE);
                    ActionDoCommand(DetermineCombatRound());
                }
                else
                {
                    // we can see who has damaged us... leave stealth and attack
                    if(GetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH))
                        SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, FALSE);
                    if(GetActionMode(OBJECT_SELF, ACTION_MODE_DETECT))
                        SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, FALSE);

                    DetermineCombatRound();
                }
            }
        }
        else
        {
            // We are fighting already -- consider switching if we've been
            // attacked by a more powerful enemy
            object oTarget = GetAttackTarget();
            if (!GetIsObjectValid(oTarget))
                oTarget = GetAttemptedAttackTarget();
            if (!GetIsObjectValid(oTarget))
                oTarget = GetAttemptedSpellTarget();

            // If our target isn't valid
            // or our damager has just dealt us 25% or more
            //    of our hp in damager
            // or our damager is more than 2HD more powerful than our target
            // switch to attack the damager.
            if (!GetIsObjectValid(oTarget)
                || (
                    oTarget != oDamager
                    &&  (
                         GetTotalDamageDealt() > (GetMaxHitPoints(OBJECT_SELF) / 4)
                         || (GetHitDice(oDamager) - 2) > GetHitDice(oTarget)
                         )
                    )
                )
            {
                // Switch targets
                DetermineCombatRound(oDamager);
            }
        }
    }

    // Send the user-defined event signal
    if(GetSpawnInCondition(NW_FLAG_DAMAGED_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DAMAGED));
    }
}
