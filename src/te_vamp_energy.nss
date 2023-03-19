void main()
{
    object oPC = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();

    int nBABP = GetBaseAttackBonus(oPC);
    int nBABT = GetBaseAttackBonus(oTarget);
    int nSTRP = GetAbilityModifier(ABILITY_STRENGTH,oPC);
    int nSTRT = GetAbilityModifier(ABILITY_STRENGTH,oTarget);

   //D6 plus strength bludge.
   //2 Negative Levels
   //Save: DC 10 + 1/2 HD + CHA Mod.



}
