////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_ramit:
// Rams the door.
////////////////////////////
// Added in v1.1

#include "siege_include"

void main()
{
    object oDoor = GetLocalObject(OBJECT_SELF, "door_target");
    object oPC = GetPCSpeaker();

    if(oDoor == OBJECT_INVALID) //Is the door still there?
    {
        SendMessageToPC(oPC, "Seems the door isnt there anymore...");
        return;
    }

    SetLocalInt(OBJECT_SELF, "firing", TRUE);

    SetLocalObject(oPC, "siege_used", OBJECT_SELF);
    SetLocalObject(oPC, "siege_target", oDoor);

    PlaySound("as_cv_smithmet2");
    DelayCommand(TIME_RAM - 0.5, PlaySound("as_cv_minecar3"));

    effect eDamage = EffectDamage(d4(2), DAMAGE_TYPE_MAGICAL);
    DelayCommand(TIME_RAM + 0.3, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, OBJECT_SELF));
    DelayCommand(TIME_RAM, ExecuteScript("siege_ramdone", oPC));
}
