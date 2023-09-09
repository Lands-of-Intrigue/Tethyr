//
// Spawn and Despawn Scripts
//
#include "spawn_functions"
#include "te_functions"
#include "aid_inc_fcns"
#include "camp_include"

//
object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
//
//
void main()
{
    // Retrieve Parent
    object oParentSpawn = GetLocalObject(OBJECT_SELF, "ParentSpawn");

    // Retrieve Script Number
    int nSpawnScript    = GetLocalInt(OBJECT_SELF, "SpawnScript");
    int nDespawnScript  = GetLocalInt(OBJECT_SELF, "DespawnScript");

    if (nSpawnScript > 0 && !GetLocalInt(OBJECT_SELF, "Despawning") )
    {
// Only Make Modifications Between These Lines
// -------------------------------------------

    // These occur for every NESS spawnpoint calling a spawn script
    //BEGIN
    /*
        if(GetObjectType(OBJECT_SELF)==OBJECT_TYPE_PLACEABLE)
        {
            // strips out parentheses for placeables
            string sNameTemp    = GetName(OBJECT_SELF);
            int nFind           = FindSubString(sNameTemp, "(");
            if(nFind != -1)
                SetName(OBJECT_SELF, GetStringLeft(sNameTemp, nFind));
        }
    */
    //END

    // Only one of the following scripts will occur for a spawnpoint calling a spawn script

        // Spawn Script 000 ----------------------------------------------------
        // Dummy Script - Never Use
        if (nSpawnScript == 0)
        {
            return;
        }
        //

        // Spawn Script 001 ----------------------------------------------------
        // This is an empty spawn script, reserved for future use
        else if (nSpawnScript == 1)
        {
            return;
        }

        else if (nSpawnScript == 10)
        {

            //             ActionCastSpellAtObject(SPELL_INVISIBILITY,
            //OBJECT_SELF, METAMAGIC_ANY, TRUE);





            // eEffect;
           // eEffect = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
           // ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, OBJECT_SELF, 1.0f);


          //  effect eEffect;
            //eEffect = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectInvisibility(INVISIBILITY_TYPE_NORMAL), OBJECT_SELF, 5.0f);
           //




            return;
        }













        // end spawn script 1

        // Spawn Script 002 ----------------------------------------------------
        // lamplighter
        else if (nSpawnScript == 2)
        {

            if(!GetLocalInt(OBJECT_SELF, "AI_SPAWNSCRIPT_COMPLETE"))
            {
                // find all objects in area with tag lightableTorch
                object oArea = GetArea(OBJECT_SELF);
                int nCount  = 1;
                object oLamp = GetFirstObjectInArea(oArea);
                while( oLamp!=OBJECT_INVALID )
                {
                    if(     GetLocalInt(oLamp,"LIGHTABLE")
                        &&  GetLocalString(OBJECT_SELF, "light")==""
                      )
                    {
                        SetLocalInt(OBJECT_SELF,"NW_L_AMION",1); // state tracking
                        AssignCommand(oLamp, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));

                        SetLocalInt(oLamp, LIGHT_VALUE, GetLocalInt(oLamp, "LIGHT_BRIGHTNESS")); // light tracking
                        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(GetLightColor(oLamp)), oLamp);
                        SetPlaceableIllumination(oLamp, TRUE);
                    }

                    oLamp = GetNextObjectInArea(oArea);
                }

                DelayCommand(0.5, RecomputeStaticLighting(oArea));
                SetLocalInt(OBJECT_SELF, "AI_SPAWNSCRIPT_COMPLETE",1);
                return;
            }
        }// end spawn script 2

        // Spawn Script 003 ----------------------------------------------------
        // Intention of this script is for a merchant or crafter to spawn in with a number of items/placeables
        // And make some noise while around.
        //
        // This script will activate up to 10 spawn points in the same area by ID
        // These IDs are set as local ints on this waypoint with the names DependentID0 - DependentID9
        // And begin play of a Sound Object by Tag. Tag of sound object is set as local string on waypoint
        else if (nSpawnScript == 3)
        {
            object oArea    =   GetArea(oParentSpawn);
            int iCount      =   0;
            int iDependentID =  GetLocalInt(oParentSpawn,"iDependentID0");
            string sSoundTag =  GetLocalString(oParentSpawn, "sSoundTag");
            while ( iDependentID > 0 && iCount < 10)
            {
                NESS_ActivateSpawnByID(iDependentID, oArea);
                NESS_ForceProcess(NESS_GetSpawnByID(iDependentID, oArea));
                iCount++;
                iDependentID    =   GetLocalInt(oParentSpawn, "iDependentID"+IntToString(iCount) );
            }
            if (sSoundTag != "")
            {
                object oSound = GetObjectByTag(sSoundTag);
                SoundObjectPlay(oSound);
            }
            return;
        }// end spawn script 3
        // Spawn Script 004 ----------------------------------------------------
        // Intention of this script is for an object to receive a permanent area of effect
        // area of effect is identified on the blueprint with local variables
        else if (nSpawnScript == 4)
        {
            effect eAOE = EffectAreaOfEffect(   GetLocalInt(OBJECT_SELF, "AOE_ID"),
                                                GetLocalString(OBJECT_SELF, "AOE_ENTER"),
                                                GetLocalString(OBJECT_SELF, "AOE_HB"),
                                                GetLocalString(OBJECT_SELF, "AOE_EXIT")
                                             );
            ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eAOE, GetLocation(OBJECT_SELF));
            int nNth = 1;
            object oAOE = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT);
            while(GetIsObjectValid(oAOE))
            {
                if(     GetAreaOfEffectCreator(oAOE)   == OBJECT_SELF
                    &&  GetLocalObject(oAOE, "PAIRED") == OBJECT_INVALID
                  )
                {
                    SetLocalObject(OBJECT_SELF, "PAIRED", oAOE);
                    SetLocalObject(oAOE, "PAIRED", OBJECT_SELF);
                    SetLocalInt(oAOE,"X1_L_IMMUNE_TO_DISPEL",10);
                    break;
                }

                oAOE = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT,OBJECT_SELF,++nNth);
            }
            return;
        }// end spawn script 4
        ////////////////////////////////////////////////////////////////////////
        // Spawn Script 012 ----------------------------------------------------
        // Intention of this script is to initialize a bard's behavior in a room with a stage
        else if (nSpawnScript == 12)
        {
            int nDelay  = GetLocalInt(OBJECT_SELF,"PERFORM_DELAY");

            SetLocalInt(OBJECT_SELF, "PERFORM_NEXT",GetTimeCumulative()+(nDelay*IGMINUTES_PER_RLMINUTE));

            return;
        }// end spawn script 12
        ////////////////////////////////////////////////////////////////////////
        // Spawn Script 020 ----------------------------------------------------
        // Vocalization at time of spawn
        else if(nSpawnScript == 20)
        {
            int nVoice;
            int nRandom = d4();
            switch(nRandom)
            {
                case 1: nVoice  = VOICE_CHAT_GATTACK1; break;
                case 2: nVoice  = VOICE_CHAT_GATTACK2; break;
                case 3: nVoice  = VOICE_CHAT_GATTACK3; break;
                case 4: nVoice  = VOICE_CHAT_GATTACK1; break;
            }
            ActionDoCommand(PlayVoiceChat(nVoice));
        }
        // Spawn Script 021 ----------------------------------------------------
        // Play Sound at time of spawn
        else if(nSpawnScript == 21)
        {
            string sSound   = GetLocalString(oParentSpawn, "SOUND_REF_1");
            if(sSound!="")
            {
                object oSound   = GetLocalObject(OBJECT_SELF, "SOUND_OBJECT");
                if(!GetIsObjectValid(oSound))
                {
                    oSound      = CreateObject(OBJECT_TYPE_PLACEABLE, "sound_player", GetLocation(oParentSpawn));
                    SetLocalObject(oParentSpawn, "SOUND_OBJECT", oSound);
                }
                AssignCommand(oSound, PlaySound(sSound) );
            }
        }
        // Spawn Script 030 ----------------------------------------------------
        // secret AID object spawn
        // Copies all AID and Secret variables to spawn from spawn point
        else if(nSpawnScript == 30)
        {
            CopyAllAIDVariables(oParentSpawn, OBJECT_SELF);
            CopyAllSecretVariables(oParentSpawn, OBJECT_SELF);
            // apply a detection AOE around the secret object so that DETECT MODE works for detection
            int nAOE    = GetLocalInt(oParentSpawn, "AOE_ID");
            if(!nAOE)
                nAOE    = 72;

            effect eAOE = EffectAreaOfEffect(   nAOE,
                                                "v2_sec_detect",
                                                "",
                                                "v2_sec_exit"
                                            );
            ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eAOE, GetLocation(OBJECT_SELF));
            object oAOE = GetNearestObject(OBJECT_TYPE_AREA_OF_EFFECT, OBJECT_SELF);
            SetLocalObject(oAOE,"SECRET_AOE_TARGET",OBJECT_SELF);
            SetLocalInt(oAOE,"X1_L_IMMUNE_TO_DISPEL",10);
        }
        // Spawn Script 030 ----------------------------------------------------
        // campfire spawn - to be used on a spawned campfire
        else if(nSpawnScript == 31)
        {
            location lCampSite  = GetLocation(OBJECT_SELF);

            int nFuel = (CAMPFIRE_FUEL_MINIMUM)*2;
            // intialize type of fire
            string sCampRef = GetLocalString(oParentSpawn, "CAMPFIRE_RESREF");
            int nState      = StringToInt(GetStringRight(sCampRef,1));
            if(nState<1||nState>3)
            {
                nState      = 1;
                sCampRef    = REF_CAMPFIRE_1;
            }

            object oCampSite    = CreateObject(OBJECT_TYPE_PLACEABLE, sCampRef, lCampSite, FALSE); // has no heartbeat event

            SetLocalObject(OBJECT_SELF, "PAIRED", oCampSite);
            SetLocalObject(oCampSite, "PAIRED", OBJECT_SELF);

            SetLocalInt(OBJECT_SELF, "CAMPFIRE_STATE", nState);
            SetLocalInt(OBJECT_SELF, FUEL_REMAINING, nFuel);
            //SetLocalString(oCampSite, "SOUND", "al_cv_firepit1");

            // campfire is lit?
            if(GetLocalInt(oParentSpawn, "CAMPFIRE_LIGHT"))
                CampfireLight();
        }

