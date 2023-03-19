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
    int nCasterLevel = GetLevelByClass(27);
    int nDuration = nCasterLevel;
    effect eSummon;



    //Set the summoned undead to the appropriate template based on the caster level
    if (nCasterLevel <= 3)
    {
        eSummon = EffectSummonCreature("te_summons072",VFX_FNF_SUMMON_UNDEAD);
    }
    else if (nCasterLevel <= 6)
    {
        eSummon = EffectSummonCreature("te_summons073",VFX_FNF_SUMMON_UNDEAD);
    }
    else if (nCasterLevel <=9)
    {
        eSummon = EffectSummonCreature("te_summons074",VFX_FNF_SUMMON_UNDEAD);
    }
    else
    {
      if (GetHasFeat(1002,OBJECT_SELF))// has epic shadowlord feat
      {
       //GZ 2003-07-24: Epic shadow lord
          eSummon = EffectSummonCreature("x2_s_eshadlord",VFX_FNF_SUMMON_UNDEAD);
      }
      else
      {
         eSummon = EffectSummonCreature("te_summons075",VFX_FNF_SUMMON_UNDEAD);
      }

    }

    //Apply VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
}
