void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"BG_Select",5);
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Prof",3);
    ActionStartConversation(oPC,"bg_proficiency",TRUE);
}

