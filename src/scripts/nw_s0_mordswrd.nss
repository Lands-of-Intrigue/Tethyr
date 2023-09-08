//::///////////////////////////////////////////////
//:: Summon Creature Series
//:: NW_S0_Summon
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Carries out the summoning of the appropriate
    creature for the Summon Monster Series of spells
    1 to 9
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////

int DNDAlignment(object oPC);
effect SetSummonEffect(int nSpellID);


#include "x2_inc_spellhook"
#include "te_functions"

void main()
{
    if (!X2PreSpellCastCode())
    {
        // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    //** the spellcaster
    object oPC = OBJECT_SELF;
    object oArea = GetArea(oPC);
    object oItem;
    //** the spell ID
    int nSpellID = GetSpellId();
    int nRoll = d3();
    //** this will store the resref of what is summoned
    string sSummon = "te_mordenkainen";
    //** the duration in round/level can be changed here
    int nCL = TE_GetCasterLevel(oPC,GetLastSpellCastClass());
    float nDuration = IntToFloat(nCL) * 1.0;

    //Caster AB + WIS Mod
    int nAttackBonus = nCL;

    if(GetLastSpellCastClass() == CLASS_TYPE_SORCERER)
    {
        nAttackBonus += GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF);
    }
    else if(GetLastSpellCastClass() == CLASS_TYPE_WIZARD)
    {
        nAttackBonus += GetAbilityModifier(ABILITY_INTELLIGENCE,OBJECT_SELF);
    }

    //** make metamagic check for extended spells
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration *= 2.0;
    }

    //** determine which visual effect I should use.
    int iVFX = VFX_FNF_SUMMON_MONSTER_1;
    //** the level of the summon is stored here
    int iLevel = 0;

    //Apply the VFX impact and summon effect
    effect eSummon;

    //** if it's not a PC
    if (!GetIsPC(OBJECT_SELF))
    {
        //** NPCs do not have henches
        eSummon = EffectSummonCreature(sSummon, iVFX);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(FloatToInt(nDuration)));
    }
    else
    {
        //** here I will store the summoned creature object
        object oSummon;
        int iMaxSummons = 2;

        //** Mages specialising in conjuration will have special perks, as in
        //** having the summons longer and being able to summon more at the same time.
        if (GetHasFeat(FEAT_SPELL_FOCUS_CONJURATION))
        {
            iMaxSummons = 3;
            nDuration *= 1.25;
        }
        if (GetHasFeat(FEAT_GREATER_SPELL_FOCUS_CONJURATION))
        {
            //** does iMaxSummons ++; twice since taking GSF CONJ removes SF CONJ
            iMaxSummons = 4;
            //** this might have to be increased too, not sure?
            nDuration *= 1.25;
        }

        //** count the henchmen the PC has, and how many of them are summons
        int iCount;
        int iSummonCount = 0;
        object oHench;
        for (iCount=1; iCount<99; iCount++)
        {
            oHench = GetHenchman(OBJECT_SELF, iCount);
            if (oHench == OBJECT_INVALID)
            {
                break;
            }
            else if (GetLocalInt(oHench, "iIAmASummonedCreature"))
                iSummonCount++;
        }

        //** prepare the unsummon effect
        effect eUnsummon = EffectVisualEffect(VFX_IMP_UNSUMMON);

        if (iSummonCount >= iMaxSummons)
        {
            //** the guy has more than he can hold, unsummon the first summons
            int i0;
            for (i0=1; i0<iCount; i0++)
            {
                oHench = GetHenchman(OBJECT_SELF, i0);
                if (GetLocalInt(oHench, "iIAmASummonedCreature"))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eUnsummon, oHench, 6.0);
                    DestroyObject(oHench, 2.5);
                    i0 = 999;
                    break;
                }
            }
        }

        //** create a new summons with some nice effects
        eSummon = EffectVisualEffect(iVFX);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, GetSpellTargetLocation());
        oSummon = CreateObject(OBJECT_TYPE_CREATURE, sSummon, GetSpellTargetLocation());
        if (oSummon == OBJECT_INVALID)
        {
            WriteTimestampedLogEntry( "BUG: Unable to create summon with resref " + sSummon
                + " for " + GetName(oPC) + " and spell ID " + IntToString(nSpellID));
            SpeakString( "BUG: Unable to create summon with resref " + sSummon
                + " for " + GetName(oPC) + " and spell ID " + IntToString(nSpellID));

        }
        else
        {
            effect eEff = GetFirstEffect(OBJECT_SELF);
            while (GetEffectType(eEff) != EFFECT_TYPE_INVALIDEFFECT)
            {
                if (GetEffectType(eEff) == EFFECT_TYPE_INVISIBILITY)
                {
                    RemoveEffect(OBJECT_SELF, eEff);
                    break;
                }

                eEff = GetNextEffect(OBJECT_SELF);
            }
            AddHenchman(OBJECT_SELF, oSummon);

            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAttackIncrease(nAttackBonus,ATTACK_BONUS_ONHAND),oSummon);
            //6 //11
            if(nAttackBonus >= 6 && nAttackBonus <11)
            {
                SetBaseAttackBonus(2,oSummon);
            }
            else if(nAttackBonus >= 11)
            {
                SetBaseAttackBonus(3,oSummon);
            }


            //** mark us as summons to make a distinction to other henchmen
            SetLocalInt(oSummon, "iIAmASummonedCreature", 1);
            SetLocalInt(oSummon, "iIGiveNoXP", 1);
            //** after the duration, play the Unsummon VFX and destroy the henchman, dropping all gear he has
            DelayCommand((TurnsToSeconds(FloatToInt(nDuration))-2.5), ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eUnsummon, oSummon, 6.0));
            DestroyObject(oSummon, TurnsToSeconds(FloatToInt(nDuration)));
        }
    }

}

