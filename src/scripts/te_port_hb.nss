#include "nwnx_time"
//Checks an area for the number of creatures with a given tag in order to make a determination on whether to do another spawn cycle or to skip it.
int AreaCreatureCheck(string sTag, object oArea);

//Does the appropriate VFX for the current spawn cycle of the portal/artifact
void DoPlaceableEffectCycle(int nType, object oPlace,object oArea, int nCycle);

void main()
{
    object oPlace       = OBJECT_SELF;
    int nType           = GetLocalInt(oPlace,"Type");
    int nLevel          = GetLocalInt(oPlace,"Level");
    location lLocation  = GetLocation(oPlace);
    int nTimeNow        = NWNX_Time_GetTimeStamp();
    int nTimeNext       = GetLocalInt(oPlace,"nTimeNext");
    int nTimeBuildUp    = GetLocalInt(oPlace,"nTimeBuildUp");
    object oArea        = GetArea(oPlace);

    if(nTimeNow < nTimeNext)
    {
        return;
    }

    if(nTimeNow >= nTimeBuildUp)
    {
        nLevel += 1;
        if(nLevel >= 5){nLevel=5;}
        SetLocalInt(oPlace,"Level",nLevel);
        SetLocalInt(oPlace,"nTimeBuildUp",nTimeNow+360);
    }
    int nRandomModifier = Random(180);
    nTimeNow += nRandomModifier;

    /////////////////////////////////
    //nType:
    // 1 - Abyssal Portal
    // 2 - Infernal Portal
    // 3 - Skeletal Artifact
    // 4 - Zombie Corpse Pile
    // 5 - Shadow Orb
    //////////////////////////////////
    if(nType == 1)
    {
        if(nLevel == 1)
        {
            //Do nothing this spawn cycle.
            if(AreaCreatureCheck("te_npc_2260",oArea) >= 3)
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,1);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
            else
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,2);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2018",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2018",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2018",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan4",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan4",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan4",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan4",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan4",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2260",lLocation,TRUE);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
        }
        else if(nLevel == 2)
        {
            //Do nothing this spawn cycle.
            if(AreaCreatureCheck("te_plan10",oArea) >= 3)
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,1);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
            else
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,2);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan10",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan10",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2018",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2018",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2018",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2018",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan4",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan4",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan4",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2260",lLocation,TRUE);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
        }
        else if(nLevel == 3)
        {
            //Do nothing this spawn cycle.
            if(AreaCreatureCheck("te_plan16",oArea) >= 3)
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,1);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
            else
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,2);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan16",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan16",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan16",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan10",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan10",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan10",lLocation,TRUE);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
        }
        else if(nLevel == 4)
        {
            //Do nothing this spawn cycle.
            if(AreaCreatureCheck("te_npc_2065",oArea) >= 2)
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,1);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
            else
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,2);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2065",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2065",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan10",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan16",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan16",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan16",lLocation,TRUE);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
        }
        else if(nLevel == 5)
        {
            //Do nothing this spawn cycle.
            if(AreaCreatureCheck("TAGOFBEBLITH?",oArea) >= 2)
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,1);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
            else
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,2);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2065",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2065",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan16",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan16",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan16",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan16",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_udmons_14",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_udmons_14",lLocation,TRUE);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
        }
    }
    else if(nType == 2)
    {
        if(nLevel == 1)
        {
            //Do nothing this spawn cycle.
            if(AreaCreatureCheck("te_npc_2266",oArea) >= 3)
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,1);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
            else
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,2);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan3",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan3",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan3",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2266",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2266",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2266",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2268",lLocation,TRUE);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
        }
        else if(nLevel == 2)
        {
            //Do nothing this spawn cycle.
            if(AreaCreatureCheck("te_npc_2268",oArea) >= 3)
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,1);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
            else
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,2);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2266",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2266",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2266",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2266",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2268",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2268",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2268",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2048",lLocation,TRUE);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
        }
        else if(nLevel == 3)
        {
            //Do nothing this spawn cycle.
            if(AreaCreatureCheck("te_npc_2048",oArea) >= 3)
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,1);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
            else
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,2);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan9",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan9",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2268",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2268",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2268",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2048",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2048",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2048",lLocation,TRUE);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
        }
        else if(nLevel == 4)
        {
            //Do nothing this spawn cycle.
            if(AreaCreatureCheck("te_plan9",oArea) >= 2)
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,1);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
            else
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,2);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan9",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan9",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan9",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2048",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2048",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2048",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2048",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2064",lLocation,TRUE);

                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
        }
        else if(nLevel == 5)
        {
            //Do nothing this spawn cycle.
            if(AreaCreatureCheck("te_npc_2064",oArea) >= 3)
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,1);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
            else
            {
                DoPlaceableEffectCycle(1,oPlace,oArea,2);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2057",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2064",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_npc_2064",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan9",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan9",lLocation,TRUE);
                CreateObject(OBJECT_TYPE_CREATURE,"te_plan9",lLocation,TRUE);
                SetLocalInt(oPlace,"nTimeNext",nTimeNow+60);
                return;
            }
        }
    }

    else if(nType == 2){}
    else if(nType == 3){}
    else if(nType == 4){}
    else if(nType == 5){}
}

//Checks an area for the number of creatures with a given tag in order to make a determination on whether to do another spawn cycle or to skip it.
int AreaCreatureCheck(string sTag, object oArea)
{
    object oCreature = GetFirstObjectInArea(oArea);
    int nReturn = 0;
    while(GetIsObjectValid(oCreature) != FALSE)
    {
        if(GetTag(oCreature) == sTag){nReturn = nReturn+1;}
        oCreature = GetNextObjectInArea(oArea);
    }
    return nReturn;
}

//Does the appropriate VFX for the current spawn cycle of the portal/artifact
void DoPlaceableEffectCycle(int nType, object oPlace,object oArea, int nCycle)
{
    //nCycles:
    //0 - Nothing happens
    //1 - Portal/Object quakes but does nothing
    //2 - Portal/Object spawns additional creatures
    if(nCycle == 0){return;}
    else if(nCycle == 1)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SCREEN_SHAKE),GetLocation(oPlace));
        //Abyss
        if(nType == 1){}
        //Infernal
        else if(nType == 2){}
        else if(nType == 3){}
        else if(nType == 4){}
        else if(nType == 5){}
    }
    else if(nCycle == 2)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SCREEN_SHAKE),GetLocation(oPlace));
        //Abyss
        if(nType == 1)
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_IMPLOSION),GetLocation(oPlace));
        }
        //Infernal
        else if(nType == 2)
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_IMPLOSION),GetLocation(oPlace));
        }
        else if(nType == 3){}
        else if(nType == 4){}
        else if(nType == 5){}
    }
}
