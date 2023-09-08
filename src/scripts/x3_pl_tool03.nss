//::///////////////////////////////////////////////
//:: TE_save
//:: TE_save.nss
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Modified On: April 13, 2016
//:://////////////////////////////////////////////
void main()
{
    object oPC = OBJECT_SELF;
    object oItem = GetItemPossessedBy(oPC, "PC_Data_Object");

        //Update information.
        SetLocalLocation(oItem, "lPCLoc", GetLocation(oPC));
        SetLocalInt(oItem,"iPCXP",GetXP(oPC));
        SetLocalInt(oItem, "iPCGP",GetGold(oPC));
        SetLocalInt(oItem,"iPCMAXGP",GetGold(oPC));
        ExportSingleCharacter(oPC);
        SendMessageToPC(oPC, "Your PC Data has been saved.");
}
