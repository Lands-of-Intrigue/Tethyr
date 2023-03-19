#include "so_inc_feats"
#include "so_inc_flags"
#include "so_inc_database"
#include "so_inc_corrupt"
#include "so_inc_xpsystem"

const string OUTCAST_RATING_PERSONAL_MODIFIER="Outcast_Rating_Modifier";
const string OUTCAST_RATING_BASE="Outcast_Rating_Base";
const string OUTCAST_RATING_RECOGNISED_OUTFIT_HELMET="Outcast_Rating_Recognised_Helmet";
const string OUTCAST_RATING_RECOGNISED_OUTFIT_ARMOR="Outcast_Rating_Recognised_Armor";

const int OUTCAST_RATING_HOSTILE=16;


void AdjustPersonalOutcastRatingModifier(object oPC, int nAdjustment)
{
    object oSkin=GetSkin(oPC);
    int nCurrentModifier=GetLocalInt(oSkin,OUTCAST_RATING_PERSONAL_MODIFIER);
    SetLocalInt(oSkin,OUTCAST_RATING_PERSONAL_MODIFIER,nCurrentModifier+nAdjustment);
}

void SetPersonalOutcastRatingModifier(object oPC, int nRating)
{
    object oSkin=GetSkin(oPC);
    SetLocalInt(oSkin,OUTCAST_RATING_PERSONAL_MODIFIER,nRating);
}

int GetPersonalOutcastRatingModifier(object oTarget)
{
    object oSkin=GetSkin(oTarget);
    int nCharismaModifier=GetAbilityModifier(ABILITY_CHARISMA,oTarget);
    int nRating=GetLocalInt(oSkin,OUTCAST_RATING_PERSONAL_MODIFIER)-nCharismaModifier;
    int nRacialType=GetRacialType(oTarget);
    if(nRacialType>6)
    {
        if(nRacialType==RACIAL_TYPE_ANIMAL)
        {
            if(GetCreatureSize(oTarget)>CREATURE_SIZE_SMALL)
            {
                switch(GetFactionID(oTarget))
                {
                    case FACTION_COMMONERS:
                    case FACTION_DEFENDERS:
                    case FACTION_HERBIVORE:
                    case FACTION_LIVESTOCK:
                    case FACTION_MERCHANTS:
                    case FACTION_NON_HOSTILE_TO_ALL:
                    case FACTION_VALLAKI_GUARD:
                    case FACTION_VALLAKI_MILITIA:
                    break;
                    default:
                    {
                        nRating+=30;
                    }
                    break;
                }
            }
        }
        else
        {
            nRating+=30;
        }

    }
    /*effect eEffect=GetFirstEffect(oTarget);
    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectType(eEffect)==EFFECT_TYPE_POLYMORPH)
        {
            nRating+=30;
        }
        else if(GetEffectType(eEffect)==EFFECT_TYPE_VISUALEFFECT)
        {
            nRating+=3;
        }
        eEffect=GetNextEffect(oTarget);
    }*/
    return nRating;
}


void SetBaseOutcastRating(object oPC, int nRating)
{
    object oSkin=GetSkin(oPC);
    SetLocalInt(oSkin,OUTCAST_RATING_BASE,nRating);
}

int GetBaseOutcastRating(object oPC)
{
    object oSkin=GetSkin(oPC);
    return GetLocalInt(oSkin,OUTCAST_RATING_BASE);
}

int GetOutcastRating(object oPC)
{
    int nRating=GetBaseOutcastRating(oPC)+GetPersonalOutcastRatingModifier(oPC);
    if(nRating<1)
    {
        nRating=1;
    }
    return nRating;
}

