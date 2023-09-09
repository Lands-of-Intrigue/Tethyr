// tb_spellhoook
// Set this in a string variable "X2_S_UD_SPELLSCRIPT" on the module
//

#include "x2_inc_switches"
#include "tb_inc_spells"
#include "te_functions"
#include "inc_spell_func"
#include "x2_inc_switches"
#include "te_afflic_func"

void main() {
    //Determine who is casting this spell..
    object oCaster = OBJECT_SELF;
    int nSpell = GetSpellId();
    object oItem = GetSpellCastItem();
    object oTarget = GetSpellTargetObject();
    object oPC = OBJECT_SELF;
    object oItemT = GetItemPossessedBy(oTarget, "PC_Data_Object");
    object oItemP = GetItemPossessedBy(oPC, "PC_Data_Object");
    int nSL = SFGetInnateSpellLevelByClass(nSpell,GetLastSpellCastClass());
    int nMetamagic = GetMetaMagicFeat();

    if(nSL >= 1)
    {

    }
    else
    {
        SFGetInnateSpellLevel(nSpell);
    }

    if(nMetamagic == METAMAGIC_NONE)
    {

    }
    else if (nMetamagic == METAMAGIC_EMPOWER)
    {
        nSL = nSL + 2;
    }
    else if (nMetamagic == METAMAGIC_EXTEND)
    {
        nSL = nSL + 1;
    }
    else if (nMetamagic == METAMAGIC_MAXIMIZE)
    {
        nSL = nSL + 3;
    }
    else if (nMetamagic == METAMAGIC_QUICKEN)
    {
        nSL = nSL + 4;
    }
    else if (nMetamagic == METAMAGIC_SILENT)
    {
        nSL = nSL + 1;
    }
    else if (nMetamagic == METAMAGIC_STILL)
    {
        nSL = nSL + 1;
    }



    int nXP = GetXP(oPC);
    int nPiety = GetLocalInt(oItemP,"nPiety");

    //Piety Fix
    if(nPiety >= 100)
    {
        nPiety = 100;
        SetLocalInt(oItemP,"nPiety",nPiety);
    }
    else if(nPiety <= 0)
    {
        nPiety = 0;
        SetLocalInt(oItemP,"nPiety",nPiety);
        if( GetLastSpellCastClass() == CLASS_TYPE_CLERIC ||
            GetLastSpellCastClass() == CLASS_TYPE_DRUID ||
            GetLastSpellCastClass() == CLASS_TYPE_RANGER ||
            GetLastSpellCastClass() == CLASS_TYPE_PALADIN ||
            GetLastSpellCastClass() == CLASS_TYPE_DIVINE_CHAMPION ||
            GetLastSpellCastClass() == CLASS_TYPE_BLACKGUARD)
        {
            SetLocalInt(oItemP,"iTrans",1);
            SendMessageToPC(oPC,"You have transgressed against your deity and must seek divine intervention. Your maximum piety is capped at 20.");
            return;
        }
    }

    //Transgression
    if( GetLastSpellCastClass() == CLASS_TYPE_CLERIC ||
        GetLastSpellCastClass() == CLASS_TYPE_DRUID ||
        GetLastSpellCastClass() == CLASS_TYPE_RANGER ||
        GetLastSpellCastClass() == CLASS_TYPE_PALADIN ||
        GetLastSpellCastClass() == CLASS_TYPE_DIVINE_CHAMPION ||
        GetLastSpellCastClass() == CLASS_TYPE_BLACKGUARD)
    {
        if(GetLocalInt(oItemP,"iTrans") == 1)
        {
            SendMessageToPC(oPC,"You have transgressed against your deity and must seek divine intervention. Your maximum piety is capped at 20.");
            SetModuleOverrideSpellScriptFinished();
            return;
        }
    }

    //Failure for Crimson Mists
    if(GetPCAffliction(oCaster) == 8)
    {
        SendMessageToPC(oCaster,"You feel the magic slip through your vessel like a sieve as you gather it...Wasted.");
        SetModuleOverrideSpellScriptFinished();
        return;
    }

    //Spellfire - PC Casting On themself
    if(GetLevelByClass(49, oTarget) < 1 && GetHasFeat(BACKGROUND_SPELLFIRE,oTarget))
    {
        SendMessageToPC(oTarget,"The energy of your spell seems to be absorbed...You feel warm, as though a fire is growing within you that cannot be contained.");

        int nManaMax = 50;
        //SetLocalInt(oItemP,"nManaMax", nManaMax);
        int nMana = GetLocalInt(oItemP,"nMana");

        if((GetLocalInt(oItemP,"nMana") < nManaMax))
        {
            SetLocalInt(oItemP,"nMana",(nMana+1));
        }

        if(GetLocalInt(oItemT,"nMana") >= 50)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(2),DAMAGE_TYPE_FIRE),oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(2),DAMAGE_TYPE_MAGICAL),oTarget);
        }

        SetModuleOverrideSpellScriptFinished();
        return;
    }

    //Paladin Piety Failure
    if(GetLastSpellCastClass() == CLASS_TYPE_PALADIN)
    {
        if((nSL >= 4 && nPiety < 80)||
           (nSL >= 3 && nPiety < 60)||
           (nSL >= 2 && nPiety < 40)||
           (nSL >= 1 && nPiety <20))
        {
            SendMessageToPC(oPC,"You find yourself unable to call upon the blessings of your deity.");
            SetModuleOverrideSpellScriptFinished();
            return;
        }
    }

    //Other Divine Failure
    if(GetLastSpellCastClass() == CLASS_TYPE_CLERIC || GetLastSpellCastClass() == CLASS_TYPE_RANGER || GetLastSpellCastClass() == CLASS_TYPE_DRUID )
    {
        if((nSL >= 9 && nPiety < 90)||
           (nSL >= 8 && nPiety < 80)||
           (nSL >= 7 && nPiety < 70)||
           (nSL >= 6 && nPiety < 60)||
           (nSL >= 5 && nPiety < 50)||
           (nSL >= 4 && nPiety < 40)||
           (nSL >= 3 && nPiety < 30))
        {
            SendMessageToPC(oPC,"You find yourself unable to call upon the blessings of your deity.");
            SetModuleOverrideSpellScriptFinished();
            return;
        }
    }

    // Items do not require components
    if (GetIsObjectValid(oItem)) {
        if (GetIsObjectValid(oTarget) && spellGetIsHealing(nSpell)) {
            // Do something for healing potions etc
        }
        return;
    }

    // Call module defined "spell_hook_pre_script" if present
    string sScript = GetLocalString(GetModule(), "spell_hook_pre_script");
    if (sScript != "") {
        DeleteLocalString(OBJECT_SELF, "spell_hook_message");
        if (ExecuteScriptAndReturnInt(sScript,OBJECT_SELF)) {
            string sMsg = GetLocalString(OBJECT_SELF, "spell_hook_message");
            if (sMsg != "")
                FloatingTextStringOnCreature(sMsg, OBJECT_SELF);
            SetModuleOverrideSpellScriptFinished();
            DeleteLocalString(OBJECT_SELF, "spell_hook_message");
            return;
        }
    }

    // If the component check fails then fail the spell
    // component check will handle any feedback
    spell_debug("Spellhook calling checkComponents", oCaster);

    if (!checkSpellComponents(nSpell, oCaster))
    {
        spell_debug("Spellhook - spell denied", oCaster);
        if( (GetLocalInt(oItemP,"nEschew") == 1)&&(GetHasFeat(1409,oPC)==TRUE))
        {
            if(nSL>=6)
            {
                SetModuleOverrideSpellScriptFinished();
                return;
            }
            else if(nSL == 5)
            {SetXP(oPC,nXP-90);}
            else if(nSL == 4)
            {SetXP(oPC,nXP-60);}
            else if(nSL == 3)
            {SetXP(oPC,nXP-30);}
            else if(nSL == 2)
            {SetXP(oPC,nXP-20);}
            else if(nSL == 1)
            {SetXP(oPC,nXP-15);}
            else if(nSL == 0)
            {SetXP(oPC,nXP-10);}
        }
        else
        {
            SetModuleOverrideSpellScriptFinished();
            return;
        }
    }
    else
    {
        spell_debug("Spellhook - spell allowed", oCaster);
    }

    //Spellfire explosion
    if (GetIsPC(oTarget) == TRUE)
    {
        if(GetLevelByClass(49, oTarget) >= 1)
        {
            int nManaMax = 50;
            //SetLocalInt(oItemT,"nManaMax", nManaMax);
            int nMana = GetLocalInt(oItemT,"nMana");

            if((GetLocalInt(oItemT,"nMana") < nManaMax))
            {
                SetLocalInt(oItemT,"nMana",(nMana+1));
                SendMessageToPC(oTarget,"You feel energized as you absorb some of the energy of the spell.");
            }

            if(GetLocalInt(oItemT,"nMana") >= 50)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(2),DAMAGE_TYPE_FIRE),oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(2),DAMAGE_TYPE_MAGICAL),oTarget);
            }
        }
    }
}
