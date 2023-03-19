#include "so_inc_general"
#include "so_inc_cache"

//#include "rl_inc_database"
//Reputation Factions

const int FACTION_COMMONERS=1;
const int FACTION_DEFENDERS=2;
const int FACTION_HOSTILES=3;
const int FACTION_MERCHANTS=4;
const int FACTION_NON_HOSTILE_TO_ALL=5;
const int FACTION_VISTANI=6;
const int FACTION_LIVESTOCK=7;
const int FACTION_HERBIVORE=8;
const int FACTION_OMNIVORE=9;
const int FACTION_PREDATORS=10;
const int FACTION_RATS=11;
const int FACTION_SNAKES=12;
const int FACTION_SPIDERS=13;
const int FACTION_UNDEAD=14;
const int FACTION_VALLAKI_GUARD=15;
const int FACTION_RED_VARDOS=16;
const int FACTION_OUTLANDERS=17;
const int FACTION_GUNDARAKITE_REBELS=18;
const int FACTION_BAAL_VERZI=19;
const int FACTION_DAWNSLAYERS=20;
const int FACTION_OUTLAWS=21;
const int FACTION_NERULL_CULT=22;
const int FACTION_KEEPERS_OF_THE_BLACK_FEATHER=23;
const int FACTION_VAMPIRES=24;
const int FACTION_WOLVES=25;
const int FACTION_WIGHTS=26;
const int FACTION_WEREWOLVES=27;
const int FACTION_WOLFWERES=28;
const int FACTION_WORSHIPPERS_OF_THE_MORNINGLORD=29;
const int FACTION_SEWER_DWELLERS=30;
const int FACTION_VALLAKI_MILITIA=31;

int GetChildFactionIDByFactionID(int nFactionID)
{
    object oFaction=GetLocalObject(GetCacheObjectFaction(),"Faction"+IntToString(nFactionID));
    return GetLocalInt(oFaction,"ChildFactionID");
}

object GetChildFactionByFactionID(int nFactionID)
{
    object oFaction=GetLocalObject(GetCacheObjectFaction(),"Faction"+IntToString(nFactionID));
    return GetLocalObject(oFaction,"ChildFaction");
}

object GetChildFactionByFaction(object oFaction)
{
    return GetLocalObject(oFaction,"ChildFaction");
}

int GetParentFactionIDByFactionID(int nFactionID)
{
    object oFaction=GetLocalObject(GetCacheObjectFaction(),"Faction"+IntToString(nFactionID));
    return GetLocalInt(oFaction,"ParentFactionID");
}

object GetParentFactionByFactionID(int nFactionID)
{
    object oFaction=GetLocalObject(GetCacheObjectFaction(),"Faction"+IntToString(nFactionID));
    return GetLocalObject(oFaction,"ParentFaction");
}

object GetParentFactionByFaction(object oFaction)
{
    return GetLocalObject(oFaction,"ParentFaction");
}




void SetReputation(object oSource, object oTarget, int nReputation)
{
    int nCurrentReputation=GetReputation(oSource, oTarget);
    //SendMessageToPC(oTarget,"Adjusting reputation towards "+GetName(oSource)+" by "+IntToString(nReputation-nCurrentReputation)+".");
    AdjustReputation(oTarget,oSource,nReputation-nCurrentReputation);
}


