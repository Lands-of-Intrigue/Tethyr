//::///////////////////////////////////////////////
//:: Associate: On Damaged
//:: NW_CH_AC6
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If already fighting then ignore, else determine combat round

    The Magus' Innocuous Familiars
        - Tracks hitpoints so that they are persistent across respawns
*/
//:://////////////////////////////////////////////
//:: Created: Preston Watamaniuk Nov 19, 2001
//:://////////////////////////////////////////////
//:: Modified: Deva Winblood Jan 17th, 2008
//:: Added Support for Mounted Combat Feat Support
//:://////////////////////////////////////////////
//:: Modified: The Magus (2013 jan 5) - added persistent damage

#include "X0_INC_HENAI"
#include "x3_inc_horse"

#include "te_functions"

// Determine whether to switch to new attacker
int SwitchTargets(object oCurTarget, object oNewEnemy);

void main()
{
    object oDamager = GetLastDamager();
    // Who have we been fighting?
    object oTarget = GetAttackTarget();
    if ( !GetIsObjectValid(oTarget) )
        oTarget = GetAttemptedAttackTarget();
    if ( !GetIsObjectValid(oTarget) )
        oTarget = GetAttemptedSpellTarget();

    object oMaster  = GetMaster();

    int nHPBefore;
    if (!GetLocalInt(GetModule(),"X3_NO_MOUNTED_COMBAT_FEAT"))
    if (GetHasFeat(FEAT_MOUNTED_COMBAT)&&HorseGetIsMounted(OBJECT_SELF))
    { // see if can negate some damage
        if (GetLocalInt(OBJECT_SELF,"bX3_LAST_ATTACK_PHYSICAL"))
        { // last attack was physical
            nHPBefore=GetLocalInt(OBJECT_SELF,"nX3_HP_BEFORE");
            if (!GetLocalInt(OBJECT_SELF,"bX3_ALREADY_MOUNTED_COMBAT"))
            { // haven't already had a chance to use this for the round
                SetLocalInt(OBJECT_SELF,"bX3_ALREADY_MOUNTED_COMBAT",TRUE);
                int nAttackRoll=GetBaseAttackBonus(oDamager)+d20();
                int nRideCheck=GetSkillRank(SKILL_RIDE,OBJECT_SELF)+d20();
                if (nRideCheck>=nAttackRoll&&!GetIsDead(OBJECT_SELF))
                { // averted attack
                    if (GetIsPC(oDamager)) SendMessageToPC(oDamager,GetName(OBJECT_SELF)+GetStringByStrRef(111991));
                    //if (GetIsPC(OBJECT_SELF)) SendMessageToPCByStrRef(OBJECT_SELF,111992);
                    if (GetCurrentHitPoints(OBJECT_SELF)<nHPBefore)
                    { // heal
                        effect eHeal=EffectHeal(nHPBefore-GetCurrentHitPoints(OBJECT_SELF));
                        AssignCommand(GetModule(),ApplyEffectToObject(DURATION_TYPE_INSTANT,eHeal,OBJECT_SELF));
                    } // heal
                } // averted attack
            } // haven't already had a chance to use this for the round
        } // last attack was physical
    } // see if can negate some damage


    // UNINTERRUPTIBLE ACTIONS
    if(GetAssociateState(NW_ASC_IS_BUSY)
       || GetAssociateState(NW_ASC_MODE_STAND_GROUND)
       || GetCurrentAction() == ACTION_FOLLOW) {
        // We're busy, don't do anything
    }

    // DEFEND MASTER
    // Priority is to protect our master
    else if(GetAssociateState(NW_ASC_MODE_DEFEND_MASTER)) {
        object oMasterEnemy = GetLastHostileActor(oMaster);

        // defend our master first
        if (GetIsObjectValid(oMasterEnemy)) {
            HenchmenCombatRound(oMasterEnemy);

        } else if ( !GetIsObjectValid(oTarget)
                || SwitchTargets(oTarget, oDamager)) {
            HenchmenCombatRound(oDamager);
        }
    }

    // SWITCH TO MORE DANGEROUS ATTACKER
    // If we're already fighting, possibly switch to our new attacker
    else if (GetIsObjectValid(oTarget) && SwitchTargets(oTarget, oDamager)) {
        // Switch to the attacker
        HenchmenCombatRound(oDamager);
    }

    // Signal the user-defined event
    if(GetSpawnInCondition(NW_FLAG_DAMAGED_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1006));
    }
}


// Determine whether to switch to new attacker
int SwitchTargets(object oCurTarget, object oNewEnemy)
{
    return (GetIsObjectValid(oNewEnemy) && oCurTarget != oNewEnemy
            &&
            (
             // The new enemy is of a higher level
             GetHitDice(oNewEnemy) > GetHitDice(oCurTarget)
             ||
             // or we just received more than 25% of our hp in damage
             GetTotalDamageDealt() > (GetMaxHitPoints(OBJECT_SELF) / 4)
             )
            );
}
