//::///////////////////////////////////////////////
//:: Name:      Bedlamson's Dynamic Merchant System
//::            Merchant NPC OnSpawned Event
//:: FileName:  bdm_merch_spawn
//:: Copyright (c) 2003 Stephen Spann
//::///////////////////////////////////////////////
//:: Created By: Bedlamson
//:: Created On: 1/23/2003
//::///////////////////////////////////////////////

// Bioware includes
#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"

// BDM include
#include "bdm_include"

void main()
{
// Bioware behaviors
SetListeningPatterns();
WalkWayPoints();
GenerateNPCTreasure();

// BDM function
BDM_SetNPCStores();
}
