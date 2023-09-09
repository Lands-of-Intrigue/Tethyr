//::///////////////////////////////////////////////
//:: Darkfire
//:: X2_S0_Darkfire
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Gives a melee weapon 1d6 fire damage +1 per two caster
  levels to a maximum of +10.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Dec 04, 2002
//:://////////////////////////////////////////////
//:: Updated by Andrew Nobbs May 08, 2003
//:: 2003-07-29: Rewritten, Georg Zoeller


#include "nw_i0_spells"
#include "x2_i0_spells"
#include "te_functions"
#include "te_afflic_func"
#include "x2_inc_spellhook"


void AddFlamingEffectToWeapon(object oTarget, float fDuration, int nCasterLvl)
{
   // If the spell is cast again, any previous itemproperties matching are removed.
   SetLocalInt(oTarget,"te_shad",0);
   IPSafeAddItemProperty(oTarget, ItemPropertyOnHitCastSpell(127,nCasterLvl), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
   IPSafeAddItemProperty(oTarget, ItemPropertyVisualEffect(ITEM_VISUAL_FIRE), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
   return;
}

void AddNegativeEffectToWeapon(object oTarget, float fDuration, int nCasterLvl)
{
   // If the spell is cast again, any previous itemproperties matching are removed.
   SetLocalInt(oTarget,"te_shad",1);
   IPSafeAddItemProperty(oTarget, ItemPropertyOnHitCastSpell(127,nCasterLvl), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
   IPSafeAddItemProperty(oTarget, ItemPropertyVisualEffect(ITEM_VISUAL_EVIL), fDuration,X2_IP_ADDPROP_POLICY_REPLACE_EXISTING,FALSE,TRUE);
   return;
}


/*
            if(GetHasFeat(1300,OBJECT_SELF) == TRUE)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration));
                AddNegativeEffectToWeapon(oMyWeapon, HoursToSeconds(nDuration),nCasterLvl);
            }
            else
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), HoursToSeconds(nDuration));
                AddFlamingEffectToWeapon(oMyWeapon, HoursToSeconds(nDuration),nCasterLvl);
            }
*/
void main()
{

    /*
      Spellcast Hook Code
      Added 2003-07-07 by Georg Zoeller
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
    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nDuration = 2 * TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLvl = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());

    //Limit nCasterLvl to 10, so it max out at +10 to the damage.
    if(nCasterLvl > 10)
    {
        nCasterLvl = 10;
    }

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2; //Duration is +100%
    }

   object oMyWeapon   =  IPGetTargetedOrEquippedMeleeWeapon();

   if(GetLocalInt(oMyWeapon,"nGunBullet") == 1)
   {
        int nStack = GetItemStackSize(oMyWeapon);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), GetLocation(OBJECT_SELF));
        if(nStack > 50)
        {
            object oPC = GetFirstObjectInShape(SHAPE_SPHERE,5.0f,GetLocation(OBJECT_SELF),TRUE,OBJECT_TYPE_CREATURE);
            while (GetIsObjectValid(oPC) == TRUE)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d2(nStack),DAMAGE_TYPE_SONIC),oPC,0.0);
                oPC = GetFirstObjectInShape(SHAPE_SPHERE,5.0f,GetLocation(OBJECT_SELF),TRUE,OBJECT_TYPE_CREATURE);
            }
        }
        else
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d2(nStack),DAMAGE_TYPE_SONIC),OBJECT_SELF,0.0);
        }
        DestroyObject(oMyWeapon,0.1f);
        return;
   }

   if(GetIsObjectValid(oMyWeapon) && GetLocalInt(oMyWeapon,"Elemental") != 1 )
   {
        SignalEvent(GetItemPossessor(oMyWeapon), EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

        if (nDuration>0)
        {
            // haaaack: store caster level on item for the on hit spell to work properly
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oMyWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oMyWeapon), TurnsToSeconds(nDuration));
            itemproperty iIp = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGEBONUS_1d6);
            IPSafeAddItemProperty(oMyWeapon, iIp, HoursToSeconds(nDuration));

         }
            return;
    }
     else
    {
           FloatingTextStrRefOnCreature(83615, OBJECT_SELF);
           return;
    }
}
