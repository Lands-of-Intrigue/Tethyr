//::///////////////////////////////////////////////
//:: Greater Shadow Conjuration
//:: NW_S0_GrShConj.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If the opponent is clicked on Shadow Bolt is cast.
    If the caster clicks on himself he will cast
    Clarity and Mirror Image.  If they click on
    the ground they will summon a Shadow Assassin.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////
#include "te_functions"

void ShadowBolt (object oTarget, int nMetaMagic);

void main()
{
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = GetSpellTargetObject();
    int nCast;
    int nDuration = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
            effect eMirror = EffectVisualEffect(0);
            effect eClarity = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
            effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE);
            effect eLink = EffectLinkEffects(eMirror, eMind);
            int nCasterLevel = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
           effect eSummon = EffectSummonCreature("sbio_shadassa");
           effect eGate = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);

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
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink,oTarget, RoundsToSeconds(2));
        case 2:
           if (!ResistSpell(OBJECT_SELF, oTarget))
           {
              ShadowBolt(oTarget, nMetaMagic);
           }
        case 3:
           ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
           ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eGate, GetSpellTargetLocation());
    }
}

void ShadowBolt (object oTarget, int nMetaMagic)
{
    int nDamage;
    int nBolts = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass())/5;
    int nCnt;
    for (nCnt = 0; nCnt < nBolts; nCnt++)
    {
        int nDam = d6(3);
        //Enter Metamagic conditions
        if (nMetaMagic == METAMAGIC_MAXIMIZE)
        {
            nDamage = 18;//Damage is at max
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
        effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
}



