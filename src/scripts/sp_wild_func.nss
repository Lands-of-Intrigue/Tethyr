///////////////////////////////////////////////
///////WILD MAGIC FUNCTIONS - SP_WILD_FUNC
///////////////////////////////////////////////
// OUTCOMES BELOW
///CASTER BELOW////////////////////////////////
//                                      // Caster Glows a Color
//                                      // Pixie dust visual effect 3d10 + 10 rounds
//                                      // Caster Gets 30/+5 DR for 1d4 rounds
//                                      // Invisibility for 1d6 rounds
//                                      // Polymorph self (penguin)
//                                      // Weapon gets +1d6 of a random damage type for 1d10 rounds.
//                                      // Caster loses 1d2 of a random stat for 1d6 rounds
//                                      // Caster gains 1d2 of a random stat for 1d6 rounds
//                                      // 1-8
///TARGET BELOW////////////////////////////////
//                                      // Target gets +1d4 Strength for 1d6 rounds
//                                      // Butterfly Spray (All creatures in a 20-meter cone, directed from the caster to the target, are blinded for 1d4 rounds. This can be negated by a fortitude save (DC 13) or spell resistance (vs. caster level 10).
//                                      // Darkness Cast on Target (1d6 rounds)
//                                      // Target gets Ethereal Visage for 1d4 Rounds
//                                      // Fake Visuals for FireBall or Lightning Bolt are produced
//                                      // Fireball at level 10
//                                      // Flesh to Stone: If the target is petrified, Stone to Flesh is cast, otherwise, Flesh to Stone is cast (lvl 11)
//                                      // Gem Spray: All creatures in a 30-meter cone, directed from the caster to the target, are hit with 1d5 gems. This causes d4 bludgeoning damage for each gem (inflicted as a single damage source), and the gems are added to the creature's inventory. A reflex save is allowed for half damage (but evasion does not apply). The gems that can be produced are garnet (5%), fire agate (30%), diamond (30%), and sapphire (35%).
//                                      // Grass Growth (entanglement for 1d6 rounds)
//                                      // Target becomes invisible for 1d6 rounds
//                                      // Lightning Bolt: Ranged touch attack, 6d6 Electrical, reflex for half.
//                                      // Polymorph target: Targer polymorphed into chicken for 1d4 rounds
//                                      // Shimmering Colors: All creatures in a 20-meter cone, directed from the caster to the target, are blinded for 1d4 rounds if they fail a fortitude save (DC 13). Spell resistance is checked (vs. caster level 1).
//                                      // Target is Slowed for 10 rounds
//                                      // Stinking cloud is created for 1d4 rounds at target location
//                                      // Summon, Rat/Cow/Penguin
//                                      // Windstorm: A mighty wind blows, affecting objects within a huge (6.67 meter radius) area of the target. Lingering areas of effect are destroyed, unlocked closed doors are opened while open doors are closed, and creatures that fail a DC 15 fortitude saving throw are knocked prone for one round.
//                                      // 9-26
///BOTH BELOW//////////////////////////////////
//                                      // Double polymorph into penguins. Penguin fight!
//                                      // All Saves are increased by 10 for 1d8 rounds
//                                      // All Saves are decreased by 10 for 1d8 rounds
///AREA BELOW//////////////////////////////////
//                                      // Heavy Rain Effects (no gameplay effect) 5 Rounds
//                                      // Dead magic increases by 50 for 1d20 rounds
//                                      // Dead magic decreases by 50 for 1d20 rounds
///SPELL BELOW/////////////////////////////////
//                                      //
///////////////////////////////////////////////
// 33 options currently
#include "X0_I0_SPELLS"
#include "te_functions"

// Heavy Rain Effects (no gameplay effect) 5 Rounds
//                                      // Dead magic increases by 50 for 1d20 rounds
//                                      // Dead magic decreases by 50 for 1d20 rounds }