void SetupBaseOutcastRating(object oPC)
{
    int nOutcastRating=0;
    int nRace=GetRacialType(oPC);
    object oSkin=GetSkin(oPC);
    switch(nRace)
    {
        case RACIAL_TYPE_DWARF:
            nOutcastRating=13;
            break;
        case RACIAL_TYPE_ELF:
            nOutcastRating=12;
            break;
        case RACIAL_TYPE_GNOME:
            nOutcastRating=10;
            break;
        case RACIAL_TYPE_HALFELF:
            nOutcastRating=9;
            break;
        case RACIAL_TYPE_HALFLING:
            nOutcastRating=9;
            break;
        case RACIAL_TYPE_HALFORC:
            nOutcastRating=20;
            break;
        case RACIAL_TYPE_HUMAN:
            nOutcastRating=8;
            break;
    }
    int nSubrace=GetSubraceID(oPC);
    switch(nSubrace)
    {
        case DATABASE_PC_SUBRACE_AASIMAR:
            nOutcastRating=12;
            break;
        case DATABASE_PC_SUBRACE_CALIBAN:
            nOutcastRating=20;
            break;
        case DATABASE_PC_SUBRACE_DROW:
            nOutcastRating=20;
            break;
        case DATABASE_PC_SUBRACE_DUERGAR:
            nOutcastRating=18;
            break;
        case DATABASE_PC_SUBRACE_TIEFLING:
            nOutcastRating=15;
            break;
        case DATABASE_PC_SUBRACE_HALF_DROW:
            nOutcastRating=17;
            break;
        case DATABASE_PC_SUBRACE_HALF_DWARF:
            nOutcastRating=17;
            break;
        case DATABASE_PC_SUBRACE_KARAMHUL:
            nOutcastRating=17;
            break;
        case DATABASE_PC_SUBRACE_KALASHTAR:
            nOutcastRating=9;
            break;
        case DATABASE_PC_SUBRACE_WHISPER_GNOME:
            nOutcastRating=11;
            break;
        case DATABASE_PC_SUBRACE_DREAM_DWARF:
            nOutcastRating=17;
            break;
        case DATABASE_PC_SUBRACE_ELF_FEYRI:
            nOutcastRating=22;
            break;
        case DATABASE_PC_SUBRACE_STAR_ELF:
            nOutcastRating=13;
            break;
        case DATABASE_PC_SUBRACE_DEEP_GNOME:
            nOutcastRating=18;
            break;
        case DATABASE_PC_SUBRACE_TANARUKK:
            nOutcastRating=20;
            break;
        case DATABASE_PC_SUBRACE_TULADHARA:
            nOutcastRating=16;
            break;
        case DATABASE_PC_SUBRACE_ZENYTHRI:
            nOutcastRating=9;
            break;
        case DATABASE_PC_SUBRACE_HALFORC_SCRO:
            nOutcastRating=20;
            break;
        case DATABASE_PC_SUBRACE_DERRO:
            nOutcastRating=15;
            break;
    }
    int nOrigin=GetOriginID(oPC);
    switch(nOrigin)
    {
        case DATABASE_PC_ORIGIN_BAROVIAN:
            nOutcastRating-=2;
            break;
    }
    int nMonstrousRace=GetLocalInt(oSkin,DATABASE_PC_MONSTROUS_RACE);
    if(nMonstrousRace==DATABASE_PC_MONSTROUS_RACE_WIGHT || nMonstrousRace==DATABASE_PC_MONSTROUS_RACE_GHOUL || nMonstrousRace==DATABASE_PC_MONSTROUS_RACE_MUMMY )
    {
        nOutcastRating+=20;
    }

    int nRDDLevel=GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC);
    switch(nRDDLevel)
    {
        case 1:
            nOutcastRating+=3;
            break;
        case 2:
            nOutcastRating+=3;
            break;
        case 3:
            nOutcastRating+=3;
            break;
        case 4:
            nOutcastRating+=5;
            break;
        case 5:
            nOutcastRating+=8;
            break;
        case 6:
            nOutcastRating+=10;
            break;
        case 7:
            nOutcastRating+=10;
            break;
        case 8:
            nOutcastRating+=13;
            break;
        case 9:
            nOutcastRating+=20;
            break;
        case 10:
            nOutcastRating+=25;
            break;
    }
    int nPMLevel=GetLevelByClass(CLASS_TYPE_PALE_MASTER,oPC);
    switch(nPMLevel)
    {
        case 1:
            nOutcastRating+=3;
            break;
        case 2:
            nOutcastRating+=3;
            break;
        case 3:
            nOutcastRating+=3;
            break;
        case 4:
            nOutcastRating+=3;
            break;
        case 5:
            nOutcastRating+=6;
            break;
        case 6:
            nOutcastRating+=11;
            break;
        case 7:
            nOutcastRating+=11;
            break;
        case 8:
            nOutcastRating+=11;
            break;
        case 9:
            nOutcastRating+=14;
            break;
        case 10:
            nOutcastRating+=17;
            break;
    }
    int nCorruptionStage=GetLocalInt(oSkin,DATABASE_PC_CORRUPTION_STAGE);
    if(GetLocalInt(oSkin, DATABASE_PC_CORRUPTION_GIFT_1) == CORRUPTION_GIFT_OF_THE_MANIPULATOR || GetLocalInt(oSkin, DATABASE_PC_CORRUPTION_GIFT_2) == CORRUPTION_GIFT_OF_THE_MANIPULATOR)
    {
        switch(nCorruptionStage)
        {
            case 1:
            nOutcastRating-=2;
            break;
            case 2:
            nOutcastRating-=4;
            break;
            case 3:
            nOutcastRating-=6;
            break;
            case 4:
            nOutcastRating-=8;
            break;
            case 5:
            nOutcastRating-=10;
            break;
        }
    }
    if(GetLocalInt(oSkin,DATABASE_PC_CORRUPTION_CURSE_1)==CORRUPTION_CURSE_OF_REPUGNANCE || GetLocalInt(oSkin,DATABASE_PC_CORRUPTION_CURSE_2)==CORRUPTION_CURSE_OF_REPUGNANCE)
    {
        switch(nCorruptionStage)
        {
            case 1:
            nOutcastRating+=2;
            break;
            case 2:
            nOutcastRating+=4;
            break;
            case 3:
            nOutcastRating+=6;
            break;
            case 4:
            nOutcastRating+=8;
            break;
            case 5:
            nOutcastRating+=10;
            break;
        }
    }
    if(nOutcastRating<1)
    {
        nOutcastRating=1;
    }
    SetBaseOutcastRating(oPC,nOutcastRating);
}

