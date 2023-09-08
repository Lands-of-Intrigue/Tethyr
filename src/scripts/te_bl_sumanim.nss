//::///////////////////////////////////////////////
//:: Summon Shadow
//:: X0_S2_ShadSum.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    PRESTIGE CLASS VERSION
    Spell powerful ally from the shadow plane to
    battle for the wizard
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 26, 2001
//:://////////////////////////////////////////////

void main()
{
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetLevelByClass(CLASS_TYPE_DRUID);
    int nDuration = nCasterLevel;
    effect eSummon;

    //Set the summoned undead to the appropriate template based on the caster level
    if (nCasterLevel <= 12)
    {
        eSummon = EffectSummonCreature("te_summons001",VFX_FNF_SUMMON_UNDEAD);
    }
    else if (nCasterLevel <= 14)
    {
        eSummon = EffectSummonCreature("te_summons004",VFX_FNF_SUMMON_UNDEAD);
    }
    else if (nCasterLevel <=16)
    {
        eSummon = EffectSummonCreature("te_summons005",VFX_FNF_SUMMON_UNDEAD);
    }
    else if (nCasterLevel <=18)
    {
        eSummon = EffectSummonCreature("te_summons002",VFX_FNF_SUMMON_UNDEAD);
    }
    else if (nCasterLevel >=19)
    {
        eSummon = EffectSummonCreature("te_summons003",VFX_FNF_SUMMON_UNDEAD);
    }
    //Apply VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
}
