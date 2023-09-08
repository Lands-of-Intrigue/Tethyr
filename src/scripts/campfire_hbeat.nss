//::///////////////////////////////////////////////
//:: campfire_hbeat
//:://////////////////////////////////////////////
/*
    Put into: placeable "campsite" OnHeartBeat Event

    This script tracks the lifespan of a fire
*/
//:://////////////////////////////////////////////
//:: Created:   The Magus (2011 nov 3) campfire / rest system
//:: Modified:  The Magus (2012 oct 24) updating system to use two placeables
//:: Modified:  Henesua (2014 feb 17) animals driven from fire
//:://////////////////////////////////////////////

#include "camp_include"

//void CreatureFleesFire(object oFire);
void AnimalFleesFire(object oFire, location lLoc)
{
   //object oCamper  = GetLocalObject(oFire, "CAMPER");
   //SendMessageToPC(oCamper, "Fire Creature("+GetName(OBJECT_SELF)+") Distance("+FloatToString(GetDistanceToObject(oFire))+")");

       //SendMessageToPC(oCamper, "FLEE("+GetName(oFire)+")");
        ClearAllActions(TRUE);
        ActionMoveAwayFromObject(oFire, TRUE, 45.0);
        string sFire    = ObjectToString(oFire);
        SetLocalInt(OBJECT_SELF, sFire+"_FLEE", TRUE);
        DelayCommand(19.8, DeleteLocalInt(OBJECT_SELF, sFire+"_FLEE") );

        object oCampers = GetFirstObjectInShape(SHAPE_SPHERE, 5.0, lLoc);
        while(oCampers!=OBJECT_INVALID)
        {
            if(GetIsPC(oCampers))
            {
                //SendMessageToPC(oCamper, "FRIEND("+GetName(oCampers)+")");
                SetIsTemporaryFriend(oCampers, OBJECT_SELF, TRUE, 20.0);
            }
            oCampers    = GetNextObjectInShape(SHAPE_SPHERE, 5.0, lLoc);
        }
}

void main ()
{
    int nLight      = GetLocalInt(OBJECT_SELF, LIGHT_VALUE); // brightness/hotness of fire

    if(nLight)
    {
        object oPair    = GetLocalObject(OBJECT_SELF,"PAIRED"); // oPair is actual campfire placeable
        if(oPair==OBJECT_INVALID)
            oPair       = OBJECT_SELF;

        // determine rate of fuel consumption and adjust fuel
        int nRate;
        if(!GetLocalInt(OBJECT_SELF,"CAMPFIRE_PERMANENT"))
        {
            float fRate = GetLocalFloat(OBJECT_SELF, "LAST_RATE") + (IGMINUTES_PER_RLMINUTE/10.0);
            if(fRate>1.0)
            {
                nRate   = FloatToInt(fRate);
                fRate   -= nRate;
                nRate   *= nLight;
            }
            SetLocalFloat(OBJECT_SELF, "LAST_RATE", fRate);
        }
        int nFuel       = GetLocalInt(OBJECT_SELF, FUEL_REMAINING)-nRate;

        // fire exhausted?
        if(nFuel<=0)
        {
            AssignCommand(oPair, SpeakString(LIGHTGREY+"*burns out.*"));
            CampfireResetLight(FALSE);
            CampfireGarbageCollection();
        }
        // fire burns on
        else
        {

           if(!GetIsAreaInterior(GetArea(OBJECT_SELF)))
           {
            // gather all animals within range and keep them at bay-------------
            location lLoc       = GetLocation(OBJECT_SELF);
            object oFire        = OBJECT_SELF;
            float fDist         = 30.0+(nLight*3.0);
            string sFire        = ObjectToString(oFire)+"_FLEE";
            object oCreature    = GetFirstObjectInShape(SHAPE_SPHERE,fDist,lLoc);
            while(oCreature!=OBJECT_INVALID)
            {
                if(     CreatureGetIsAnimal(oCreature)
                    &&  !GetLocalInt(oCreature, sFire)
                  )
                    AssignCommand(oCreature, AnimalFleesFire(oFire, lLoc));

                oCreature    = GetNextObjectInShape(SHAPE_SPHERE,fDist,lLoc);
            }
            // keep animals at bay ---------------------------------------------
           }
            int nWeather    = GetWeather(GetArea(OBJECT_SELF));
            if(nWeather!=WEATHER_CLEAR && nWeather!=WEATHER_INVALID)
            {
                // don't speak every heartbeat
                int nTick   = GetLocalInt(OBJECT_SELF, "SPEAK_TICK");
                if(!nTick)
                {
                    AssignCommand(oPair, SpeakString(LIGHTGREY+"*sputters and hisses in the wet*"));
                }
                nTick++;
                if(nTick>5)
                    nTick   = 0;
                SetLocalInt(OBJECT_SELF, "SPEAK_TICK", nTick);

                SetLocalString(OBJECT_SELF, "SOUND", "al_na_firesmldr1");
            }
            else
            {
                string sSound = GetLocalString(oPair, "SOUND");
                if(sSound=="" || sSound=="al_na_firesmoldr1")
                    sSound      = "al_cv_firepit1";
                // need to adjust this depending on what fire is doing
                SetLocalString(OBJECT_SELF, "SOUND", sSound);
            }

            // fuel was consumed
            if(nRate)
            {
                SetLocalInt(OBJECT_SELF,FUEL_REMAINING, nFuel);
                if(ConvertFuelToLight(nFuel)!=nLight)
                    CampfireResetLight(nFuel);
            }

        }
    }
    // fire unlit
    else
    {
        // a placeable which starts burning on its first HB?
        if(GetLocalInt(OBJECT_SELF,"CAMPFIRE_INIT_ON"))
            CampfireLight();
    }
}
