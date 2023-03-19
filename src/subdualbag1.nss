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
    string sOwner = GetLocalString(OBJECT_SELF,"Name");
    string sFeedback = sOwner+"'s belongings";
    SpeakString(sFeedback);
    subDEBUG(GetName(GetLastOpenedBy()) + " just opened " + sFeedback);
}
