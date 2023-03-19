//::///////////////////////////////////////////////
//:: Summon Mount
//:: te_sp_summnt.nss
//:://////////////////////////////////////////////
/*
    Spell summons a mount.
*/
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Function(D20), LLC
//:: Created By: David Novotny
//:: Created On: April 12, 2017
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
    object oArea = GetArea(oPC);
    int nCasterLevel = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    location lTarget = GetSpellTargetLocation();
    object oTarget = GetSpellTargetObject();
    int iUndead = GetLocalInt(oTarget, "iUndead");
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    int nDuration = GetHitDice(oPC)*2;

    if ((GetIsAreaAboveGround(oArea))&&(!GetIsAreaInterior(oArea)))
    {
        effect eSummon;
        //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
        //Check for metamagic extend
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration *2;   //Duration is +100%
        }
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, lTarget);
        eSummon = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
        object oHorse;
        if(GetRacialType(oPC) == RACIAL_TYPE_HALFLING || GetRacialType(oPC) == RACIAL_TYPE_GNOME || GetRacialType(oPC) == RACIAL_TYPE_DWARF)
        {
            oHorse = CreateObject(OBJECT_TYPE_CREATURE,"hrs_06",lTarget,FALSE);
        }
        else
        {
            oHorse = CreateObject(OBJECT_TYPE_CREATURE,"hrs_05",lTarget,FALSE);
        }
        AddHenchman(oPC,oHorse);

        //Apply VFX impact and summon effect

        //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    }
    else
    {
        SendMessageToPC(oPC, "This spell may only be cast outdoors");
    }
}
