#include "x2_inc_spellhook"

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
    //** the spell ID
    int nSpellID = GetSpellId();
    //** this will store the resref of what is summoned
    string sSummon = "";
    //** the duration in round/level can be changed here
    float nDuration = IntToFloat(GetHitDice(oPC)+GetAbilityModifier(ABILITY_CHARISMA,oPC)) * 1.0;

    //** make metamagic check for extended spells
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration *= 2.0;
    }

    //** determine which visual effect I should use.
    int iVFX = VFX_FNF_SUMMON_MONSTER_1;;
    //** the level of the summon is stored here
    if(GetIsAreaAboveGround(oArea) == TRUE)
    {
        if(GetIsAreaInterior(oArea) == TRUE)
        {
            sSummon = "te_nightchild3";
        }
        else
        {
            if(d20(1) == 20)
            {
                sSummon = "te_nightchild5";
            }
            else
            {
                sSummon = "te_nightchild2";
            }
        }
    }
    else
    {
         if(d20(1) == 20)
        {
            sSummon = "te_nightchild6";
        }
        else
        {
            sSummon = "te_nightchild1";
        }
    }

    if(GetHasFeat(BACKGROUND_DARK_ELF,oPC) == TRUE)
    {
        sSummon = "te_nightchild4";
    }


    // Determine the summoned creature!

    //Apply the VFX impact and summon effect
    effect eSummon;

    //** if it's not a PC
    if (!GetIsPC(OBJECT_SELF))
    {
        //** NPCs do not have henches
        eSummon = EffectSummonCreature(sSummon, iVFX);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(FloatToInt(nDuration)));
    }
    else
    {
        //** here I will store the summoned creature object
        object oSummon;
        int iMaxSummons = 5;

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
            //** dispel invisibility if everything worked and the caster is invisible
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

            //** mark us as summons to make a distinction to other henchmen
            SetLocalInt(oSummon, "iIAmASummonedCreature", 1);
            SetLocalInt(oSummon, "iIGiveNoXP", 1);
            //** after the duration, play the Unsummon VFX and destroy the henchman, dropping all gear he has
            DelayCommand((TurnsToSeconds(FloatToInt(nDuration))-2.5), ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eUnsummon, oSummon, 6.0));
            DestroyObject(oSummon, HoursToSeconds(FloatToInt(nDuration)));
        }
    }

}
