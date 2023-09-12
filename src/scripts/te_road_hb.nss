#include "NWNX_Time"

void main()
{
    object oPlace = OBJECT_SELF;
    string sRoad = GetLocalString(oPlace,"sOwner");
    object oArea = GetArea(oPlace);
    int nResetTime = GetLocalInt(oPlace,"nResetTime");
    int nLocalTime = GetTimeHour()*100+GetTimeMinute();
    int nLastCleared = GetLocalInt(oPlace,"nLastCleared");
    int nGuardGroup;
    string sTemplate;
    if(nLastCleared != 0 && (nLocalTime - nLastCleared) >= nResetTime)
    {
        object oWaypoint = GetFirstObjectInShape(SHAPE_SPHERE,100.0f,GetLocation(oPlace),FALSE,OBJECT_TYPE_WAYPOINT);
        while (GetIsObjectValid(oWaypoint) == TRUE)
        {
            if(GetObjectType(oWaypoint) == OBJECT_TYPE_WAYPOINT)
            {
                if(GetLocalString(oWaypoint,"sOwner") == "sTrade1" ||
                   GetLocalString(oWaypoint,"sOwner") == "sTrade4" ||
                   GetLocalString(oWaypoint,"sOwner") == "sGate3"    )
                {
                    nGuardGroup = GetLocalInt(oWaypoint,"GuardGroup");
                    switch (nGuardGroup)
                    {
                        case 1: sTemplate = "sg_bandit"; break;
                        case 2: sTemplate = "sg_bandit"; break;
                        case 3: sTemplate = "sg_bandit"; break;
                        case 4: sTemplate = "sg_banditlead"; break;
                        case 5: sTemplate = "sg_banditlead"; break;
                        default: sTemplate = "sg_bandit";
                    }
                    SetLocalString(oWaypoint, "f_Template", sTemplate);
                }
                else if(GetLocalString(oWaypoint,"sOwner") == "sTrade2")
                {
                    nGuardGroup = GetLocalInt(oWaypoint,"GuardGroup");
                    switch (nGuardGroup)
                    {
                        case 1: sTemplate = "sg_deserter"; break;
                        case 2: sTemplate = "sg_deserter"; break;
                        case 3: sTemplate = "sg_deserter"; break;
                        case 4: sTemplate = "sg_deserter"; break;
                        case 5: sTemplate = "sg_deserter"; break;
                        default: sTemplate = "sg_deserter";
                    }
                    SetLocalString(oWaypoint, "f_Template", sTemplate);
                }
                else if(GetLocalString(oWaypoint,"sOwner") == "sTrade3" ||
                        GetLocalString(oWaypoint,"sOwner") == "sTrade5")
                {
                    nGuardGroup = GetLocalInt(oWaypoint,"GuardGroup");
                    switch (nGuardGroup)
                    {
                        case 1: sTemplate = "sg_babyoccult"; break;
                        case 2: sTemplate = "sg_babyoccult"; break;
                        case 3: sTemplate = "sg_babyoccult"; break;
                        case 4: sTemplate = "sg_occult"; break;
                        case 5: sTemplate = "sg_occult"; break;
                        default: sTemplate = "sg_babyoccult";
                    }
                    SetLocalString(oWaypoint, "f_Template", sTemplate);
                }
                else if(GetLocalString(oWaypoint,"sOwner") == "sMine1" ||
                        GetLocalString(oWaypoint,"sOwner") == "sMine2" ||
                        GetLocalString(oWaypoint,"sOwner") == "sMine3")
                {
                    SetLocalString(oWaypoint, "f_Template", "sg_ankheg");
                }
                else if(GetLocalString(oWaypoint,"sOwner") == "sGate1")
                {
                    nGuardGroup = GetLocalInt(oWaypoint,"GuardGroup");
                    switch (nGuardGroup)
                    {
                        case 1: sTemplate = "sg_ghoul"; break;
                        case 2: sTemplate = "sg_ghoul"; break;
                        case 3: sTemplate = "sg_ghoul"; break;
                        case 4: sTemplate = "sg_ghoul"; break;
                        case 5: sTemplate = "sg_ghoul"; break;
                        default: sTemplate = "sg_ghoul";
                    }
                    SetLocalString(oWaypoint, "f_Template", sTemplate);
                }
                else if(GetLocalString(oWaypoint,"sOwner") == "sGate2")
                {
                    nGuardGroup = GetLocalInt(oWaypoint,"GuardGroup");
                    switch (nGuardGroup)
                    {
                        case 1: sTemplate = "sg_goblow"; break;
                        case 2: sTemplate = "sg_goblow"; break;
                        case 3: sTemplate = "sg_goblow"; break;
                        case 4: sTemplate = "sg_gobgreat"; break;
                        case 5: sTemplate = "sg_gobgreat"; break;
                        default: sTemplate = "sg_goblow";
                    }
                    SetLocalString(oWaypoint, "f_Template", sTemplate);
                }
                else if(GetLocalString(oWaypoint,"sOwner") == "sGate4")
                {
                    nGuardGroup = GetLocalInt(oWaypoint,"GuardGroup");
                    switch (nGuardGroup)
                    {
                        case 1: sTemplate = "sg_zombieheavy"; break;
                        case 2: sTemplate = "sg_zombieheavy"; break;
                        case 3: sTemplate = "sg_zombieheavy"; break;
                        case 4: sTemplate = "sg_zombieheavy"; break;
                        case 5: sTemplate = "sg_zombieheavy"; break;
                        default: sTemplate = "sg_zombieheavy";
                    }
                    SetLocalString(oWaypoint, "f_Template", sTemplate);
                }
                else if(GetLocalString(oWaypoint,"sOwner") == "sFort1")
                {
                    nGuardGroup = GetLocalInt(oWaypoint,"GuardGroup");
                    switch (nGuardGroup)
                    {
                        case 1: sTemplate = "sg_hell"; break;
                        case 2: sTemplate = "sg_hell"; break;
                        case 3: sTemplate = "sg_hell"; break;
                        case 4: sTemplate = "sg_hellmed"; break;
                        case 5: sTemplate = "sg_hellmed"; break;
                        default: sTemplate = "sg_hellmed";
                    }
                    SetLocalString(oWaypoint, "f_Template", sTemplate);
                }
            }
            oWaypoint = GetNextObjectInShape(SHAPE_SPHERE,100.0f,GetLocation(oPlace),FALSE,OBJECT_TYPE_WAYPOINT);
        }
        DeleteLocalInt(oPlace,"nLastCleared");
    }
}
