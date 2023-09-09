#include "ceb_featcheck"
//Updated 11/17/19 by DM Djinn
void main()
{
object oPC=GetLastUsedBy();
object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
int nBlood   = GetLocalInt(oItem,"nBlood");
int nSticky  = GetLocalInt(oItem,"nSticky");
int nDust    = GetLocalInt(oItem,"nDust");
int nPlan    = GetLocalInt(oItem,"nPlan");

string sType = GetLocalString(OBJECT_SELF, "type");
string sTool;
string sFeat;
string sMat;
int nDC;
int nMod;
int nRespawn;
int nSpawnhour;
int nDay;
int nRoll = d20(1) + (GetHitDice(oPC));
int nDate=GetLocalInt(OBJECT_SELF, "Date");
int nHour=GetLocalInt(OBJECT_SELF, "Hour");
int nRedate=GetLocalInt(OBJECT_SELF, "Redate");
int nRehour=GetLocalInt(OBJECT_SELF, "Rehour");
int nReminute=GetLocalInt(OBJECT_SELF, "Reminute");
int nResecond=GetLocalInt(OBJECT_SELF, "Resecond");
int nHarvesttime;

if (sType=="te_spidven")
    {
        nDC=17;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Hunting";
        sMat="it_poison020";
        nHarvesttime=6;
        SetLocalInt(oItem,"nSticky",nSticky+5);
    }

if (sType=="te_firedrake")
    {
        nDC=18;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Alchemy";
        sMat="te_bounty034";
        nHarvesttime=6;
        SetLocalInt(oItem,"nBlood",nBlood+5);
    }

if (sType=="te_plogiston")
    {
        nDC=21;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Alchemy";
        sMat="te_bounty036";
        nHarvesttime=6;
        SetLocalInt(oItem,"nDust",nDust+5);
    }

if (sType=="acacia")
    {
        nDC=17;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=6;
        sTool="ceb_crtcottonpicker";
        sFeat="Herbalism";
        sMat="it_comp_eyelash";
        SetLocalInt(oItem,"nSticky",nSticky+5);
        nHarvesttime=6;
    }

if (sType=="te_silkgland")
    {
        nDC=17;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Hunting";
        sMat="te_bount027";
        nHarvesttime=6;
        SetLocalInt(oItem,"nSticky",nSticky+5);
    }

if (sType=="antlers")
    {
        nDC=20;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Hunting";
        sMat="te_bount017";
        nHarvesttime=6;
         SetLocalInt(oItem,"nBlood",nBlood+5);
    }

if (sType=="softhide")
    {
        nDC=15;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Hunting";
        sMat="te_cebcraft020";
        nHarvesttime=6;
         SetLocalInt(oItem,"nBlood",nBlood+5);
    }

if (sType=="hardhide")
    {
        nDC=15;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Hunting";
        sMat="te_cebcraft01";
        nHarvesttime=6;
         SetLocalInt(oItem,"nBlood",nBlood+5);
    }

if (sType =="te_tentacle")
    {
        nDC=18;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Hunting";
        sMat="it_comp_tentacle";
        nHarvesttime=6;
        SetLocalInt(oItem,"nBlood",nBlood+5);
     }

if (sType =="te_ankheg")
    {
        nDC=21;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Hunting";
        sMat="te_item_8462";
        nHarvesttime=6;
        SetLocalInt(oItem,"nSticky",nSticky+5);
     }

if (sType =="te_eyestalk")
    {
        nDC=21;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Hunting";
        sMat="te_item_8460";
        nHarvesttime=6;
        SetLocalInt(oItem,"nBlood",nBlood+5);
     }

if (sType =="te_drider")
    {
        nDC=23;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Hunting";
        sMat="te_bount005";
        nHarvesttime=6;
        SetLocalInt(oItem,"nSticky",nSticky+5);
     }

if (sType =="te_stag")
    {
        nDC=18;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Hunting";
        sMat="te_bount017";
        nHarvesttime=6;
        SetLocalInt(oItem,"nBlood",nBlood+5);
     }

if (sType =="te_minotaur")
    {
        nDC=18;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Hunting";
        sMat="te_bount020";
        nHarvesttime=6;
        SetLocalInt(oItem,"nBlood",nBlood+5);
     }

if (sType =="te_dragon")
    {
        nDC=25;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Hunting";
        sMat="te_cebcraft024";
        nHarvesttime=60;
        SetLocalInt(oItem,"nBlood",nBlood+5);
     }

if (sType=="te_satyr")
    {
        nDC=18;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Hunting";
        sMat="te_item_8461";
        nHarvesttime=6;
        SetLocalInt(oItem,"nBlood",nBlood+5);
    }

if (sType=="cotton")
    {
        nDC=15;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sMat="te_item_0010";
        nHarvesttime=6;
        SetLocalInt(oItem,"nSticky",nSticky+5);
    }

if (sType=="oakwood")
    {
        nDC=16;
        nMod=GetAbilityModifier(ABILITY_STRENGTH,oPC);
        nRespawn=3;
        sTool="ceb_crtwoodaxe";
        sFeat="Wood_Gathering";
        sMat="te_cebcraft026";
        nHarvesttime=6;
        SetLocalInt(oItem,"nSticky",nSticky+5);
    }

if (sType=="darkwood")
    {
        nDC=20;
        nMod=GetAbilityModifier(ABILITY_STRENGTH,oPC);
        nRespawn=6;
        sTool="ceb_crtwoodaxe";
        sFeat="Wood_Gathering";
        sMat="te_cebcraft025";
        nHarvesttime=10;
        SetLocalInt(oItem,"nSticky",nSticky+5);
    }


if (sType=="iron")
    {
        nDC=15;
        nMod=GetAbilityModifier(ABILITY_STRENGTH,oPC);
        nRespawn=3;
        sTool="ceb_crtpickaxe";
        sFeat="Mining";
        sMat="te_item_8468";
        nHarvesttime=6;
        SetLocalInt(oItem,"nDust",nDust+5);
    }

if (sType=="mithril")
    {
        nDC=20;
        nMod=GetAbilityModifier(ABILITY_STRENGTH,oPC);
        nRespawn=6;
        sTool="ceb_crtpickaxe";
        sFeat="Mining";
        sMat="te_item_8469";
        nHarvesttime=15;
        SetLocalInt(oItem,"nDust",nDust+5);
    }


if (sType=="adamantine")
    {
        nDC=24;
        nMod=GetAbilityModifier(ABILITY_STRENGTH,oPC);
        nRespawn=12;
        sTool="ceb_crtpickaxe";
        sFeat="Mining";
        sMat="te_item_8470";
        nHarvesttime=20;
        SetLocalInt(oItem,"nDust",nDust+5);
    }


if (sType=="quartz")
    {
        nDC=20;
        nMod=GetAbilityModifier(ABILITY_STRENGTH,oPC);
        nRespawn=2;
        sTool="ceb_crtpickaxe";
        sFeat="Mining";
        sMat="NW_IT_MSMLMISC11";
        nHarvesttime=10;
        SetLocalInt(oItem,"nDust",nDust+5);
    }


if (sType=="sulfur")
    {
        nDC=17;
        nMod=GetAbilityModifier(ABILITY_STRENGTH,oPC);
        nRespawn=3;
        sTool="ceb_crtpickaxe";
        sFeat="Mining";
        sMat="it_comp_sulfur";
        nHarvesttime=10;
        SetLocalInt(oItem,"nDust",nDust+5);
    }


if (sType=="coal")
    {
        nDC=15;
        nMod=GetAbilityModifier(ABILITY_STRENGTH,oPC);
        nRespawn=3;
        sTool="ceb_crtpickaxe";
        sFeat="Mining";
        sMat="it_comp_lumpcoal";
        nHarvesttime=6;
        SetLocalInt(oItem,"nDust",nDust+5);
    }

if (sType=="haunspeir")
    {
        nDC=15;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Herbalism";
        sMat="RawHaunspeir";
        nHarvesttime=6;
        SetLocalInt(oItem,"nSticky",nSticky+5);
    }

if (sType=="jhuild")
    {
        nDC=15;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Herbalism";
        sMat="RawJhuild";
        nHarvesttime=6;
        SetLocalInt(oItem,"nSticky",nSticky+5);
    }

if (sType=="kammarth")
    {
        nDC=15;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Herbalism";
        sMat="RawKammarth";
        nHarvesttime=6;
        SetLocalInt(oItem,"nSticky",nSticky+5);
    }

if (sType=="katakuda")
    {
        nDC=15;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Herbalism";
        sMat="RawKatakuda";
        nHarvesttime=6;
        SetLocalInt(oItem,"nSticky",nSticky+5);
    }

if (sType=="rhul")
    {
        nDC=15;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Herbalism";
        sMat="RawRhul";
        nHarvesttime=6;
        SetLocalInt(oItem,"nSticky",nSticky+5);
    }

if (sType=="sezaradroot")
    {
        nDC=15;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=3;
        sTool="ceb_crtcottonpicker";
        sFeat="Herbalism";
        sMat="RawSezaradRoot";
        nHarvesttime=6;
        SetLocalInt(oItem,"nSticky",nSticky+5);
    }

if (sType=="rose")/* type variable */
    {
        nDC=10;        /* DC Challenge */
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);     /* Ability that helps with DC */
        nRespawn=3;     /* In game hours to respawn */
        sTool="ceb_crtcottonpicker";  /* tool needed */
        sMat="RosePetals";
        nHarvesttime=5;
        SetLocalInt(oItem,"nSticky",nSticky+5);
    }

