//::///////////////////////////////////////////////
//:: Name: mim_terrain_ent
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    OnEnter script for terrain types.

    Creates terrain bonuses and penalties as per d20

    Only terrains not adequately modelled by traps (like boiling water and lava)
    and not adequately modelled by OldManWhistler's PHB Skills were implemented.

*/
//:://////////////////////////////////////////////
//:: Created By: Belisarius
//:: Created On: October 11th, 2012
//:://////////////////////////////////////////////

/* Terrain Types
0   Open
10  Under water, clear
11  Under water, murky
20  Undergrowth - light Half movement, concealment 20%. -2 Tumble and Move Silently
21  Undergrowth - heavy Quarter movement, Concealment 30%. -5 Tumble and Move Silently. +5 Hide
30  Ice sheet       Half movement, -5 Balance and Tumble
40  Rubble - light      Balance and Tumble -2
41  Rubble - dense      Half movement, -5 Balance and Tumble, -2 Move Silently
50  Scree - gradual     -2 Balance, Tumble and Move Silently
51  Scree - steep       -5 Balance, Tumble and -2 Move Silently
60  Trees           +2 AC, +1 Reflex
61  Trees - massive     +4 AC, +2 Reflex
70  Slope - gradual     +1 Melee vs foes downhill
71  Slope - steep       Half movement, -2 Tumble, +1 Melee vs foes downhill
80  Bog - shallow       Half movement, -2 Tumble, -2 Move Silently
81  Bog - deep      Quarter movment, +4 AC, +2 Reflex, -2 Move Silently
90  Trench / streambed  Half movement, +4 AC ranged, -1 AC melee
91  Low wall        +4 AC ranged, +2 Reflex

Custom terrains
100 Road            +20% movement, -10 Hide
101 Lava     Half movement, 2D6 fire damage per round
102 Acid     Half movement, 2D6 acid damage per round


Feel free to add your own terrain types.
Books such as Frostburn, Sandstorm and Stormwrack have many.
*/

const int DEBUG = FALSE;

