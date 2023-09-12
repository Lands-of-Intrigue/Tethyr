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

#include "x2_inc_spellhook"
#include "te_functions"
void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oPC = OBJECT_SELF;
    int nSpellID = GetSpellId();
    int nDuration = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    int nType = GetLocalInt(GetArea(OBJECT_SELF), "iXPRate");
    int iMaxSummons = 1;
    int nFNF_Effect;
    string sSummon;

    if( (GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER)==TRUE) || (GetLevelByClass(CLASS_TYPE_DRUID) >= 1)) //WITH THE ANIMAL DOMAIN/DRUID
    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "te_summons013";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "te_summons017";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "te_summons024";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "te_summons025";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "te_summons032";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            sSummon = "te_summons037";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            sSummon = "te_summons042";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            sSummon = "te_summons046";
        }
    }
    else  //WITOUT THE ANIMAL DOMAIN
    {
        if (nType == 1) //Desert
        {
            if(nSpellID == SPELL_SUMMON_CREATURE_I)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons012";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_II)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons017";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_III)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons024";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_summons027";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_V)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_summons031";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons036";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons041";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons045";
            }
        }
        else if (nType == 2) //Plains
        {
            if(nSpellID == SPELL_SUMMON_CREATURE_I)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons013";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_II)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons019";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_III)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons022";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_summons028";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_V)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_summons033";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons039";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons043";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons047";
            }
        }
        else if (nType == 3) //Hills
        {
            if(nSpellID == SPELL_SUMMON_CREATURE_I)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons014";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_II)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons019";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_III)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons023";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_summons029";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_V)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_summons034";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons039";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons044";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons048";
            }
        }
        else if (nType == 4) //Marsh
        {
            if(nSpellID == SPELL_SUMMON_CREATURE_I)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons015";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_II)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons020";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_III)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons024";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_summons026";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_V)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_summons030";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons038";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons043";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons049";
            }
        }
        else if (nType == 5) //Forest
        {
            if(nSpellID == SPELL_SUMMON_CREATURE_I)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons013";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_II)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons018";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_III)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons022";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_summons028";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_V)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_summons033";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons038";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons043";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons047";
            }
        }
        else if (nType == 6) //Crypt
        {
            if(nSpellID == SPELL_SUMMON_CREATURE_I)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons011";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_II)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons016";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_III)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_summons021";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_summons026";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_V)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_summons030";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons035";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons040";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_summons045";
            }
        }
        else if (nType >= 7) //Everything else
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "te_summons011";
        }
        else
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "te_summons011";
        }
    }
    //Make metamagic check for extend
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }

    //Apply the VFX impact and summon effect
    effect eSummon;

    if (!GetIsPC(OBJECT_SELF))
    {
        //** NPCs do not have henches
        eSummon = EffectSummonCreature(sSummon, nFNF_Effect);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));
    }
    else
    {
        //** here I will store the summoned creature object
        object oSummon;
        int iMaxSummons = 5;

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
        eSummon = EffectVisualEffect(nFNF_Effect);
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
            //** dispel invisibility if everything worked and the caster is invisible
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

            //** mark us as summons to make a distinction to other henchmen
            SetLocalInt(oSummon, "iIAmASummonedCreature", 1);
            SetLocalInt(oSummon, "iIGiveNoXP", 1);
            //** after the duration, play the Unsummon VFX and destroy the henchman, dropping all gear he has
            DelayCommand((TurnsToSeconds(nDuration)-2.5), ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eUnsummon, oSummon, 6.0));
            DestroyObject(oSummon, TurnsToSeconds(nDuration));
        }
    }
}
