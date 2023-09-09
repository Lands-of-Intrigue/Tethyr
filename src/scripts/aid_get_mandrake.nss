//::///////////////////////////////////////////////
//:: aid_get_mandrake
//:://////////////////////////////////////////////
/*
    script for taking mandrake in aid system
    the mandrake screams and can thus kill those nearby
*/
//:://////////////////////////////////////////////
//:: Created: The Magus (2012 jul 13)
//:: Modified:
//:://////////////////////////////////////////////

#include "aid_inc_fcns"
#include "X0_I0_SPELLS"

void MoveToMandrake(object oMandrake);
void TakeMandrake(object oMandrake);
void DoScream();

void MoveToMandrake(object oMandrake)
{
    ClearAllActions();
    ActionMoveToObject(oMandrake, TRUE);
    ActionDoCommand(TakeMandrake(oMandrake));
}

void TakeMandrake(object oMandrake)
{

    DoManipulate(OBJECT_SELF, oMandrake, ANIMATION_LOOPING_GET_LOW, 3.0);

    FloatingTextStringOnCreature(LIME+GetName(OBJECT_SELF)+" pulls the "+GREEN+GetName(oMandrake)+LIME+" from the earth.", OBJECT_SELF);
    object oItem    = CreateItemOnObject("mandrake", OBJECT_SELF);
    SetIdentified(oItem,TRUE);

    float fDelay = 0.1;
    if(!GetHasEffect(EFFECT_TYPE_SILENCE, oMandrake)&&!GetHasEffect(EFFECT_TYPE_SILENCE))
    {
        fDelay  += 4.1;
        AssignCommand(oMandrake, DoScream());
    }

    DeleteLocalString(oMandrake, "examine");
    DeleteLocalString(oMandrake, "onTake");

    DestroyObject(oMandrake, fDelay);
}

void DoScream()
{
    location lLoc   = GetLocation(OBJECT_SELF);
    SpeakString("*Screams!*");

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES), lLoc);
    float fDelay;
    effect eDeath   = EffectDeath();
    effect eVis     = EffectVisualEffect(VFX_IMP_DEATH);
    object oTarget  = GetFirstObjectInShape(SHAPE_SPHERE, 15.0, lLoc);
    int nRace;
    while(GetIsObjectValid(oTarget))
    {
        nRace   = GetRacialType(oTarget);
        if(     !GetHasEffect(EFFECT_TYPE_DEAF, oTarget)
            &&  !GetHasEffect(EFFECT_TYPE_SILENCE, oTarget)
            &&  nRace!=RACIAL_TYPE_FEY
            &&  nRace!=RACIAL_TYPE_HUMANOID_GOBLINOID
          )
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_WAIL_OF_THE_BANSHEE));
            if(!MySavingThrow(SAVING_THROW_FORT, oTarget, 12, SAVING_THROW_TYPE_DEATH))//fort save to avoid death
            {
                fDelay = GetRandomDelay(2.5, 3.5);
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oTarget));
            }
        }
        oTarget  = GetNextObjectInShape(SHAPE_SPHERE, 15.0, lLoc);
    }
}

void main()
{
    object oMandrake= OBJECT_SELF;
    object oPC      = GetLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT);
    DeleteLocalObject(OBJECT_SELF, AID_TRIGGERING_OBJECT); // Garbage collection
    AssignCommand(oPC, MoveToMandrake(oMandrake));
}
