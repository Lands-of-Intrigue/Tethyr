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
    int nCasterLevel = GetLevelByClass(47,OBJECT_SELF);
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
        float fDelay = 3.0;

        if(GetHasFeat(1137,OBJECT_SELF))
        {
            eSummon = EffectSummonCreature("te_summons063",VFX_FNF_SUMMON_GATE, fDelay);
        }
        else if(GetHasFeat(1138,OBJECT_SELF))
        {
            eSummon = EffectSummonCreature("te_summons075",VFX_FNF_SUMMON_GATE, fDelay);
        }
        else if(GetHasFeat(1139,OBJECT_SELF))
        {
            eSummon = EffectSummonCreature("te_summons064",VFX_FNF_SUMMON_GATE, fDelay);
        }

        //Apply the VFX impact and summon effect
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));
}

