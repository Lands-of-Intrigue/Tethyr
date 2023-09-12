//:://////////////////////////////////////////////////
//:: Tethyr's Spellfire Blast Evocation
//:: TE_SC_blast
//:: Copyright (c) 2015 Function(D20)
//:///////////////////////////////////////////////////

//:///////////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: November 1, 2015
//:///////////////////////////////////////////////////
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "te_functions"

void main()
{
    //Declare Major Variables
    object oTarget = GetSpellTargetObject();
    object oPC = OBJECT_SELF;
    object oCaster = OBJECT_SELF;
    int CLASS_TYPE_SC = 49;
    int nCasterLvl = GetLevelByClass(CLASS_TYPE_BARD,oCaster)+(GetLevelByClass(CLASS_TYPE_CLERIC,oCaster)/2)+(GetLevelByClass(CLASS_TYPE_DRUID,oCaster)/2)+GetLevelByClass(CLASS_TYPE_SHADOW_ADEPT,oCaster)+GetLevelByClass(CLASS_TYPE_PALE_MASTER,oCaster)+GetLevelByClass(CLASS_TYPE_SORCERER,oCaster)+GetLevelByClass(CLASS_TYPE_SPELLFIRE,oCaster)+GetLevelByClass(CLASS_TYPE_WARLOCK,oCaster)+GetLevelByClass(CLASS_TYPE_WIZARD,oCaster);
    //GetLevelByClass(CLASS_TYPE_SPELLFIRE, oPC);
    int nTouch = TouchAttackRanged(oTarget,TRUE);
    effect eRay1 = EffectBeam(823, OBJECT_SELF, BODY_NODE_HAND);
    effect eRay2 = EffectBeam(823, OBJECT_SELF, BODY_NODE_HAND, TRUE);
    effect eVis1 = EffectVisualEffect(821);
    int nDamF;
    int nDamM;
    effect eDamF;
    effect eDamM;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    int nMana = GetLocalInt(oItem,"nMana");

    SignalEvent(oTarget, EventSpellCastAt(oPC, SPELL_NEGATIVE_ENERGY_RAY, TRUE)); //Signal to the target it is being attacked.

    if (nMana >= 1)
    {
        SetLocalInt(oItem, "nMana", (nMana-1));
        if (nTouch > 0)
        {
            nDamF = d6(nCasterLvl/2)*nTouch;
            nDamF = GetReflexAdjustedDamage(nDamF, oTarget, TE_GetSpellSaveDC(OBJECT_SELF,GetSpellId(),GetLastSpellCastClass()), SAVING_THROW_TYPE_FIRE);

            if(GetIsUndead(oTarget) == TRUE && GetPCAffliction(oTarget) != 3 && GetPCAffliction(oTarget) != 4 && GetPCAffliction(oTarget) != 8)
            {
                nDamF = FloatToInt(nDamF * 1.5f );
            }

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay1, oTarget, 1.7);
            eDamF = EffectDamage(nDamF, DAMAGE_TYPE_FIRE);
            eDamM = EffectDamage(nDamF, DAMAGE_TYPE_MAGICAL);
            DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamF, oTarget));
            DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamM, oTarget));
            DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis1, oTarget));
            AdjustReputation(oPC, oTarget, 0);


        }
        else
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay2, oTarget, 1.7);
            AdjustReputation(oPC, oTarget, 0);
        }
    }
    else
    {
        SendMessageToPC(oPC,"You reach into your well of stored power and find it empty.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(nCasterLvl),DAMAGE_TYPE_FIRE),oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(nCasterLvl),DAMAGE_TYPE_MAGICAL),oPC);
        AdjustReputation(oPC, oTarget, 0);
    }

}