void main()
{

    object oCreature = GetExitingObject();

    if (GetIsObjectValid(oCreature)) // A creature leaving a terrain has triggered this script
    {
        object oTrigger = OBJECT_SELF;

        effect eEffect = GetFirstEffect(oCreature);
        while (GetIsEffectValid(eEffect))
         {
           if (GetEffectCreator(eEffect) == oTrigger)
            {
               RemoveEffect(oCreature, eEffect);
               if(DEBUG) PrintString("Terrain effect removed");
            }
           eEffect = GetNextEffect(oCreature);
        }

        // Remove any terrain variables
        SetLocalInt(oCreature, "In_Water_Source", FALSE);
        SetLocalInt(oCreature, "InTerrain", 0);
    }
    else
    {
        oCreature = GetEnteringObject();
        object oTrigger = OBJECT_SELF;
        int iTerrainType = GetLocalInt(oTrigger,"TerrainType");

        SetLocalInt(oCreature,"InTerrain",iTerrainType);
        switch (iTerrainType)
         {
            case 10:  // Under water
             {
                SetLocalInt (oCreature, "In_Water_Source", TRUE);
                // Drowning effects in heartbeat script
             }
             break;

            case 20:   //Undergrowth - light
              {
                effect eEffect = SupernaturalEffect(EffectMovementSpeedIncrease(-50));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                 eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_TUMBLE,2));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_MOVE_SILENTLY,2));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectConcealment(20));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             }
            break;
            case 21:   //Undergrowth - heavy
              {
                effect eEffect = SupernaturalEffect(EffectMovementSpeedIncrease(-75));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                 eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_TUMBLE,5));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_MOVE_SILENTLY,5));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSkillIncrease(SKILL_HIDE,10));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectConcealment(30));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             }
            break;
            case 30:   //  Ice sheet
              {
                effect eEffect = SupernaturalEffect(EffectMovementSpeedIncrease(-50));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                 eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_TUMBLE,5));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             }
            break;
            case 40:   // Rubble - lightt
              {
                effect eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_TUMBLE,2));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             }
            break;
            case 41:   // Rubble -dense
              {
                effect eEffect = SupernaturalEffect(EffectMovementSpeedIncrease(-50));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_TUMBLE,5));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_MOVE_SILENTLY,2));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             }
            break;
            case 50:   //scree -gradual slope
              {
                effect eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_TUMBLE,2));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_MOVE_SILENTLY,2));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             }
            break;
            case 51:   //scree -  steep slope
              {
                effect eEffect = SupernaturalEffect(EffectMovementSpeedIncrease(-50));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_TUMBLE,5));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_MOVE_SILENTLY,2));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             }
            break;
            case 60:   //  Trees
              {
                effect eEffect = EffectACIncrease(2);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSavingThrowIncrease(SAVING_THROW_REFLEX,1));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             }
            break;
            case 61:   //  Tree - massive
              {
                effect eEffect = EffectACIncrease(4);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSavingThrowIncrease(SAVING_THROW_REFLEX,2));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             }
            break;
            case 70:   //  Slope - gradual
              {
             // +1 Melee attacks on foes downhill - see Heartbeat
             }
            break;
            case 71:   // Slope  -  steepe
              {
                effect eEffect = SupernaturalEffect(EffectMovementSpeedDecrease(50));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_TUMBLE,5));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             // +1 Melee attacks on foes downhill - - see Heartbeat
             }
            break;
            case 80:   // Bog - shallow
              {
                effect eEffect = SupernaturalEffect(EffectMovementSpeedDecrease(50));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_TUMBLE,2));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_MOVE_SILENTLY,2));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                SetLocalInt (oCreature, "In_Water_Source", TRUE);
                SetLocalInt(GetItemPossessedBy(oCreature,"PC_Data_Object"),"nMud",GetLocalInt(GetItemPossessedBy(oCreature,"PC_Data_Object"),"nMud")+15);

             }
            break;
            case 81:   // Bog -deep
              {
                effect eEffect = SupernaturalEffect(EffectMovementSpeedDecrease(75));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_TUMBLE,(20+GetSkillRank(SKILL_TUMBLE,oCreature,FALSE))));  // set Tumble to -20, which is close to being unuseable as per rules
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_MOVE_SILENTLY,2));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                SetLocalInt (oCreature, "In_Water_Source", TRUE);
                SetLocalInt(GetItemPossessedBy(oCreature,"PC_Data_Object"),"nMud",GetLocalInt(GetItemPossessedBy(oCreature,"PC_Data_Object"),"nMud")+35);
             }
            break;

            case 90:   //  Trench / stream bed / ditch
              {
                effect eEffect = SupernaturalEffect(EffectMovementSpeedIncrease(-50));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = EffectACIncrease(2,AC_DODGE_BONUS,AC_VS_DAMAGE_TYPE_ALL);  // Additional -5 AC against melee, implemented in HB
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             }
          break;
            case 91:   // low wall
              {
                effect eEffect = EffectACIncrease(4,AC_DODGE_BONUS,AC_VS_DAMAGE_TYPE_ALL);  // Additional -4 AC against melee, implemented in HB
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSavingThrowIncrease(SAVING_THROW_REFLEX,2));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             }
            break;


            case 100:   // Road
              {
                effect eEffect = SupernaturalEffect(EffectMovementSpeedIncrease(20));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
                eEffect = SupernaturalEffect(EffectSkillDecrease(SKILL_HIDE,10));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             }
             break;

            case 101:   // lava
              {
                effect eEffect = SupernaturalEffect(EffectMovementSpeedDecrease(50));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             }
             break;

            case 102:   // acid
              {
                effect eEffect = SupernaturalEffect(EffectMovementSpeedDecrease(50));
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oCreature);
             }
             break;
         }
    }
}
