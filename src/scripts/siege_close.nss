////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_close:
// OnClose() event of siege weaponry, to end loading state and check for valid ammo.
////////////////////////////
#include "siege_include"

void main()
{
SetLocalInt(OBJECT_SELF, "loading", FALSE);

if(!GetIsAmmoValid(OBJECT_SELF))
    SendMessageToPC(GetLastUsedBy(), "Ammo loaded is invalid, or no ammo equipped.");

}
