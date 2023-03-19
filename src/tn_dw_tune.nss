#include "nw_j_assassin"
void main()
{
    object oPC = GetPCSpeaker();
    object oHarp = GetNearestObjectByTag("tn_harpplc");
    int nRoll = d20();
    nRoll = nRoll;
    if (GetSkillRank(SKILL_PERFORM, oPC, FALSE) + nRoll >= 18)
    {
        aSetPLocalInt(oPC, "Tuned", 1);
        FloatingTextStringOnCreature("You skillfully tune the harp!", oPC, TRUE);
    }
    else
    {
        switch (d4())
        {
            case 1: FloatingTextStringOnCreature("You fiddle with the pegs on the harp until the strings tighten.", oPC, TRUE);
            break;
            case 2: FloatingTextStringOnCreature("You tighten the strings of the harp.", oPC, TRUE);
            break;
            case 3: FloatingTextStringOnCreature("You mess with the string tuning devices of the harp.", oPC, TRUE);
            break;
            case 4: FloatingTextStringOnCreature("You fail to tune the harp.", oPC, TRUE);
            break;
        }
        aSetPLocalInt(oPC, "Tuned", 0);
    }
}
