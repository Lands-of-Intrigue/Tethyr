//::///////////////////////////////////////////////
//:: Summon Undead
//:: X2_S2_SumUndead
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     The level of the Pale Master determines the
     type of undead that is summoned.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Feb 05, 2003
//:: Updated By: Georg Zoeller, Oct 2003
//:://////////////////////////////////////////////
#include "loi_functions"
#include "te_afflic_func"

void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    //Declare major variables
    int nCasterLevel = GetAllCasterLevel(OBJECT_SELF);
    int nDuration = 24;

    if (GetIsNight() == TRUE)
    {
        //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
        effect eSummon;
        //Summon the appropriate creature based on the summoner level
        if (nCasterLevel <= 11)
        {
            //Ghoul
            eSummon = EffectSummonCreature("te_summons010",VFX_IMP_HARM,0.0f,0);
        }
        else if ((nCasterLevel >= 12) && (nCasterLevel <= 14))
        {
            //Shadow
            eSummon = EffectSummonCreature("te_summons009",VFX_IMP_HARM,0.0f,0);
        }
        else if ((nCasterLevel >= 15) && (nCasterLevel <= 17))
        {
            //Ghast
            eSummon = EffectSummonCreature("te_summons007",VFX_IMP_HARM,0.0f,1);
        }
        else if (nCasterLevel >= 18)
        {
            //Wight
            eSummon = EffectSummonCreature("te_summons008",VFX_FNF_SUMMON_UNDEAD,0.0f,1);
        }
        // * Apply the summon visual and summon the two undead.
        // * ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_LOS_EVIL_10),GetSpellTargetLocation());
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
    }
    else
    {
        SendMessageToPC(oPC, "This spell may only be cast at night...");
    }
}
