////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_startrange:
// Begins using the seige weapon.
////////////////////////////
// v1.1: Ram enabled. "firing" variable enabled

#include "siege_include"

void main()
{
    object oPC = GetLastUsedBy();

    //Added in v1.1
    if(GetLocalInt(OBJECT_SELF, "firing") == TRUE)
    {
        SendMessageToPC(oPC, "Wait until the weapon finishes firing...");
        return;
    }

    object oLastUser = GetLocalObject(OBJECT_SELF, "last_user");

    if(oLastUser == OBJECT_INVALID)
    {
        oLastUser = oPC;
    }

    if(oLastUser == oPC)
    {
        if(GetLocalInt(OBJECT_SELF, "loading") == TRUE)
        {
            SpeakString("Load ammunition");
        } else
        {
            SetLocalObject(OBJECT_SELF, "last_user", oPC);
            if(GetType(OBJECT_SELF) == SIEGE_RAM)
            {
                //Ram enabled in 1.1
                BeginConversation("siege_ram", oPC);
            } else
            {
                BeginConversation("siege_ranged", oPC);
            }
        }
    } else
    {
        SendMessageToPC(oPC, "Weapon currently in use.");
    }

}
