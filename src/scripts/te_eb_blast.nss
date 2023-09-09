//:://////////////////////////////////////////////////
//:: Tethyr's Warlock Eldritch Blast Evocation
//:: Melee edition
//:: TE_EB_Magic
//:: Copyright (c) 2020 Function(D20)
//:///////////////////////////////////////////////////

/*
   Warlock uses eldritch blast feat to attack player
   Rolls ranged touch attack to see if hit.
   Attack does 1d6 damage per character level
*/
//:///////////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: October 17, 2015
//:: Revised On: April 19, 2020
//:///////////////////////////////////////////////////

#include "loi_functions"
#include "te_afflic_func"
#include "te_functions"
#include "nw_i0_spells"
#include "x2_i0_spells"

void main()
{
    object oTarget = GetSpellTargetObject();
    object oPC = OBJECT_SELF;
    int nCL = TE_GetCasterLevel(oPC,CLASS_TYPE_WARLOCK);
    int nDC = TE_GetSpellSaveDC(oPC,GetLastSpell(),CLASS_TYPE_WARLOCK);
    int nEssence = GetLocalInt(oPC,"nEssence");
    int nTouch = TouchAttackMelee(oTarget);
    effect eVisEnd = EffectVisualEffect(207);

    int nDamage = d6(nCL/2);

    effect eSickening  = EffectLinkEffects(EffectVisualEffect(1736),EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL));
    effect eSickTemp   = EffectLinkEffects(EffectVisualEffect(1963),eVisEnd);
           eSickTemp   = EffectLinkEffects(EffectAttackDecrease(2,ATTACK_BONUS_MISC),eSickTemp);
           eSickTemp   = EffectLinkEffects(EffectSavingThrowDecrease(SAVING_THROW_ALL,2,SAVING_THROW_TYPE_ALL),eSickTemp);
           eSickTemp   = EffectLinkEffects(EffectSkillDecrease(SKILL_ALL_SKILLS,2),eSickTemp);
           eSickTemp   = EffectLinkEffects(EffectDamageDecrease(2,DAMAGE_TYPE_BASE_WEAPON),eSickTemp);
    ////////////////
    effect eFrightful  = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),EffectVisualEffect(1736));
    effect eFrightTemp = EffectLinkEffects(EffectVisualEffect(1966),eVisEnd);
           eFrightTemp = EffectLinkEffects(EffectAttackDecrease(2,ATTACK_BONUS_MISC),eFrightTemp);
           eFrightTemp = EffectLinkEffects(EffectSavingThrowDecrease(SAVING_THROW_ALL,2,SAVING_THROW_TYPE_ALL),eFrightTemp);
           eFrightTemp = EffectLinkEffects(EffectSkillDecrease(SKILL_ALL_SKILLS,2),eFrightTemp);
    ////////////////
    effect eBrimstone  = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_FIRE,DAMAGE_POWER_NORMAL),EffectVisualEffect(1741));
    effect eBrimTemp   = EffectLinkEffects(EffectBlindness(),eVisEnd);
    ////////////////
    effect eHellrime   = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_COLD,DAMAGE_POWER_NORMAL),EffectVisualEffect(1737));
    effect eHellTemp   = EffectLinkEffects(EffectStunned(),eVisEnd);
    ////////////////
    effect eVitriolic  = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_ACID,DAMAGE_POWER_NORMAL),EffectVisualEffect(1739));
       int nVitLength  = nCL/5;
    effect eVitSecond  = EffectLinkEffects(EffectDamage(d6(2),DAMAGE_TYPE_ACID,DAMAGE_POWER_NORMAL),EffectVisualEffect(1739));
    ////////////////
    effect eBewitching = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),EffectVisualEffect(1736));
    effect eBewitTemp  = EffectLinkEffects(EffectConfused(),eVisEnd);
    ////////////////
    effect eUtterdark  = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_NEGATIVE,DAMAGE_POWER_NORMAL),EffectVisualEffect(1742));
    effect eUtterTemp  = EffectLinkEffects(EffectNegativeLevel(2,TRUE),eVisEnd);
    ////////////////
    effect eRepel      = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),EffectVisualEffect(1736));
    effect eRepelTemp  = EffectLinkEffects(EffectKnockdown(),eVisEnd);
    ////////////////
    effect eNormal     = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),EffectVisualEffect(1736));

    if(nTouch > 0)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 1054));
            if (!MyResistSpell(OBJECT_SELF, oTarget) || nEssence == 1059)
            {
                if(nEssence == 1055)//Frightful
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eFrightful,oTarget);
                    if(!WillSave(oTarget,nDC,SAVING_THROW_TYPE_FEAR,oPC)){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFrightTemp,oTarget,RoundsToSeconds(1));}
                }
                else if(nEssence == 1056)//Sicken
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSickening,oTarget);
                    if(!FortitudeSave(oTarget,nDC,SAVING_THROW_TYPE_DISEASE,oPC)){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSickTemp,oTarget,RoundsToSeconds(1));}
                }
                else if(nEssence == 1057)//Brimstone
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eBrimstone,oTarget);
                    if(!FortitudeSave(oTarget,nDC,SAVING_THROW_TYPE_FIRE,oPC)){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBrimTemp,oTarget,RoundsToSeconds(1));}
                }
                else if(nEssence == 1058)//Hellrime
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eHellrime,oTarget);
                    if(!FortitudeSave(oTarget,nDC,SAVING_THROW_TYPE_COLD,oPC)){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eHellTemp,oTarget,RoundsToSeconds(1));}
                }
                else if(nEssence == 1059)//Vitriolic
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVitriolic,oTarget);
                    if(nVitLength >= 6) {DelayCommand(36.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVitSecond,oTarget));}
                    if(nVitLength >= 5) {DelayCommand(30.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVitSecond,oTarget));}
                    if(nVitLength >= 4) {DelayCommand(24.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVitSecond,oTarget));}
                    if(nVitLength >= 3) {DelayCommand(18.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVitSecond,oTarget));}
                    if(nVitLength >= 2) {DelayCommand(12.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVitSecond,oTarget));}
                    if(nVitLength >= 1) {DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVitSecond,oTarget));}
                }
                else if(nEssence == 1060)//Bewitch
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eBrimstone,oTarget);
                    if(!WillSave(oTarget,nDC,SAVING_THROW_TYPE_MIND_SPELLS,oPC)){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBewitTemp,oTarget,RoundsToSeconds(1));}
                }
                else if(nEssence == 1061)//Utterdark
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eUtterdark,oTarget);
                    if(!FortitudeSave(oTarget,nDC,SAVING_THROW_TYPE_NEGATIVE,oPC)){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eUtterTemp,oTarget,RoundsToSeconds(1));}
                }
                else if(nEssence == 1062) //Repel
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eRepel,oTarget);
                    if(!ReflexSave(oTarget,nDC,SAVING_THROW_TYPE_SPELL,oPC)){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRepelTemp,oTarget,RoundsToSeconds(1));}
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eNormal,oTarget);
                }
            }
        }
    }
}
