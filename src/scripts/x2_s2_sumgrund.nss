//::///////////////////////////////////////////////
//:: Summon Greater Undead
//:: X2_S2_SumGrUnd
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     2003-10-03 - GZ: Added Epic Progression
     The level of the Pale Master determines the
     type of undead that is summoned.

     Level 9 <= Mummy Warrior
     Level 10 <= Spectre
     Level 12 <= Vampire Rogue
     Level 14 <= Bodak
     Level 16 <= Ghoul King
     Level 18 <= Vampire Mage
     Level 20 <= Skeleton Blackguard
     Level 22 <= Lich
     Level 24 <= Lich Lord
     Level 26 <= Alhoon
     Level 28 <= Elder Alhoon
     Level 30 <= Lesser Demi Lich

     Lasts 14 + Casterlevel rounds
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Feb 05, 2003
//:://////////////////////////////////////////////
#include "loi_functions"
#include "te_afflic_func"
void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    object oRevived = GetPCBodyOwner(oTarget);
    int iUndead = GetLocalInt(oTarget, "iUndead");

    int nCasterLevel = GetAllCasterLevel(OBJECT_SELF);
    int nDuration = 24;

    effect eSummon;

    if (GetIsNight() == TRUE)
    {
        //--------------------------------------------------------------------------
        // Summon the appropriate creature based on the summoner level
        //--------------------------------------------------------------------------
        if (nCasterLevel <= 16)
        {
            eSummon = EffectSummonCreature("te_summons006",VFX_FNF_SUMMON_UNDEAD);
        }
        else if ((nCasterLevel >= 17) && (nCasterLevel <= 19))
        {
            eSummon = EffectSummonCreature("te_summons100",VFX_FNF_SUMMON_UNDEAD);
        }
        else if ((nCasterLevel >= 20) && (nCasterLevel <= 22))
        {
            eSummon = EffectSummonCreature("te_summons101",VFX_FNF_SUMMON_UNDEAD); // change later
        }
        else if ((nCasterLevel >= 23))
        {
            eSummon = EffectSummonCreature("te_summons102",VFX_FNF_SUMMON_UNDEAD);
        }


        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_LOS_EVIL_10),GetSpellTargetLocation());
        //Apply the summon visual and summon the two undead.
        //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
    }
    else
    {
        SendMessageToPC(oPC, "This spell may only be cast at night...");
    }
}
