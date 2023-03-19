//::///////////////////////////////////////////////
//:: DM Tool 9 Instant Feat
//:: x3_dm_tool09
//:: Copyright (c) 2007 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is a blank feat script for use with the
    10 DM instant feats provided in NWN v1.69.

    Look up feats.2da, spells.2da and iprp_feats.2da

*/
//:://////////////////////////////////////////////
//:: Created By: Brian Chung
//:: Created On: 2007-12-05
//:://////////////////////////////////////////////

#include "spawn_functions"

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    object oWaypoint = GetFirstObjectInArea(oArea);
    string sOwner;
    string sSetOwner;
    string sTemplate;
    int    nGuardGroup;

    while (GetIsObjectValid(oWaypoint) == TRUE)
    {
        if(GetObjectType(oWaypoint) == OBJECT_TYPE_WAYPOINT)
        {
            if(GetLocalString(oWaypoint,"sOwner") != "")
            {
                sOwner      = GetLocalString(oWaypoint,"sOwner");
                sSetOwner   = GetCampaignString("Settlement",sOwner+"_sOwner");
                nGuardGroup = GetLocalInt(oWaypoint,"GuardGroup");

                if(sSetOwner == "") {sTemplate = "";}
                else if (sSetOwner == "sLock")
                {
                    switch (nGuardGroup)
                    {
                        case 1: sTemplate = "sg_lockpf"; break;
                        case 2: sTemplate = "sg_lockpa"; break;
                        case 3: sTemplate = "sg_lockga"; break;
                        case 4: sTemplate = "sg_lockkf"; break;
                        case 5: sTemplate = "sg_lockka"; break;
                        default: sTemplate = "sg_lockpf";
                    }
                }
                else if (sSetOwner == "sTejarn")
                {
                    switch (nGuardGroup)
                    {
                        case 1: sTemplate = "sg_tejpf"; break;
                        case 2: sTemplate = "sg_tejpa"; break;
                        case 3: sTemplate = "sg_tejga"; break;
                        case 4: sTemplate = "sg_tejkf"; break;
                        case 5: sTemplate = "sg_tejkf"; break;
                        default: sTemplate = "sg_tejka";
                    }
                }
                else if (sSetOwner == "sSwamp")
                {
                    switch (nGuardGroup)
                    {
                        case 1: sTemplate = "sg_swapf"; break;
                        case 2: sTemplate = "sg_swapa"; break;
                        case 3: sTemplate = "sg_swaga"; break;
                        case 4: sTemplate = "sg_swakf"; break;
                        case 5: sTemplate = "sg_swaka"; break;
                        default: sTemplate = "sg_swapf";
                    }
                }
                else if (sSetOwner == "sSpire")
                {
                    switch (nGuardGroup)
                    {
                        case 1: sTemplate = "sg_spipf"; break;
                        case 2: sTemplate = "sg_spipa"; break;
                        case 3: sTemplate = "sg_spiga"; break;
                        case 4: sTemplate = "sg_spikf"; break;
                        case 5: sTemplate = "sg_spika"; break;
                        default: sTemplate = "sg_spipf";
                    }
                }
                else if (sSetOwner == "sBrost")
                {
                    switch (nGuardGroup)
                    {
                        case 1: sTemplate = "sg_bropf"; break;
                        case 2: sTemplate = "sg_bropa"; break;
                        case 3: sTemplate = "sg_broga"; break;
                        case 4: sTemplate = "sg_brokf"; break;
                        case 5: sTemplate = "sg_broka"; break;
                        default: sTemplate = "sg_bropf";
                    }
                }

                SetLocalString(oWaypoint, "f_Template", sTemplate);

            }
        }
        oWaypoint = GetNextObjectInArea(oArea);
    }
    SendMessageToPC(OBJECT_SELF,"Loop complete.");
}
