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

effect SetSummonEffect(int nSpellID, int nType);

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
    nDuration = 24;
    if(nDuration == 1)
    {
        nDuration = 2;
    }
    effect eSummon = SetSummonEffect(nSpellID,nType);

    //Make metamagic check for extend
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply the VFX impact and summon effect

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
}


effect SetSummonEffect(int nSpellID, int nType)
{
    int nFNF_Effect;
    string sSummon;
    if( (GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER)==TRUE) || (GetLevelByClass(CLASS_TYPE_DRUID) >= 1)) //WITH THE ANIMAL DOMAIN/DRUID
    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "te_mons1f";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "te_mons2d";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "te_mons3m";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "te_mons4c";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "te_mons5dr";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            sSummon = "te_mons6dr";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            sSummon = "te_mons7dr";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            sSummon = "te_mons7dr";
        }
    }
    else  //WITOUT THE ANIMAL DOMAIN
    {
        if (nType == 1) //Desert
        {
            if(nSpellID == SPELL_SUMMON_CREATURE_I)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons1d";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_II)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons2d";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_III)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons3m";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_mons4d";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_V)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_mons5d";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons6d";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons7d";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons8c";
            }
        }
        else if (nType == 2) //Plains
        {
            if(nSpellID == SPELL_SUMMON_CREATURE_I)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons1f";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_II)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons2hp";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_III)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons3f";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_mons4fp";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_V)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_mons5f";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons6h";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons7fmp";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons8fp";
            }
        }
        else if (nType == 3) //Hills
        {
            if(nSpellID == SPELL_SUMMON_CREATURE_I)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons1h";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_II)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons2hp";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_III)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons3h";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_mons4h";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_V)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_mons5h";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons6h";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons7h";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons8h";
            }
        }
        else if (nType == 4) //Marsh
        {
            if(nSpellID == SPELL_SUMMON_CREATURE_I)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons1m";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_II)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons2m";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_III)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons3m";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_mons4cm";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_V)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_mons5cm";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons6fm";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons7fmp";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons8m";
            }
        }
        else if (nType == 5) //Forest
        {
            if(nSpellID == SPELL_SUMMON_CREATURE_I)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons1f";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_II)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons2f";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_III)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons3f";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_mons4fp";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_V)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_mons5f";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons6fm";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons7fmp";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons8fp";
            }
        }
        else if (nType == 6) //Crypt
        {
            if(nSpellID == SPELL_SUMMON_CREATURE_I)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons1c";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_II)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons2cf";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_III)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
                sSummon = "te_mons3c";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_mons4cm";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_V)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
                sSummon = "te_mons5cm";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons6c";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons7c";
            }
            else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
            {
                nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
                sSummon = "te_mons8c";
            }
        }
        else if (nType >= 7) //Everything else
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "te_mons3";
        }
        else
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "te_mons3";
        }
    }
    //effect eVis = EffectVisualEffect(nFNF_Effect);
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    effect eSummonedMonster = EffectSummonCreature(sSummon, nFNF_Effect);
    return eSummonedMonster;
}
