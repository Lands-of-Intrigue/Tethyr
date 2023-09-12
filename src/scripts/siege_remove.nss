////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_remove:
// Despawns the placeable and puts the item version in the PC's backpack.
////////////////////////////

#include "siege_include"
#include "gs_inc_fixture"

void main()
{
    object oPC = GetPCSpeaker();
    int iType = GetType(OBJECT_SELF);

    if(GetLocalInt(OBJECT_SELF, "firing") == TRUE)
    {
        SendMessageToPC(oPC, "Wait for the weapon to finish firing.");
        return;
    }
    if(GetLocalInt(OBJECT_SELF, "aiming") == TRUE)
    {
        SendMessageToPC(oPC, "You must finish aiming before you can pick the weapon up.");
        return;
    }

    gsFXDeleteFixture(GetTag(GetArea(OBJECT_SELF)),OBJECT_SELF);

    if(iType == SIEGE_ARBALEST)
    {
        CreateItemOnObject("siege_arbalest", oPC);
        DelayCommand(1.0, DestroyObject(OBJECT_SELF));

        return;
    }
    if(iType == SIEGE_ONAGER)
    {
        CreateItemOnObject("siege_onager", oPC);
        DelayCommand(1.0, DestroyObject(OBJECT_SELF));

        return;
    }
    if(iType == SIEGE_CANNON)
    {
        CreateItemOnObject("siege_cannon", oPC);
        DelayCommand(1.0, DestroyObject(OBJECT_SELF));

        return;
    }
    if(iType == SIEGE_SCORPION)
    {
        CreateItemOnObject("siege_scorpion", oPC);
        DelayCommand(1.0, DestroyObject(OBJECT_SELF));

        return;
    }
    if(iType == SIEGE_RAM)
    {
        if(GetLocalInt(OBJECT_SELF, "on_fire") == TRUE)
        {
            SendMessageToPC(oPC, "You cannot pick up a burning ram.");
        } else
        {
            DelayCommand(1.0, DestroyObject(OBJECT_SELF));
            CreateItemOnObject("siege_ram", oPC);
        }
        return;
    }


}
