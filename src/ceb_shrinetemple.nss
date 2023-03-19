/* Valid Object Tags for Trigger Area:
ShrineG - Good Shrine (Protection from Evil)
ShrineN - Neurtral Shrine (Protection from Evil and Good)
ShrineE - Evil Shrine (Protection from Good)
TempleG - Double Protection from Evil and Undead Turning (Level 9)
TempleN - Double Protection from Evil & Good and Undead Turning (Level 9)
TempleE - Double Protection from Good and Undead Turning (Level 9)
TempleGun - Double Protection from Evil (Undead Permitted)
TempleNun - Double Protection from Evil & Good (Undead Permitted)
TempleEun - Double Protection from Good (Undead Permitted)
*/

#include "te_functions"

void main()
{

object oTarget = GetEnteringObject();
int iTHD;
int iType = GetLocalInt(OBJECT_SELF,"nType");
int iDeity = GetLocalInt(OBJECT_SELF,"nDeity");

if(GetIsPC(oTarget) == TRUE)
{
    iTHD = 9;
}

    /*SHRINE G*/
    if (GetLocalString(OBJECT_SELF,"nType") == "ShrineG")
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectACIncrease(2, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), ALIGNMENT_ALL, ALIGNMENT_EVIL), oTarget, 3600.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL, 2), ALIGNMENT_ALL, ALIGNMENT_EVIL), oTarget, 3600.0f);
        if(GetHasFeat(DEITY_Deneir,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Deneir)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_LORE,2),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Eldath,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Eldath)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_HEAL,2),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_FORT,2,SAVING_THROW_TYPE_ALL),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Ilmater,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Ilmater)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_HEAL,2),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_FORT,2,SAVING_THROW_TYPE_FEAR),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Mielikki,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Mielikki)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(1,ATTACK_BONUS_MISC),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Milil,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Milil)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_PERFORM,2),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Mystra,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Mystra)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_WILL,2,SAVING_THROW_TYPE_ALL),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_SPELLCRAFT,2),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Elven_Powers,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Elven_Powers)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(1,ATTACK_BONUS_MISC),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_ALL,2,SAVING_THROW_TYPE_ALL),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Selune,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Selune)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_SPOT,2),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_ALL,2,SAVING_THROW_TYPE_ALL),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Torm,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Torm)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_DISCIPLINE,2),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_WILL,2,SAVING_THROW_TYPE_ALL),oTarget,3600.0);
        }
    }

    /*SHRINE N*/
    if (GetLocalString(OBJECT_SELF,"nType") == "ShrineN")
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectACIncrease(2, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), ALIGNMENT_ALL, ALIGNMENT_EVIL), oTarget, 3600.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL, 2), ALIGNMENT_ALL, ALIGNMENT_EVIL), oTarget, 3600.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectACIncrease(2, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), ALIGNMENT_ALL, ALIGNMENT_GOOD), oTarget, 3600.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL, 2), ALIGNMENT_ALL, ALIGNMENT_GOOD), oTarget, 3600.0f);
        if(GetHasFeat(DEITY_Azuth,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Azuth)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_CONCENTRATION,2),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_SPELLCRAFT,2),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Halfling_Powers,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Halfling_Powers)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_REFLEX,2,SAVING_THROW_TYPE_ALL),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_PICK_POCKET,2),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Garagos,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Garagos)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(1,ATTACK_BONUS_MISC),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Helm,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Helm)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_SPOT,2),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Hoar,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Hoar)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(1,ATTACK_BONUS_MISC),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_WILL,2,SAVING_THROW_TYPE_FEAR),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Red_Knight,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Red_Knight)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_DISCIPLINE,2),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Shaundakul,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Shaundakul)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectMovementSpeedIncrease(10),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Siamorphe,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Siamorphe)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_PERSUADE,2),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Tempus,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Tempus)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(2,ATTACK_BONUS_MISC),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Waukeen,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Waukeen)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_APPRAISE,2),oTarget,3600.0);
        }

    }

    /*SHRINE E*/
    if (GetLocalString(OBJECT_SELF,"nType") == "ShrineE")
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectACIncrease(2, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), ALIGNMENT_ALL, ALIGNMENT_GOOD), oTarget, 3600.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL, 2), ALIGNMENT_ALL, ALIGNMENT_GOOD), oTarget, 3600.0f);
        if(GetHasFeat(DEITY_Cyric,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Cyric)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_BLUFF,2),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_WILL,2,SAVING_THROW_TYPE_ALL),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Underdark_Powers,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Underdark_Powers)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_DISCIPLINE,2),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_TAUNT,2),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Shar,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Shar)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_BLUFF,2),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_ALL,2,SAVING_THROW_TYPE_ALL),oTarget,3600.0);
        }
    }

    /*TEMPLE G*/
    if (GetLocalString(OBJECT_SELF,"nType") == "TempleG")
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectACIncrease(4, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), ALIGNMENT_ALL, ALIGNMENT_EVIL), oTarget, 3600.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL, 4), ALIGNMENT_ALL, ALIGNMENT_EVIL), oTarget, 3600.0f);

        if(GetHasFeat(DEITY_Mielikki,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Mielikki)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(1,ATTACK_BONUS_MISC),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Ilmater,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Ilmater)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_HEAL,2),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_FORT,2,SAVING_THROW_TYPE_FEAR),oTarget,3600.0);
        }

        if (GetIsUndead(oTarget) == TRUE && GetHasFeat(iDeity,oTarget) != TRUE)
        {
            if(GetPCAffliction(oTarget) == 3 || GetPCAffliction(oTarget) == 4 || GetPCAffliction(oTarget) == 8)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(15),DAMAGE_TYPE_DIVINE,DAMAGE_POWER_NORMAL),oTarget);
            }

            int nTurnHD = GetTurnResistanceHD(oTarget);

            if(GetIsPC(oTarget) == TRUE)
            {
                nTurnHD += GetHitDice(oTarget);
            }

            effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
            effect eVisTurn = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
            effect eDamage;
            effect eTurned = EffectTurned();
            effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
            effect eLink = EffectLinkEffects(eVisTurn, eTurned);
            eLink = EffectLinkEffects(eLink, eDur);
            effect eImpactVis = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);

            effect eDeath = SupernaturalEffect(EffectDeath(TRUE));
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpactVis, GetLocation(OBJECT_SELF));

            if(nTurnHD <= 8)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oTarget);
            }
            else if(nTurnHD > 8 && nTurnHD <= 16)
            {
                if(GetPCAffliction(oTarget) == 7 && GetAlignmentGoodEvil(oTarget) == ALIGNMENT_GOOD)
                {
                    //Do nothing
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
                }
            }
            else
            {
                //Do nothing
            }
        }
    }
    /*TEMPLE N*/
    if (GetLocalString(OBJECT_SELF,"nType") == "TempleN")
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectACIncrease(4, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), ALIGNMENT_ALL, ALIGNMENT_EVIL), oTarget, 3600.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL, 4), ALIGNMENT_ALL, ALIGNMENT_EVIL), oTarget, 3600.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectACIncrease(4, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), ALIGNMENT_ALL, ALIGNMENT_GOOD), oTarget, 3600.0f);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL, 4), ALIGNMENT_ALL, ALIGNMENT_GOOD), oTarget, 3600.0f);

        if(GetHasFeat(DEITY_Helm,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Helm)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_SPOT,2),oTarget,3600.0);
        }
        if(GetHasFeat(DEITY_Kelemvor,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Kelemvor)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_FORT,1,SAVING_THROW_TYPE_FEAR),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_WILL,1,SAVING_THROW_TYPE_FEAR),oTarget,3600.0);
        }

        if (GetIsUndead(oTarget) == TRUE && GetHasFeat(iDeity,oTarget) != TRUE)
        {
            if(GetPCAffliction(oTarget) == 3 || GetPCAffliction(oTarget) == 4 || GetPCAffliction(oTarget) == 8)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(15),DAMAGE_TYPE_DIVINE,DAMAGE_POWER_NORMAL),oTarget);
            }

            int nTurnHD = GetTurnResistanceHD(oTarget);
            effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
            effect eVisTurn = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
            effect eDamage;
            effect eTurned = EffectTurned();
            effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
            effect eLink = EffectLinkEffects(eVisTurn, eTurned);
            eLink = EffectLinkEffects(eLink, eDur);
            effect eImpactVis = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);

            effect eDeath = SupernaturalEffect(EffectDeath(TRUE));
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpactVis, GetLocation(OBJECT_SELF));

            if(nTurnHD <= 8)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oTarget);
            }
            else if(nTurnHD > 8 && nTurnHD <= 16)
            {
                if(GetPCAffliction(oTarget) == 7 && GetAlignmentGoodEvil(oTarget) == ALIGNMENT_GOOD)
                {
                    //Do nothing
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
                }
            }
            else
            {
                //Do nothing
            }
        }
    }
    /*TEMPLE E*/
    if (GetLocalString(OBJECT_SELF,"nType") == "TempleE")
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectACIncrease(4, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), ALIGNMENT_ALL, ALIGNMENT_GOOD), oTarget, 3600.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL, 4), ALIGNMENT_ALL, ALIGNMENT_GOOD), oTarget, 3600.0f);

        if(GetHasFeat(DEITY_Shar,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Shar)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_BLUFF,2),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_ALL,2,SAVING_THROW_TYPE_ALL),oTarget,3600.0);
        }

        if (GetIsUndead(oTarget) == TRUE && GetHasFeat(iDeity,oTarget) != TRUE)
        {
            if(GetPCAffliction(oTarget) == 3 || GetPCAffliction(oTarget) == 4 || GetPCAffliction(oTarget) == 8)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(15),DAMAGE_TYPE_DIVINE,DAMAGE_POWER_NORMAL),oTarget);
            }

            int nTurnHD = GetTurnResistanceHD(oTarget);
            effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
            effect eVisTurn = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
            effect eDamage;
            effect eTurned = EffectTurned();
            effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
            effect eLink = EffectLinkEffects(eVisTurn, eTurned);
            eLink = EffectLinkEffects(eLink, eDur);
            effect eImpactVis = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);

            effect eDeath = SupernaturalEffect(EffectDeath(TRUE));
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpactVis, GetLocation(OBJECT_SELF));

            if(nTurnHD <= 8)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDeath,oTarget);
            }
            else if(nTurnHD > 8 && nTurnHD <= 16)
            {
                if(GetPCAffliction(oTarget) == 7 && GetAlignmentGoodEvil(oTarget) == ALIGNMENT_GOOD)
                {
                    //Do nothing
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eLink, oTarget);
                }
            }
            else
            {
                //Do nothing
            }
        }
    }
    /*TEMPLE G Undead*/
    if (GetLocalString(OBJECT_SELF,"nType") == "TempleGun")
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectACIncrease(4, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), ALIGNMENT_ALL, ALIGNMENT_EVIL), oTarget, 3600.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL, 4), ALIGNMENT_ALL, ALIGNMENT_EVIL), oTarget, 3600.0f);
    }
    /*TEMPLE N Undead*/
    if (GetLocalString(OBJECT_SELF,"nType") == "TempleNun")
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectACIncrease(4, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), ALIGNMENT_ALL, ALIGNMENT_EVIL), oTarget, 3600.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL, 4), ALIGNMENT_ALL, ALIGNMENT_EVIL), oTarget, 3600.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectACIncrease(4, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), ALIGNMENT_ALL, ALIGNMENT_GOOD), oTarget, 3600.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL, 4), ALIGNMENT_ALL, ALIGNMENT_GOOD), oTarget, 3600.0f);
    }
    /*TEMPLE E Undead*/
    if (GetLocalString(OBJECT_SELF,"nType") == "TempleEun")
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectACIncrease(4, AC_NATURAL_BONUS, AC_VS_DAMAGE_TYPE_ALL), ALIGNMENT_ALL, ALIGNMENT_GOOD), oTarget, 3600.0f);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, VersusAlignmentEffect(EffectSavingThrowIncrease(SAVING_THROW_ALL, 4), ALIGNMENT_ALL, ALIGNMENT_GOOD), oTarget, 3600.0f);

        if(GetHasFeat(DEITY_Shar,oTarget) && GetLocalInt(OBJECT_SELF,"nDeity") == DEITY_Shar)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_BLUFF,2),oTarget,3600.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSavingThrowIncrease(SAVING_THROW_ALL,2,SAVING_THROW_TYPE_ALL),oTarget,3600.0);
        }

    }

}
