//::///////////////////////////////////////////////
//:: Subdual Damage 1.6
//:: subdual_mod_act
//:: Copyright (c) 2018 CarfaxAbbey.net
//:://////////////////////////////////////////////
/*
    Allows for PC subdual in PvP combat.
    Non-Lethal Damage

    This script is only used if you DON'T have
    Tag Based Items enabled
*/
//:://////////////////////////////////////////////
//:: Revised By: Diavlen (hatter@carfaxabbey.net)
//:: Created On: August 11, 2006
//:: Revised: March 30, 2018
//:://////////////////////////////////////////////

void main() {
    object oItem    =   GetItemActivated();
    object oPC      =   GetItemActivator();
    string sItemTag =   GetTag(oItem);

    if(sItemTag=="SubdualModeTog")  {
        ExecuteScript("subdualmodetog", oPC);
        return;
    }
}