void StampRecognisedOutfit(object oPC)
{
    object oSkin=GetSkin(oPC);
    string sArmor;
    string sHelmet;
    object oArmor=GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
    if(!GetIsObjectValid(oArmor))
    {
        sArmor="Empty";
    }
    else
    {
        sArmor=GetName(oArmor);
    }
    SetLocalString(oSkin,OUTCAST_RATING_RECOGNISED_OUTFIT_ARMOR,sArmor);
    object oHelmet=GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
    if(!GetIsObjectValid(oHelmet))
    {
        sHelmet="Empty";
    }
    else
    {
        sHelmet=GetName(oHelmet);
    }
    SetLocalString(oSkin,OUTCAST_RATING_RECOGNISED_OUTFIT_HELMET,sHelmet);
}

int GetIsRecognised(object oPC, object oPerciever=OBJECT_SELF)
{
    object oSkin=GetSkin(oPC);
    float fDistance=GetDistanceBetween(oPerciever,oPC);
    int nDC=20+d20()+GetSkillRank(SKILL_SPOT,oPerciever)-FloatToInt(fDistance);
    object oArmor=GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
    object oHelmet=GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
    if(GetIsObjectValid(oArmor)&&GetName(oArmor)!=GetLocalString(oSkin,OUTCAST_RATING_RECOGNISED_OUTFIT_ARMOR))
    {
        nDC-=10;
    }
    if(GetIsObjectValid(oHelmet)&&GetName(oHelmet)!=GetLocalString(oSkin,OUTCAST_RATING_RECOGNISED_OUTFIT_ARMOR))
    {
        nDC-=10;
    }
    if(nDC<1)
    {
        nDC=1;
    }
    int nSucces=GetIsSkillSuccessful(oPC,SKILL_INFLUENCE,nDC);
    if(!nSucces)
    {
        StampRecognisedOutfit(oPC);
        return TRUE;
    }
    return FALSE;
}

