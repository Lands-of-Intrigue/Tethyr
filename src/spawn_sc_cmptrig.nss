//
//   NESS
//   Camp Trigger Scripts v8.1.3
//
//
#include "spawn_functions"
//
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
void DestroyCamp(object oCamp, float fCampDecay, int nSaveState);
//
//
void main()
{
    // Initialize Variables
    object oSpawned;
    string sObject;
    int iCount, nCampNumP, nCampNumC;

    // Retrieve Script
    int nCampTriggerScript = GetLocalInt(OBJECT_SELF, "CampTriggerScript");

    // Invalid Script
    if (nCampTriggerScript == -1)
    {
        return;
    }

    object oCamp = OBJECT_SELF;
    object oSpawn = GetLocalObject(OBJECT_SELF, "ParentSpawn");
    float fCampDecay = GetLocalFloat(oSpawn, "f_CampDecay");

//
// Only Make Modifications Between These Lines
// -------------------------------------------


    // Destroy Camp
    if (nCampTriggerScript == 0)
    {
        DestroyCamp(oCamp, fCampDecay, FALSE);
    }


    if (nCampTriggerScript == 10)
    {

        /*
        //object oPC = GetEnteringObject();
        //if (!GetIsPC(oPC)) return;


        //int i = 0;
        int i;
        object oTarget = GetObjectByTag("tt_spore", i);
        location lTarget;
        lTarget = GetLocation(oTarget);


        //while (GetIsObjectValid(oTarget))
        while (i < 11)
            {


                        location lTarget;
                        lTarget = GetLocation(oTarget);
                        CreateTrapAtLocation(TRAP_BASE_TYPE_AVERAGE_GAS, lTarget, 2.0);
                        i++;
                        oTarget = GetObjectByTag("tt_spore", i);

            }



        */

    }



















    //


// -------------------------------------------
// Only Make Modifications Between These Lines
//
}