void SetFactionByID(object oPC, int nFaction)
{
    //object oSkin=GetSkin(oPC);
    object oModule=GetModule();
    object oCache=GetCacheObjectFaction();
    object oFaction=GetLocalObject(oCache,"Faction"+IntToString(nFaction));
    if(oFaction!=OBJECT_INVALID)
    {
        if(GetIsPC(oPC)&&!GetIsDM(oPC)&&!GetIsDMPossessed(oPC))
        {
            //SetLocalInt(oSkin,DATABASE_PC_FACTION,nFaction);
            SendMessageToPC(oPC,"You will now be treated as a member of the "+GetName(oFaction)+" faction.");
            int nTemp=1;
            int nReputation;
            object oSkin=GetSkin(oPC);
            object oTemp=GetLocalObject(oCache,"Faction1");
            while(oTemp!=OBJECT_INVALID)
            {
                if(GetLocalInt(oSkin,DATABASE_PC_FACTION_MARKED_AS_ENEMY+IntToString(nTemp))||GetLocalInt(oSkin,DATABASE_PC_FACTION_MARKED_AS_ENEMY+IntToString(GetChildFactionIDByFactionID(nTemp)))||GetLocalInt(oSkin,DATABASE_PC_FACTION_MARKED_AS_ENEMY+IntToString(GetParentFactionIDByFactionID(nTemp))))
                {
                    nReputation=0;
                }
                else if(GetLocalInt(oSkin,DATABASE_PC_FACTION_MARKED_AS_FRIEND+IntToString(nTemp))||GetLocalInt(oSkin,DATABASE_PC_FACTION_MARKED_AS_FRIEND+IntToString(GetChildFactionIDByFactionID(nTemp)))||GetLocalInt(oSkin,DATABASE_PC_FACTION_MARKED_AS_FRIEND+IntToString(GetParentFactionIDByFactionID(nTemp))))
                {
                    nReputation=100;
                }
                else if(oTemp==oFaction)
                {
                    nReputation=100;
                }
                else
                {
                    nReputation=GetReputation(oTemp,oFaction);
                }
                SetReputation(oTemp,oPC,nReputation);
                nTemp++;
                oTemp=GetLocalObject(oCache,"Faction"+IntToString(nTemp));
            }
            SetLocalInt(GetSkin(oPC),DATABASE_PC_SHOWN_FACTION,nFaction);
            object oOtherPC=GetFirstPC();
            int nOtherPCFaction;
            while(oOtherPC!=OBJECT_INVALID)
            {
                if(oOtherPC!=oPC&&!GetIsDM(oOtherPC))
                {
                    nOtherPCFaction=GetLocalInt(GetSkin(oOtherPC),DATABASE_PC_SHOWN_FACTION);
                    oTemp=GetLocalObject(oCache,"Faction"+IntToString(nOtherPCFaction));
                    if(oTemp!=OBJECT_INVALID)
                    {
                        if(GetLocalInt(oSkin,DATABASE_PC_FACTION_MARKED_AS_ENEMY+IntToString(nOtherPCFaction))||GetLocalInt(oSkin,DATABASE_PC_FACTION_MARKED_AS_ENEMY+IntToString(GetChildFactionIDByFactionID(nOtherPCFaction)))||GetLocalInt(oSkin,DATABASE_PC_FACTION_MARKED_AS_ENEMY+IntToString(GetParentFactionIDByFactionID(nOtherPCFaction))))
                        {
                            SetPCDislike(oPC,oOtherPC);
                        }
                        else if(GetLocalInt(oSkin,DATABASE_PC_FACTION_MARKED_AS_FRIEND+IntToString(nOtherPCFaction))||GetLocalInt(oSkin,DATABASE_PC_FACTION_MARKED_AS_FRIEND+IntToString(GetChildFactionIDByFactionID(nOtherPCFaction)))||GetLocalInt(oSkin,DATABASE_PC_FACTION_MARKED_AS_FRIEND+IntToString(GetParentFactionIDByFactionID(nOtherPCFaction))))
                        {
                            SetPCLike(oPC,oOtherPC);
                        }
                        else
                        {
                            if(GetReputation(oTemp,oFaction)<11)
                            {
                                SetPCDislike(oPC,oOtherPC);
                            }
                            else
                            {
                                SetPCLike(oPC,oOtherPC);
                            }
                        }
                    }
                }
                oOtherPC=GetNextPC();
            }


        }
        else
        {
            ChangeFaction(oPC,oFaction);
        }
    }
}

void SetPCFactionByID(object oPC, int nFaction)
{
    object oSkin=GetSkin(oPC);
    SetLocalInt(oSkin,DATABASE_PC_FACTION,nFaction);
}

void SetPCInnateFactionByID(object oPC, int nFaction)
{
    object oSkin=GetSkin(oPC);
    SetLocalInt(oSkin,DATABASE_PC_INNATE_FACTION,nFaction);
}

void RevealFaction(object oPC)
{
    object oSkin=GetSkin(oPC);
    int nFaction=GetLocalInt(oSkin,DATABASE_PC_FACTION);
    SetFactionByID(oPC,nFaction);
}

void HideFaction(object oPC)
{
    object oSkin=GetSkin(oPC);
    int nFaction=GetLocalInt(oSkin,DATABASE_PC_INNATE_FACTION);
    SetFactionByID(oPC,nFaction);
}

int GetPCShownFactionID(object oPC)
{
    return GetLocalInt(GetSkin(oPC),DATABASE_PC_SHOWN_FACTION);
}

int GetPCFactionID(object oPC)
{
    return GetLocalInt(GetSkin(oPC),DATABASE_PC_FACTION);
}

object GetPCFaction(object oPC)
{
    return GetLocalObject(GetCacheObjectFaction(), "Faction"+IntToString(GetPCFactionID(oPC)));
}


int GetPCInnateFactionID(object oPC)
{
    return GetLocalInt(GetSkin(oPC),DATABASE_PC_INNATE_FACTION);
}

int GetIsNPCInFaction(object oNPC, int nFaction)
{
    if(GetFactionEqual(oNPC,GetLocalObject(GetCacheObjectFaction(),"Faction"+IntToString(nFaction))))
    {
        return TRUE;
    }
    return FALSE;
}

