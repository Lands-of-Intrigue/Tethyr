////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_firefar:
// Fires a ballistic weapon at max range.
////////////////////////////
// v1.1: Added the "firing" variable.
// Enabled Cannons and Scorpions

#include "siege_include"

void main()
{
    SetLocalInt(OBJECT_SELF, "in_use", TRUE);

    DelayCommand(6.0, SetLocalInt(OBJECT_SELF, "in_use", FALSE)); //Give user time to reload

    int iType = GetType(OBJECT_SELF);
    float fFacing = GetFacing(OBJECT_SELF);
    vector vWeapon = GetPosition(OBJECT_SELF);
    object oPC = GetLocalObject(OBJECT_SELF, "last_user");

    if(!GetIsAmmoValid(OBJECT_SELF)) //Can this weapon shoot this ammo? Is it even ammo?
    {
        SendMessageToPC(oPC, "Invalid ammo or no ammo loaded!");
        return;
    }

    //Added this command in 1.1
    SetLocalInt(OBJECT_SELF, "firing", TRUE);

    //Changed this in 1.1: Purely cosmetic
    SpeakString("Get ready...");

    if(iType == SIEGE_ONAGER)
    {
        float fRange = RANGE_ONAGER;
        vector vTarget = Vector();

        vTarget.x = vWeapon.x + (fRange * cos(fFacing));
        vTarget.y = vWeapon.y + (fRange * sin(fFacing));
        vTarget.z = vWeapon.z;

        location lTarget = Location(GetArea(OBJECT_SELF), vTarget, 0.0); //Compile a Location from the Vector

        SetLocalObject(oPC, "siege_used", OBJECT_SELF);
        SetLocalLocation(oPC, "siege_location", lTarget);
        DelayCommand(TIME_ONAGER, ExecuteScript("siege_fireend", oPC)); //Most of the coding here is done on the other end.

        PlaySound("as_cv_ropecreak2");
        DelayCommand(TIME_ONAGER, PlaySound("zep_catapult"));

        return;
    }
    if(iType == SIEGE_ARBALEST)
    {
        float fRange = RANGE_ARBALEST;
        vector vTarget = Vector();
        vTarget.x = vWeapon.x + (fRange * cos(fFacing));
        vTarget.y = vWeapon.y + (fRange * sin(fFacing));
        vTarget.z = vWeapon.z;

        location lTarget = Location(GetArea(OBJECT_SELF), vTarget, 0.0); //Compile a Location from the Vector

        //Find a single target.
        object oTarget = GetFirstObjectInShape(ARBALEST_AIM, AIM_ACCURACY, lTarget, TRUE, OBJECT_TYPE_CREATURE, vWeapon);
        int iMissed = TRUE;

        if(oTarget != OBJECT_INVALID)//If there is no first object, it makes sense there are no other objects.
        {
            int iDone = FALSE;
            int iCurrDC = ARBALEST_AIM_DC;
            iMissed = FALSE;

            while(iDone == FALSE)
            {

                if(GetDistanceToObject(oTarget) < (fRange / 3))
                    iCurrDC = ARBALEST_AIM_DC - 5;  //If its really close, the DC is lower.
                else if(GetDistanceToObject(oTarget) > (fRange / 1.5))
                    iCurrDC = ARBALEST_AIM_DC + 5; //Likewise, if its far, the DC is harder.
                else iCurrDC = ARBALEST_AIM_DC;

                if((d20() >= iCurrDC) && (!GetIsDead(oTarget)))//Check to see if its a dead thing.
                {
                    iDone = TRUE;
                } else
                { //If not, try the next one in the shape.
                    oTarget = GetNextObjectInShape(ARBALEST_AIM, AIM_ACCURACY, lTarget, TRUE, OBJECT_TYPE_CREATURE, vWeapon);
                }
                if(oTarget == OBJECT_INVALID)
                {
                    iDone = TRUE;   //None left, break out.
                    iMissed = TRUE;
                }
            }
        }

        //Show the firing anim
        ExecuteScript("zep_onoff", OBJECT_SELF); //Why re-write it when it works fine?
        DelayCommand(TIME_ARBALEST, ExecuteScript("zep_onoff", OBJECT_SELF));

        if(iMissed)
        {
            DelayCommand(TIME_ARBALEST, SendMessageToPC(oPC, "You didnt hit anything."));

            //Added this in 1.1: Make sure to un-set the firing variable or else the weapon is jammed.
            DelayCommand(TIME_ARBALEST + 1.0, SetLocalInt(OBJECT_SELF, "firing", FALSE));
            DelayCommand(TIME_ARBALEST, DestroyObject(GetFirstItemInInventory()));
            return;
        }

        SetLocalObject(oPC, "siege_used", OBJECT_SELF);
        SetLocalObject(oPC, "siege_target", oTarget);
        DelayCommand(TIME_ARBALEST, ExecuteScript("siege_fireend", oPC));

        return;
    }
    if(iType == SIEGE_CANNON)
    {
        float fRange = RANGE_CANNON;
        vector vTarget = Vector();

        vTarget.x = vWeapon.x + (fRange * cos(fFacing));
        vTarget.y = vWeapon.y + (fRange * sin(fFacing));
        vTarget.z = vWeapon.z;

        location lTarget = Location(GetArea(OBJECT_SELF), vTarget, 0.0); //Compile a Location from the Vector

        SetLocalObject(oPC, "siege_used", OBJECT_SELF);
        SetLocalLocation(oPC, "siege_location", lTarget);
        DelayCommand(TIME_CANNON, ExecuteScript("siege_fireend", oPC)); //Most of the coding here is done on the other end.

        //Show the firing anim
        DelayCommand(TIME_CANNON, ExecuteScript("zep_onoff", OBJECT_SELF));

        return;
    }

    ///////////////////////////////
    //No entry for rams of course.
    ///////////////////////////////

    if(iType == SIEGE_SCORPION)
    {
        float fRange = RANGE_SCORPION;
        vector vTarget = Vector();
        vTarget.x = vWeapon.x + (fRange * cos(fFacing));
        vTarget.y = vWeapon.y + (fRange * sin(fFacing));
        vTarget.z = vWeapon.z;

        location lTarget = Location(GetArea(OBJECT_SELF), vTarget, 0.0); //Compile a Location from the Vector

        //Find a single target.
        object oTarget = GetFirstObjectInShape(ARBALEST_AIM, AIM_ACCURACY, lTarget, TRUE, OBJECT_TYPE_CREATURE, vWeapon);
        int iMissed = TRUE;

        if(oTarget != OBJECT_INVALID)//If there is no first object, it makes sense there are no other objects.
        {
            int iDone = FALSE;
            int iCurrDC = ARBALEST_AIM_DC;
            iMissed = FALSE;

            while(iDone == FALSE)
            {

                if(GetDistanceToObject(oTarget) < (fRange / 3))
                    iCurrDC = ARBALEST_AIM_DC - 5;  //If its really close, the DC is lower.
                else if(GetDistanceToObject(oTarget) > (fRange / 1.5))
                    iCurrDC = ARBALEST_AIM_DC + 5; //Likewise, if its far, the DC is harder.
                else iCurrDC = ARBALEST_AIM_DC;

                if((d20() >= iCurrDC) && (!GetIsDead(oTarget)))//Check to see if its a dead thing.
                {
                    iDone = TRUE;
                } else
                { //If not, try the next one in the shape.
                    oTarget = GetNextObjectInShape(ARBALEST_AIM, AIM_ACCURACY, lTarget, TRUE, OBJECT_TYPE_CREATURE, vWeapon);
                }
                if(oTarget == OBJECT_INVALID)
                {
                    iDone = TRUE;   //None left, break out.
                    iMissed = TRUE;
                }
            }
        }

        //Show the firing anim
        ExecuteScript("zep_onoff", OBJECT_SELF); //Why re-write it when it works fine?
        DelayCommand(TIME_SCORPION, ExecuteScript("zep_onoff", OBJECT_SELF));

        if(iMissed)
        {
            DelayCommand(TIME_SCORPION, SendMessageToPC(oPC, "You didnt hit anything."));

            //Added this in 1.1: Make sure to un-set the firing variable or else the weapon is jammed.
            DelayCommand(TIME_SCORPION + 1.0, SetLocalInt(OBJECT_SELF, "firing", FALSE));
            DelayCommand(TIME_SCORPION, DestroyObject(GetFirstItemInInventory()));
            return;
        }

        SetLocalObject(oPC, "siege_used", OBJECT_SELF);
        SetLocalObject(oPC, "siege_target", oTarget);
        DelayCommand(TIME_SCORPION, ExecuteScript("siege_fireend", oPC));

        return;
    }
}
