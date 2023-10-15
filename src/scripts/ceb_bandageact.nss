#include "x2_inc_switches"
#include "nwnx_item"
#include "nwnx_creature"
#include "loi_mythicxp"

void bandage(object oPC , object oTarget)
{
     int roll = d20(1);
     int check = roll+GetSkillRank(SKILL_HEAL, oPC, FALSE);
     int nMod = 0;
     int checkDC = 15;
     if (GetHasFeat(1480, oPC) == TRUE)//Anatomy Proficiency
     {
        SendMessageToPC(oPC, "You are especially adept at applying bandages due to your proficiency with anatomy.");
        nMod = 2;
        checkDC = 13;
     }
     SendMessageToPC(oPC, (IntToString(roll) + "+" + IntToString(GetSkillRank(SKILL_HEAL, oPC, FALSE)) + "=" + IntToString(check) + " vs. DC " +IntToString(checkDC)));
     if (check >= checkDC)
     {
          ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(d4(1)+GetAbilityModifier(ABILITY_WISDOM, oPC)+(GetSkillRank(SKILL_HEAL, oPC, FALSE)/2+nMod)), oTarget);
          SendMessageToPC(oPC, "The bandages stop the bleeding.");
          if (oPC != oTarget)
          {
               SendMessageToPC(oTarget, "The bandages stop the bleeding.");
          }
          TickMythicXp(oPC, ABILITY_WISDOM, 2);
     }
     else
     {
          SendMessageToPC(oPC, "Your healing attempt has failed, the bandages are ruined");
          if (oPC != oTarget)
          {
               SendMessageToPC(oTarget, "The healing attempt has failed.");
          }
     }
}

void main()
{
     object oPC = GetItemActivator();
     object oTarget = GetItemActivatedTarget();

     if (GetUserDefinedItemEventNumber() !=  X2_ITEM_EVENT_ACTIVATE) return;

     if(GetIsReactionTypeHostile(oTarget,oPC) == TRUE)
     {
        SendMessageToPC(oPC,"You cannot bandage a hostile creature!");
        SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
        return;
     }

     if (GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
     {
          SendMessageToPC(oPC, "Bandaging this object would have no effect.");
          SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
          return;
     }
     if (GetRacialType(oTarget) == RACIAL_TYPE_OOZE)
     {
          SendMessageToPC(oPC, "Bandaging a creature of this type would have no effect.");
          SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
          return;
     }
     if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
     {
          SendMessageToPC(oPC, "Bandaging a creature of this type would have no effect.");
          SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
          return;
     }
     if (GetRacialType(oTarget) == RACIAL_TYPE_CONSTRUCT)
     {
          SendMessageToPC(oPC, "Bandaging a creature of this type would have no effect.");
          SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
          return;
     }
     if (GetRacialType(oTarget) == RACIAL_TYPE_ELEMENTAL)
     {
          SendMessageToPC(oPC, "Bandaging a creature of this type would have no effect.");
          SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
          return;
     }
     if (GetIsInCombat(oPC) == TRUE)
     {
          SendMessageToPC(oPC, "You cannot perform this action while you are in combat.");
          SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
          return;
     }
     if (GetIsInCombat(oTarget) == TRUE)
     {
          SendMessageToPC(oPC, "You cannot perform this action while the target is in combat.");
          return;
     }
     if (GetCurrentHitPoints(oTarget) >= 1)
     {
          object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oTarget);
          int nBaseAC = NWNX_Item_GetBaseArmorClass(oArmor);
          int nMaterial = GetLocalInt(oArmor, "Material");
          int nArmorCatagory = 0;

        if(nBaseAC > 0 && nBaseAC < 4)
          {
            nArmorCatagory = 1;
          }
          else if(nBaseAC > 3 && nBaseAC < 6)
          {
               nArmorCatagory = 2;
          }
          else if(nBaseAC > 5)
          {
               nArmorCatagory = 3;
          }

          if(nMaterial == 3)
          {
               nArmorCatagory = nArmorCatagory - 1;
          }

          if(nArmorCatagory > 1)
          {
               SendMessageToPC(oPC, "Please ask the patient to remove their armor.");
               return;
          }
     }
     DestroyObject(GetItemActivated());
     AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 15.0f));
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oPC, 15.0f);
     if (oPC != oTarget)
     {
        AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0f, 15.0f));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectEntangle(), oTarget, 15.0f);
     }
     DelayCommand (15.0f, bandage(oPC, oTarget));
}
