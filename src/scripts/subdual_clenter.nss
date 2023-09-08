//::///////////////////////////////////////////////
//:: Subdual Damage 1.6
//:: subdual_clenter
//:: Copyright (c) 2018 CarfaxAbbey.net
//:://////////////////////////////////////////////
/*
    Allows for PC subdual in PvP combat.
    Non-Lethal Damage
*/
//:://////////////////////////////////////////////
//:: Revised By: Diavlen (hatter@carfaxabbey.net)
//:: Created On: August 11, 2006
//:: Revised: March 30, 2018
//:://////////////////////////////////////////////

#include "subdual_inc"

void main() {
    object oPC  =   OBJECT_SELF;

    // If PC doesn't have a subdual tool, give them one.
    if(!GetIsObjectValid(GetItemPossessedBy(oPC,"SubdualModeTog")))
        CreateItemOnObject("subdualmodetog",oPC);

    // This will set all PCs to Subdual Damage.  They have to turn it off
    // if they want to use lethal force against another player.
    SetLocalInt(oPC,"SUBDUAL",SUBDUAL_MODE_SUBDUAL);
    DelayCommand(5.0,FloatingTextStringOnCreature("**Doing Subdual Damage**",oPC,FALSE));
}
