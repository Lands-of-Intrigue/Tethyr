//::///////////////////////////////////////////////
//:: Create Greater Undead
//:: NW_S0_CrGrUnd.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons an undead type pegged to the character's
    level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "loi_functions"
#include "te_afflic_func"
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
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    object oRevived = GetPCBodyOwner(oTarget);
    location lTarget = GetSpellTargetLocation();
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetAllCasterLevel(OBJECT_SELF);
    int nDuration = 24;
    effect eSummon;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    int iUndead = GetLocalInt(oTarget, "iUndead");
    int nHealed = GetMaxHitPoints(oRevived);
    effect eHeal = EffectHeal(nHealed + 10);
    effect eRaise = EffectResurrection();

    if (GetIsNight() == TRUE)
    {
        if(GetIsObjectValid(oTarget) != TRUE)
        {
            //Make metamagic extend check
            if (nMetaMagic == METAMAGIC_EXTEND)
            {
                nDuration = nDuration *2;   //Duration is +100%
            }
            //Determine undead to summon based on level
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
            //Apply summon effect and VFX impact.
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lTarget, HoursToSeconds(nDuration));
        }
        else
        {
            int iUndead = GetLocalInt(oTarget, "iUndead");
            if(iUndead == 1)
            {
                EventReviveUndPCBody(oTarget, oPC);
            }
            else
            {
                SendMessageToPC(oPC,"Invalid target.");
            }
        }
    }
    else
    {
        SendMessageToPC(oPC, "This spell may only be cast at night...");
    }
}
