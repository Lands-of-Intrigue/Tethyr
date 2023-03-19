//::///////////////////////////////////////////////
//:: Create Undead
//:: NW_S0_CrUndead.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Spell summons a Ghoul, Shadow, Ghast, Wight or
    Wraith
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
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetAllCasterLevel(OBJECT_SELF);
    location lTarget = GetSpellTargetLocation();
    object oTarget = GetSpellTargetObject();
    int iUndead = GetLocalInt(oTarget, "iUndead");
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    int nDuration = 24;

    if (GetIsNight() == TRUE)
    {
        if(GetIsObjectValid(oTarget) != TRUE)
        {
            effect eSummon;
            //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
            //Check for metamagic extend
            if (nMetaMagic == METAMAGIC_EXTEND)
            {
                nDuration = nDuration *2;   //Duration is +100%
            }
            //Set the summoned undead to the appropriate template based on the caster level
            if (nCasterLevel <= 11)
            {
                eSummon = EffectSummonCreature("te_summons010",VFX_FNF_SUMMON_UNDEAD);
            }
            else if ((nCasterLevel >= 12) && (nCasterLevel <= 14))
            {
                eSummon = EffectSummonCreature("te_summons009",VFX_FNF_SUMMON_UNDEAD);
            }
            else if ((nCasterLevel >= 15) && (nCasterLevel <= 17))
            {
                eSummon = EffectSummonCreature("te_summons007",VFX_FNF_SUMMON_UNDEAD); // change later
            }
            else if ((nCasterLevel >= 18))
            {
                eSummon = EffectSummonCreature("te_summons008",VFX_FNF_SUMMON_UNDEAD);
            }

            //Apply VFX impact and summon effect
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lTarget, HoursToSeconds(nDuration));
            //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
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
