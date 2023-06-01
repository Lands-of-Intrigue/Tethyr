//::///////////////////////////////////////////////
//:: restarea_enter
//:://////////////////////////////////////////////
/*
    MAGUS REST SYSTEM
    Enter Event Script for a Trigger
    Trigger defines fine grained control of rest settings

    the enter event sets each specified local int on the creature
    the exit event removes each specified local int from the creature

    put a local int on the trigger to establish what it does for the player
    REST_UNRESTRICTED   - will establish unrestricted rest for the player (this takes precedence over all other settings)
    REST_RESTRICTED     - will establish restricted rest for the player if area or module is set to unrestricted

    each of these allow the PC to ignore the particular rest test while inside the trigger
    REST_IGNORE_TIME
    REST_IGNORE_WARMTH
    REST_IGNORE_BED
    REST_IGNORE_FOOD

*/
//:://////////////////////////////////////////////
//:: Creator   : The Magus (2013 july 13)
//:: Modified  :
//:://////////////////////////////////////////////

// INCLUDES --------------------------------------------------------------------
#include "rest_include"

void main()
{
    object oEntered = GetEnteringObject();

    if(GetLocalInt(OBJECT_SELF, REST_UNRESTRICTED))
        SetLocalInt(oEntered, REST_UNRESTRICTED, TRUE);
    if(GetLocalInt(OBJECT_SELF, REST_RESTRICTED))
        SetLocalInt(oEntered, REST_RESTRICTED, TRUE);

    int nRestShelter    = GetLocalInt(oEntered, REST_SHELTER);
    if( GetLocalInt(OBJECT_SELF, "REST_IGNORE_TIME") )
        nRestShelter = nRestShelter | REST_IGNORE_TIME;
    if(GetLocalInt(OBJECT_SELF, "REST_IGNORE_WARMTH"))
        nRestShelter = nRestShelter | REST_IGNORE_WARMTH;
    if(GetLocalInt(OBJECT_SELF, "REST_IGNORE_BED"))
        nRestShelter = nRestShelter | REST_IGNORE_BED;
    if(GetLocalInt(OBJECT_SELF, "REST_IGNORE_FOOD"))
        nRestShelter = nRestShelter | REST_IGNORE_FOOD;
    SetLocalInt(oEntered, REST_SHELTER, nRestShelter);

    string sMessage = GetLocalString(OBJECT_SELF, "REST_MESSAGE_ENTER");
    if(sMessage!="")
    {
        SendMessageToPC(oEntered, "<c#ßþ>"+sMessage);
    }
}

