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
    object oFirstTarget = GetSpellTargetObject();
    object oPC = OBJECT_SELF;
    int nCL = TE_GetCasterLevel(oPC,CLASS_TYPE_WARLOCK);
    int nDC = TE_GetSpellSaveDC(oPC,GetLastSpell(),CLASS_TYPE_WARLOCK);
    int nEssence = GetLocalInt(oPC,"nEssence");
    effect eVisEnd = EffectVisualEffect(207);

    int nDamage = d6(nCL/2);
    int nDamStrike;
    int nNumAffected = 0;
    effect eBeamS;
    effect eBeamM;
    object oHolder;
    object oTarget;

    int nCasterLevel = nCL/5;


    if(nEssence == 1055)     {eBeamS = EffectBeam(VFX_BEAM_EVIL, oPC, BODY_NODE_HAND);}
    else if(nEssence == 1056){eBeamS = EffectBeam(VFX_BEAM_MIND, oPC, BODY_NODE_HAND);}
    else if(nEssence == 1057){eBeamS = EffectBeam(VFX_BEAM_FIRE, oPC, BODY_NODE_HAND);}
    else if(nEssence == 1058){eBeamS = EffectBeam(VFX_BEAM_COLD, oPC, BODY_NODE_HAND);}
    else if(nEssence == 1059){eBeamS = EffectBeam(VFX_BEAM_DISINTEGRATE, oPC, BODY_NODE_HAND);}
    else if(nEssence == 1060){eBeamS = EffectBeam(VFX_BEAM_MIND, oPC, BODY_NODE_HAND);}
    else if(nEssence == 1061){eBeamS = EffectBeam(VFX_BEAM_BLACK, oPC, BODY_NODE_HAND);}
    else if(nEssence == 1062){eBeamS = EffectBeam(VFX_BEAM_CHAIN, oPC, BODY_NODE_HAND);}
    else                     {eBeamS = EffectBeam(VFX_BEAM_ODD, oPC, BODY_NODE_HAND);}

    effect eSickening  = EffectVisualEffect(1736);
    effect eSickTemp   = EffectLinkEffects(EffectVisualEffect(1963),eVisEnd);
           eSickTemp   = EffectLinkEffects(EffectAttackDecrease(2,ATTACK_BONUS_MISC),eSickTemp);
           eSickTemp   = EffectLinkEffects(EffectSavingThrowDecrease(SAVING_THROW_ALL,2,SAVING_THROW_TYPE_ALL),eSickTemp);
           eSickTemp   = EffectLinkEffects(EffectSkillDecrease(SKILL_ALL_SKILLS,2),eSickTemp);
           eSickTemp   = EffectLinkEffects(EffectDamageDecrease(2,DAMAGE_TYPE_BASE_WEAPON),eSickTemp);
           //eBeamS = EffectBeam(VFX_BEAM_MIND, oNextTarget, BODY_NODE_HAND);
           //eBeamM = EffectBeam(VFX_BEAM_MIND, oNextTarget, BODY_NODE_HAND,TRUE);

    ////////////////
    effect eFrightful  = EffectVisualEffect(1736);
    effect eFrightTemp = EffectLinkEffects(EffectVisualEffect(1966),eVisEnd);
           eFrightTemp = EffectLinkEffects(EffectAttackDecrease(2,ATTACK_BONUS_MISC),eFrightTemp);
           eFrightTemp = EffectLinkEffects(EffectSavingThrowDecrease(SAVING_THROW_ALL,2,SAVING_THROW_TYPE_ALL),eFrightTemp);
           eFrightTemp = EffectLinkEffects(EffectSkillDecrease(SKILL_ALL_SKILLS,2),eFrightTemp);
           //eBeamS = EffectBeam(VFX_BEAM_EVIL, oNextTarget, BODY_NODE_HAND);
           //eBeamM = EffectBeam(VFX_BEAM_EVIL, oNextTarget, BODY_NODE_HAND,TRUE);
    ////////////////
    effect eBrimstone  = EffectVisualEffect(1741);
    effect eBrimTemp   = EffectLinkEffects(EffectBlindness(),eVisEnd);
           //eBeamS = EffectBeam(VFX_BEAM_FIRE, oNextTarget, BODY_NODE_HAND);
           //eBeamM = EffectBeam(VFX_BEAM_FIRE, oNextTarget, BODY_NODE_HAND,TRUE);
    ////////////////
    effect eHellrime = EffectVisualEffect(1737);
    effect eHellTemp   = EffectLinkEffects(EffectStunned(),eVisEnd);
           //eBeamS = EffectBeam(VFX_BEAM_COLD, oNextTarget, BODY_NODE_HAND);
           //eBeamM = EffectBeam(VFX_BEAM_COLD, oNextTarget, BODY_NODE_HAND,TRUE);
    ////////////////
    effect eVitriolic = EffectVisualEffect(1739);
           //eBeamS = EffectBeam(VFX_BEAM_DISINTEGRATE, oNextTarget, BODY_NODE_HAND);
           //eBeamM = EffectBeam(VFX_BEAM_DISINTEGRATE, oNextTarget, BODY_NODE_HAND,TRUE);
       int nVitLength  = nCL/5;
    effect eVitSecond  = EffectLinkEffects(EffectDamage(d6(2),DAMAGE_TYPE_ACID,DAMAGE_POWER_NORMAL),EffectVisualEffect(1739));
    ////////////////
    effect eBewitching = EffectVisualEffect(1736);
    effect eBewitTemp  = EffectLinkEffects(EffectConfused(),eVisEnd);
           //eBeamS = EffectBeam(VFX_BEAM_MIND, oNextTarget, BODY_NODE_HAND);
           //eBeamM = EffectBeam(VFX_BEAM_MIND, oNextTarget, BODY_NODE_HAND,TRUE);
    ////////////////
    effect eUtterdark  = EffectVisualEffect(1742);
    effect eUtterTemp  = EffectLinkEffects(EffectNegativeLevel(2,TRUE),eVisEnd);
           //eBeamS = EffectBeam(VFX_BEAM_BLACK, oNextTarget, BODY_NODE_HAND);
           //eBeamM = EffectBeam(VFX_BEAM_BLACK, oNextTarget, BODY_NODE_HAND,TRUE);
    ////////////////
    effect eRepel      = EffectVisualEffect(1736);
    effect eRepelTemp  = EffectLinkEffects(EffectKnockdown(),eVisEnd);
           //eBeamS = EffectBeam(VFX_BEAM_CHAIN, oNextTarget, BODY_NODE_HAND);
           //eBeamM = EffectBeam(VFX_BEAM_CHAIN, oNextTarget, BODY_NODE_HAND,TRUE);
    ////////////////
    effect eNormal  =  EffectVisualEffect(1736);
           //eBeamS = EffectBeam(VFX_BEAM_ODD, oNextTarget, BODY_NODE_HAND);
           //eBeamC = EffectBeam(VFX_BEAM_ODD, oNextTarget, BODY_NODE_CHEST);
           //eBeamM = EffectBeam(VFX_BEAM_ODD, oNextTarget, BODY_NODE_HAND,TRUE);


    location lSpellLocation;

    if(spellsIsTarget(oFirstTarget,SPELL_TARGET_SELECTIVEHOSTILE,OBJECT_SELF))
    {
        SignalEvent(oFirstTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CHAIN_LIGHTNING));

        if(!MyResistSpell(OBJECT_SELF,oFirstTarget) || nEssence == 1059)
        {
            if(nEssence == 1055)//Frightful
            {
                nDamage = GetReflexAdjustedDamage(nDamage,oFirstTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_SPELL);
                eFrightful  = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),eFrightful);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eFrightful,oFirstTarget);
                if(!WillSave(oFirstTarget,nDC,SAVING_THROW_TYPE_FEAR,oPC)){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFrightTemp,oFirstTarget,RoundsToSeconds(1));}
            }
            else if(nEssence == 1056)//Sicken
            {
                nDamage = GetReflexAdjustedDamage(nDamage,oFirstTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_SPELL);
                eSickening  = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),eSickTemp);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eSickening,oFirstTarget);
                if(!FortitudeSave(oFirstTarget,nDC,SAVING_THROW_TYPE_DISEASE,oPC)){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSickTemp,oFirstTarget,RoundsToSeconds(1));}
            }
            else if(nEssence == 1057)//Brimstone
            {
                nDamage = GetReflexAdjustedDamage(nDamage,oFirstTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_FIRE);
                eBrimstone  = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_FIRE,DAMAGE_POWER_NORMAL),eBrimstone);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eBrimstone,oTarget);
                if(!FortitudeSave(oFirstTarget,nDC,SAVING_THROW_TYPE_FIRE,oPC)){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBrimTemp,oFirstTarget,RoundsToSeconds(1));}
            }
            else if(nEssence == 1058)//Hellrime
            {
                nDamage = GetReflexAdjustedDamage(nDamage,oFirstTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_COLD);
                eHellrime   = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_COLD,DAMAGE_POWER_NORMAL),eHellrime);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eHellrime,oFirstTarget);
                if(!FortitudeSave(oFirstTarget,nDC,SAVING_THROW_TYPE_COLD,oPC)){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eHellTemp,oFirstTarget,RoundsToSeconds(1));}
            }
            else if(nEssence == 1059)//Vitriolic
            {

                eVitriolic  = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_ACID,DAMAGE_POWER_NORMAL),eVitriolic);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVitriolic,oFirstTarget);
                if(nVitLength >= 6) {DelayCommand(36.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVitSecond,oFirstTarget));}
                if(nVitLength >= 5) {DelayCommand(30.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVitSecond,oFirstTarget));}
                if(nVitLength >= 4) {DelayCommand(24.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVitSecond,oFirstTarget));}
                if(nVitLength >= 3) {DelayCommand(18.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVitSecond,oFirstTarget));}
                if(nVitLength >= 2) {DelayCommand(12.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVitSecond,oFirstTarget));}
                if(nVitLength >= 1) {DelayCommand(6.0, ApplyEffectToObject(DURATION_TYPE_INSTANT,eVitSecond,oFirstTarget));}
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeamS,oFirstTarget,1.0);
            }
            else if(nEssence == 1060)//Bewitch
            {
                nDamage = GetReflexAdjustedDamage(nDamage,oFirstTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_SPELL);
                eBewitching = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),eBewitching);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eBrimstone,oFirstTarget);
                if(!WillSave(oFirstTarget,nDC,SAVING_THROW_TYPE_MIND_SPELLS,oPC)){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBewitTemp,oFirstTarget,RoundsToSeconds(1));}
            }
            else if(nEssence == 1061)//Utterdark
            {
                nDamage = GetReflexAdjustedDamage(nDamage,oFirstTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_SPELL);
                eUtterdark  = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_NEGATIVE,DAMAGE_POWER_NORMAL),eUtterdark);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eUtterdark,oFirstTarget);
                if(!FortitudeSave(oFirstTarget,nDC,SAVING_THROW_TYPE_NEGATIVE,oPC)){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eUtterTemp,oFirstTarget,RoundsToSeconds(1));}
            }
            else if(nEssence == 1062) //Repel
            {
                nDamage = GetReflexAdjustedDamage(nDamage,oFirstTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_SPELL);
                eRepel = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),eRepel);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eRepel,oFirstTarget);
                if(!ReflexSave(oFirstTarget,nDC,SAVING_THROW_TYPE_SPELL,oPC)){ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRepelTemp,oFirstTarget,RoundsToSeconds(1));}
            }
            else
            {
                nDamage = GetReflexAdjustedDamage(nDamage,oFirstTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_SPELL);
                eNormal = EffectLinkEffects(EffectDamage(nDamage,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),eNormal);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eNormal,oFirstTarget);
            }
        }
    }
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeamS,oFirstTarget,0.5);

    if(nEssence == 1055){eBeamS = EffectBeam(VFX_BEAM_EVIL, oFirstTarget, BODY_NODE_CHEST);}
    else if(nEssence == 1056){eBeamS = EffectBeam(VFX_BEAM_MIND, oFirstTarget, BODY_NODE_CHEST);}
    else if(nEssence == 1057){eBeamS = EffectBeam(VFX_BEAM_FIRE, oFirstTarget, BODY_NODE_CHEST);}
    else if(nEssence == 1058){eBeamS = EffectBeam(VFX_BEAM_COLD, oFirstTarget, BODY_NODE_CHEST);}
    else if(nEssence == 1059){eBeamS = EffectBeam(VFX_BEAM_DISINTEGRATE, oFirstTarget, BODY_NODE_CHEST);}
    else if(nEssence == 1060){eBeamS = EffectBeam(VFX_BEAM_MIND, oFirstTarget, BODY_NODE_CHEST);}
    else if(nEssence == 1061){eBeamS = EffectBeam(VFX_BEAM_BLACK, oFirstTarget, BODY_NODE_CHEST);}
    else if(nEssence == 1062){eBeamS = EffectBeam(VFX_BEAM_CHAIN, oFirstTarget, BODY_NODE_CHEST);}
    else                     {eBeamS = EffectBeam(VFX_BEAM_ODD, oFirstTarget, BODY_NODE_CHEST);}

    float fDelay = 0.2;
    int nCnt = 0;

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
    while(GetIsObjectValid(oTarget) && nCnt < nCasterLevel)
    {
        if(oTarget != oFirstTarget && spellsIsTarget(oTarget,SPELL_TARGET_SELECTIVEHOSTILE,OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeamS,oTarget,0.5));
            SignalEvent(oTarget,EventSpellCastAt(OBJECT_SELF,SPELL_CHAIN_LIGHTNING));
            if(!MyResistSpell(OBJECT_SELF,oTarget,fDelay) || nEssence == 1059)
            {
                if(nEssence == 1055)//Frightful
                {
                    nDamStrike = GetReflexAdjustedDamage(nDamage,oTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_SPELL);
                    nDamStrike = nDamage/2;
                    eFrightful  = EffectLinkEffects(EffectDamage(nDamStrike,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),eFrightful);
                    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eFrightful,oTarget));
                    if(!WillSave(oTarget,nDC,SAVING_THROW_TYPE_FEAR,oPC)){DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFrightTemp,oTarget,RoundsToSeconds(1)));}
                }
                else if(nEssence == 1056)//Sicken
                {
                    nDamStrike = GetReflexAdjustedDamage(nDamage,oTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_SPELL);
                    nDamStrike = nDamStrike/2;
                    eSickening  = EffectLinkEffects(EffectDamage(nDamStrike,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),eSickTemp);
                    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eSickening,oTarget));
                    if(!FortitudeSave(oTarget,nDC,SAVING_THROW_TYPE_DISEASE,oPC)){DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSickTemp,oTarget,RoundsToSeconds(1)));}
                }
                else if(nEssence == 1057)//Brimstone
                {
                    nDamStrike = GetReflexAdjustedDamage(nDamage,oTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_FIRE);
                    nDamStrike = nDamage/2;
                    eBrimstone  = EffectLinkEffects(EffectDamage(nDamStrike,DAMAGE_TYPE_FIRE,DAMAGE_POWER_NORMAL),eBrimstone);
                    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eBrimstone,oTarget));
                    if(!FortitudeSave(oTarget,nDC,SAVING_THROW_TYPE_FIRE,oPC)){DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBrimTemp,oTarget,RoundsToSeconds(1)));}
                }
                else if(nEssence == 1058)//Hellrime
                {
                    nDamStrike = GetReflexAdjustedDamage(nDamage,oTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_COLD);
                    nDamStrike = nDamStrike/2;
                    eHellrime   = EffectLinkEffects(EffectDamage(nDamStrike,DAMAGE_TYPE_COLD,DAMAGE_POWER_NORMAL),eHellrime);
                    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eHellrime,oTarget));
                    if(!FortitudeSave(oTarget,nDC,SAVING_THROW_TYPE_COLD,oPC)){DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eHellTemp,oTarget,RoundsToSeconds(1)));}
                }
                else if(nEssence == 1059)//Vitriolic
                {
                    nDamStrike = GetReflexAdjustedDamage(nDamage,oTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_ACID);
                    nDamStrike = nDamStrike/2;
                    eVitriolic  = EffectLinkEffects(EffectDamage(nDamStrike,DAMAGE_TYPE_ACID,DAMAGE_POWER_NORMAL),eVitriolic);
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
                    nDamStrike = GetReflexAdjustedDamage(nDamage,oTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_SPELL);
                    nDamStrike = nDamStrike/2;
                    eBewitching = EffectLinkEffects(EffectDamage(nDamStrike,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),eBewitching);
                    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eBrimstone,oTarget));
                    if(!WillSave(oTarget,nDC,SAVING_THROW_TYPE_MIND_SPELLS,oPC)){DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBewitTemp,oTarget,RoundsToSeconds(1)));}
                }
                else if(nEssence == 1061)//Utterdark
                {
                    nDamStrike = GetReflexAdjustedDamage(nDamage,oTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_SPELL);
                    nDamStrike = nDamStrike/2;
                    eUtterdark  = EffectLinkEffects(EffectDamage(nDamStrike,DAMAGE_TYPE_NEGATIVE,DAMAGE_POWER_NORMAL),eUtterdark);
                    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eUtterdark,oTarget));
                    if(!FortitudeSave(oTarget,nDC,SAVING_THROW_TYPE_NEGATIVE,oPC)){DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eUtterTemp,oTarget,RoundsToSeconds(1)));}
                }
                else if(nEssence == 1062) //Repel
                {
                    nDamStrike = GetReflexAdjustedDamage(nDamage,oTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_SPELL);
                    nDamStrike = nDamStrike/2;
                    eRepel = EffectLinkEffects(EffectDamage(nDamStrike,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),eRepel);
                    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eRepel,oTarget));
                    if(!ReflexSave(oTarget,nDC,SAVING_THROW_TYPE_SPELL,oPC)){DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eRepelTemp,oTarget,RoundsToSeconds(1)));}
                }
                else
                {
                    nDamStrike = GetReflexAdjustedDamage(nDamage,oTarget,TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()),SAVING_THROW_TYPE_SPELL);
                    nDamStrike = nDamStrike/2;
                    eNormal = EffectLinkEffects(EffectDamage(nDamStrike,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL),eNormal);
                    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eNormal,oTarget));
                }
            }
            oHolder = oTarget;

            if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
            {
                if(nEssence == 1055){eBeamS = EffectBeam(VFX_BEAM_EVIL, oHolder, BODY_NODE_CHEST);}
                else if(nEssence == 1056){eBeamS = EffectBeam(VFX_BEAM_MIND, oHolder, BODY_NODE_CHEST);}
                else if(nEssence == 1057){eBeamS = EffectBeam(VFX_BEAM_FIRE, oHolder, BODY_NODE_CHEST);}
                else if(nEssence == 1058){eBeamS = EffectBeam(VFX_BEAM_COLD, oHolder, BODY_NODE_CHEST);}
                else if(nEssence == 1059){eBeamS = EffectBeam(VFX_BEAM_DISINTEGRATE, oHolder, BODY_NODE_CHEST);}
                else if(nEssence == 1060){eBeamS = EffectBeam(VFX_BEAM_MIND, oHolder, BODY_NODE_CHEST);}
                else if(nEssence == 1061){eBeamS = EffectBeam(VFX_BEAM_BLACK, oHolder, BODY_NODE_CHEST);}
                else if(nEssence == 1062){eBeamS = EffectBeam(VFX_BEAM_CHAIN, oHolder, BODY_NODE_CHEST);}
                else                     {eBeamS = EffectBeam(VFX_BEAM_ODD, oHolder, BODY_NODE_CHEST);}
            }
            fDelay = fDelay +0.1f;
        }

        if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            nCnt++;
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oFirstTarget), TRUE, OBJECT_TYPE_CREATURE);
    }
}