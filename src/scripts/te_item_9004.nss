//::///////////////////////////////////////////////
//:: Example Item Event Script
//:: x2_it_example
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is an example on how to use the
    new default module events for NWN to
    have all code concerning one item in
    a single file.

    Note that this system only works, if
    the following events set on your module

    OnEquip      - x2_mod_def_equ
    OnUnEquip    - x2_mod_def_unequ
    OnAcquire    - x2_mod_def_aqu
    OnUnAcqucire - x2_mod_def_unaqu
    OnActivate   - x2_mod_def_act

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-10
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "nw_i0_spells"

//First Blindness / Message
void Werewolf_1(object oTarget);

//Second anger, attack
void Werewolf_2(object oTarget);

//Polymorph!
void Werewolf_3(object oTarget);

void Werewolf_1(object oTarget)
{
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectBlindness(),oTarget,RoundsToSeconds(3));
    SendMessageToPC(oTarget,"You feel a sense of anger overtake you as you struggle to remove a fine powder from your eyes.");
}

void Werewolf_2(object oTarget)
{

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectConfused(),oTarget,TurnsToSeconds(2));
    SendMessageToPC(oTarget,"You can no longer contol yourself or your anger...You feel the beast within starting to take over completely.");
}

void Werewolf_3(object oTarget)
{
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectPolymorph(144,TRUE),oTarget,HoursToSeconds(1));
    SendMessageToPC(oTarget,"You have lost all control...There is only a wolf now.");

}

void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oTarget;

    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
        oTarget = GetItemActivatedTarget();

        if (GetHasFeat(1175,oTarget))
        {
            if(!MySavingThrow(SAVING_THROW_FORT,oTarget,20,SAVING_THROW_TYPE_POISON,oItem))
            {
                Werewolf_1(oTarget);
                SendMessageToPC(oTarget,"Your anger begins to grow out of your control...You feel the beast within you pushing towards the surface.");
                DelayCommand(30.0,Werewolf_2(oTarget));
                DelayCommand(15.0,Werewolf_3(oTarget));
                SendMessageToPC(oPC,"Your worst fears are confirmed as the person before you turns into a monster before your very eyes.");
            }
            else
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectBlindness(),oTarget,RoundsToSeconds(1));
                SendMessageToPC(oTarget,"You feel a sense of anger overtake you as you struggle to remove a fine powder from your eyes.");
                DelayCommand(RoundsToSeconds(1),SendMessageToPC(oTarget,"However, it begins to subside as you manage to remove most of the irritating powder."));
            }
        }
        else
        {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectBlindness(),oTarget,RoundsToSeconds(3));
                SendMessageToPC(oTarget,"You feel a sense of anger overtake you as you struggle to remove a fine powder from your eyes.");
        }
    }
}
