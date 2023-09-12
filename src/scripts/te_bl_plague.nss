//::///////////////////////////////////////////////
//:: Plague
//:: TE_SC_Plague
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a zone of destruction around the caster
    within which all living creatures are pummeled
    with fire and divine damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 11, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 21, 2001

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

    //Declare major variables
    int nCL = GetLevelByClass(CLASS_TYPE_BLIGHTER, OBJECT_SELF);

    effect eVis = EffectVisualEffect(VFX_IMP_DISEASE_S);
    effect eFireStorm = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    float fDelay;
    int nRand;
    int nDisease;
    int i;

    //Apply Fire and Forget Visual in the area;
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm, GetLocation(OBJECT_SELF));
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while(GetIsObjectValid(oTarget))
    {
        if (spellsIsTarget(oTarget, SPELL_TARGET_ALLALLIES, OBJECT_SELF) && oTarget != OBJECT_SELF)
        {
            fDelay = GetRandomDelay(1.5, 2.5);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIRE_STORM));
            //Make SR check, and appropriate saving throw(s).
            if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
            {
                for (i = 1; i < 3; i++)
                    {
                        int nRand = Random(7)+1;
                        switch (nRand)
                        {
                            case 1:
                                nDisease = DISEASE_BLINDING_SICKNESS;
                            break;
                            case 2:
                                nDisease = DISEASE_CACKLE_FEVER;
                            break;
                            case 3:
                                nDisease = DISEASE_FILTH_FEVER;
                            break;
                            case 4:
                                nDisease = DISEASE_MINDFIRE;
                            break;
                            case 5:
                                nDisease = DISEASE_RED_ACHE;
                            break;
                            case 6:
                                nDisease = DISEASE_SHAKES;
                            break;
                            case 7:
                                nDisease = DISEASE_SLIMY_DOOM;
                            break;
                        }

                    effect eDisease = EffectDisease(nDisease);
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDisease, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
            }
        }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE);
    }
}
