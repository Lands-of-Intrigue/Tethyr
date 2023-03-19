//::///////////////////////////////////////////////
//:: Name
//:: FileName
//:: Copyright (c) 2005 The Ravenloft PW Project
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Soeren Peter Moeller/Zarathustra217
//:: Created On:
//:://////////////////////////////////////////////

#include "so_inc_constants"
#include "so_inc_cache"


const string CHARACTER_SKIN="CharacterSkin";

//Returns an integer value with the number of hours since year 0, month 0, day 0, hour 0.
//Usefull when used as comparison with previously created numbers to find out hours passed.
//Especially since we will have persistant time between resets and crashes.
int TimeStamp();


//Returns the levels of all classes of the creature oCreature added together as an integer. -GetHitDice should do the same.
//int GetLevels(object oCreature);

//Returns the skin item worn on oCreature
object GetSkin(object oCreature);

//Returns the player ID of oPC
int GetID(object oPC);

int fac(int nInt)
{
    int nTemp=nInt-1;
    while(nTemp>0)
    {
        nInt+=nTemp;
        nTemp--;
    }
    return nInt;
}

int TimeStamp()
{
    int nYear=GetCalendarYear();
    int nMonth=GetCalendarMonth();
    int nDay=GetCalendarDay();
    int nHour=GetTimeHour();
    int nTimeStamp=(((nYear*12)+nMonth-1)*30+nDay-1)*24+nHour;
    return nTimeStamp;
}

/*int GetLevels(object oCreature)
{
    int nLevels=GetLevelByPosition(1,oCreature)+GetLevelByPosition(2,oCreature)+GetLevelByPosition(3,oCreature);
    return nLevels;
}*/

int ImprovedRandom(int nInterval)
{
    if(nInterval<1)
    {
        return 0;
    }
    int nRandom=Random(nInterval+1);
    if(nRandom==0)
    {
        return ImprovedRandom(nInterval);
    }
    else
    {
        return nRandom-1;
    }
}

int GetID(object oPC)
{
    return StringToInt(GetDeity(oPC));
}

object GetSkin(object oCreature)
{
    object oSkin=OBJECT_INVALID;
    if(GetIsPC(oCreature)&&!GetIsDM(oCreature)&&!GetIsDMPossessed(oCreature)&&GetID(oCreature))
    {
        oSkin=GetLocalObject(oCreature,CHARACTER_SKIN);
        if(GetIsPossessedFamiliar(oCreature))
        {
            return oSkin;
        }

        //Check if there's a skin present.
        if(GetTag(oSkin)!=DATABASE_PC_SKIN_TAG)
        {
            oSkin=GetItemInSlot(INVENTORY_SLOT_CARMOUR,oCreature);
            if(GetTag(oSkin)!=DATABASE_PC_SKIN_TAG)
            {
                oSkin=GetItemPossessedBy(oCreature,DATABASE_PC_SKIN_TAG);
                if(!GetIsObjectValid(oSkin))
                {
                    SendMessageToPC(oCreature,"Your character seems corrupt. Please contact us in the DM channel or on the forums if you need help.");
                    SendMessageToAllDMs("!!!Corrupted character detected: "+GetName(oCreature)+" ("+GetPCPublicCDKey(oCreature)+")!!!");
                    WriteTimestampedLogEntry("<!>"+"!!!Corrupted character detected: "+GetObjectInfoString(oCreature)+"!!!");
                    SetCommandable(FALSE,oCreature);
                    return OBJECT_INVALID;
                }
            }
            SetLocalObject(oCreature,CHARACTER_SKIN,oSkin);
        }

        //Check that the skin is possessed by the creature.
        if(GetItemPossessor(oSkin)!=oCreature)
        {
            object oNewSkin=CopyItem(oSkin, oCreature, TRUE);
            DestroyObject(oSkin);
            oSkin=oNewSkin;
            SetLocalObject(oCreature,CHARACTER_SKIN,oSkin);
        }


        //Check if the skin has proper settings.
        if(GetLocalInt(oSkin,DATABASE_PC_ID)!=GetID(oCreature))
        {
            //Transition until all have their IDs set?:
            if(GetLocalInt(oSkin,DATABASE_PC_ID)!=GetID(oCreature))
            {
                SetLocalInt(oSkin,DATABASE_PC_ID,GetID(oCreature));
            }
        }

        //If no other skin is equipped, equip skin.
        if(!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oCreature)))
        {
            AssignCommand(oCreature,ClearAllActions());
            AssignCommand(oCreature,ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR));
        }


    }
    else
    {
        oSkin=GetItemInSlot(INVENTORY_SLOT_CARMOUR,oCreature);
    }
    return oSkin;
}