if (sType=="berry")
    {
        nDC=5;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=2;
        sMat="te_item_8398";
        nHarvesttime=3;
        SetLocalInt(oItem,"nSticky",nSticky+5);
    }

if (sType=="acorn")
    {
        nDC=5;
        nMod=GetAbilityModifier(ABILITY_INTELLIGENCE,oPC);
        nRespawn=2;
        sMat="te_item_8397";
        nHarvesttime=3;
    }
if (sType=="plaguestone")
    {
        nDC=27;
        nMod=GetAbilityModifier(ABILITY_STRENGTH,oPC);
        nRespawn=3;
        sTool="ceb_crtpickaxe";
        sFeat="Mining";
        sMat="plaguestone";
        nHarvesttime=18;
        SetLocalInt(oItem,"nDust",nDust+5);
    }


    if(nBlood >= 100) {SetLocalInt(oItem,"nBlood",100);}
    if(nBlood <= 0)   {SetLocalInt(oItem,"nBlood",0);}
    if(nSticky >= 100) {SetLocalInt(oItem,"nSticky",100);}
    if(nSticky <= 0)   {SetLocalInt(oItem,"nSticky",0);}
    if(nDust >= 100) {SetLocalInt(oItem,"nDust",100);}
    if(nDust <= 0)   {SetLocalInt(oItem,"nDust",0);}
    if(nPlan >= 100) {SetLocalInt(oItem,"nPlan",100);}
    if(nPlan <= 0)   {SetLocalInt(oItem,"nPlan",0);}