//
// Only Make Modifications Between These Lines
// -------------------------------------------

    }

    if (nDespawnScript > 0 && GetLocalInt(OBJECT_SELF, "Despawning") )
    {
//
// Only Make Modifications Between These Lines
// -------------------------------------------

    // These occur for every NESS spawnpoint calling a despawn script
    //BEGIN



    //END

    // Only one of the following scripts will occur for a spawnpoint calling a despawn script
        // Despawn Script 000 --------------------------------------------------
        // Dummy Script - Never Use
        if (nDespawnScript == 0)
        {
            return;
        }
        // end despawn script 0

        // Despawn Script 001 --------------------------------------------------
        // This is an empty despawn script, reserved for future use
        else if (nDespawnScript == 1)
        {
            return;
        }
        // end despawn script 1

        // Despawn Script 002 --------------------------------------------------
        else if (nDespawnScript == 2)
        {

            // lampdouser
            //SendMessageToPC(GetFirstPC(), "dousing torches");

            // find all objects in area with tag lightableTorch
            object oArea = GetArea(OBJECT_SELF);
            object oTorch = GetFirstObjectInArea(oArea);
            int nCount = 0;
            string sTorchTag = "lightableTorch";

            while (oTorch != OBJECT_INVALID)
            {
                if (GetTag(oTorch) == sTorchTag)
                {
                    nCount++;
                    AssignCommand(oTorch,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                    DelayCommand(0.4, SetPlaceableIllumination(oTorch, FALSE));
                    SetLocalInt(oTorch,"NW_L_AMION",0);
                }

                oTorch = GetNextObjectInArea(oArea);
            }

            if (nCount > 0)
            {
                DelayCommand(0.1,RecomputeStaticLighting(oArea));
            }

            return;
        }// end despawn script 2

        // Despawn Script 003 --------------------------------------------------
        // This script will despawn the children of up to 10 spawn points in the same area by ID
        // These IDs are set as local ints on this spawn point with the names DependentID0 - DependentID9
        else if (nDespawnScript == 3)
        {
            object oArea    =   GetArea(oParentSpawn);
            object oSpawn;
            int iCount      =   0;
            int iDependentID =  GetLocalInt(oParentSpawn, "iDependentID0");
            string sSoundTag =  GetLocalString(oParentSpawn, "sSoundTag");
            while ( iDependentID > 0 && iCount < 10)
            {
                oSpawn  =   NESS_GetSpawnByID(iDependentID, oArea);

                NESS_ActivateSpawn(oSpawn);
                NESS_ForceProcess(oSpawn);
                DespawnChildren(oSpawn);
                NESS_DeactivateSpawn(oSpawn);
                iCount++;
                iDependentID    =   GetLocalInt(oParentSpawn, "iDependentID"+IntToString(iCount) );
            }
            if (sSoundTag != "")
            {
                object oSound = GetObjectByTag(sSoundTag);
                SoundObjectStop(oSound);
            }
            return;
        }
        // end despawn script 3

        // Area Cleanup Example
        else if (nDespawnScript == 999)
        {
            // Settings
            int nMerchantPrefixLetters = 3;
            string sMerchantPrefix = "MC_";
            int nChestPrefixLetters = 3;
            string sChestPrefix = "CH_";

            // Create an Area Merchant List
            int nMerchantNum;
            string sMerchantNum;
            int nNth = 1;
            object oMerchant = GetNearestObject(OBJECT_TYPE_STORE, OBJECT_SELF, nNth);
            while (oMerchant != OBJECT_INVALID)
            {
                if (GetStringLeft(GetTag(oMerchant), nMerchantPrefixLetters) == sMerchantPrefix)
                {
                    nMerchantNum++;
                    sMerchantNum = "Merchant" + PadIntToString(nMerchantNum, 2);
                    SetLocalObject(OBJECT_SELF, sMerchantNum, oMerchant);
                }
                nNth++;
                oMerchant = GetNearestObject(OBJECT_TYPE_STORE, OBJECT_SELF, nNth);
            }

            // Create an Area Chest List
            int nChestNum;
            string sChestNum;
            nNth = 1;
            object oChest = GetNearestObject(OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nNth);
            while (oChest != OBJECT_INVALID)
            {
                if (GetStringLeft(GetTag(oChest), nChestPrefixLetters) == sChestPrefix)
                {
                    nChestNum++;
                    sChestNum = "Chest" + PadIntToString(nChestNum, 2);
                    SetLocalObject(OBJECT_SELF, sChestNum, oChest);
                }
                nNth++;
                oChest = GetNearestObject(OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nNth);
            }

            // Cleanup Creatures
            nNth = 1;
            object oCreature = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nNth);
            while (oCreature != OBJECT_INVALID)
            {
                // Destroy Creatures NOT Spawned by Spawner
                if (GetLocalObject(oCreature, "ParentSpawn") == OBJECT_INVALID)
                {
                    DestroyObject(oCreature);
                }

                // Cleanup Corpses
                if (GetIsDead(oCreature) == TRUE)
                {
                    AssignCommand(oCreature, SetIsDestroyable(TRUE, TRUE));
                    DestroyObject(oCreature);
                }

                nNth++;
                oCreature = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, nNth);
            }

            // Cleanup All Items in Area
            string sItemTag;
            int nStack;
            int nCurrentMerchant = 0;
            int nCurrentChest = 0;
            nNth = 1;
            object oItem = GetNearestObject(OBJECT_TYPE_ITEM, OBJECT_SELF, nNth);
            while (oItem != OBJECT_INVALID)
            {
                // Retrieve Item Information
                sItemTag = GetTag(oItem);
                nStack = GetNumStackedItems(oItem);

                // Destroy Item
                DestroyObject(oItem);

                // Place Items on Merchants
                if (nMerchantNum > 0)
                {
                    if (nCurrentMerchant = nMerchantNum - 1)
                    {
                        nCurrentMerchant = 0;
                    }
                    oMerchant = GetLocalObject(OBJECT_SELF, "Merchant" +  PadIntToString(nCurrentMerchant, 2));
                    CreateItemOnObject(sItemTag, oMerchant, nStack);
                    nCurrentMerchant++;
                }
                // Place Items in Chests
                else if (nChestNum > 0)
                {
                    if (nCurrentChest = nChestNum -1)
                    {
                        nCurrentChest = 0;
                    }
                    oChest = GetLocalObject(OBJECT_SELF, "Chest" +  PadIntToString(nCurrentChest, 2));
                    CreateItemOnObject(sItemTag, oChest, nStack);
                    nCurrentChest++;
                }

                nNth++;
                oItem = GetNearestObject(OBJECT_TYPE_ITEM, OBJECT_SELF, nNth);
            }

            // Cleanup 'Body Bags'
            nNth = 1;
            oItem = GetNearestObject(OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nNth);
            while (oItem != OBJECT_INVALID)
            {
                if(GetTag(oItem) == "Body Bag")
                {
                    // Check for Inventory
                    if (GetHasInventory(oItem) == TRUE)
                    {
                        object oInventoryItem = GetFirstItemInInventory(oItem);
                        while (oInventoryItem != OBJECT_INVALID)
                        {
                            // Retrieve Item Information
                            sItemTag = GetTag(oInventoryItem);
                            nStack = GetNumStackedItems(oInventoryItem);

                            // Destroy Item
                            DestroyObject(oInventoryItem);

                            // Place Items on Merchants
                            if (nMerchantNum > 0)
                            {
                                if (nCurrentMerchant = nMerchantNum - 1)
                                {
                                    nCurrentMerchant = 0;
                                }
                                oMerchant = GetLocalObject(OBJECT_SELF, "Merchant" +  PadIntToString(nCurrentMerchant, 2));
                                CreateItemOnObject(sItemTag, oMerchant, nStack);
                                nCurrentMerchant++;
                            }
                            // Place Items in Chests
                            else if (nChestNum > 0)
                            {
                                if (nCurrentChest = nChestNum -1)
                                {
                                    nCurrentChest = 0;
                                }
                                oChest = GetLocalObject(OBJECT_SELF, "Chest" +  PadIntToString(nCurrentChest, 2));
                                CreateItemOnObject(sItemTag, oChest, nStack);
                                nCurrentChest++;
                            }
                            oInventoryItem = GetNextItemInInventory(oItem);
                        }
                    }

                    // Destroy Body Bag
                    DestroyObject(oItem);
                }
                nNth++;
                oItem = GetNearestObject(OBJECT_TYPE_PLACEABLE, OBJECT_SELF, nNth);
            }
        }
        //


// -------------------------------------------
// Only Make Modifications Between These Lines
//

    }

    // Clean Up
    SetLocalInt(OBJECT_SELF, "SpawnScript", 0);
    SetLocalInt(OBJECT_SELF, "DespawnScript", 0);
}
