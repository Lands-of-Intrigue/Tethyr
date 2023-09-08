
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
#include "nw_i0_spells"
#include "te_afflic_func"
#include "nwnx_creature"

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

        if(GetHasFeat(1304,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1304);}
        if(GetHasFeat(1305,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1305);}
        if(GetHasFeat(1306,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1306);}
        if(GetHasFeat(1307,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1307);}
        if(GetHasFeat(1308,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1308);}
        if(GetHasFeat(1309,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1309);}
        if(GetHasFeat(1310,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1310);}
        if(GetHasFeat(1311,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1311);}
        if(GetHasFeat(1312,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1312);}
        if(GetHasFeat(1313,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1313);}
        if(GetHasFeat(1314,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1314);}
        if(GetHasFeat(1315,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1315);}
        if(GetHasFeat(1316,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1316);}
        if(GetHasFeat(1317,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1317);}
        if(GetHasFeat(1318,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1318);}
        if(GetHasFeat(1319,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1319);}
        if(GetHasFeat(1320,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1320);}
        if(GetHasFeat(1321,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1321);}
        if(GetHasFeat(1322,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1322);}
        if(GetHasFeat(1323,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1323);}
        if(GetHasFeat(1324,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1324);}
        if(GetHasFeat(1325,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1325);}
        if(GetHasFeat(1326,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1326);}
        if(GetHasFeat(1327,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1327);}
        if(GetHasFeat(1328,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1328);}
        if(GetHasFeat(1329,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1329);}
        if(GetHasFeat(1330,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1330);}
        if(GetHasFeat(1331,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1331);}
        if(GetHasFeat(1332,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1332);}
        if(GetHasFeat(1333,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1333);}
        if(GetHasFeat(1334,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1334);}
        if(GetHasFeat(1335,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1335);}
        if(GetHasFeat(1336,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1336);}
        if(GetHasFeat(1337,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1337);}
        if(GetHasFeat(1338,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1338);}
        if(GetHasFeat(1339,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1339);}
        if(GetHasFeat(1340,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1340);}
        if(GetHasFeat(1341,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1341);}
        if(GetHasFeat(1342,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1342);}
        if(GetHasFeat(1343,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1343);}
        if(GetHasFeat(1344,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1344);}
        if(GetHasFeat(1345,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1345);}
        if(GetHasFeat(1346,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1346);}
        if(GetHasFeat(1347,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1347);}
        if(GetHasFeat(1348,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1348);}
        if(GetHasFeat(1349,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1349);}
        if(GetHasFeat(1350,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1350);}
        if(GetHasFeat(1351,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1351);}
        if(GetHasFeat(1352,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1352);}
        if(GetHasFeat(1353,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1353);}
        if(GetHasFeat(1354,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1354);}
        if(GetHasFeat(1355,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1355);}
        if(GetHasFeat(1356,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1356);}
        if(GetHasFeat(1357,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1357);}
        if(GetHasFeat(1358,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1358);}
        if(GetHasFeat(1359,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1359);}
        if(GetHasFeat(1360,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1360);}
        if(GetHasFeat(1361,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1361);}
        if(GetHasFeat(1362,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1362);}
        if(GetHasFeat(1363,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1363);}
        if(GetHasFeat(1364,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1364);}
        if(GetHasFeat(1365,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1365);}
        if(GetHasFeat(1366,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1366);}
        if(GetHasFeat(1367,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1367);}
        if(GetHasFeat(1368,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1368);}
        if(GetHasFeat(1369,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1369);}
        if(GetHasFeat(1370,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1370);}
        if(GetHasFeat(1371,oTarget) == TRUE) {NWNX_Creature_RemoveFeat(oTarget,1371);}

        NWNX_Creature_AddFeat(oTarget,1329);
    }
}
