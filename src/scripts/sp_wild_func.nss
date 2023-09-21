#include "X0_I0_SPELLS"
#include "te_functions"

void WildMagicEffects(object oPerson, object oTarget);
void ApplyWildMagicGlow(object oPC);

void WildMagicEffects(object oPerson, object oTarget)
{
    ApplyWildMagicGlow(oPerson);

    // generate a random number from 1 to 25
    int nTable = 1 + d100(1) % 25;

    // int nRand;
    switch(nTable) {
    case 1:  // Mini quake of staggered knockdowns from caster
        {
            location lPerson = GetLocation(oPerson);
            effect eExplode = EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY);
            effect eVis = EffectVisualEffect(VFX_IMP_HEAD_NATURE);
            effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
            effect eTrip = EffectKnockdown();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eShake, oPerson, RoundsToSeconds(d3()));
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, GetLocation(oPerson));

            object oAffected = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lPerson, TRUE, OBJECT_TYPE_CREATURE);
            while (GetIsObjectValid(oAffected))
            {
                float fDelay = GetDistanceBetweenLocations(lPerson, GetLocation(oAffected))/20;
                // * DO a strength check vs. Strength 20
                if (d20() + GetAbilityScore(oAffected, ABILITY_STRENGTH) <= 20 + d20() )
                {
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTrip, oAffected, 6.0));
                    //This visual effect is applied to the target object not the location as above.  This visual effect
                    //represents the flame that erupts on the target not on the ground.
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oAffected));
                }
                oAffected = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lPerson, TRUE, OBJECT_TYPE_CREATURE);
            }
            SendMessageToPC(oPerson, "Wild Magic explodes from you with concussive force.");
        }
        break;
    case 2: //Pixie Dust Visual Effect, 3d10 + 10 Rounds
        {
            int nDuration = d10(3) + 10;
            effect eEnd = EffectVisualEffect(VFX_DUR_PIXIEDUST);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oPerson, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic adds glittering to your spell.");
        }
        break;
    case 3:  // Caster Gets 30/+5 DR for 1d4 rounds
        {
            int nDuration = d4(1);
            effect eEnd = EffectDamageReduction(30, 5);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oPerson, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic enhaces you with temporary damage resistence.");
        }
        break;
    case 4:  // Invisibility for 1d6 rounds
        {
            int nDuration = d6(1);
            effect eEnd = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oPerson, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic shrouds you from mundane sight.");
        }
        break;
    case 5:  // Polymorph self (penguin)
        {
            int nDuration = d4(1);
            effect eEnd = EffectPolymorph(26); // 26 == Penguin;
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oPerson, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic polymorphs you.");
        }
        break;
    case 6:  // Character gets +1d6 of a random damage type for 1d10 rounds.
        {
            int nDuration = d10(1);
            int nRand = d10(1);
            int nDtype;
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
            effect eEnd = EffectDamageIncrease(d10(1), nDtype);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oPerson, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic enchances your weapons with increased effect.");
        }
        break;
    case 7:  // Caster loses 1d2 of a random stat for 1d6 rounds
        {
            int nDuration = d6(1);
            int nRand = d6(1);
            effect eEnd;
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
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oPerson, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic boosts an ability.");
        }
        break;
    case 8:  // Caster gains 1d2 of a random stat for 1d6 rounds
        {
            int nDuration = d6(1);
            int nRand = d6(1);
            effect eEnd;
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
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oPerson, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic hinders an ability.");
        }
        break;
    case 9:  // Target gets +1d4 Strength for 1d6 rounds
        {
            int nDuration = d6(1);
            effect eEnd = EffectAbilityIncrease(0, d4(1)); //STR
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oTarget, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic strengthens your target.");
        }
        break;
    case 10:  // Both caster and target fall asleep for 1d6 rounds
        {
            int nDuration = d6(1);
            effect eEnd = EffectSleep();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oPerson, RoundsToSeconds(nDuration));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oTarget, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic lulls you and your target to sleep.");
        }
        break;
    case 11:  // Darkness Cast on Target (1d6 rounds)
        {
            int nDuration = d6(1);
            effect eEndArea = EffectAreaOfEffect(AOE_PER_DARKNESS, "", "", "");
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEndArea, GetLocation(oTarget), RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic covers your target in darkness.");
        }
        break;
    case 12:  // Target gets 25% Concealment for 1d4 Rounds
        {
            effect eEnd = EffectConcealment(25);
            int nDuration = d4(1);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oTarget, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic conceals your target.");
        }
        break;
    case 13:  // Fake Visuals for FireBall are produced
        {
            effect eEnd = EffectVisualEffect(VFX_FNF_FIREBALL);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEnd, GetLocation(oTarget));
            SendMessageToPC(oPerson, "Wild Magic surges in illusionary flame.");
        }
        break;
    case 14:  // Fireball at level 10
        {
            effect eEnd = EffectVisualEffect(VFX_FNF_FIREBALL);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEnd, GetLocation(oTarget));
            object oAffected = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(oTarget), TRUE, 
                OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
            while (GetIsObjectValid(oAffected))
            {
                int nDamage = GetReflexAdjustedDamage(d6(10), oAffected, 15, SAVING_THROW_TYPE_FIRE);
                effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oAffected);

                oAffected = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, GetLocation(oTarget), TRUE, 
                    OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
            }
            SendMessageToPC(oPerson, "Wild Magic surges in uncontrollable flame.");
        }
        break;
    case 15:  // Flesh to Stone: If the target is petrified, Stone to Flesh is cast, otherwise, Flesh to Stone is cast (lvl 11) duration 10 rounds
        if (GetHasEffect(79 /*petrified*/, oTarget))
        {
            RemoveEffectsByType(oTarget, EFFECT_TYPE_PETRIFY);
            SendMessageToPC(oPerson, "Wild Magic turns your target's stone into flesh.");
        }
        else if(FortitudeSave(oTarget, 21, SAVING_THROW_FORT) == FALSE && GetSpellResistance(oTarget) < 21)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectPetrify(), oTarget, RoundsToSeconds(10));
            SendMessageToPC(oPerson, "Wild Magic turns your target's flesh into stone.");
        }
        else
        {
            SendMessageToPC(oPerson, "Wild Magic attempts to turn your target's flesh into stone.");
        } 
        break;
    case 16:  // Grass Growth (entanglement for 1d6 rounds)
        {
            effect eEnd = EffectEntangle();
            int nDuration = d6(1);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oTarget, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic entangles your target.");
        }
        break;
    case 17:  // Target becomes invisible for 1d6 rounds
        {
            effect eEnd = EffectInvisibility(1);
            int nDuration = d6(1);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oTarget, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic conceals your target from view.");
        }
        break;
    case 18:  // Lightning Bolt: Ranged touch attack, 6d6 Electrical, reflex for half. DC 15.
        {
            int nDamage = GetReflexAdjustedDamage(d6(6), oTarget, 15, SAVING_THROW_TYPE_ELECTRICITY);
            effect eEnd = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eEnd, oTarget);
            SendMessageToPC(oPerson, "Wild Magic strikes your target with lightning.");
        }
        break;
    case 19:  // Polymorph target: Targer polymorphed into chicken for 1d6 rounds
        {
            effect eEnd = EffectPolymorph(40);
            int nDuration = d6(1);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oTarget, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic polymorphs your target.");
        }
        break;
    case 20:  // Target is Slowed for 10 rounds
        {
            effect eEnd = EffectSlow();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oTarget, RoundsToSeconds(10));
            SendMessageToPC(oPerson, "Wild Magic slows your target.");
        }
        break;
    case 21:  // Target is Hasted for 1d6 rounds
        {
            int nDuration = d6(1);
            effect eEnd = EffectHaste();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oTarget, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic makes time move faster for your target.");
        }
        break;
    case 22:  // Summon, Rat/Cow/Penguin, 10 Rounds
        {
            int nRand = (d6(1)-1)/2;
            effect eEnd;
            if (nRand == 0)
                eEnd = EffectSummonCreature("nw_rat001", VFX_IMP_POLYMORPH, 0.0f, 1);
            else if (nRand == 1)
                eEnd = EffectSummonCreature("nw_cow", VFX_IMP_POLYMORPH, 0.0f, 1);
            else if (nRand == 2)
                eEnd = EffectSummonCreature("x0_penguin001", VFX_IMP_POLYMORPH, 0.0f, 1);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEnd, GetLocation(oTarget));
            SendMessageToPC(oPerson, "Wild Magic summons an animal.");
        }
    case 23:  // Double polymorph into penguins. Penguin fight! 1d10 Rounds
        {
            effect eEnd = EffectPolymorph(26); //penguin
            int nDuration = d10(1);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oPerson, RoundsToSeconds(nDuration));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oTarget, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic polymorphs you and your target.");
        }
        break;
    case 24:  // All Saves are increased by 10 for 1d8 rounds
        {
            effect eEnd = EffectSavingThrowIncrease(SAVING_THROW_ALL, 10);
            int nDuration = d8(1);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oPerson, RoundsToSeconds(nDuration));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oTarget, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic greatly increases the saves of you and your target.");
        }
        break;
    case 25:  // All Saves are decreased by 10 for 1d8 rounds
        {
            effect eEnd = EffectSavingThrowDecrease(SAVING_THROW_ALL, 10);
            int nDuration = d8(1);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oPerson, RoundsToSeconds(nDuration));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEnd, oTarget, RoundsToSeconds(nDuration));
            SendMessageToPC(oPerson, "Wild Magic greatly reduces the saves of you and your target.");
        }
        break;

    }
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