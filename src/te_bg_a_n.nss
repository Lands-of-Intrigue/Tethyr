#include "nwnx_creature"

void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",7);

    ActionStartConversation(oPC, "bg_disfig", TRUE);
}
