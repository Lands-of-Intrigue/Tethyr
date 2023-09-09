//Function: Start Normal Pickup Conversation // Date: 23MAR16
//Creator: Jonathan Lorentsen // Email: jlorents93@hotmail.com
//Instructions: Add script to placeable's OnUsed
//For Placeables with no intended use (don't use Signs/Anvils/Ect)
//Instead modify and save as new for special Placeables if intended for pickup

void main()
{
object oPC = GetLastUsedBy(); //Get Last User
object oItem = GetItemPossessedBy(oPC, "PC_Data_Object"); //Fetch PC Data Item
object oTarget = OBJECT_SELF; //Target Caller
AssignCommand(oPC, ActionStartConversation(oTarget, "place_use_norm", TRUE, FALSE)); //PC Converse with Target
SetLocalObject(oItem, "oPick", oTarget); //Set Temp Var to Call
}
