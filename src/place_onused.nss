//Function: Start Normal Pickup Conversation // Date: 23MAR16
//Creator: Jonathan Lorentsen // Email: jlorents93@hotmail.com
//Instructions: Add script to placeable's OnUsed
//**ATTENTION: Add script to placeable's OnClosed if Container
//Add Variable "iPick" = 1 if Pickable Object to Object
//Add Variable "iType" = # to the object per below:
//PLACEABLE_TYPE_NORMAL = 0
//PLACEABLE_TYPE_CHAIR = 1
//PLACEABLE_TYPE_LIGHTSOURCE = 2
//PLACEABLE_TYPE_SIGN = 3
//PLACEABLE_TYPE_CONTAINER = 4
//PLACEABLE_TYPE_SIEGE = 5
//Add Variable "iTurn" = 1 if Turnable Object to Object

#include "loi_functions"

void main()
{
object oPC = GetLastUsedBy(); //Get Last User
object oTarget = OBJECT_SELF; //Target Caller
EventUsePlaceable(oPC, oTarget, "placeable_convo");
}
