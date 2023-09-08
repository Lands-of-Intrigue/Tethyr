//:://////////////////////////////////////////////////
//:: Tethyr's Warlock Eldritch Blast Evocation
//:: Acid edition
//:: TE_EB_ACID
//:: Copyright (c) 2015 Function(D20)
//:///////////////////////////////////////////////////

/*
   Warlock uses eldritch blast feat to attack player
   Rolls ranged touch attack to see if hit.
   Attack does 1d6 damage per character level
*/
//:///////////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: October 17, 2015
//:///////////////////////////////////////////////////

void main()
{
   //Declare Major Variables
   object oPC = OBJECT_SELF;
   effect eFF = EffectAbilityIncrease(ABILITY_STRENGTH, 4);

   ApplyEffectToObject(DURATION_TYPE_INSTANT, eFF, oPC, 0.0);
}
