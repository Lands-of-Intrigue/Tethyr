//Function: Pickup Script // Date: 23MAR16
//Creator: Jonathan Lorentsen // Email: jlorents93@hotmail.com
//Instructions: Ensure Item (TAG) & Placeable (Blueprint Resref) is same
//Place Script inside Conversation to be called from

void main()
{
object oPC = GetPCSpeaker(); //Get PC Speaker
object oItem = GetItemPossessedBy(oPC, "PC_Data_Object"); //Fetch PC Data Item
object oTarget = GetLocalObject(oItem, "oPick"); //Get Temp Var
AssignCommand(oPC, ActionSit(oTarget)); //Sit
DeleteLocalObject(oItem, "oPick"); //Delete Temp Var
}
