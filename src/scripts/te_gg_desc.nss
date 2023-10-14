#include "loi_xp"

void main()
{
    object oPlace = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    string sGrove = GetLocalString(oPlace,"Grove");
    int nGroveState = GetLocalInt(GetModule(),sGrove);
    int nMod = 0;
    int nTimeStamp = (GetCalendarYear()*1000000)+(GetCalendarMonth()*10000)+(GetCalendarDay()*100)+GetTimeHour();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    int nPiety = GetLocalInt(oItem,"nPiety");

    if(GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC) >= 1 || GetLevelByClass(50,oPC) >= 1)
    {
        SetLocalInt(oItem,"nPiety",nPiety+10);
    }
    else
    {
        SetLocalInt(oItem,"nPiety",nPiety-10);
    }

    if(GetLocalInt(oItem,"nPiety") >= 100)
    {
        SetLocalInt(oItem,"nPiety",100);
    }
    else if(GetLocalInt(oItem,"nPiety") <= 0)
    {
        SetLocalInt(oItem,"nPiety",0);
    }

    nMod += GetLevelByClass(CLASS_TYPE_DRUID,oPC);
    nMod += (GetLevelByClass(CLASS_TYPE_RANGER,oPC)/2);
    nMod += (GetLevelByClass(CLASS_TYPE_CLERIC,oPC)/2);
    nMod += (GetLevelByClass(CLASS_TYPE_SORCERER,oPC)/2);
    nMod += (GetLevelByClass(CLASS_TYPE_WIZARD,oPC)/2);
    nMod += (GetLevelByClass(CLASS_TYPE_PALADIN,oPC)/2);
    nMod += GetLevelByClass(CLASS_TYPE_BARD,oPC);
    nMod += GetLevelByClass(47,oPC);
    nMod += GetLevelByClass(CLASS_TYPE_BLACKGUARD,oPC);

    AwardXP(oPC, 50);

    if(GetAlignmentGoodEvil(oPC) != ALIGNMENT_NEUTRAL)
    {
        nMod = (nMod + 2);
    }

    if(GetAlignmentLawChaos(oPC) != ALIGNMENT_NEUTRAL)
    {
        nMod = (nMod + 2);
    }

    if(GetHasFeat(1186,oPC))
    {
        nMod = (nMod - 2);
    }

    if(GetHasFeat(1187,oPC))
    {
        nMod = (nMod + 2);
    }

    if(GetHasFeat(1392,oPC))
    {
        nMod = (nMod + 2);
    }

    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER,oPC))
    {
        nMod = (nMod - 2);
    }

    if(GetHasFeat(FEAT_PLANT_DOMAIN_POWER,oPC))
    {
        nMod = (nMod - 2);
    }

    if(GetTimeHour() == 18)
    {
        nMod = (nMod +5);
    }

    if(GetLocalInt(oPlace,"BadLayline") == 1)
    {
        nMod = nMod/5;
    }

    if(GetIsDM(oPC) == TRUE)
    {
        nMod = 5;
    }

    SetLocalInt(GetModule(),sGrove,nGroveState+nMod);

    if(GetLocalInt(GetModule(),sGrove)>100)
    {
        SetLocalInt(GetModule(),sGrove,100);
    }

    SetLocalInt(oPlace,"nLastMod",nTimeStamp+6);

    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_HARM),oPC);
}