int TestIsPC(object oPC)
{
    if(StringToInt(GetDeity(oPC))>0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

int GetIsLocationValid(location lLoc)
{
    if(GetAreaFromLocation(lLoc)!=OBJECT_INVALID)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

string ReplaceSubString(string sMainString, string sSubOld, string sSubNew)
{
    int nLength=GetStringLength(sMainString);
    int nSubLength=GetStringLength(sSubOld);
    int nLocation=FindSubString(sMainString,sSubOld);
    if(nLocation>0)
    {
        string sMainLeft=GetStringLeft(sMainString,nLocation-1);
        string sMainRight=GetStringRight(sMainString,nLength-(nSubLength+nLocation));
        sMainRight=ReplaceSubString(sMainRight, sSubOld, sSubNew);
        return sMainLeft+sSubNew+sMainRight;
    }
    return sMainString;
}

object SecureObject(object oObject)
{
    if(GetIsObjectValid(oObject))
    {
        return oObject;
    }
    else
    {
        return OBJECT_INVALID;
    }
}

string IntToRightAlignedString(int nInteger, int nSpace)
{
    string sInt=IntToString(nInteger);
    int nSize=GetStringLength(sInt);
    while(nSize<nSpace)
    {
        sInt=" "+sInt;
        nSize++;
    }
    return sInt;
}

string RightAlignString(string sString, int nSpace)
{
    int nSize=GetStringLength(sString);
    while(nSize<nSpace)
    {
        sString=" "+sString;
        nSize++;
    }
    return sString;
}

location GetLocationInFrontOf(object oTarget)
{
    object oArea=GetArea(oTarget);
    float fOrientation=GetFacing(oTarget);//+180.0;
    vector vTarget=GetPosition(oTarget);
    vTarget.x=vTarget.x+cos(fOrientation)*1.0;
    vTarget.y=vTarget.y+sin(fOrientation)*1.0;
    return Location(oArea,vTarget,fOrientation);
}

location GetLocationBehind(object oTarget)
{
    object oArea=GetArea(oTarget);
    float fOrientation=GetFacing(oTarget);//+180.0;
    vector vTarget=GetPosition(oTarget);
    vTarget.x=vTarget.x+cos(fOrientation)*-1.0;
    vTarget.y=vTarget.y+sin(fOrientation)*-1.0;
    return Location(oArea,vTarget,fOrientation);
}



void CheckForParty(object oPC)
{
    object oLeader=GetFactionLeader(oPC);
    if(oLeader!=oPC&&!GetIsDM(oPC))
    {
        SendMessageToPC(oPC,"Forming parties is not allowed! Please disband your party at once!");
        SendMessageToPC(oLeader,"Forming parties is not allowed! Please disband your party at once!");
        SendMessageToAllDMs(GetName(oPC)+" and "+GetName(oLeader)+" detected as using the party function...");
        WriteTimestampedLogEntry("<!>"+GetObjectInfoString(oPC)+" and "+GetObjectInfoString(oLeader)+" detected as using the party function...");
    }
}

void HeartBeat(object oHeartBeater)
{
    if(GetLocalInt(GetArea(oHeartBeater),"Activated"))
    {
        string sScript=GetLocalString(oHeartBeater,"Script");
        int nMinInterval=GetLocalInt(oHeartBeater,"BeatIntervalMin");
        int nMaxInterval=GetLocalInt(oHeartBeater,"BeatIntervalMax");
        int nInterval=nMinInterval+Random(1+nMaxInterval-nMinInterval);
        if(nInterval>0)
        {
            ExecuteScript(sScript,oHeartBeater);
            DelayCommand(IntToFloat(nInterval),HeartBeat(oHeartBeater));
        }
    }
}

int GetUniqueKey()
{
    object oModule=GetModule();
    int nCount=GetLocalInt(oModule,WORLD_COUNTER);
    SetLocalInt(oModule,WORLD_COUNTER,nCount+1);
    return nCount;
}

int RL_GetIsUndead(object oTarget)
{
    if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD&&!GetLocalInt(GetSkin(oTarget),DATABASE_PC_UNDEAD)&&GetLevelByClass(CLASS_TYPE_UNDEAD,oTarget)==0)
    {
        return FALSE;
    }
    return TRUE;
}

int GetIsSpring()
{
    int nMonth=GetCalendarMonth();
    if(nMonth>2&&nMonth<6)
    {
        return TRUE;
    }
    return FALSE;
}

int GetIsSummer()
{
    int nMonth=GetCalendarMonth();
    if(nMonth>5&&nMonth<9)
    {
        return TRUE;
    }
    return FALSE;
}

int GetIsFall()
{
    int nMonth=GetCalendarMonth();
    if(nMonth>8&&nMonth<12)
    {
        return TRUE;
    }
    return FALSE;
}

int GetIsWinther()
{
    int nMonth=GetCalendarMonth();
    if(nMonth>11||nMonth<3)
    {
        return TRUE;
    }
    return FALSE;
}

int GetSeason()
{
    int nMonth=GetCalendarMonth();
    switch(nMonth)
    {
        case 12:
            return SEASON_WINTER;
        break;
        case 11:
            return SEASON_FALL;
        break;
        case 10:
            return SEASON_FALL;
        break;
        case 9:
            return SEASON_FALL;
        break;
        case 8:
            return SEASON_SUMMER;
        break;
        case 7:
            return SEASON_SUMMER;
        break;
        case 6:
            return SEASON_SUMMER;
        break;
        case 5:
            return SEASON_SPRING;
        break;
        case 4:
            return SEASON_SPRING;
        break;
        case 3:
            return SEASON_SPRING;
        break;
        case 2:
            return SEASON_WINTER;
        break;
        case 1:
            return SEASON_WINTER;
        break;
        default:
            return 0;
        break;
    }
    return 0;
}

void CreateAndGiveItem(string sItemTemplate, object oTarget)
{
    object oItem=CreateItemOnObject(sItemTemplate, oTarget);
}

void ActionCreateAndGiveItem(string sItemTemplate, object oTarget)
{
    ActionDoCommand(CreateAndGiveItem(sItemTemplate, oTarget));
}

int GetSubraceID(object oPC)
{
    object oSkin=GetSkin(oPC);
    return GetLocalInt(oSkin,DATABASE_PC_SUBRACE);
}

string GetSubraceFromID(int nID)
{
    string sReturn="";
    switch(nID)
    {
        case 1:
            sReturn="Sun Elf";
            break;
        case 2:
            sReturn="Wild Elf";
            break;
        case 3:
            sReturn="Wood Elf";
            break;
        case 4:
            sReturn="Drow";
            break;
        case 5:
            sReturn="Gold Dwarf";
            break;
        case 6:
            sReturn="Duergar";
            break;
        case 7:
            sReturn="Aasimar";
            break;
        case 8:
            sReturn="Tiefling";
            break;
        case 9:
            sReturn="Caliban";
            break;
        case 10:
            sReturn="Canjar Half Vistani";
            break;
        case 11:
            sReturn="Corvara Half Vistani";
            break;
        case 12:
            sReturn="Equaar Half Vistani";
            break;
        case 13:
            sReturn="Kamii Half Vistani";
            break;
        case 14:
            sReturn="Naiat Half Vistani";
            break;
        case 15:
            sReturn="Vatraska Half Vistani";
            break;
        case 16:
            sReturn="Zarovan Half Vistani";
            break;
        case 17:
            sReturn="Half-Drow";
            break;
        case 18:
            sReturn="Sidhelien";
            break;
        case 19:
            sReturn="Kagonesti";
            break;
        case 20:
            sReturn="Qualinesti";
            break;
        case 21:
            sReturn="Silvanesti";
            break;
        case 22:
            sReturn="Aerenal Elf";
            break;
        case 23:
            sReturn="Valenar Elf";
            break;
        case 24:
            sReturn="Grey Elf";
            break;
        case 25:
            sReturn="Grugash";
            break;
        case 26:
            sReturn="Sylvan Elf";
            break;
        case 27:
            sReturn="Belcadiz Elf";
            break;
        case 28:
            sReturn="Shadow Elf";
            break;
        case 29:
            sReturn="Shiye Elf";
            break;
        case 30:
            sReturn="Auieran Human";
            break;
        case 31:
            sReturn="Brecht Human";
            break;
        case 32:
            sReturn="Khinasi Human";
            break;
        case 33:
            sReturn="Rjurik Human";
            break;
        case 34:
            sReturn="Vos Human";
            break;
        case 35:
            sReturn="Kalashtar";
            break;
        case 36:
            sReturn="Half-Sidhelien";
            break;
        case 37:
            sReturn="Athasian Half-Elf";
            break;
        case 38:
            sReturn="Cerilian Halfling";
            break;
        case 39:
            sReturn="Athasian Halfling";
            break;
        case 40:
            sReturn="Kender";
            break;
        case 41:
            sReturn="Talenta Halfling";
            break;
        case 42:
            sReturn="Tallfellow Halfling";
            break;
        case 43:
            sReturn="Deep Halfling";
            break;
        case 44:
            sReturn="Tinker Gnome";
            break;
        case 45:
            sReturn="Mad Gnome";
            break;
        case 46:
            sReturn="Deep Gnome";
            break;
        case 47:
            sReturn="Forest Gnome";
            break;
        case 48:
            sReturn="Karamhul";
            break;
        case 49:
            sReturn="Mul";
            break;
        case 50:
            sReturn="Dark Dwarf";
            break;
        case 51:
            sReturn="Derro";
            break;
        case 52:
            sReturn="Moulder Dwarf";
            break;
        case 53:
            sReturn="Kogolor Dwarf";
            break;
        case 54:
            sReturn="Deep Dwarf";
            break;
        case 55:
            sReturn="Arctic Dwarf";
            break;
        case 56:
            sReturn="Wild Dwarf";
            break;
        case 57:
            sReturn="Zenythri";
            break;
        case 58:
            sReturn="Tuladhara";
            break;
        case 59:
            sReturn="Tanarukk";
            break;
        case 60:
            sReturn="Fey'ri";
            break;
        case 61:
            sReturn="Aperusa";
            break;
        case 62:
            sReturn="Korobokuru";
            break;
        case 63:
            sReturn="Star Elf";
            break;
        case 64:
            sReturn="Furchin";
            break;
        case 65:
            sReturn="Desert Dwarf";
            break;
        case 66:
            sReturn="Maztican Halfling";
            break;
        case 67:
            sReturn="Chaos Gnome";
            break;
        case 68:
            sReturn="Whisper Gnome";
            break;
        case 69:
            sReturn="Dream Dwarf";
            break;
        case 70:
            sReturn="Glacier Dwarf";
            break;
        case 71:
            sReturn="Rhul-Thaun";
            break;
        case 72:
            sReturn="Athasian Elf";
            break;
        case 73:
            sReturn="Scro";
            break;
        case 74:
            sReturn="Abber Nomad";
            break;
        case 75:
            sReturn="Xeph";
            break;
        case 76:
            sReturn="Lerara";
            break;
    }
    return sReturn;
}

void SetSubraceByID(object oPC, int nID)
{
    object oSkin=GetSkin(oPC);
    SetLocalInt(oSkin,DATABASE_PC_SUBRACE,nID);
    SetSubRace(oPC,GetSubraceFromID(nID));
}

int GetOriginID(object oPC)
{
    object oSkin=GetSkin(oPC);
    return GetLocalInt(oSkin,DATABASE_PC_ORIGIN);
}

void SetOriginByID(object oPC, int nID)
{
    object oSkin=GetSkin(oPC);
    SetLocalInt(oSkin,DATABASE_PC_ORIGIN,nID);
}

string GetOriginByID(int nID)
{
    string sReturn="";
    switch(nID)
    {
        case DATABASE_PC_ORIGIN_BAROVIAN:
            sReturn="Barovian";
            break;
        case DATABASE_PC_ORIGIN_GUNDARAKITE:
            sReturn="Gundarakite";
            break;
        case DATABASE_PC_ORIGIN_RAVENLOFT_NATIVE:
            sReturn="Ravenloft Native";
            break;
        case DATABASE_PC_ORIGIN_CERILIAN:
            sReturn="Cerilian";
            break;
        case DATABASE_PC_ORIGIN_ATHASIAN:
            sReturn="Athasian";
            break;
        case DATABASE_PC_ORIGIN_EBERRONIAN:
            sReturn="Eberronian";
            break;
        case DATABASE_PC_ORIGIN_TORILIAN:
            sReturn="Torilian";
            break;
        case DATABASE_PC_ORIGIN_MYSTARAN:
            sReturn="Mystaran";
            break;
        case DATABASE_PC_ORIGIN_OERTHIAN:
            sReturn="Oerthian";
            break;
        case DATABASE_PC_ORIGIN_PLANAR:
            sReturn="Planar";
            break;
        case DATABASE_PC_ORIGIN_SPACEBORNE:
            sReturn="Spaceborne";
            break;
        case DATABASE_PC_ORIGIN_GOTHICEARTH:
            sReturn="Gothic Earth Native";
            break;
        case DATABASE_PC_ORIGIN_KRYNNIAN:
            sReturn="Krynnian";
            break;
    }
    return sReturn;
}



int GetTurnResistance(object oCreature)
{
    if(GetIsPC(oCreature))
    {
        return GetLocalInt(GetSkin(oCreature),DATABASE_PC_TURN_RESISTANCE);
    }
    else
    {
        return GetTurnResistanceHD(oCreature);
    }
}

void SetTurnResistance(object oCreature, int nValue)
{
    SetLocalInt(GetSkin(oCreature),DATABASE_PC_TURN_RESISTANCE, nValue);
}

void AddJournalEntries(object oPC)
{
    AddJournalQuestEntry("OOC_RULES_1",1,oPC,FALSE,FALSE,FALSE);
    AddJournalQuestEntry("OOC_RULES_2",1,oPC,FALSE,FALSE,FALSE);
    AddJournalQuestEntry("OOC_RULES_3",1,oPC,FALSE,FALSE,FALSE);
    AddJournalQuestEntry("OOC_RULES_4",1,oPC,FALSE,FALSE,FALSE);
    AddJournalQuestEntry("OOC_RULES_5",1,oPC,FALSE,FALSE,FALSE);
    AddJournalQuestEntry("OOC_RULES_5B",1,oPC,FALSE,FALSE,FALSE);
    AddJournalQuestEntry("OOC_RULES_5C",1,oPC,FALSE,FALSE,FALSE);
    AddJournalQuestEntry("OOC_RULES_6",1,oPC,FALSE,FALSE,FALSE);
    AddJournalQuestEntry("OOC_RULES_6B",1,oPC,FALSE,FALSE,FALSE);
    AddJournalQuestEntry("OOC_RULES_7",1,oPC,FALSE,FALSE,FALSE);
    AddJournalQuestEntry("OOC_RULES_7B",1,oPC,FALSE,FALSE,FALSE);
    AddJournalQuestEntry("OOC_RULES_8",1,oPC,FALSE,FALSE,FALSE);
    AddJournalQuestEntry("Emotes",1,oPC,FALSE,FALSE,FALSE);
}

string GetRacialTypeName(object oTarget)
{
    string sRace=GetSubRace(oTarget);
    if(sRace=="")
    {
        switch(GetRacialType(oTarget))
        {
            case RACIAL_TYPE_DWARF:
            sRace="Dwarf";
            break;
            case RACIAL_TYPE_ELF:
            sRace="Elf";
            break;
            case RACIAL_TYPE_GNOME:
            sRace="Gnome";
            break;
            case RACIAL_TYPE_HALFELF:
            sRace="Half-Elf";
            break;
            case RACIAL_TYPE_HALFLING:
            sRace="Halfling";
            break;
            case RACIAL_TYPE_HALFORC:
            sRace="Half-Orc";
            break;
            case RACIAL_TYPE_HUMAN:
            sRace="Human";
            break;
            default:
            sRace="Other";
            break;
        }
    }
    return sRace;
}

//Partly from www.NWNLexicon.com
int GetIdentifiedGoldPieceValue(object oItem)
{
    // Initial flag
    int bIdentified=GetIdentified(oItem);
    int bPlot=GetPlotFlag(oItem);
    // If not already, set to identfied
    if (!bIdentified) SetIdentified(oItem, TRUE);
    if (bPlot) SetPlotFlag(oItem,FALSE);
    // Get the GP value
    int nGP=GetGoldPieceValue(oItem);

    // Re-set the identification flag to its original
    SetIdentified(oItem, bIdentified);
    SetPlotFlag(oItem,bPlot);

    // Return the correct value
    return nGP;
}

void ApplyPersistentVisualEffects(object oPC)
{
    object oSkin=GetSkin(oPC);
    int nVFX=GetLocalInt(oSkin,DATABASE_PC_PERSISTENT_VFX);
    if(nVFX>0)
    {
        effect eVFX=SupernaturalEffect(EffectVisualEffect(nVFX));
        AssignCommand(GetModule(), ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, oPC));
    }

    int nVFX2=GetLocalInt(oSkin,DATABASE_PC_PERSISTENT_VFX2);
    if(nVFX2>0)
    {
        effect eVFX2=SupernaturalEffect(EffectVisualEffect(nVFX2));
        AssignCommand(GetModule(), ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX2, oPC));
    }

    int nVFX3=GetLocalInt(oSkin,DATABASE_PC_PERSISTENT_VFX3);
    if(nVFX3>0)
    {
        effect eVFX3=SupernaturalEffect(EffectVisualEffect(nVFX3));
        AssignCommand(GetModule(), ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX3, oPC));
    }

}


