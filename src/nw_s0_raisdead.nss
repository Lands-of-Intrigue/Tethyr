//::///////////////////////////////////////////////
//:: [Raise Dead]
//:: [NW_S0_RaisDead.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Brings a character back to life with 1 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: VFX Pass By: Preston W, On: June 22, 2001

// DEATH CODE START
    #include "loi_functions"
    #include "x2_inc_spellhook"
// DEATH CODE END


void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    //Declare major variables
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    effect eRaise = EffectResurrection();
    effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
    int iUndead = GetLocalInt(oTarget, "iUndead");

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAISE_DEAD, FALSE));

    if (iUndead == 0)
    {
        if(GetHasFeat(1137, GetPCBodyOwner(oTarget)) == TRUE || GetHasFeat(1139, GetPCBodyOwner(oTarget)) == TRUE)
        {
            SendMessageToPC(oPC, "The soul seems beyond the reach of your spell...");
        }
        else
        {
            EventRevivePCBody(oTarget, oPC);
        }
    }
    else
    {
        SendMessageToPC(oPC, "This spell cannot be used to raise undead.");
    }
}

