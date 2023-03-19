//::///////////////////////////////////////////////
//:: Summon Creature Series
//:: NW_S0_Summon
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Carries out the summoning of the appropriate
    creature for the Summon Monster Series of spells
    1 to 9
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////

int DNDAlignment(object oPC);
effect SetSummonEffect(int nSpellID);


#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
        // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    //** the spellcaster
    object oPC = OBJECT_SELF;
    object oArea = GetArea(oPC);
    object oItem;
    //** the spell ID
    int nSpellID = GetSpellId();
    int nRoll = d3();
    //** this will store the resref of what is summoned
    string sSummon = "te_spiritweap";
    //** the duration in round/level can be changed here
    float nDuration = IntToFloat(GetCasterLevel(OBJECT_SELF)) * 1.0;

    //** make metamagic check for extended spells
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration *= 2.0;
    }

    //** determine which visual effect I should use.
    int iVFX = VFX_FNF_SUMMON_MONSTER_1;
    //** the level of the summon is stored here
    int iLevel = 0;

    //Apply the VFX impact and summon effect
    effect eSummon;

    //** if it's not a PC
    if (!GetIsPC(OBJECT_SELF))
    {
        //** NPCs do not have henches
        eSummon = EffectSummonCreature(sSummon, iVFX);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(FloatToInt(nDuration)));
    }
    else
    {
        //** here I will store the summoned creature object
        object oSummon;
        int iMaxSummons = 2;

        //** Mages specialising in conjuration will have special perks, as in
        //** having the summons longer and being able to summon more at the same time.
        if (GetHasFeat(FEAT_SPELL_FOCUS_CONJURATION))
        {
            iMaxSummons = 3;
            nDuration *= 1.25;
        }
        if (GetHasFeat(FEAT_GREATER_SPELL_FOCUS_CONJURATION))
        {
            //** does iMaxSummons ++; twice since taking GSF CONJ removes SF CONJ
            iMaxSummons = 4;
            //** this might have to be increased too, not sure?
            nDuration *= 1.25;
        }

        //** count the henchmen the PC has, and how many of them are summons
        int iCount;
        int iSummonCount = 0;
        object oHench;
        for (iCount=1; iCount<99; iCount++)
        {
            oHench = GetHenchman(OBJECT_SELF, iCount);
            if (oHench == OBJECT_INVALID)
            {
                break;
            }
            else if (GetLocalInt(oHench, "iIAmASummonedCreature"))
                iSummonCount++;
        }

        //** prepare the unsummon effect
        effect eUnsummon = EffectVisualEffect(VFX_IMP_UNSUMMON);

        if (iSummonCount >= iMaxSummons)
        {
            //** the guy has more than he can hold, unsummon the first summons
            int i0;
            for (i0=1; i0<iCount; i0++)
            {
                oHench = GetHenchman(OBJECT_SELF, i0);
                if (GetLocalInt(oHench, "iIAmASummonedCreature"))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eUnsummon, oHench, 6.0);
                    DestroyObject(oHench, 2.5);
                    i0 = 999;
                    break;
                }
            }
        }

        //** create a new summons with some nice effects
        eSummon = EffectVisualEffect(iVFX);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, GetSpellTargetLocation());
        oSummon = CreateObject(OBJECT_TYPE_CREATURE, sSummon, GetSpellTargetLocation());
        if (oSummon == OBJECT_INVALID)
        {
            WriteTimestampedLogEntry( "BUG: Unable to create summon with resref " + sSummon
                + " for " + GetName(oPC) + " and spell ID " + IntToString(nSpellID));
            SpeakString( "BUG: Unable to create summon with resref " + sSummon
                + " for " + GetName(oPC) + " and spell ID " + IntToString(nSpellID));

        }
        else
        {

            //Deity Weapons:
            /*Akadi*/  if(GetHasFeat(1304,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap001",oSummon,1);}
            /*Auril*/  else if(GetHasFeat(1305,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap024",oSummon,1);}
            /*Azuth*/  else if(GetHasFeat(1306,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap025",oSummon,1);}
            /*Bane*/  else if(GetHasFeat(1316,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap029",oSummon,1);}
            /*Beshaba*/  else if(GetHasFeat(1307,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap016",oSummon,1);}
            /*Chauntea*/  else if(GetHasFeat(1352,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap002",oSummon,1);}
            /*Cyric*/  else if(GetHasFeat(1308,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap003",oSummon,1);}
            /*Deneir*/  else if(GetHasFeat(1309,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap026",oSummon,1);}
            /*Dwarven_Powers*/  else if(GetHasFeat(1359,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap055",oSummon,1);}
            /*Eldath*/  else if(GetHasFeat(1355,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap027",oSummon,1);}
            /*Elven_Powers*/  else if(GetHasFeat(1357,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap054",oSummon,1);}
            /*Finder_Wyvernspur*/  else if(GetHasFeat(1339,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap040",oSummon,1);}
            /*Garagos*/  else if(GetHasFeat(1340,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap041",oSummon,1);}
            /*Gargauth*/  else if(GetHasFeat(1341,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap042",oSummon,1);}
            /*Gond*/  else if(GetHasFeat(1310,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap017",oSummon,1);}
            /*Grumbar*/  else if(GetHasFeat(1311,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap004",oSummon,1);}
            /*Gwaeron_Windstrom*/  else if(GetHasFeat(1342,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap043",oSummon,1);}
            /*Halfling_Powers*/  else if(GetHasFeat(1360,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap057",oSummon,1);}
            /*Helm*/  else if(GetHasFeat(1312,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap018",oSummon,1);}
            /*Hoar*/  else if(GetHasFeat(1343,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap044",oSummon,1);}
            /*Ibrandul*/  else if(GetHasFeat(1313,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap028",oSummon,1);}
            /*Ilmater*/  else if(GetHasFeat(1314,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap019",oSummon,1);}
            /*Ishtisha*/  else if(GetHasFeat(1315,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap005",oSummon,1);}
            /*Kelemvor*/  else if(GetHasFeat(1317,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap006",oSummon,1);}
            /*Kossuth*/  else if(GetHasFeat(1318,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap007",oSummon,1);}
            /*Lathander*/  else if(GetHasFeat(1319,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap008",oSummon,1);}
            /*Leira*/  else if(GetHasFeat(1320,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap030",oSummon,1);}
            /*Lliira*/  else if(GetHasFeat(1321,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap031",oSummon,1);}
            /*Loviatar*/  else if(GetHasFeat(1322,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap032",oSummon,1);}
            /*Lurue*/  else if(GetHasFeat(1344,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap045",oSummon,1);}
            /*Malar*/  else if(GetHasFeat(1323,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap033",oSummon,1);}
            /*Mask*/  else if(GetHasFeat(1324,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap034",oSummon,1);}
            /*Mielikki*/  else if(GetHasFeat(1354,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap020",oSummon,1);}
            /*Milil*/  else if(GetHasFeat(1325,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap035",oSummon,1);}
            /*Mystra*/  else if(GetHasFeat(1326,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap009",oSummon,1);}
            /*Nobanion*/  else if(GetHasFeat(1345,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap046",oSummon,1);}
            /*Oghma*/  else if(GetHasFeat(1327,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap010",oSummon,1);}
            /*Red_Knight*/  else if(GetHasFeat(1346,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap047",oSummon,1);}
            /*Savras*/  else if(GetHasFeat(1347,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap048",oSummon,1);}
            /*Selune*/  else if(GetHasFeat(1328,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap021",oSummon,1);}
            /*Shar*/  else if(GetHasFeat(1329,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap011",oSummon,1);}
            /*Sharess*/  else if(GetHasFeat(1348,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap049",oSummon,1);}
            /*Shaundakul*/  else if(GetHasFeat(1330,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap036",oSummon,1);}
            /*Shiallia*/  else if(GetHasFeat(1356,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap050",oSummon,1);}
            /*Siamorphe*/  else if(GetHasFeat(1349,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap051",oSummon,1);}
            /*Silvanus*/  else if(GetHasFeat(1353,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap012",oSummon,1);}
            /*Sune*/  else if(GetHasFeat(1331,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap013",oSummon,1);}
            /*Talona*/  else if(GetHasFeat(1332,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap037",oSummon,1);}
            /*Talos*/  else if(GetHasFeat(1333,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap014",oSummon,1);}
            /*Tempus*/  else if(GetHasFeat(1334,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap015",oSummon,1);}
            /*Torm*/  else if(GetHasFeat(1335,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap038",oSummon,1);}
            /*Tymora*/  else if(GetHasFeat(1336,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap022",oSummon,1);}
            /*Tyr*/  else if(GetHasFeat(1337,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap039",oSummon,1);}
            /*Umberlee*/  else if(GetHasFeat(1338,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap023",oSummon,1);}
            /*Underdark_Powers*/  else if(GetHasFeat(1358,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap056",oSummon,1);}
            /*Valkur*/  else if(GetHasFeat(1350,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap052",oSummon,1);}
            /*Velsharoon*/  else if(GetHasFeat(1351,oPC) == TRUE) {oItem = CreateItemOnObject("te_spiritweap053",oSummon,1);}

            SetDroppableFlag(oItem,FALSE);


            AssignCommand(oSummon,ActionEquipItem(oItem,INVENTORY_SLOT_RIGHTHAND));            //** dispel invisibility if everything worked and the caster is invisible
            effect eEff = GetFirstEffect(OBJECT_SELF);
            while (GetEffectType(eEff) != EFFECT_TYPE_INVALIDEFFECT)
            {
                if (GetEffectType(eEff) == EFFECT_TYPE_INVISIBILITY)
                {
                    RemoveEffect(OBJECT_SELF, eEff);
                    break;
                }

                eEff = GetNextEffect(OBJECT_SELF);
            }
            AddHenchman(OBJECT_SELF, oSummon);

            //Caster AB + WIS Mod
            int nAttackBonus = GetBaseAttackBonus(OBJECT_SELF)+GetAbilityModifier(ABILITY_WISDOM,OBJECT_SELF)-3;
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectAttackIncrease(nAttackBonus,ATTACK_BONUS_ONHAND),oSummon);
            //6 //11
            if(nAttackBonus >= 6 && nAttackBonus <11)
            {
                SetBaseAttackBonus(2,oSummon);
            }
            else if(nAttackBonus >= 11)
            {
                SetBaseAttackBonus(3,oSummon);
            }


            //** mark us as summons to make a distinction to other henchmen
            SetLocalInt(oSummon, "iIAmASummonedCreature", 1);
            SetLocalInt(oSummon, "iIGiveNoXP", 1);
            //** after the duration, play the Unsummon VFX and destroy the henchman, dropping all gear he has
            DelayCommand((TurnsToSeconds(FloatToInt(nDuration))-2.5), ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eUnsummon, oSummon, 6.0));
            DestroyObject(oSummon, TurnsToSeconds(FloatToInt(nDuration)));
        }
    }

}

