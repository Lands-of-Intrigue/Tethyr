//::///////////////////////////////////////////////
//:: Shades
//:: NW_S0_Shades.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If the opponent is clicked on Shadow Bolt is cast.
    If the caster clicks on himself he will cast
    Stoneskin and Mirror Image.  If they click on
    the ground they will summon a Shadow Lord.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 25, 2001
#include "te_functions"

void ShadowBolt (object oTarget, int nMetaMagic);

void main()
{
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = GetSpellTargetObject();
    int nCast;
    int nDuration = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    effect eVis;
            effect eStone = EffectDamageReduction(1, DAMAGE_POWER_PLUS_FIVE, nDuration * 10);
            effect eMirror = EffectVisualEffect(0);
            effect eLink = EffectLinkEffects(eStone, eMirror);
                       int nCasterLevel = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
           effect eSummon = EffectSummonCreature("sbio_shadlord");
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }

    if (GetIsObjectValid(oTarget))
    {
        if (oTarget == OBJECT_SELF)
        {
            nCast = 1;
        }
        else
        {
            nCast = 2;
        }
    }
    else
    {
        nCast = 3;
    }

    switch (nCast)
    {
        case 1:
            eVis = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
            eLink = EffectLinkEffects(eLink, eVis);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, HoursToSeconds(nDuration));
        case 2:
           if (!ResistSpell(OBJECT_SELF, oTarget))
           {
              ShadowBolt(oTarget, nMetaMagic);
           }
        case 3:
           eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);

           ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
           ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    }
}

void ShadowBolt (object oTarget, int nMetaMagic)
{
    int nDamage;
    int nBolts = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass())/5;
    int nCnt;
    effect eVis2 = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);

    for (nCnt = 0; nCnt < nBolts; nCnt++)
    {
        int nDam = d6(4);
        //Enter Metamagic conditions
        if (nMetaMagic == METAMAGIC_MAXIMIZE)
        {
            nDamage = 24;//Damage is at max
        }
        else if (nMetaMagic == METAMAGIC_EMPOWER)
        {
            nDamage = nDamage + nDamage/2; //Damage/Healing is +50%
        }
        if (ReflexSave(oTarget, TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass())))
        {
            nDamage = nDamage/2;
        }
        effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
    }
}


