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
#include "loi_functions"
#include "te_functions"
#include "nwnx_creature"

void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oTarget;
    int nAffliction;
    object oData;

    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
        oTarget = GetItemActivatedTarget();
        nAffliction = GetPCAffliction(oTarget);
        oData = GetItemPossessedBy(oTarget,"PC_Data_Object");

        if(GetRacialType(oTarget) == RACIAL_TYPE_ELF)
        {
            if(nAffliction == 0)
            {
                SendMessageToPC(oTarget,"Target is now a Drider");
                SetPCAffliction(oTarget,6);
                Affliction_Items(oTarget,6);

                if(GetGender(oTarget) == GENDER_MALE)
                {
                    SetCreatureAppearanceType(oTarget,3548);
                }
                else
                {
                    SetCreatureAppearanceType(oTarget,3541);
                }
            }
            else if (GetPCAffliction(oTarget) == 6)
            {
                SendMessageToPC(oTarget,"Target is now a Vampire Drider");
                SetPCAffliction(oTarget,4);
                Affliction_Items(oTarget,4);

                if(GetGender(oTarget) == GENDER_MALE)
                {
                    SetCreatureAppearanceType(oTarget,3548);
                }
                else
                {
                    SetCreatureAppearanceType(oTarget,3541);
                }
                NWNX_Creature_AddFeat(oTarget, 1414);
                NWNX_Creature_AddFeat(oTarget, 1415);
                NWNX_Creature_AddFeat(oTarget, 1422);
                NWNX_Creature_AddFeat(oTarget, 1423);
                NWNX_Creature_AddFeat(oTarget, 1424);

            }
            else if (GetPCAffliction(oTarget) == 4)
            {
                SendMessageToPC(oTarget,"Target is now a normal Drow.");
                SetPCAffliction(oTarget,0);
                Affliction_Items(oTarget,0);

                if(GetGender(oTarget) == GENDER_MALE)
                {
                    SetCreatureAppearanceType(oTarget,1);
                }
                else
                {
                    SetCreatureAppearanceType(oTarget,1);
                }
                NWNX_Creature_RemoveFeat(oTarget, 1414);
                NWNX_Creature_RemoveFeat(oTarget, 1415);
                NWNX_Creature_RemoveFeat(oTarget, 1422);
                NWNX_Creature_RemoveFeat(oTarget, 1423);
                NWNX_Creature_RemoveFeat(oTarget, 1424);
            }
        }
        else
        {
            SendMessageToPC(oTarget,"Tool only applicable with elves.");
        }

    }
}
