//::///////////////////////////////////////////////
//:: Example Item Event Script
//:: x2_it_example
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is an example of how to use the
    new default module events for NWN to
    have all code concerning one item in
    a single file.

    Note that this system only works if
    the following scripts are set in your
    module events

    OnEquip      - x2_mod_def_equ
    OnUnEquip    - x2_mod_def_unequ
    OnAcquire    - x2_mod_def_aqu
    OnUnAcqucire - x2_mod_def_unaqu
    OnActivate   - x2_mod_def_act
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-10
//:: Modified By: Grimlar
//:: Modified On: March 2004
//:://////////////////////////////////////////////
#include "x2_inc_itemprop"
#include "x2_inc_switches"
#include "nwnx_time"
#include "nw_i0_spells"

void main()
{
    int    nEvent = GetUserDefinedItemEventNumber(); // Which event triggered this
    object oItem         =  GetSpellCastItem();     // The item triggering this spellscript
    object oPC           = OBJECT_SELF;             // The player triggering it
    object oSpellOrigin  = OBJECT_SELF ;            // Where the spell came from
    object oSpellTarget  = GetSpellTargetObject();  // What the spell is aimed at
    int nTimeNow = NWNX_Time_GetTimeStamp();
    int nStoneskinDR = GetLocalInt(oSpellTarget,"nStoneskinDR");
    int nStoneskinTime = GetLocalInt(oSpellTarget,"nStoneskinTime");
    int nNewStoneSkinDR = 0;
    // Set the return value for the item event script
    // * X2_EXECUTE_SCRIPT_CONTINUE - continue calling script after executed script is done
    // * X2_EXECUTE_SCRIPT_END - end calling script after executed script is done
    int nResult = X2_EXECUTE_SCRIPT_END;

    if(nEvent == X2_ITEM_EVENT_ONHITCAST)
    {
        int nD20 = d20(1);
        if(nD20 >= 11)
        {
            if(GetDistanceBetween(oSpellOrigin, oSpellTarget) < 1.6 )
            {
                int nDam = d6();

                if(nStoneskinDR > 0)
                {
                    if(nTimeNow >= nStoneskinTime)
                    {
                        SetLocalInt(oSpellTarget,"nStoneskinDR",0);
                        RemoveEffectsFromSpell(oSpellTarget, SPELL_STONESKIN);
                        RemoveEffectsFromSpell(oSpellTarget, SPELL_GREATER_STONESKIN);
                    }
                    else
                    {
                        nNewStoneSkinDR = nStoneskinDR-nDam;
                        if(nNewStoneSkinDR <= 0)
                        {
                            nNewStoneSkinDR = 0;
                            RemoveEffectsFromSpell(oSpellTarget, SPELL_STONESKIN);
                            RemoveEffectsFromSpell(oSpellTarget, SPELL_GREATER_STONESKIN);
                        }
                        SetLocalInt(oSpellTarget,"nStoneskinDR",nNewStoneSkinDR);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(353),oSpellTarget);
                        SendMessageToPC(oSpellTarget,"Stoneskin Damage Reduction Absorbs "+IntToString(nDam)+" damage ("+IntToString(nNewStoneSkinDR)+" points remaining)");
                        SendMessageToPC(oPC,"Damage Reduction Absorbs "+IntToString(nDam)+" damage");
                    }
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDam, DAMAGE_TYPE_PIERCING), oSpellTarget);
                    SendMessageToPC(oPC,GetName(oPC)+" has spikey armor!");
                }
            }
        }
    }

    // Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}
