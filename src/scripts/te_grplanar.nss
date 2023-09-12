//::///////////////////////////////////////////////
//:: Greater Planar Binding
//:: NW_S0_GrPlanar.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons an outsider dependant on alignment, or
    holds an outsider if the creature fails a save.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
int DNDAlignment(object oPC);

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
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
    int nDuration = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    effect eSummon;
    effect eGate;
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);

    effect eLink = EffectLinkEffects(eDur, EffectParalyze());
    eLink = EffectLinkEffects(eLink, eDur2);
    eLink = EffectLinkEffects(eLink, eDur3);

    object oTarget = GetSpellTargetObject();
    int nRacial = GetRacialType(oTarget);
    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Check to see if a valid target has been chosen
    if (GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_PLANAR_BINDING));
            //Check for racial type
            if(nRacial == RACIAL_TYPE_OUTSIDER)
            {
                //Allow will save to negate hold effect
                if(!MySavingThrow(SAVING_THROW_WILL, oTarget, TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass())+5))
                {
                    //Apply the hold effect
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration/2));
                }
            }
        }
    }
    else
    {
        //If the ground was clicked on summon an outsider based on alignment
        int nAlign = DNDAlignment(OBJECT_SELF);
        float fDelay = 3.0;
        switch (nAlign)
        {
            case 0:
                eSummon = EffectSummonCreature("te_summons052",VFX_FNF_SUMMON_CELESTIAL, fDelay);
            break;
            case 1:
                eSummon = EffectSummonCreature("te_summons050", VFX_FNF_SUMMON_CELESTIAL, fDelay);
            break;
            case 2:
                eSummon = EffectSummonCreature("te_summons054",VFX_FNF_SUMMON_CELESTIAL, fDelay);
            break;
            case 3:
                eSummon = EffectSummonCreature("te_summons055", VFX_FNF_SUMMON_MONSTER_3, 1.0);
            break;
            case 4:
                eSummon = EffectSummonCreature("te_summons055", VFX_FNF_SUMMON_MONSTER_3, 1.0);
            break;
            case 5:
                eSummon = EffectSummonCreature("te_summons055", VFX_FNF_SUMMON_MONSTER_3, 1.0);
            break;
            case 6:
                eSummon = EffectSummonCreature("te_summons056",VFX_FNF_SUMMON_GATE, fDelay);
            break;
            case 7:
                eSummon = EffectSummonCreature("te_summons074",VFX_FNF_SUMMON_GATE, fDelay);
            break;
            case 8:
                eSummon = EffectSummonCreature("te_summons057",VFX_FNF_SUMMON_GATE, fDelay);
            break;
        }

        if(GetHasFeat(1137,OBJECT_SELF) == TRUE)
        {
            eSummon = EffectSummonCreature("te_summons056",VFX_FNF_SUMMON_GATE, fDelay);
        }
        if(GetHasFeat(1139,OBJECT_SELF) == TRUE)
        {
            eSummon = EffectSummonCreature("te_summons057",VFX_FNF_SUMMON_GATE, fDelay);
        }

        //Apply the VFX impact and summon effect
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
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
