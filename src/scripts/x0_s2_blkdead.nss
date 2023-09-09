//::///////////////////////////////////////////////
//:: x0_s2_blkdead
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Level 3 - 6:  Summons Ghast
    Level 7 - 10: Doom Knight
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

void main()
{




    int nCasterLevel = GetLevelByClass(CLASS_TYPE_BLACKGUARD, OBJECT_SELF);
    effect eSummon;
    float fDelay = 3.0;
    int nDuration = nCasterLevel;
    if (nCasterLevel <= 3)
    {
        //Tyrant Fog Zombie
        eSummon = EffectSummonCreature("te_su_wrai",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 4) && (nCasterLevel <= 5))
    {
        //Skeleton Warrior
        eSummon = EffectSummonCreature("te_su_spec",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 6) && (nCasterLevel <= 7))
    {
        //Skeleton Warrior
        eSummon = EffectSummonCreature("te_cuvawm",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >=8) && (nCasterLevel <= 9))
    {
        //Skeleton Warrior
        eSummon = EffectSummonCreature("te_cu_vasd",VFX_FNF_SUMMON_UNDEAD);
    }
    else
    {
        //Skeleton Chieftain
        eSummon = EffectSummonCreature("te_summons100",VFX_FNF_SUMMON_UNDEAD);
    }

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));

}
