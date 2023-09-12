//::///////////////////////////////////////////////
//:: Animate Dead
//:: NW_S0_AnimDead.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons a powerful skeleton or zombie depending
    on caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 11, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "te_afflic_func"
#include "loi_functions"
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

    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    object oRevived = GetPCBodyOwner(oTarget);

    if(GetIsObjectValid(oTarget) != TRUE)
    {
        //Declare major variables
        int nMetaMagic = GetMetaMagicFeat();
        int nCasterLevel = GetAllCasterLevel(OBJECT_SELF);
        int nDuration = GetAllCasterLevel(OBJECT_SELF);
        nDuration = 24;
        //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
        effect eSummon;
        //Metamagic extension if needed
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration * 2;  //Duration is +100%
        }
        //Summon the appropriate creature based on the summoner level
        if (nCasterLevel <= 6)
        {
            //Tyrant Fog Zombie
            eSummon = EffectSummonCreature("te_summons080",VFX_FNF_SUMMON_UNDEAD);
        }
        else if ((nCasterLevel >= 7) && (nCasterLevel <= 8))
        {
            //Skeleton Warrior
            eSummon = EffectSummonCreature("te_summons076",VFX_FNF_SUMMON_UNDEAD);
        }
        else if ((nCasterLevel >= 9) && (nCasterLevel <= 10))
        {
            //Skeleton Warrior
            eSummon = EffectSummonCreature("te_summons078",VFX_FNF_SUMMON_UNDEAD);
        }
        else if ((nCasterLevel >=11) && (nCasterLevel <= 12))
        {
            //Skeleton Warrior
            eSummon = EffectSummonCreature("te_summons077",VFX_FNF_SUMMON_UNDEAD);
        }
        else
        {
            //Skeleton Chieftain
            eSummon = EffectSummonCreature("te_summons079",VFX_FNF_SUMMON_UNDEAD);
        }
        //Apply the summon visual and summon the two undead.
        //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
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
