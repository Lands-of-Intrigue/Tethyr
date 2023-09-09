void main()
{
object oPC = GetPCSpeaker();
if (GetLocalInt(oPC, "RESEARCH_TIMER") == 0){
    if (GetSkillRank(SKILL_SPELLCRAFT, oPC) + d20(1) >= 20)
        {
        GiveXPToCreature(oPC,300);
        SendMessageToPC(oPC, "Your research is Successful! You must wait 24 hours to research again.");
        }
    else
        {
        SendMessageToPC(oPC, "Your research is Unseccessful! You must wait 24 hours to research again.");
        }
    SetLocalInt(oPC, "RESEARCH_TIMER", 1);
    DelayCommand(43200.0, DeleteLocalInt(oPC,"RESEARCH_TIMER" ));
}
else
{
    SendMessageToPC(oPC, "You are unable to resaerch right now.");
}
}
