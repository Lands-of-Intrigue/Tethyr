////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_include:
// Has various functions I didnt want to write more than once.
////////////////////////////
// v1.1: Added some more constants

#include "x0_i0_position"
//Used for much of the vector system

//I guess you can change these if you want, but it really wont do anything.

const int SIEGE_ONAGER = 1; //Shoots only non-magical AE things.
const int SIEGE_ARBALEST = 2; //Shoots low damage/range, high speed single target
const int SIEGE_CANNON = 3; //Shoots only magical AE things.
const int SIEGE_RAM = 4; //Hits doors.
const int SIEGE_SCORPION = 5; //Shoots high damage/range, low speed single target

// You can change these if you wish. These determine max ranges.
const float RANGE_ONAGER = 45.0;
const float RANGE_ARBALEST = 60.0;
const float RANGE_CANNON = 40.0;
const float RANGE_RAM = 5.0; //The max distance, in meters, away the ram can be from a door to recognise it.
const float RANGE_SCORPION = 75.0;

// These determine the time it takes to load+fire a weapon.
const float TIME_ONAGER = 5.0;
const float TIME_ARBALEST = 2.0;
const float TIME_CANNON = 3.0; //The cannon only fires magic stuff--Hence fast.
const float TIME_RAM = 2.0;
const float TIME_SCORPION = 4.5; //The Scorpion shoots farther and more damage than Arbalest, but slower

// Various damage related things
const float ONAGER_SHARD_RADIUS = 10.0; //How wide the radius of shards should  be.
const int ONAGER_SHARD_MODIFIER = 16; //Onager shard bits roll this modifier + d20 against targets AC
                                      //Anything lightly armored (AC at most this) will always be hit.
                                      //Anything heavily armored (AC higher than this + 20) will never be hit.
const float RAM_FIRE_TIME = 30.0; //Time, in seconds, that a ram will stay on fire with Alchemist's Fire.
const float CANNON_WEB_TIME = 45.0; //Time web lasts

// Misc stuff
const float DIST_AIMFIRE = 3.5; //How far away the player can be to fire/aim weapon

//const float RUN_TIME = 1.5; Removed in 1.1
const int ARBALEST_AIM = SHAPE_CONE; //Aiming pattern of Arbalest and Scorpion
                                              //Set only to SHAPE_SPELLCYLINDER or SHAPE_CONE
                                              //Others could prove odd results. (Shooting behind, etc)
const float AIM_ACCURACY = 10.0; //How wide the cylinder/cone is at the end.
const int ARBALEST_AIM_DC = 10; //Default DC to hit a creature, +/- 5 if the creature is far or near.
const float MARK_TIME = 30.0; //How long scorch marks caused by ballistic weapons will last.
//Following added in 1.1
const float AIM_TIME = 5.0; //How long the aiming delay should be.
const int RAM_FIRE = TRUE; //Enables and disables ability to put Alchemist's Fire on rams.


///////////////////////////
//Add more weapon types or change the tags here.
//This simply returns the weapon type of the weapon in question.
//Returns -1 if its not a Siege Weapon.
///////////////////////////

int GetType (object oWeapon)
{
    string sTag = GetTag(oWeapon);

    if(sTag == "siege_onager")
    {
        return SIEGE_ONAGER;
    }
    if(sTag == "siege_arbalest")
    {
        return SIEGE_ARBALEST;
    }
    if(sTag == "siege_cannon")
    {
        return SIEGE_CANNON;
    }
    if(sTag == "siege_ram")
    {
        return SIEGE_RAM;
    }
    if(sTag == "siege_scorpion")
    {
        return SIEGE_SCORPION;
    }
    return -1;
}


////////////////////////
//Checks to see if the ammo loaded is in fact valid.
//Check is by default performed OnClose, when beginning to fire,
//and when actually firing (to prevent any exploiting)
////////////////////////

int GetIsAmmoValid(object oWeapon)
{

int iWeapon = GetType(oWeapon);
string sAmmo = GetTag(GetFirstItemInInventory(oWeapon));

if(sAmmo == "")
{
    return FALSE; //There is no ammo.
}

if(iWeapon == SIEGE_ONAGER)
{
    if(GetStringLeft(sAmmo, 7) != "onager_")
    {
        return FALSE;
    } else
    {
        return TRUE;
    }
}
if(iWeapon == SIEGE_ARBALEST)
{
    if(GetStringLeft(sAmmo, 9) != "arbalest_")
    {
        return FALSE;
    } else
    {
        return TRUE;
    }
}
if(iWeapon == SIEGE_CANNON)
{
    if(GetStringLeft(sAmmo, 7) != "cannon_")
    {
        return FALSE;
    } else
    {
        return TRUE;
    }
}
////////////////////////////
//No ram entry, duh.. they dont use ammo.
////////////////////////////
if(iWeapon == SIEGE_SCORPION)
{
    if(GetStringLeft(sAmmo, 9) != "scorpion_")
    {
        return FALSE;
    } else
    {
        return TRUE;
    }
}
return FALSE; //In case for some reason oWeapon isnt siege after all.
}

////////////////////////////
//This function is called when a weapon is fired to make it so that creatures
//killed by siege fire give no XP
//v1.1: Changed to actually work :)
////////////////////////////
void NoXPForDeath(object oTarget)
{
int iHP = GetCurrentHitPoints(oTarget);
if(iHP <= 0)
{
    effect eRezz = EffectResurrection();
    effect eDeath = EffectDeath();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eRezz, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget);
}
}
