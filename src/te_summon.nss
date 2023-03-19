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
    int nRoll = d3();
    int nAlign = DNDAlignment(OBJECT_SELF);
    //** this will store the resref of what is summoned
    string sSummon = "";
    //** the duration in round/level can be changed here
    float nDuration = IntToFloat(GetCasterLevel(OBJECT_SELF)) * 1.0;

    //** make metamagic check for extended spells
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration *= 2.0;
    }

    //** determine which visual effect I should use.
    int iVFX;
    //** the level of the summon is stored here
    int iLevel = 0;
    switch(nSpellID)
    {
        case SPELL_SUMMON_CREATURE_I:
            iLevel = 1; iVFX = VFX_FNF_SUMMON_MONSTER_1; break;
        case SPELL_SUMMON_CREATURE_II:
            iLevel = 2; iVFX = VFX_FNF_SUMMON_MONSTER_1; break;
        case SPELL_SUMMON_CREATURE_III:
            iLevel = 3; iVFX = VFX_FNF_SUMMON_MONSTER_1; break;
        case SPELL_SUMMON_CREATURE_IV:
            iLevel = 4; iVFX = VFX_FNF_SUMMON_MONSTER_2; break;
        case SPELL_SUMMON_CREATURE_V:
            iLevel = 5; iVFX = VFX_FNF_SUMMON_MONSTER_2; break;
        case SPELL_SUMMON_CREATURE_VI:
            iLevel = 6; iVFX = VFX_FNF_SUMMON_MONSTER_2; break;
        case SPELL_SUMMON_CREATURE_VII:
            iLevel = 7; iVFX = VFX_FNF_SUMMON_MONSTER_3; break;
        case SPELL_SUMMON_CREATURE_VIII:
            iLevel = 8; iVFX = VFX_FNF_SUMMON_MONSTER_3; break;
        case SPELL_SUMMON_CREATURE_IX:
            iLevel = 9; iVFX = VFX_FNF_SUMMON_MONSTER_3; break;
    }
    // Determine the summoned creature!
    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER, oPC) == TRUE || GetLevelByClass(CLASS_TYPE_DRUID, oPC) >= 1)
    {
        switch (nSpellID)
        {
            case SPELL_SUMMON_CREATURE_I:
            {
                sSummon = "te_mons1f";
                break;
            }
            case SPELL_SUMMON_CREATURE_II:
            {
                sSummon = "te_mons2f";
                break;
            }
            case SPELL_SUMMON_CREATURE_III:
            {
                sSummon = "te_mons3m";
                break;
            }
            case SPELL_SUMMON_CREATURE_IV:
            {
                sSummon = "te_mons4c";
                break;
            }
            case SPELL_SUMMON_CREATURE_V:
            {
                sSummon = "te_mons5dr";
                break;
            }
            case SPELL_SUMMON_CREATURE_VI:
            {
                sSummon = "te_mons6dr";
                break;
            }
            case SPELL_SUMMON_CREATURE_VII:
            {
                sSummon = "te_mons7dr";
                break;
            }
            case SPELL_SUMMON_CREATURE_VIII:
            {
                sSummon = "te_mons8dr";
                break;
            }
            case SPELL_SUMMON_CREATURE_IX:
            {
                sSummon = "te_mons8dr";
                break;
            }
        }
    }
    else
    {
        switch (GetLocalInt(oArea, "iXPRate"))
        {
            case 1: //Deserts
            switch (nSpellID)
            {
                case SPELL_SUMMON_CREATURE_I:
                {
                    sSummon = "te_mons1d";
                    break;
                }
                case SPELL_SUMMON_CREATURE_II:
                {
                    sSummon = "te_mons2d";
                    break;
                }
                case SPELL_SUMMON_CREATURE_III:
                {
                    sSummon = "te_mons3m";
                    break;
                }
                case SPELL_SUMMON_CREATURE_IV:
                {
                    sSummon = "te_mons4d";
                    break;
                }
                case SPELL_SUMMON_CREATURE_V:
                {
                    sSummon = "te_mons5d";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VI:
                {
                    sSummon = "te_mons6d";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VII:
                {
                    sSummon = "te_mons7d";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VIII:
                {
                    sSummon = "te_mons8c";
                    break;
                }
                case SPELL_SUMMON_CREATURE_IX:
                {
                    sSummon = "te_mons8c";
                    break;
                }
            }
            break;
            case 2: //Plains
            switch (nSpellID)
            {
                case SPELL_SUMMON_CREATURE_I:
                {
                    sSummon = "te_mons1d";
                    break;
                }
                case SPELL_SUMMON_CREATURE_II:
                {
                    sSummon = "te_mons2d";
                    break;
                }
                case SPELL_SUMMON_CREATURE_III:
                {
                    sSummon = "te_mons3m";
                    break;
                }
                case SPELL_SUMMON_CREATURE_IV:
                {
                    sSummon = "te_mons4d";
                    break;
                }
                case SPELL_SUMMON_CREATURE_V:
                {
                    sSummon = "te_mons5d";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VI:
                {
                    sSummon = "te_mons6d";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VII:
                {
                    sSummon = "te_mons7d";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VIII:
                {
                    sSummon = "te_mons8c";
                    break;
                }
                case SPELL_SUMMON_CREATURE_IX:
                {
                    sSummon = "te_mons8c";
                    break;
                }
            }
            break;
            case 3: //Hills
            switch (nSpellID)
            {
                case SPELL_SUMMON_CREATURE_I:
                {
                    sSummon = "te_mons1h";
                    break;
                }
                case SPELL_SUMMON_CREATURE_II:
                {
                    sSummon = "te_mons2hp";
                    break;
                }
                case SPELL_SUMMON_CREATURE_III:
                {
                    sSummon = "te_mons3h";
                    break;
                }
                case SPELL_SUMMON_CREATURE_IV:
                {
                    sSummon = "te_mons4fp";
                    break;
                }
                case SPELL_SUMMON_CREATURE_V:
                {
                    sSummon = "te_mons5f";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VI:
                {
                    sSummon = "te_mons6h";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VII:
                {
                    sSummon = "te_mons7fmp";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VIII:
                {
                    sSummon = "te_mons8fp";
                    break;
                }
                case SPELL_SUMMON_CREATURE_IX:
                {
                    sSummon = "te_mons8fp";
                    break;
                }
            }
            break;
            case 4: //Marshes
            switch (nSpellID)
            {
                case SPELL_SUMMON_CREATURE_I:
                {
                    sSummon = "te_mons1m";
                    break;
                }
                case SPELL_SUMMON_CREATURE_II:
                {
                    sSummon = "te_mons2m";
                    break;
                }
                case SPELL_SUMMON_CREATURE_III:
                {
                    sSummon = "te_mons3m";
                    break;
                }
                case SPELL_SUMMON_CREATURE_IV:
                {
                    sSummon = "te_mons4cm";
                    break;
                }
                case SPELL_SUMMON_CREATURE_V:
                {
                    sSummon = "te_mons5cm";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VI:
                {
                    sSummon = "te_mons6fm";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VII:
                {
                    sSummon = "te_mons7fmp";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VIII:
                {
                    sSummon = "te_mons8m";
                    break;
                }
                case SPELL_SUMMON_CREATURE_IX:
                {
                    sSummon = "te_mons8m";
                    break;
                }
            }
            break;
            case 5: //Forests
            switch (nSpellID)
            {
                case SPELL_SUMMON_CREATURE_I:
                {
                    sSummon = "te_mons1f";
                    break;
                }
                case SPELL_SUMMON_CREATURE_II:
                {
                    sSummon = "te_mons2f";
                    break;
                }
                case SPELL_SUMMON_CREATURE_III:
                {
                    sSummon = "te_mons3f";
                    break;
                }
                case SPELL_SUMMON_CREATURE_IV:
                {
                    sSummon = "te_mons4fp";
                    break;
                }
                case SPELL_SUMMON_CREATURE_V:
                {
                    sSummon = "te_mons5f";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VI:
                {
                    sSummon = "te_mons6fm";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VII:
                {
                    sSummon = "te_mons7fmp";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VIII:
                {
                    sSummon = "te_mons8fp";
                    break;
                }
                case SPELL_SUMMON_CREATURE_IX:
                {
                    sSummon = "te_mons8fp";
                    break;
                }
            }
            break;
            case 6: //Crypt/Cavern
            switch (nSpellID)
            {
                case SPELL_SUMMON_CREATURE_I:
                {
                    sSummon = "te_mons1c";
                    break;
                }
                case SPELL_SUMMON_CREATURE_II:
                {
                    sSummon = "te_mons2cf";
                    break;
                }
                case SPELL_SUMMON_CREATURE_III:
                {
                    sSummon = "te_mons3c";
                    break;
                }
                case SPELL_SUMMON_CREATURE_IV:
                {
                    sSummon = "te_mons4cm";
                    break;
                }
                case SPELL_SUMMON_CREATURE_V:
                {
                    sSummon = "te_mons5cm";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VI:
                {
                    sSummon = "te_mons6c";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VII:
                {
                    sSummon = "te_mons7c";
                    break;
                }
                case SPELL_SUMMON_CREATURE_VIII:
                {
                    sSummon = "te_mons8c";
                    break;
                }
                case SPELL_SUMMON_CREATURE_IX:
                {
                    sSummon = "te_mons8c";
                    break;
                }
            }
            break;
            case 7: //Roads - "No Spawns"
                sSummon = "te_mons1";
                break;
            case 8: //Towns - "No Spawns"
                sSummon = "te_mons1";
                break;
            case 9: //Temples - "No Spawns"
                sSummon = "te_mons1";
                break;
            case 10: //Secret Areas - "No Spawns"
                sSummon = "te_mons1";
                break;
            case 11: //Taverns - "No Spawns"
                sSummon = "te_mons1";
                break;
            case 12: //Keeps - "No Spawns"
                sSummon = "te_mons1";
                break;
        }
    }



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
            DestroyObject(oSummon, TurnsToSeconds(FloatToInt(nDuration)));
        }
    }

}


int DNDAlignment(object oPC)
{
  int i;
  if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_GOOD) {
    switch(GetAlignmentLawChaos(oPC)) {
      case ALIGNMENT_LAWFUL:    i=0;                             break;
      case ALIGNMENT_NEUTRAL:   i=1;                             break;
      case ALIGNMENT_CHAOTIC:   i=2;                             break;
    }
  }
  if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_NEUTRAL) {
    switch(GetAlignmentLawChaos(oPC)) {
      case ALIGNMENT_LAWFUL:    i=3;                             break;
      case ALIGNMENT_NEUTRAL:   i=4;                             break;
      case ALIGNMENT_CHAOTIC:   i=5;                             break;
    }
  } else if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_EVIL) {
    switch(GetAlignmentLawChaos(oPC)) {
      case ALIGNMENT_LAWFUL:    i=6;                             break;
      case ALIGNMENT_NEUTRAL:   i=7;                             break;
      case ALIGNMENT_CHAOTIC:   i=8;                             break;
    }
  }
  return i;
}
