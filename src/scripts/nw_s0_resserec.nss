//::///////////////////////////////////////////////
//:: [Ressurection]
//:: [NW_S0_Ressurec.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Brings a character back to life with full
//:: health.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: VFX Pass By: Preston W, On: June 22, 2001
    #include "loi_functions"
    #include "x2_inc_spellhook"
    #include "nwnx_creature"

void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    object oRevived = GetPCBodyOwner(oTarget);
    int nHealed = GetMaxHitPoints(oRevived);
    effect eHeal = EffectHeal(nHealed + 10);
    effect eRaise = EffectResurrection();
    int iUndead = GetLocalInt(oTarget, "iUndead");
    effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);

    //Check to make sure the target is dead first
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESURRECTION, FALSE));

        if (iUndead == 0)
        {
            //Apply the heal, raise dead and VFX impact effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oRevived);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oRevived);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
            EventResurrectPCBody(oTarget, oPC);
        }
        else
        {
            NWNX_Creature_RemoveFeat(oRevived, 1414);
            NWNX_Creature_RemoveFeat(oRevived, 1415);
            NWNX_Creature_RemoveFeat(oRevived, 1422);
            NWNX_Creature_RemoveFeat(oRevived, 1423);
            NWNX_Creature_RemoveFeat(oRevived, 1424);
            NWNX_Creature_RemoveFeat(oRevived,1475);
            NWNX_Creature_RemoveFeat(oRevived,1476);
            NWNX_Creature_RemoveFeat(oRevived,1477);
            NWNX_Creature_RemoveFeat(oRevived,1478);

            SetLocalInt(oTarget,"Undead",0);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oRevived);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oRevived);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
            EventResurrectPCBody(oTarget, oPC);
            SetPCAffliction(oRevived,0);
            Affliction_Items(oRevived,0);
        }
}