void WildMagicEffects(object oPerson, object oTarget)
{
    effect eEnd;
    object oEnd;
    object oEnd2 = OBJECT_INVALID;
    int nDuration;
    int nAreaBool = 0;
    int nDtype = -1;
    int nShape;
    int nInstant = TRUE;
    int nTable = 101;
    float fSize;
    int nSavingThrowType = SAVING_THROW_TYPE_CHAOS;
    int nFollow = FALSE;
    string nOnEnter = "", nHeartBeat = "", nOnExit = "";
    int nAOEID;
    effect eVis = EffectDarkness();
    int nDdie = 6;
    int nDdice = 1;
    int nDC = 13;
    int nSaveType = SAVING_THROW_TYPE_NONE;
    int nDamage;
    int nDead;
    int nWeather;
    object oArea;
    int nDeadSet;
    float fDelay;

    nTable = 1 + d100(1) % 25;

    int nRand;
    switch(nTable) {
    case 1:  //Hiccups for 1d6 rounds
        {
            SpeakString("[An uncontrollable hiccup errupts from " + GetName(oPerson) + ".]");
            int nHiccups = d6(1);
            while (nHiccups > 1)
            {
                DelayCommand(RoundsToSeconds(nHiccups), SpeakString("[Hiccups.]"));
            }
        }
        break;
    case 2: //Pixie Dust Visual Effect, 3d10 + 10 Rounds
        oEnd = oPerson;
        nDuration = d10(3) + 10;
        eEnd = EffectVisualEffect(VFX_DUR_PIXIEDUST);
        break;
    case 3:  // Caster Gets 30/+5 DR for 1d4 rounds
        oEnd = oPerson;
        nDuration = d4(1);
        eEnd = EffectDamageReduction(30, 5);
        break;
    case 4:  // Invisibility for 1d6 rounds
        oEnd = oPerson;
        nDuration = d6(1);
        eEnd = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
        break;
    case 5:  // Polymorph self (penguin)
        oEnd = oPerson;
        nDuration = d4(1);
        eEnd = EffectPolymorph(26); // 26 == Penguin;
        break;
    case 6:  // Character gets +1d6 of a random damage type for 1d10 rounds.
        oEnd = oPerson;
        nDuration = d10(1);
        nRand = d10(1);
        if (nRand == 1)
            nDtype = DAMAGE_TYPE_SLASHING;
        else if (nRand == 2)
            nDtype = DAMAGE_TYPE_PIERCING;
        else if (nRand == 3)
            nDtype = DAMAGE_TYPE_BLUDGEONING;
        else if (nRand == 4)
            nDtype = DAMAGE_TYPE_ELECTRICAL;
        else if (nRand == 5)
            nDtype = DAMAGE_TYPE_ACID;
        else if (nRand == 6)
            nDtype = DAMAGE_TYPE_SONIC;
        else if (nRand == 7)
            nDtype = DAMAGE_TYPE_POSITIVE;
        else if (nRand == 8)
            nDtype = DAMAGE_TYPE_COLD;
        else if (nRand == 9)
            nDtype = DAMAGE_TYPE_FIRE;
        else if (nRand == 10)
            nDtype = DAMAGE_TYPE_NEGATIVE;
        eEnd = EffectDamageIncrease(d10(1), nDtype);
        break;
    case 7:  // Caster loses 1d2 of a random stat for 1d6 rounds
        oEnd = oPerson;
        nDuration = d6(1);
        nRand = d6(1);
        if (nRand == 1)
            eEnd = EffectAbilityIncrease(0, d2(1)); //STR
        else if (nRand == 2)
            eEnd = EffectAbilityIncrease(1, d2(1)); //DEX
        else if (nRand == 3)
            eEnd = EffectAbilityIncrease(2, d2(1)); //CON
        else if (nRand == 4)
            eEnd = EffectAbilityIncrease(3, d2(1)); //INT
        else if (nRand == 5)
            eEnd = EffectAbilityIncrease(4, d2(1)); //WIS
        else if (nRand == 6)
            eEnd = EffectAbilityIncrease(5, d2(1)); //CHA
        break;
    case 8:  // Caster gains 1d2 of a random stat for 1d6 rounds
        oEnd = oPerson;
        nDuration = d6(1);
        nRand = d6(1);
        if (nRand == 1)
            eEnd = EffectAbilityDecrease(0, d2(1)); //STR
        else if (nRand == 2)
            eEnd = EffectAbilityDecrease(1, d2(1)); //DEX
        else if (nRand == 3)
            eEnd = EffectAbilityDecrease(2, d2(1)); //CON
        else if (nRand == 4)
            eEnd = EffectAbilityDecrease(3, d2(1)); //INT
        else if (nRand == 5)
            eEnd = EffectAbilityDecrease(4, d2(1)); //WIS
        else if (nRand == 6)
            eEnd = EffectAbilityDecrease(5, d2(1)); //CHA
        break;
    case 9:  // Target gets +1d4 Strength for 1d6 rounds
        oEnd = oTarget;
        nDuration = d6(1);
        eEnd = EffectAbilityIncrease(0, d4(1));
        break;
    case 10:  // Butterfly Spray (All creatures in a 20-meter cone, directed from the caster to the target, are blinded for 1d4 rounds. This can be negated by a fortitude save (DC 13) or spell resistance (vs. caster level 10).
        nDuration = d4(1);
        nDC = 13;
        nAreaBool = 1;
        eEnd = EffectBlindness();
        nShape = SHAPE_CONE;
        nInstant = FALSE;
        fSize = 20.0;
        nSaveType = 1;
        break;
    case 11:  // Darkness Cast on Target (1d6 rounds)
        nDuration = d6(1);
        nAreaBool = 2;
        oEnd = oTarget;
        eEnd = EffectDarkness();
        nShape = SHAPE_SPHERE;
        nInstant = FALSE;
        nAOEID = AOE_PER_DARKNESS;
        break;
    case 12:  // Target gets 25% Concealment for 1d4 Rounds
        eEnd = EffectConcealment(25);
        oEnd = oTarget;
        nDuration = d4(1);
        break;
    case 13:  // Fake Visuals for FireBall are produced
        nAreaBool = 4;
        eEnd = EffectVisualEffect(VFX_FNF_FIREBALL);
        oEnd = oTarget;
        break;
    case 14:  // Fireball at level 10
        nAreaBool = 5;
        oEnd = oTarget;
        nSaveType = 4;
        nDtype = DAMAGE_TYPE_FIRE;
        nDdice = 10;
        fSize = RADIUS_SIZE_HUGE;
        eVis = EffectVisualEffect(VFX_FNF_FIREBALL);
        break;
    case 15:  // Flesh to Stone: If the target is petrified, Stone to Flesh is cast, otherwise, Flesh to Stone is cast (lvl 11)
        oEnd = oTarget;
        if (GetHasEffect(79 /*petrified*/, oTarget))
        {
            nAreaBool = -1;
            RemoveEffectsByType(oTarget, EFFECT_TYPE_PETRIFY);
        }
        else
        {
            if(FortitudeSave(oTarget, 21, SAVING_THROW_FORT) || GetSpellResistance(oTarget) > 21)
                eEnd = EffectPetrify();
        }
        break;
    case 16:  // Grass Growth (entanglement for 1d6 rounds)
        eEnd = EffectEntangle();
        nInstant = FALSE;
        nDuration = d6(1);
        oEnd = oTarget;
        break;
    case 17:  // Target becomes invisible for 1d6 rounds
        eEnd = EffectInvisibility(1);
        oEnd = oTarget;
        nInstant = FALSE;
        nDuration = d6(1);
        break;
    case 18:  // Lightning Bolt: Ranged touch attack, 6d6 Electrical, reflex for half. DC 15.
    `   oEnd = oTarget;
        nDamage = d6(6);
        nDamage = GetReflexAdjustedDamage(nDamage, oTarget, 15, SAVING_THROW_TYPE_ELECTRICITY);
        eEnd = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
        break;
    case 19:  // Polymorph target: Targer polymorphed into chicken for 1d4 rounds
        oEnd = oTarget;
        eEnd = EffectPolymorph(40);
        nDuration = d4(1);
        nInstant = FALSE;
        break;
    case 20:  // Target is Slowed for 10 rounds
        oEnd = oTarget;
        eEnd = EffectSlow();
        nDuration = 10;
        nInstant = FALSE;
        break;
    case 21:  // Stinking cloud is created for 1d4 rounds at target location
        nDuration = d4(1);
        nAreaBool = 2;
        oEnd = oTarget;
        eEnd = EffectDarkness();
        nShape = SHAPE_SPHERE;
        nInstant = FALSE;
        nAOEID = AOE_PER_FOGSTINK;
        break;
    case 22:  // Summon, Rat/Cow/Penguin, 10 Rounds
        nAreaBool = 3;
        nInstant = FALSE;
        oEnd = oTarget;
        nDuration = 10;
        nRand = (d6(1)-1)/2;
        if (nRand == 0)
            eEnd = EffectSummonCreature("nw_rat001", VFX_IMP_POLYMORPH, 0.0f, 1);
        else if (nRand == 1)
            eEnd = EffectSummonCreature("nw_cow", VFX_IMP_POLYMORPH, 0.0f, 1);
        else if (nRand == 2)
            eEnd = EffectSummonCreature("x0_penguin001", VFX_IMP_POLYMORPH, 0.0f, 1);
    case 23:  // Double polymorph into penguins. Penguin fight! 1d10 Rounds
    `   eEnd = EffectPolymorph(26); //penguin
        oEnd = oPerson;
        oEnd2 = oTarget;
        nInstant = FALSE;
        nDuration = d10(1);
        break;
    case 24:  // All Saves are increased by 10 for 1d8 rounds
        eEnd = EffectSavingThrowIncrease(SAVING_THROW_ALL, 10);
        oEnd = oTarget;
        oEnd2 = oPerson;
        nInstant = FALSE;
        nDuration = d8(1);
        break;
    case 25:  // All Saves are decreased by 10 for 1d8 rounds
        eEnd = EffectSavingThrowDecrease(SAVING_THROW_ALL, 10);
        oEnd = oTarget;
        oEnd2 = oPerson;
        nInstant = FALSE;
        nDuration = d8(1);
        break;

    }
    if (nAreaBool == 0)
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oEnd, RoundsToSeconds(nDuration));
        if (oEnd2 != OBJECT_INVALID)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oEnd2, RoundsToSeconds(nDuration));
        }
        if (eVis != EffectDarkness())
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oEnd, RoundsToSeconds(nDuration));
            if (oEnd2 != OBJECT_INVALID)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oEnd2, RoundsToSeconds(nDuration));
            }
        }
    }
    if (nAreaBool == 1 || nAreaBool == 5)
    //SPELL WITH SHAPE
    {

         oTarget = GetFirstObjectInShape(nShape, fSize, GetLocation(oEnd), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
         while(GetIsObjectValid(oTarget))
        {

     //     March 2003. Removed this as part of the reputation pass
     //            if((GetSpellId() == 340 && !GetIsFriend(oTarget)) || GetSpellId() == 25)
               {
                    //Fire cast spell at event for the specified target
                   SignalEvent(oTarget, EventSpellCastAt(OBJECT_INVALID, SPELL_CONE_OF_COLD));
                   //Get the distance between the target and caster to delay the application of effects
                   fDelay = GetDistanceBetween(oPerson, oTarget)/20.0;
                   //Make SR check, and appropriate saving throw(s).
                   if(!MyResistSpell(oPerson, oTarget, fDelay))
                   {
                       //Detemine damage
                    if(nDtype != -1)
                    {
                        if(nDdie == 6)
                        {
                            nDamage = d6(nDdice);
                        }
                    }

                    int nSuccess = TRUE;
                    if(nSaveType == 1)
                    {
                        if (FortitudeSave(oTarget, nDC, nSavingThrowType) == 0) nSuccess = FALSE;
                    }
                    else if(nSaveType == 2)
                    {
                        if (ReflexSave(oTarget, nDC, nSavingThrowType) == 0) nSuccess = FALSE;
                    }
                    else if(nSaveType == 3)
                    {
                        if (WillSave(oTarget, nDC, nSavingThrowType) == 0) nSuccess = FALSE;
                    }
                    else if(nSaveType == 4)
                    {
                        nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, nSaveType);
                    }

                    // Apply effects to the currently selected target.

                    //Apply delayed effects
                    if (nSuccess == FALSE && nInstant == TRUE && nDtype == -1)
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEnd, oTarget));
                    else if (nSuccess == FALSE && nInstant == FALSE && nDtype == -1)
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oTarget, RoundsToSeconds(nDuration)));
                    if (nDtype != -1)
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage, nDtype), oTarget));
                }

        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(nShape, 11.0, GetLocation(oEnd), TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
    }
    if (nAreaBool == 2)
    //PERSISTENT AREA OF EFFECT
    {
        effect eEndArea = EffectAreaOfEffect(nAOEID, nOnEnter, nHeartBeat, nOnExit);
        if (nInstant == TRUE)
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEndArea, GetLocation(oEnd), RoundsToSeconds(nDuration));
        if (nInstant == FALSE)
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eEndArea, GetLocation(oEnd), RoundsToSeconds(nDuration));
    }
    if (nAreaBool == 3 || nAreaBool == 4)
    //JUST AN EFFECT AT LOCATION
    {
        if (nInstant == TRUE)
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEnd, GetLocation(oEnd));
        if (nInstant == FALSE)
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eEnd, GetLocation(oEnd));
    }
    if (nAreaBool == 4 || nAreaBool == 5)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oEnd));
    }
    return;
}

void ApplyWildMagicGlow(object oPC)
{
    int nRand = d6(1);
    effect eGlow;
    if (nRand == 1)
        eGlow = EffectVisualEffect(VFX_DUR_AURA_BLUE);
    else if (nRand == 2)
        eGlow = EffectVisualEffect(VFX_DUR_AURA_BROWN);
    else if (nRand == 3)
        eGlow = EffectVisualEffect(VFX_DUR_AURA_GREEN);
    else if (nRand == 4)
        eGlow = EffectVisualEffect(VFX_DUR_AURA_MAGENTA);
    else if (nRand == 5)
        eGlow = EffectVisualEffect(VFX_DUR_AURA_ORANGE);
    else if (nRand == 6)
        eGlow = EffectVisualEffect(VFX_DUR_AURA_RED);

    int nDuration = d6(1);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eGlow, oPC, RoundsToSeconds(nDuration));
}