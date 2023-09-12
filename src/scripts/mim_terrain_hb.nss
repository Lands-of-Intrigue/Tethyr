#include "gogs_uw_inc"
#include "x0_i0_enemy"

// This script uses Gogs Underwater Scripts - if you have your own, please replace "ApplyUnderWaterEffects" with your own heartbeat function.

const float MELEE_RANGE = 2.0;

void ApplyTerrainHeartbeat(object oCreature);
void ApplyTerrainHeartbeat (object oCreature)
{
    int iTerrainType = GetLocalInt(oCreature,"InTerrain");
    switch (iTerrainType)
    {
        case 10:  // Under water - clear
         {
            ApplyUnderWaterEffects(oCreature);
         }
         break;
        case 11:  // Under water - murky
         {
            ApplyUnderWaterEffects(oCreature);
         }
         break;
        case 70:   //  Slope - gradual
          {
         // +1 Melee attacks on foes downhill
        object oEnemy = GetNearestEnemy(oCreature);
            if (GetDistanceBetween(oCreature,oEnemy) <= MELEE_RANGE)
            {
                vector vEnemyPos= GetPosition(oEnemy);
                vector vCreaturePos= GetPosition(oCreature);
                if (vEnemyPos.z < vCreaturePos.z)
                {
                   effect eEffect = EffectAttackIncrease(1,ATTACK_BONUS_MISC);
                   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oCreature,6.1);
                }

            }

         }
        break;
        case 71:   //  Slope - steep
          {
         // +1 Melee attacks on foes downhill
        object oEnemy = GetNearestEnemy(oCreature);
            if (GetDistanceBetween(oCreature,oEnemy) <= MELEE_RANGE)
            {
                vector vEnemyPos= GetPosition(oEnemy);
                vector vCreaturePos= GetPosition(oCreature);
                if (vEnemyPos.z < vCreaturePos.z)
                {
                   effect eEffect = EffectAttackIncrease(1,ATTACK_BONUS_MISC);
                   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oCreature,6.1);
                }

            }


         }
        break;
        case 90:   //  Trench / stream bed / ditch
          {
            object oEnemy = GetNearestEnemy(oCreature);
            if (GetDistanceBetween(oCreature,oEnemy) <= MELEE_RANGE)
            {
                effect eEffect = EffectACDecrease(5,AC_DODGE_BONUS,AC_VS_DAMAGE_TYPE_ALL);  // Additional -5 AC against melee, implemented in HB
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oCreature,6.1);
            }
         }
      break;
        case 91:   // low wall
          {
            object oEnemy = GetNearestEnemy(oCreature);
            if (GetDistanceBetween(oCreature,oEnemy) <= MELEE_RANGE)
            {
                effect eEffect = EffectACDecrease(4,AC_DODGE_BONUS,AC_VS_DAMAGE_TYPE_ALL);  // Additional -4 AC against melee, implemented in HB
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oCreature,6.1);
            }
          }
        break;

          case 101:   //  Lava
          {
            object oEnemy = GetNearestEnemy(oCreature);
            if (GetDistanceBetween(oCreature,oEnemy) <= MELEE_RANGE)
            {
                effect eEffect = EffectDamage(d6(2),DAMAGE_TYPE_FIRE,DAMAGE_POWER_NORMAL);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oCreature);
            }
         }
      break;

          case 102:   //  acid
          {
            object oEnemy = GetNearestEnemy(oCreature);
            if (GetDistanceBetween(oCreature,oEnemy) <= MELEE_RANGE)
            {
                effect eEffect = EffectDamage(d6(2),DAMAGE_TYPE_ACID,DAMAGE_POWER_NORMAL);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oCreature);
            }
         }
      break;
    }
return;
}

void main()
{
    object oTrigger = OBJECT_SELF;
    object oArea = GetArea(oTrigger);


    object oCreature = GetFirstObjectInArea(oArea);
    while (GetIsObjectValid(oCreature))
     {
        if (GetObjectType(oCreature) == OBJECT_TYPE_CREATURE)
        {
            if (GetIsInSubArea(oCreature,oTrigger) == TRUE)
            {
                ApplyTerrainHeartbeat(oCreature);
            }
        }
        oCreature = GetNextObjectInArea(oArea);
     }
}