object GetFactionByID(int nID)
{
    return GetLocalObject(GetCacheObjectFaction(),"Faction"+IntToString(nID));
}

location GetFactionBaseLocationByID(int nID)
{
    location lTarget;
    switch(nID)
    {
        case FACTION_RED_VARDOS:
            lTarget=GetLocation(GetCachedWaypointByTag("rl_red_vardos_start", GetCacheObjectPlayer()));
        break;
        case FACTION_VALLAKI_GUARD:
            lTarget=GetLocation(GetCachedWaypointByTag("rl_vallaki_guards_start", GetCacheObjectPlayer()));
        break;
        case FACTION_VALLAKI_MILITIA:
            lTarget=GetLocation(GetCachedWaypointByTag("val_militia_start", GetCacheObjectPlayer()));
        break;
        case FACTION_WORSHIPPERS_OF_THE_MORNINGLORD:
            lTarget=GetLocation(GetCachedWaypointByTag("START_MORNINGLORD", GetCacheObjectPlayer()));
        break;
        case FACTION_DAWNSLAYERS:
            lTarget=GetLocation(GetCachedWaypointByTag("START_MORNINGLORD", GetCacheObjectPlayer()));
        break;
        case FACTION_SEWER_DWELLERS:
            lTarget=GetLocation(GetCachedWaypointByTag("START_SEWER_DWELLERS", GetCacheObjectPlayer()));
        break;
        case FACTION_KEEPERS_OF_THE_BLACK_FEATHER:
            lTarget=GetLocation(GetCachedWaypointByTag("START_KEEPERS", GetCacheObjectPlayer()));
        break;
        case FACTION_GUNDARAKITE_REBELS:
            lTarget=GetLocation(GetCachedWaypointByTag("rebelspawnpoint", GetCacheObjectPlayer()));
        break;
        case FACTION_WIGHTS:
            lTarget=GetLocation(GetCachedWaypointByTag("START_UNDEAD", GetCacheObjectPlayer()));
        break;
        case FACTION_VAMPIRES:
            lTarget=GetLocation(GetCachedWaypointByTag("START_VAMPIRES", GetCacheObjectPlayer()));
        break;
        default:
            lTarget=GetLocation(GetCachedWaypointByTag("rl_playerstart", GetCacheObjectPlayer()));
        break;
    }
    return lTarget;
}

/*string GetFactionBaseLocationAreaName(int nID)
{
    string sResult;
    switch(nID)
    {
        case FACTION_RED_VARDOS:
            sResult="Below Tigan's Rest";
        break;
        case FACTION_VALLAKI_GUARDS:
            sResult="Vallki Guards Head Quarters";
        break;
        case
        default:
            sResult="Vistani Camp outside Vallaki";
        break;
    }
    return sResult;
}*/

string RankToString(int nFactionID, int nRank)
{
    string sResult;
    switch(nFactionID)
    {
        case FACTION_RED_VARDOS:
        {
            switch(nRank)
            {
                case 0:
                {
                    sResult="Initiate";
                }
                break;
                case 1:
                {
                    sResult="Member";
                }
                break;
                case 2:
                {
                    sResult="Member";
                }
                break;
                case 3:
                {
                    sResult="Quartermaster";
                }
                break;
                case 4:
                {
                    sResult="Adviser";
                }
                break;
                case 5:
                {
                    sResult="Captain";
                }
                break;
                }
        }
        break;
        case FACTION_VALLAKI_GUARD:
        {
            switch(nRank)
            {
                case 0:
                {
                    sResult="Recruit";
                }
                break;
                case 1:
                {
                    sResult="Private";
                }
                break;
                case 2:
                {
                    sResult="Lance Corporal";
                }
                break;
                case 3:
                {
                    sResult="Corporal";
                }
                break;
                case 4:
                {
                    sResult="Sargeant";
                }
                break;
                case 5:
                {
                    sResult="Lieutenant";
                }
                break;
                }
        }
        break;
        case FACTION_KEEPERS_OF_THE_BLACK_FEATHER:
        {
            switch(nRank)
            {
                case 4:
                {
                    sResult="Talon Chief";
                }
                break;
                case 5:
                {
                    sResult="Talon Chief";
                }
                break;
                default:
                {
                    sResult="Talon Member";
                }
                break;
                }
        }
        break;
        case FACTION_WORSHIPPERS_OF_THE_MORNINGLORD:
        {
            switch(nRank)
            {
                default:
                {
                    sResult="Light Carrier";
                }
                break;
                }
        }
        break;
        default:
        {
            sResult="Unranked";
        }
        break;
    }
    return sResult;
}