if (sFeat == "Hunting")
{
    if(GetHasFeat(1480,oPC) == TRUE)//anatomy
    {
        SendMessageToPC(oPC, "Your knowledge of anatomy grants you a bonus to this task.");
        nDC = nDC - 2;
    }
}

if (FeatCheck(sFeat, oPC) == FALSE)
    {
        nRoll = (nRoll -(GetHitDice(oPC)));
        SendMessageToPC(oPC, "Since you are not proficient in "+sFeat+", you are unable to collect this resource effectively.");
    }
if (sTool != "" && GetItemPossessedBy(oPC, sTool) == OBJECT_INVALID)
    {
        SendMessageToPC(oPC, "You do not have the required tool.");
        return;
    }

if (nDate < GetCalendarDay()) nHour=nHour+24;

if (nHour-GetTimeHour() < nRespawn && sFeat != "Hunting" && sFeat != "Alchemy")
    {
        SendMessageToPC(oPC, "This resource has been depleted.");
        return;
    }

if (nRedate >= GetCalendarDay() &&
    nRehour >= GetTimeHour() &&
    nReminute >= GetTimeMinute() &&
    nResecond+nHarvesttime >= GetTimeSecond())
    {
        SendMessageToPC(oPC, "You cannot do this yet.");
        return;
    }
if (nRoll == 1)
    {
        SendMessageToPC(oPC, "Roll: 1 Critical failure! You destroy your tool.");
        DestroyObject(GetItemPossessedBy(oPC, sTool));
        return;
    }

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oPC, IntToFloat(nHarvesttime));
AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM19, 1.0f, IntToFloat(nHarvesttime)));

if (nRoll+nMod >= nDC ||
    nRoll==20)
    {
        DelayCommand(IntToFloat(nHarvesttime), SendMessageToPC(oPC, "Roll: "+IntToString(nRoll+nMod)+" You successfully harvest the resource."));
        DelayCommand(IntToFloat(nHarvesttime), AssignCommand(oPC, ActionGiveItem(CreateItemOnObject(sMat, oPC), oPC)));
        if (sFeat=="Hunting" || sFeat=="Alchemy"){
            DelayCommand(IntToFloat(nHarvesttime), DestroyObject(OBJECT_SELF));
            return;
            }
        SetLocalInt(OBJECT_SELF, "Date", GetCalendarDay());
        SetLocalInt(OBJECT_SELF, "Hour", GetTimeHour());
        return;
    }
else
    {
        DelayCommand(IntToFloat(nHarvesttime), SendMessageToPC(oPC, "Roll: "+IntToString(nRoll+nMod)+" You fail to harvest the resource."));
        SetLocalInt(OBJECT_SELF, "Redate", GetCalendarDay());
        /* Randomize Respawn */
        if (nRespawn < 4) nSpawnhour=GetTimeHour()+d2(1);
        else if (nRespawn < 9) nSpawnhour=GetTimeHour()+d4(1);
        else nSpawnhour=GetTimeHour()+d6(1);
        if (nHour > 23) nHour=nHour-24;
        SetLocalInt(OBJECT_SELF, "Rehour", nSpawnhour);
        SetLocalInt(OBJECT_SELF, "Reminute", GetTimeMinute());
        SetLocalInt(OBJECT_SELF, "Resecond", GetTimeSecond());
        return;
    }
}
