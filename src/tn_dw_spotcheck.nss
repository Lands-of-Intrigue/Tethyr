void main()
{
    object oPC = GetEnteringObject();
    int nRoll = d20();
    if (GetSkillRank(SKILL_SPOT, oPC, FALSE) + nRoll >= 18)
    {
        FloatingTextStringOnCreature("You notice a faint green glint coming from the fireplace!", oPC, FALSE);
    }
}