int GetFactionRank(object oTarget)
{
    if(GetIsPC(oTarget))
    {
        return GetLocalInt(GetSkin(oTarget),DATABASE_PC_FACTION_RANK);
    }
    else
    {
        return GetLocalInt(oTarget,FACTION_RANK);
    }
}

void SetFactionRank(object oTarget, int nRank)
{
    if(GetIsPC(oTarget))
    {
        SetLocalInt(GetSkin(oTarget),DATABASE_PC_FACTION_RANK,nRank);
    }
    else
    {
        SetLocalInt(oTarget,FACTION_RANK,nRank);
    }
}

void MakeFactionIDMember(object oTarget, int nFaction)
{
    if(GetIsPC(oTarget))
    {
        if(GetPCFactionID(oTarget)!=nFaction)
        {
            SetPCFactionByID(oTarget, nFaction);
            object oItem=GetItemPossessedBy(oTarget,"item_factiontool");
            if(oItem==OBJECT_INVALID)
            {
                CreateItemOnObject("item_factiontool",oTarget);
            }
            switch(nFaction)
            {
                case FACTION_RED_VARDOS:
                {
                    CreateItemOnObject("rl_vardokey",oTarget);
                    CreateItemOnObject("rl_vardosymbol",oTarget);
                }
                break;
                case FACTION_VALLAKI_GUARD:
                {
                    CreateItemOnObject("val_guardgarb",oTarget);
                }
                break;
                case FACTION_VALLAKI_MILITIA:
                {
                    CreateItemOnObject("val_militiagarb",oTarget);
                    CreateItemOnObject("val_militia_key",oTarget);
                }
                break;
                case FACTION_GUNDARAKITE_REBELS:
                {
                    if(GetGender(oTarget)==GENDER_MALE)
                    {
                    CreateItemOnObject("val_gundargarb",oTarget);
                    }
                    else
                    {
                     CreateItemOnObject("val_gundargarbf",oTarget);
                    }
                    CreateItemOnObject("gundarakitekey",oTarget);
                }
                break;
                case FACTION_WORSHIPPERS_OF_THE_MORNINGLORD:
                {
                    CreateItemOnObject("val_morninggarb",oTarget);
                    CreateItemOnObject("lightcarrierspea",oTarget);
                    CreateItemOnObject("val_mlholysmbol",oTarget);
                }
                break;
                case FACTION_SEWER_DWELLERS:
                {
                    SetFactionByID(oTarget, nFaction);
                    CreateItemOnObject("rl_sewerdwellerg",oTarget);
                    CreateItemOnObject("rl_drainkey",oTarget);
                    CreateItemOnObject("rl_sewdwelunifor",oTarget);
                }
                break;
                case FACTION_KEEPERS_OF_THE_BLACK_FEATHER:
                {
                    CreateItemOnObject("rl_keepfeather",oTarget);
                    CreateItemOnObject("mb_silverthreadbasekey",oTarget);
                }
                break;
                case FACTION_BAAL_VERZI:
                {
                    CreateItemOnObject("val_baalgarb",oTarget);
                    CreateItemOnObject("rl_baalverzidagg",oTarget);
                    CreateItemOnObject("bv_hqkey",oTarget);
                    }
                break;
                case FACTION_WIGHTS:
                {
                    CreateItemOnObject("rl_undeadamulet",oTarget);
                    CreateItemOnObject("rl_undeadhqkey1",oTarget);
                    CreateItemOnObject("rl_undeadhqkey2",oTarget);
                }
                break;
                case FACTION_DAWNSLAYERS:
                {
                    CreateItemOnObject("val_dsring",oTarget);
                    CreateItemOnObject("val_dshqkey",oTarget);
                }
                break;
                case FACTION_VAMPIRES:
                {
                    CreateItemOnObject("denofknaveske003",oTarget);
                }
                break;
            }
        }
    }
}


int GetIsSpecialFactionID(int nFaction)
{
    switch(nFaction)
    {
        case FACTION_RED_VARDOS:
        case FACTION_VALLAKI_GUARD:
        case FACTION_VALLAKI_MILITIA:
        case FACTION_GUNDARAKITE_REBELS:
        case FACTION_WORSHIPPERS_OF_THE_MORNINGLORD:
        case FACTION_SEWER_DWELLERS:
        case FACTION_KEEPERS_OF_THE_BLACK_FEATHER:
        case FACTION_BAAL_VERZI:
        case FACTION_WIGHTS:
        {
            return TRUE;
        }
        break;
    }
    return FALSE;
}

int GetFactionID(object oTarget)
{
    int nCount=1;
    object oFaction=GetFactionByID(nCount);
    while(GetIsObjectValid(oFaction))
    {
        if(GetFactionEqual(oTarget, oFaction))
        {
            return nCount;
        }
        nCount++;
        oFaction=GetFactionByID(nCount);
    }
    return -1;
}

