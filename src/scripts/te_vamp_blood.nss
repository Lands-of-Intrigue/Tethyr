#include "te_functions"
#include "loi_functions"
#include "te_afflic_func"
#include "loi_xp"

void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    int nBABP = GetBaseAttackBonus(oPC);
    int nBABT = GetBaseAttackBonus(oTarget);
    int nSTRP = GetAbilityModifier(ABILITY_STRENGTH,oPC);
    int nSTRT = GetAbilityModifier(ABILITY_STRENGTH,oTarget);
    float fDelay;
    int nGrappleP = nBABP+nSTRP;
    int nGrappleT = nBABT+nSTRT;

    int nDC = (10+GetAbilityModifier(ABILITY_CHARISMA,oPC)+(GetHitDice(oPC)/2));

    int nDrain = d4(1);
    string sFeedback = STRING_COLOR_BLUE;

    int iNow = (GetCalendarYear()*10000)+(GetCalendarMonth()*100) + GetCalendarDay();

    if (GetPCAffliction(oPC) == 8)
    {
        SendMessageToPC(oPC,"<c#ßþ>You move towards your victim and feel your misty tendrils expand out in search of blood...</c>");
        effect eVis = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
        effect eFireStorm = EffectVisualEffect(VFX_IMP_HARM);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFireStorm, GetLocation(OBJECT_SELF));
        //Declare the spell shape, size and the location.  Capture the first target object in the shape.
        object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
        //Cycle through the targets within the spell shape until an invalid object is captured.
        while(GetIsObjectValid(oTarget))
        {
            //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIRE_STORM));
            if(!GetIsReactionTypeHostile(oTarget,oPC) == TRUE)
            {

            }
            else
            {
                //Make SR check, and appropriate saving throw(s).
                if(ReflexSave(oTarget,nDC,SAVING_THROW_TYPE_NEGATIVE,oPC) == 0)
                {
                      if    (GetRacialType(oTarget) == RACIAL_TYPE_OUTSIDER            ||
                             GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT           ||
                             GetRacialType(oTarget) == RACIAL_TYPE_ELEMENTAL           ||
                             GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_GOBLINOID  ||
                             GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_MONSTROUS  ||
                             GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_REPTILIAN  ||
                             GetRacialType(oTarget) == RACIAL_TYPE_OOZE)
                      {

                      }
                      else
                      {
                          if(GetLocalInt(GetItemInSlot(INVENTORY_SLOT_NECK,oTarget),"NeckProtect")> 0)
                          {
                              //Roll Damage
                              int nDamage = d10(3);
                              effect eFire = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oTarget));
                              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                              DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectTemporaryHitpoints(nDamage),oPC,TurnsToSeconds(6)));
                              if(GetIsPC(oTarget) == TRUE)
                              {
                                SetLocalInt(oItem,"Blood",GetLocalInt(oItem,"Blood")+nDamage);
                              }
                              SendMessageToPC(oPC,"You find "+GetName(oTarget)+"'s <cþ  >blood</c>...");
                              nDamage = 0;
                          }
                      }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, GetLocation(OBJECT_SELF), OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
        }

    }
    else
    {
        if(!GetIsReactionTypeHostile(oTarget,oPC) == TRUE)
        {
            SendMessageToPC(oPC,"This ability can only be used on hostile creatures.");
            return;
        }
            int nTouch = TouchAttackMelee(oTarget,TRUE);
            ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM10, 1.0, 2.0);
            AssignCommand(oTarget, PlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 2.0));
            if (nTouch > 0)
            {
                sFeedback += "You take hold of your victim...\n";
                SendMessageToPC(oTarget,GetName(oPC)+" tries to take hold of you!");
                if(nGrappleP > nGrappleT)
                {
                    sFeedback += "And wrap your arms around them, sinking your teeth into their body...\n";
                    if(GetIsUndead(oTarget) == TRUE)
                    {
                         sFeedback += "And find naught but<cððð> dust</c>...";
                    }
                    else if (GetRacialType(oTarget) == RACIAL_TYPE_OUTSIDER            ||
                             GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT           ||
                             GetRacialType(oTarget) == RACIAL_TYPE_ELEMENTAL           ||
                             GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_GOBLINOID  ||
                             GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_MONSTROUS  ||
                             GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_REPTILIAN  ||
                             GetRacialType(oTarget) == RACIAL_TYPE_OOZE)
                    {
                         sFeedback += "And find poison!";
                    }
                    else
                    {
                         sFeedback += "And find your hunger satiated by the sickeningly sweet taste of <cþ  >blood</c>...";
                         SendMessageToPC(oTarget,"And succeeds in puncturing your neck!");

                            if(FortitudeSave(oTarget,nDC,SAVING_THROW_TYPE_NEGATIVE,oPC) == 0)
                            {
                                effect eDrain = SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,nDrain));
                                ApplyEffectToObject(DURATION_TYPE_PERMANENT,eDrain,oTarget);
                                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectTemporaryHitpoints(5),oPC,TurnsToSeconds(6));

                                 if ((GetLocalInt(oItem,"nBloodUse") < iNow)&&GetIsPC(oTarget)==TRUE)
                                 {
                                    SetLocalInt(oItem,"nBloodUse",iNow);
                                    AwardXP(oPC,500);
                                 }
                            }
                            else
                            {
                                 sFeedback += "\nBut only momentarily...";
                            }

                    }
                }
                else
                {
                    sFeedback += "Who shrugs off your hold and thrusts you away.";
                    SendMessageToPC(oTarget,"You successfully push them away!");
                }

            }
            else
            {
                sFeedback +="<c#ßþ>You fail to take hold of your victim...</c>";
                SendMessageToPC(oTarget,GetName(oPC)+" tried to lunge at you!");
            }

            SendMessageToPC(oPC,sFeedback);
    }
}
