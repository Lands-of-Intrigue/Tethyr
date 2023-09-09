//Custom trap functions
#include "nw_i0_spells"
void CustomDoTrapSpike(object oTarget,int nDamage,int iDC);
void HolyTrap(object oTarget,int Undead_Dmg, int Oth_dmg,int iDC);
void TangleTrap(object oTarget,int iRounds, float fRadius, int iDC);
void AcidBlob(object oTarget,int iDam,int iRounds, int iDC);
void FireTrap(object oTarget,float fSize,int nDamage, int iDC);
void GasTrap(object oTarget,string sScript,int iRounds);
void FrostTrap(object oTarget,int iDam, int iDC,int iRounds);
void NegativeTrap(object oTarget,int iStrL,int iDam, int iDC,int iLvlD);
void SonicTrap(object oTarget,int iDam,float fSize,int iDC,int iRounds);
void AcidSplash(object oTarget,int nDamage,int iDC);




void CustomDoTrapSpike(object oTarget,int nDamage,int iDC)
{
    //Declare major variables
    //object oTarget = GetEnteringObject();

    int nRealDamage = GetReflexAdjustedDamage(nDamage, oTarget, iDC, SAVING_THROW_TYPE_TRAP, OBJECT_SELF);
    if (nDamage > 0)
    {
        effect eDam = EffectDamage(nRealDamage, DAMAGE_TYPE_PIERCING);
        effect eVis = EffectVisualEffect(253);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
    }
}



//Will saving throw vs divine damage for half damage.
void HolyTrap(object oTarget,int Undead_Dmg, int Oth_dmg,int iDC)
{

    effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);


        if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
        {
             //standard bioware does not give them a saving through
             //uncomment to give them one for half damage.
            //int iWill =WillSave(oTarget,iDC,SAVING_THROW_TYPE_TRAP,OBJECT_SELF);
            ///if(iWill>=1)Undead_Dmg=Undead_Dmg/2;
            effect eDamUndead = EffectDamage(Undead_Dmg, DAMAGE_TYPE_DIVINE);
            //Apply Holy Damage and VFX impact
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamUndead, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
        else
        {
          int iWill =WillSave(oTarget,iDC,SAVING_THROW_TYPE_TRAP,OBJECT_SELF);
          if(iWill>=1)Oth_dmg=Oth_dmg/2;
          effect eDam = EffectDamage(Oth_dmg, DAMAGE_TYPE_DIVINE);
            //Apply Holy Damage and VFX impact
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
}


void TangleTrap(object oTarget,int iRounds, float fRadius, int iDC)
{
    location lTarget = GetLocation(oTarget);
    effect eSlow = EffectSlow();
    effect eVis = EffectVisualEffect(VFX_IMP_SLOW);
    //Find first target in the size
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fRadius, lTarget);
    //Cycle through the objects in the radius
    while (GetIsObjectValid(oTarget))
    {
        if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, iDC, SAVING_THROW_TYPE_TRAP))
        {
            //Apply slow effect and slow effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oTarget, RoundsToSeconds(iRounds));
        }
        //Get next target in the shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fRadius, lTarget);
    }
}


void AcidBlob(object oTarget,int iDam,int iRounds, int iDC)
{
    iDam = GetReflexAdjustedDamage(iDam,oTarget,iDC,SAVING_THROW_TYPE_ACID,OBJECT_SELF);
    effect eDam = EffectDamage(iDam, DAMAGE_TYPE_ACID);
    effect eHold = EffectParalyze();
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
    effect eDur = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eLink = EffectLinkEffects(eHold, eDur);

    //Make Reflex Save
    if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, iDC, SAVING_THROW_TYPE_TRAP))
    {
        //Apply Hold and Damage
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(iRounds));
    }
    else
    {
        //Apply Hold
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}


void FireTrap(object oTarget,float fSize,int nDamage, int iDC)
{
    location lTarget = GetLocation(oTarget);
    int nDamage;
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eDam;

    //Get first object in the target area
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lTarget);
    //Cycle through the target area until all object have been targeted
    while(GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {


            //Adjust the trap damage based on the feats of the target
            if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, iDC, SAVING_THROW_TYPE_TRAP))
            {
                if (GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
                {
                    nDamage /= 2;
                }
            }
            else if (GetHasFeat(FEAT_EVASION, oTarget) || GetHasFeat(FEAT_IMPROVED_EVASION, oTarget))
            {
                nDamage = 0;
            }
            else
            {
                nDamage /= 2;
            }
            if (nDamage > 0)
            {
                //Set the damage effect
                eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                if (nDamage > 0)
                {
                    //Apply effects to the target.
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    DelayCommand(0.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                }
            }
        }
        //Get next target in shape
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, lTarget);
    }
}


void GasTrap(object oTarget,string sScript,int iRounds)
{
    //Declare major variables including Area of Effect Object
    //AOE_PER_FOGACID is in vfx_persistent.2da and defines visual and radius 5 meters.
    //but we overriding the scripts that fire with this area effect.
    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGACID, sScript, "****", "****");
    location lTarget = GetLocation(oTarget);

    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(iRounds));
}


void FrostTrap(object oTarget,int iDam, int iDC,int iRounds)
{
    effect eDam = EffectDamage(iDam, DAMAGE_TYPE_COLD);
    effect eParal = EffectParalyze();
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eFreeze = EffectVisualEffect(VFX_DUR_BLUR);
    effect eLink = EffectLinkEffects(eParal, eFreeze);

    if(!MySavingThrow(SAVING_THROW_FORT,oTarget, iDC, SAVING_THROW_TYPE_TRAP))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(iRounds));
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}


void NegativeTrap(object oTarget,int iStrL,int iDam, int iDC,int iLvlD)
{

    effect eNeg = EffectAbilityDecrease(ABILITY_STRENGTH, iStrL);
    if(iLvlD ==1)eNeg = EffectNegativeLevel(iStrL);
    effect eDam = EffectDamage(iDam, DAMAGE_TYPE_NEGATIVE);
    eNeg = SupernaturalEffect(eNeg);
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);

    // Undead are healed by Negative Energy.
    if ( GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD )
    {
        effect eHeal = EffectHeal(iDam);
        effect eVisHeal = EffectVisualEffect(VFX_IMP_HEALING_M);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisHeal, oTarget);
    }
    else
    {
        //Make a saving throw check
        if(!MySavingThrow(SAVING_THROW_FORT, oTarget, iDC, SAVING_THROW_TYPE_TRAP))
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eNeg, oTarget);
        }
        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    }
}

void SonicTrap(object oTarget,int iDam,float fSize,int iDC,int iRounds)
{
    effect eStun = EffectStunned();
    effect eFNF = EffectVisualEffect(VFX_FNF_SOUND_BURST);
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
    effect eLink = EffectLinkEffects(eStun, eMind);
    effect eDam = EffectDamage(iDam, DAMAGE_TYPE_SONIC);
    //Apply the FNF to the spell location
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eFNF, GetLocation(oTarget));
    //Get the first target in the spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fSize,GetLocation(oTarget));
    while (GetIsObjectValid(oTarget))
    {
        DelayCommand(0.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
        //Make a Will roll to avoid being stunned
        if(!MySavingThrow(SAVING_THROW_WILL, oTarget, iDC, SAVING_THROW_TYPE_TRAP))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(iRounds));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, fSize, GetLocation(oTarget));
    }
}

void AcidSplash(object oTarget,int nDamage,int iDC)
{
    effect eDam;
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);

    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, iDC, SAVING_THROW_TYPE_TRAP);

    eDam = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

}

