//::///////////////////////////////////////////////
//:: Gate
//:: NW_S0_Gate.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: Summons a Balor to fight for the caster.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////
#include "x2_inc_spellhook"
#include "te_functions"
int DNDAlignment(object oPC);

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    int nDuration = nCasterLevel;
    effect eSummon;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
    //Make metamagic extend check
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Summon the Balor and apply the VFX impact
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    int nAlign = DNDAlignment(OBJECT_SELF);
        float fDelay = 3.0;
        switch (nAlign)
        {
            case 0:
                eSummon = EffectSummonCreature("te_summons058",VFX_FNF_SUMMON_CELESTIAL, fDelay);
            break;
            case 1:
                eSummon = EffectSummonCreature("te_summons059", VFX_FNF_SUMMON_CELESTIAL, fDelay);
            break;
            case 2:
                eSummon = EffectSummonCreature("te_summons060",VFX_FNF_SUMMON_CELESTIAL, fDelay);
            break;
            case 3:
                eSummon = EffectSummonCreature("te_summons062", VFX_FNF_SUMMON_MONSTER_3, 1.0);
            break;
            case 4:
                eSummon = EffectSummonCreature("te_summons062", VFX_FNF_SUMMON_MONSTER_3, 1.0);
            break;
            case 5:
                eSummon = EffectSummonCreature("te_summons062", VFX_FNF_SUMMON_MONSTER_3, 1.0);
            break;
            case 6:
                eSummon = EffectSummonCreature("te_summons063",VFX_FNF_SUMMON_GATE, fDelay);
            break;
            case 7:
                eSummon = EffectSummonCreature("te_summons075",VFX_FNF_SUMMON_GATE, fDelay);
            break;
            case 8:
                eSummon = EffectSummonCreature("te_summons064",VFX_FNF_SUMMON_GATE, fDelay);
            break;
        }

        if(GetHasFeat(1137,OBJECT_SELF)==TRUE)
        {
            eSummon = EffectSummonCreature("te_summons064",VFX_FNF_SUMMON_GATE, fDelay);
        }
        if(GetHasFeat(1139,OBJECT_SELF)==TRUE)
        {
            eSummon = EffectSummonCreature("te_summons063",VFX_FNF_SUMMON_GATE, fDelay);
        }


        //Apply the VFX impact and summon effect
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));
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
