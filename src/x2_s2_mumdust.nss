//::///////////////////////////////////////////////
//:: Mummy Dust
//:: X2_S2_MumDust
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Summons a strong warrior mummy for you to
     command.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Feb 07, 2003
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
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


    //Declare major variables
    int nDuration = 24;
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eSummon;
    //Summon the appropriate creature based on the summoner level
    //Warrior Mummy
    if (nCasterLevel <= 20)
    {
        eSummon = EffectSummonCreature("te_summons100",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 21) && (nCasterLevel <= 22))
    {
        eSummon = EffectSummonCreature("te_md_am",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 23) && (nCasterLevel <= 23))
    {
        eSummon = EffectSummonCreature("te_md_ah",VFX_FNF_SUMMON_UNDEAD); // change later
    }
    else if ((nCasterLevel >= 25))
    {
        eSummon = EffectSummonCreature("te_md_aw",VFX_FNF_SUMMON_UNDEAD);
    }

    if(GetHasFeat(1357,OBJECT_SELF) == TRUE)
    {
        eSummon = EffectSummonCreature("te_summons098",VFX_FNF_SUMMON_UNDEAD);
    }

    if(GetHasFeat(1359,OBJECT_SELF) == TRUE)
    {
        eSummon = EffectSummonCreature("te_summons099",VFX_FNF_SUMMON_UNDEAD);
    }
    eSummon = ExtraordinaryEffect(eSummon);
    //Apply the summon visual and summon the undead.
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
}


