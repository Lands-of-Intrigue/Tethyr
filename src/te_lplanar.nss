//::///////////////////////////////////////////////
//:: Lesser Planar Binding
//:: NW_S0_LsPlanar.nss
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
//:: VFX Pass By: Preston W, On: June 20, 2001

int DNDAlignment(object oPC);
#include "x2_inc_spellhook"

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
    int nAlign = DNDAlignment(OBJECT_SELF);
    object oTarget = GetSpellTargetObject();
    int nRacial = GetRacialType(oTarget);
    if(nDuration == 0)
    {
        nDuration = 1;
    }

    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Check to see if the target is valid
    if (GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LESSER_PLANAR_BINDING));
            //Check to make sure the target is an outsider
            if(nRacial == RACIAL_TYPE_OUTSIDER)
            {
                //Make a will save
                if(!WillSave(oTarget, TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass())))
                {
                    //Apply the linked effect
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration/2));
                }
            }
        }
    }
    else
    {
        //Get the alignment of the caster
        float fDelay = 3.0;
        switch (nAlign)
        {
            //Set the summon effect based on alignment
            case 0:
            case 1:
            case 2:
                {
                    eSummon = EffectSummonCreature("te_summons050",VFX_FNF_SUMMON_GATE , fDelay);
                    //eGate = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
                }
            break;
            case 3:
            case 4:
            case 5:
                {
                    eSummon = EffectSummonCreature("te_summons061", VFX_FNF_SUMMON_MONSTER_3);
                    //eGate = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3, ,1.0);
                }
            break;
            case 6:
                {
                    eSummon = EffectSummonCreature("te_summons065", VFX_FNF_SUMMON_MONSTER_3);
                    //eGate = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3, ,1.0);
                }
            break;
            case 7:
                {
                    eSummon = EffectSummonCreature("te_summons072",VFX_FNF_SUMMON_GATE , fDelay);
                    //eGate = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
                }
            break;
            case 8:
                {
                    eSummon = EffectSummonCreature("te_summons066", 219 ,fDelay);
                    //eGate = EffectVisualEffect(219);
                }
            break;
        }
        //Apply the summon effect and the VFX impact
        //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGate, GetSpellTargetLocation());
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
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
