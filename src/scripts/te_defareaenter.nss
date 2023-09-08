#include "x2_inc_toollib"
#include "loi_functions"
#include "te_afflic_func"
#include "so_inc_weather"
#include "spawn_main"
#include "rest_include"
#include "nwnx_area"
#include "nwnx_webhook"
#include "nwnx_webhook_rch"
#include "inc_sqlite_time"
#include "gs_inc_shop"
#include "gs_inc_fixture"
#include "gs_inc_placeable"
#include "x2_inc_spellhook"

void GameOfGrovesCheck(object oArea);

void main() {
    object oPC = GetEnteringObject();
    object oArea = GetArea(oPC);
    object oMod = GetModule();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");
    int iPop = GetLocalInt(OBJECT_SELF, "iPop");
    int iHB = GetLocalInt(OBJECT_SELF, "iHB");
    int iHBOn = GetLocalInt(OBJECT_SELF, "iHBOn");
    int nEnabled       = GetLocalInt(OBJECT_SELF, "GS_ENABLED");
    int nTimeNow = SQLite_GetTimeStamp();

    if(oPC==OBJECT_INVALID)
    {
        return;
    }
    //Hopefully fixes spawning in City of Judgement with Negative HP
    if(GetTag(oArea) == "CityofJudgement")
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)),oPC);
    }
    //Remove all MageBreaker Effects
    effect eLoop=GetFirstEffect(oPC);
    while(GetIsEffectValid(eLoop))
    {
        if(GetEffectTag(eLoop) == "SRMageBreaker" || GetEffectTag(eLoop) == "MSMageBreaker" || GetEffectTag(eLoop) == "SIMageBreaker")
            RemoveEffect(oPC, eLoop);
        eLoop=GetNextEffect(oPC);
    }
    //Reapply MageBreaker Effects
    if(GetLevelByClass(58, oPC) >= 1)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, TagEffect(EffectSpellResistanceIncrease(8 + (GetLevelByClass(58, oPC)*2)), "SRMageBreaker"), oPC);
    }
    if(GetLevelByClass(58, oPC) >= 8)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, TagEffect(EffectMovementSpeedIncrease(20), "MSMageBreaker"), oPC);
    }
    else if (GetLevelByClass(58, oPC) >= 5)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, TagEffect(EffectMovementSpeedIncrease(10), "MSMageBreaker"), oPC);
    }
    if(GetLevelByClass(58, oPC) >= 10)
    {
        if(GetHasFeat(1614))
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, TagEffect(EffectSpellLevelAbsorption(5, 0, SPELL_SCHOOL_ABJURATION), "SIMageBreaker"), oPC);
        }
        if(GetHasFeat(1615))
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, TagEffect(EffectSpellLevelAbsorption(5, 0, SPELL_SCHOOL_CONJURATION), "SIMageBreaker"), oPC);
        }
        if(GetHasFeat(1616))
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, TagEffect(EffectSpellLevelAbsorption(5, 0, SPELL_SCHOOL_DIVINATION), "SIMageBreaker"), oPC);
        }
        if(GetHasFeat(1617))
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, TagEffect(EffectSpellLevelAbsorption(5, 0, SPELL_SCHOOL_ENCHANTMENT), "SIMageBreaker"), oPC);
        }
        if(GetHasFeat(1618))
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, TagEffect(EffectSpellLevelAbsorption(5, 0, SPELL_SCHOOL_EVOCATION), "SIMageBreaker"), oPC);
        }
        if(GetHasFeat(1619))
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, TagEffect(EffectSpellLevelAbsorption(5, 0, SPELL_SCHOOL_ILLUSION), "SIMageBreaker"), oPC);
        }
        if(GetHasFeat(1620))
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, TagEffect(EffectSpellLevelAbsorption(5, 0, SPELL_SCHOOL_NECROMANCY), "SIMageBreaker"), oPC);
        }
        if(GetHasFeat(1621))
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, TagEffect(EffectSpellLevelAbsorption(5, 0, SPELL_SCHOOL_TRANSMUTATION), "SIMageBreaker"), oPC);
        }
    }

    //Magic Kill/Reset Effects
    if (GetCampaignString("Tethyr_Database", "KillMagic") == "True")
    {
        SetCampaignInt("Deadmagic",GetTag(oArea),100);
        SetCampaignInt("Wildmagic",GetTag(oArea),100);
    }
    else if(GetCampaignString("Tethyr_Database", "KillMagic") == "Random")
    {
        SetCampaignInt("Deadmagic",GetTag(oArea),d100());
        SetCampaignInt("Wildmagic",GetTag(oArea),d100());
    }

    //Cleanup bodies
    if(abs(GetLocalInt(oArea,"nCleanup")-nTimeNow) >= 600)
    {
        SetLocalInt(oArea,"nCleanup",nTimeNow);

        object oBody = GetFirstObjectInArea(OBJECT_SELF);
        while(GetIsObjectValid(oBody) != FALSE)
        {
            if(GetObjectType(oBody) == OBJECT_TYPE_PLACEABLE)
            {
                if(GetTag(oBody) == "te_hunt_mam"     ||
                   GetTag(oBody) == "te_remain_mam"   ||
                   GetTag(oBody) == "te_remain_nonc"  ||
                   GetTag(oBody) == "te_hunt_bug"     ||
                   GetTag(oBody) == "te_remain_bug")
               {
                    if(abs(GetLocalInt(oBody,"nCreated")-nTimeNow)>= 900)
                    {
                        if(GetHasInventory(oBody) == TRUE)
                        {
                            DestroyObject(GetFirstItemInInventory(oBody),0.0f);
                        }
                        DestroyObject(oBody,0.1f);
                    }
               }
            }
            oBody = GetNextObjectInArea(OBJECT_SELF);
        }
    }

    //load area
    if (! nEnabled)
    {
        //gsPLLoadArea();
        gsFXLoadFixture(GetTag(OBJECT_SELF));

        SetLocalInt(OBJECT_SELF, "GS_ENABLED", TRUE);

        object oPlace = GetFirstObjectInArea(OBJECT_SELF);
        while (GetIsObjectValid(oPlace) != FALSE)
        {
            if(GetObjectType(oPlace) == OBJECT_TYPE_PLACEABLE)
            {
                if(GetTag(oPlace) == "TE_SHOP")
                {
                    SetName(oPlace,TE_SH_GetShopName(oPlace));
                }
            }
            oPlace = GetNextObjectInArea(OBJECT_SELF);
        }
    }

    string sFeedback = GetLocalString(oArea,"sGenEntry");
    if(GetLocalString(oArea,"sListenEnt") != "")
    {
        if(GetIsSkillSuccessful(oPC,SKILL_LISTEN,15) > 0)
        {
            sFeedback += " "+GetLocalString(oArea,"sListenEnt");
        }
    }
    if(GetLocalString(oArea,"sSpotEnt") != "")
    {
        if(GetIsSkillSuccessful(oPC,SKILL_SPOT,15) > 0)
        {
            sFeedback += " "+GetLocalString(oArea,"sSpotEnt");
        }
    }
    SendMessageToPC(oPC,sFeedback);

    GameOfGrovesCheck(oArea);


    // WEATHER SYSTEM
    int iWeather = GetLocalInt(oMod, "iWeather");
    if(GetLocalInt(OBJECT_SELF,"iWeather") != 1)
    {
        SetLocalInt(oArea,"WeatherUpdate",TRUE);
        UpdateAreaWeather(oArea,TRUE);
        SetLocalInt(OBJECT_SELF,"iWeather",1);
    }

    // BEGIN PCs, Possessed Familiars, and DMs ---------------------------------
    if ( GetIsPC(oPC))
    {
        iPop++;
        SetLocalInt(OBJECT_SELF, "iPop", iPop);

        if ((iPop >= 1) && (iHBOn != TRUE) && (iHB != TRUE))
        {
            SetLocalInt(OBJECT_SELF, "iHB", 1);
            SetLocalInt(OBJECT_SELF, "iHBOn", 1);
            DelayCommand(5.0,ExecuteScript("te_pseudohb", OBJECT_SELF));
        }

        string sJoinMsg = " ("+GetPCPlayerName(oPC)+"/"+GetPCPublicCDKey(oPC)+") has entered "+GetName(oArea)+" - (Players: "+IntToString(NWNX_Area_GetNumberOfPlayersInArea(OBJECT_SELF))+")";
        NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sJoinMsg, GetName(oPC));

        //Advance number of times person has been in the area.
        SetLocalInt(oItem,GetTag(oArea),GetLocalInt(oItem,GetTag(oArea))+1);

        // COUNT PCS IN AREA
        int nPCs    = GetLocalInt(OBJECT_SELF, SPAWN_PCS_IN_AREA)+1;

        // NESS Spawns -- only works for PCs or PCScriers
        if ( GetLocalInt(OBJECT_SELF, "AREA_NESS_DISABLE") )
        {
            // Maintain PC count even if NESS is disabled
            SetLocalInt(OBJECT_SELF, SPAWN_PCS_IN_AREA, nPCs);
        }
        else
        {
            // File: spawn_functions  -- init NESS pseudo heartbeat
            Spawn_OnAreaEnter();
        }

        // GIVE AREA DESCRIPTION
        if (GetLocalInt(oArea, "iEntryMsg") == 1)
        {
            SendMessageToPC(oPC, GetLocalString(oArea, "sEntryMsg"));
        }

        if( GetIsDM(oPC) )
        {
            ExploreAreaForPlayer(OBJECT_SELF, oPC);
        }
        else
        {
            // PCs and Familiars
            // ensure PCs are not in cutscenemode and are mortal
            SetCutsceneMode(oPC,FALSE);
            SetPlotFlag(oPC,FALSE);
            SetImmortal(oPC,FALSE);

        }

    } // END PCs, Possessed Familiars, and DMs ---------------------------------


    if(GetObjectType(oPC)==OBJECT_TYPE_CREATURE)
    {
        // Run custom OnEnter script on all entering Creatures
        string  sOnEnterExecute = GetLocalString (OBJECT_SELF, "AREA_SCRIPT_ENTER");
        if (sOnEnterExecute != "")
        {
            SetLocalObject(oPC, "ENTERING_AREA", OBJECT_SELF);
            ExecuteScript(sOnEnterExecute, oPC);
            DeleteLocalObject(oPC, "ENTERING_AREA");
        }


    }

    WriteTimestampedLogEntry(GetName(oPC)+"("+GetPCPublicCDKey(oPC)+") enters "+GetName(OBJECT_SELF)+". ("+IntToString(iPop)+" players in area.)");
    SendMessageToPC(oPC, GetWeatherFeedback(oPC));


    /*int nActivated = GetLocalInt(oArea, "Activated");
    string sATag = GetTag(oArea);
    int i;
    object oPlace;
    if(nActivated != 1)
    {
        SendMessageToPC(oPC,"Adding Persistent Placeables to Area.");
        int nPlaceCount = GetCampaignInt("TE_Placeable","pl"+sATag);

        if (nPlaceCount > 0)
        {
            for (i = 1; i < 20; i++)
            {
                if(GetCampaignInt("TE_AreaPlaceable","pl"+IntToString(i)+sATag) == 1)
                {
                   oPlace = CreateObject(OBJECT_TYPE_PLACEABLE, GetCampaignString("TE_Placeable","plr"+IntToString(i)+sATag), GetCampaignLocation("TE_Placeable","pll"+IntToString(i)+sATag));
                   SetName(oPlace,GetCampaignString("TE_Placeable","pln"+IntToString(i)+sATag));
                   SetDescription(oPlace, GetCampaignString("TE_Placeable","pld"+IntToString(i)+sATag));
                   SendMessageToPC(oPC,"Placeable #"+IntToString(i)+" added.");
                }
            }
        }
        SetLocalInt(oArea,"Activated",1);

    }
*/


    if(GetLocalInt(oArea,"nFlood") == 1)
    {
        if(GetLocalInt(oArea,"TILEMAGIC_APPLIED") == FALSE)
        {
            if (GetLocalInt(oMod,"nFlood") == 2)
            {
                SetLocalInt(oArea,"TILEMAGIC_APPLIED",TRUE);
                SetLocalInt(oArea,"nFlooStat",2);
                TLChangeAreaGroundTiles(oArea,X2_TL_GROUNDTILE_WATER,GetAreaSize(AREA_WIDTH,oArea),GetAreaSize(AREA_HEIGHT,oArea),GetLocalFloat(oArea,"fFlood2"));
            }
            else if (GetLocalInt(oMod,"nFlood") == 1)
            {
                SetLocalInt(oArea,"TILEMAGIC_APPLIED",TRUE);
                SetLocalInt(oArea,"nFlooStat",1);
                TLChangeAreaGroundTiles(oArea,X2_TL_GROUNDTILE_WATER,GetAreaSize(AREA_WIDTH,oArea),GetAreaSize(AREA_HEIGHT,oArea),GetLocalFloat(oArea,"fFlood1"));
            }
            else
            {
                SetLocalInt(oArea,"TILEMAGIC_APPLIED",FALSE);
            }
        }
        else
        {
            if(GetLocalInt(oMod,"nFlood") == 2 && GetLocalInt(oArea,"nFlooStat") == 1)
            {
                TLResetAreaGroundTilesEx(oArea);
                DelayCommand(0.1,TLChangeAreaGroundTiles(oArea,X2_TL_GROUNDTILE_WATER,GetAreaSize(AREA_WIDTH,oArea),GetAreaSize(AREA_HEIGHT,oArea),GetLocalFloat(oArea,"fFlood2")));
            }
        }
    }

    SetLocalString(oPC,"IN_AREA",ObjectToString(OBJECT_SELF)); // tracking whether Area Enter has finished and PC is in an area
    ExecuteScript("s_cleartrash",oArea);

    if(GetLocalInt(oArea,"nTrap") == 1)
    {
        ExecuteScript("yt_onarea_trap",oArea);
    }
}

// Does a Game of Groves check and activates/deactivates appropriate spawns.
void GameOfGrovesCheck(object oArea)
{
    string sGrove = GetLocalString(oArea,"NESS_GROVE");
    int nState = GetLocalInt(GetModule(),sGrove);
    string sGroveTag;
    string sGroveGroup;
    float fRain = GetLocalFloat(GetModule(),"Weather_Local_Rain");
    float fTemp = GetLocalFloat(GetModule(),"Weather_Local_Ground_Temperature");

    if(nState == 0)
    {
        nState = 1;
    }

    object oWaypoint = GetFirstObjectInArea(oArea);
    while (oWaypoint != OBJECT_INVALID)
    {
        if(GetObjectType(oWaypoint) == OBJECT_TYPE_WAYPOINT)
        {
            int iWeather = GetLocalInt(oWaypoint,"Weather");
            int iCommoner = GetLocalInt(oWaypoint,"Commoner");
            int iSeason = GetLocalInt(oWaypoint,"Season");
            int iRain = GetLocalInt(oWaypoint,"Rain");

            string sOwner = GetLocalString(oWaypoint,"sOwner");
            string sSetOwner   = GetCampaignString("Settlement",sOwner+"_sOwner");
            //Make Commoners hide when it's raining or snowing out.
            if(iCommoner != 0)
            {
                if(fRain > 0.0)
                {
                    NESS_DeactivateSpawn(oWaypoint);
                    DespawnChildren(oWaypoint);
                }
                else{NESS_ActivateSpawn(oWaypoint);}
            }
            if(iWeather != 0)
            {
                if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                else
                {
                    NESS_DeactivateSpawn(oWaypoint);
                    DespawnChildren(oWaypoint);
                }
            }

            sGroveGroup = GetLocalString(oWaypoint,"NESS_GROVE_GROUP");

            if(sGroveGroup != "")
            {
                if(nState <= 10)
                {
                    if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_007"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_009"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_011"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_013"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_016"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_019"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_020"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_021"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_022"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_023"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_025"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_030"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_047"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_052"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_055"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_062"){NESS_DeactivateSpawn(oWaypoint);}
                    else
                    {
                    //Summer Only Spawn
                        if(iSeason == 1)
                        {
                            //Temperature Above Freezing
                            if(fTemp >= 2.0)
                            {
                                //Rain Only Spawn
                                if(iRain == 1)
                                {
                                    if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                    else{NESS_DeactivateSpawn(oWaypoint);}
                                }
                                //No Rain Spawn
                                else if(iRain == 2)
                                {
                                    if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                    else{NESS_ActivateSpawn(oWaypoint);}
                                }
                                //No Rain Preference
                                else
                                {NESS_ActivateSpawn(oWaypoint);}
                            }
                            //Temperature Below Freezing
                            else
                            {NESS_DeactivateSpawn(oWaypoint);}
                        }
                        //Winter Only Spawn
                        else if(iSeason == 2)
                        {
                            //Temperature Below Freezing
                            if(fTemp < 2.0)
                            {
                                //Rain Only Spawn
                                if(iRain == 1)
                                {
                                    if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                    else{NESS_DeactivateSpawn(oWaypoint);}
                                }
                                //No Rain Spawn
                                else if(iRain == 2)
                                {
                                    if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                    else{NESS_ActivateSpawn(oWaypoint);}
                                }
                                //No Rain Preference
                                else
                                {NESS_ActivateSpawn(oWaypoint);}
                            }
                            //Temperature Below Freezing
                            else
                            {NESS_DeactivateSpawn(oWaypoint);}
                        }
                        //No Winter/Summer Preference
                        else
                        {
                            //Rain Only Spawn
                            if(iRain == 1)
                            {
                                if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                else{NESS_DeactivateSpawn(oWaypoint);}
                            }
                            //No Rain Spawn
                            else if(iRain == 2)
                            {
                                if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                else{NESS_ActivateSpawn(oWaypoint);}
                            }
                            //No Rain Preference
                            else
                            {NESS_ActivateSpawn(oWaypoint);}
                        }
                    }
                }
                else if ((nState > 10) && (nState <=30))
                {
                    if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_007"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_009"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_011"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_017"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_019"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_020"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_021"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_022"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_023"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_024"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_025"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_030"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_035"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_038"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_040"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_044"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_050"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_054"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_055"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_058"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_059"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_061"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_063"){NESS_DeactivateSpawn(oWaypoint);}
                    {
                    //Summer Only Spawn
                        if(iSeason == 1)
                        {
                            //Temperature Above Freezing
                            if(fTemp >= 2.0)
                            {
                                //Rain Only Spawn
                                if(iRain == 1)
                                {
                                    if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                    else{NESS_DeactivateSpawn(oWaypoint);}
                                }
                                //No Rain Spawn
                                else if(iRain == 2)
                                {
                                    if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                    else{NESS_ActivateSpawn(oWaypoint);}
                                }
                                //No Rain Preference
                                else
                                {NESS_ActivateSpawn(oWaypoint);}
                            }
                            //Temperature Below Freezing
                            else
                            {NESS_DeactivateSpawn(oWaypoint);}
                        }
                        //Winter Only Spawn
                        else if(iSeason == 2)
                        {
                            //Temperature Below Freezing
                            if(fTemp < 2.0)
                            {
                                //Rain Only Spawn
                                if(iRain == 1)
                                {
                                    if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                    else{NESS_DeactivateSpawn(oWaypoint);}
                                }
                                //No Rain Spawn
                                else if(iRain == 2)
                                {
                                    if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                    else{NESS_ActivateSpawn(oWaypoint);}
                                }
                                //No Rain Preference
                                else
                                {NESS_ActivateSpawn(oWaypoint);}
                            }
                            //Temperature Below Freezing
                            else
                            {NESS_DeactivateSpawn(oWaypoint);}
                        }
                        //No Winter/Summer Preference
                        else
                        {
                            //Rain Only Spawn
                            if(iRain == 1)
                            {
                                if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                else{NESS_DeactivateSpawn(oWaypoint);}
                            }
                            //No Rain Spawn
                            else if(iRain == 2)
                            {
                                if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                else{NESS_ActivateSpawn(oWaypoint);}
                            }
                            //No Rain Preference
                            else
                            {NESS_ActivateSpawn(oWaypoint);}
                        }
                    }
                }
                else if ((nState > 30) && (nState <=70))
                {
                    if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_001"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_004"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_005"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_008"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_011"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_012"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_017"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_024"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_025"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_026"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_032"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_033"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_035"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_036"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_037"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_038"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_039"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_040"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_042"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_043"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_044"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_049"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_050"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_053"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_054"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_055"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_058"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_059"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_061"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_063"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_065"){NESS_DeactivateSpawn(oWaypoint);}
                    else
                    {
                    //Summer Only Spawn
                        if(iSeason == 1)
                        {
                            //Temperature Above Freezing
                            if(fTemp >= 2.0)
                            {
                                //Rain Only Spawn
                                if(iRain == 1)
                                {
                                    if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                    else{NESS_DeactivateSpawn(oWaypoint);}
                                }
                                //No Rain Spawn
                                else if(iRain == 2)
                                {
                                    if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                    else{NESS_ActivateSpawn(oWaypoint);}
                                }
                                //No Rain Preference
                                else
                                {NESS_ActivateSpawn(oWaypoint);}
                            }
                            //Temperature Below Freezing
                            else
                            {NESS_DeactivateSpawn(oWaypoint);}
                        }
                        //Winter Only Spawn
                        else if(iSeason == 2)
                        {
                            //Temperature Below Freezing
                            if(fTemp < 2.0)
                            {
                                //Rain Only Spawn
                                if(iRain == 1)
                                {
                                    if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                    else{NESS_DeactivateSpawn(oWaypoint);}
                                }
                                //No Rain Spawn
                                else if(iRain == 2)
                                {
                                    if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                    else{NESS_ActivateSpawn(oWaypoint);}
                                }
                                //No Rain Preference
                                else
                                {NESS_ActivateSpawn(oWaypoint);}
                            }
                            //Temperature Below Freezing
                            else
                            {NESS_DeactivateSpawn(oWaypoint);}
                        }
                        //No Winter/Summer Preference
                        else
                        {
                            //Rain Only Spawn
                            if(iRain == 1)
                            {
                                if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                else{NESS_DeactivateSpawn(oWaypoint);}
                            }
                            //No Rain Spawn
                            else if(iRain == 2)
                            {
                                if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                else{NESS_ActivateSpawn(oWaypoint);}
                            }
                            //No Rain Preference
                            else
                            {NESS_ActivateSpawn(oWaypoint);}
                        }
                    }
                }
                else if ((nState > 70) && (nState <=90))
                {
                    if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_001"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_002"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_004"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_005"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_008"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_012"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_017"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_018"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_024"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_025"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_026"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_027"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_028"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_032"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_033"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_034"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_035"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_036"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_037"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_038"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_039"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_040"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_041"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_042"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_043"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_044"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_049"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_050"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_053"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_054"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_057"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_058"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_059"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_061"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_062"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_063"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_065"){NESS_DeactivateSpawn(oWaypoint);}
                    else
                    {
                    //Summer Only Spawn
                        if(iSeason == 1)
                        {
                            //Temperature Above Freezing
                            if(fTemp >= 2.0)
                            {
                                //Rain Only Spawn
                                if(iRain == 1)
                                {
                                    if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                    else{NESS_DeactivateSpawn(oWaypoint);}
                                }
                                //No Rain Spawn
                                else if(iRain == 2)
                                {
                                    if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                    else{NESS_ActivateSpawn(oWaypoint);}
                                }
                                //No Rain Preference
                                else
                                {NESS_ActivateSpawn(oWaypoint);}
                            }
                            //Temperature Below Freezing
                            else
                            {NESS_DeactivateSpawn(oWaypoint);}
                        }
                        //Winter Only Spawn
                        else if(iSeason == 2)
                        {
                            //Temperature Below Freezing
                            if(fTemp < 2.0)
                            {
                                //Rain Only Spawn
                                if(iRain == 1)
                                {
                                    if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                    else{NESS_DeactivateSpawn(oWaypoint);}
                                }
                                //No Rain Spawn
                                else if(iRain == 2)
                                {
                                    if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                    else{NESS_ActivateSpawn(oWaypoint);}
                                }
                                //No Rain Preference
                                else
                                {NESS_ActivateSpawn(oWaypoint);}
                            }
                            //Temperature Below Freezing
                            else
                            {NESS_DeactivateSpawn(oWaypoint);}
                        }
                        //No Winter/Summer Preference
                        else
                        {
                            //Rain Only Spawn
                            if(iRain == 1)
                            {
                                if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                else{NESS_DeactivateSpawn(oWaypoint);}
                            }
                            //No Rain Spawn
                            else if(iRain == 2)
                            {
                                if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                else{NESS_ActivateSpawn(oWaypoint);}
                            }
                            //No Rain Preference
                            else
                            {NESS_ActivateSpawn(oWaypoint);}
                        }
                    }
                }
                else
                {
                    if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_001"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_002"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_004"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_005"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_006"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_008"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_010"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_012"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_014"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_016"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_017"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_018"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_024"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_026"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_027"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_028"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_029"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_032"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_033"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_034"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_035"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_036"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_037"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_038"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_039"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_040"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_041"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_042"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_043"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_044"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_045"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_046"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_048"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_049"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_050"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_051"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_052"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_053"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_054"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_056"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_057"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_058"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_059"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_060"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_061"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_062"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_063"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_064"){NESS_DeactivateSpawn(oWaypoint);}
                    else if(GetLocalString(oWaypoint,"NESS_TAG") == "te_sylvan_065"){NESS_DeactivateSpawn(oWaypoint);}
                    else
                    {
                    //Summer Only Spawn
                        if(iSeason == 1)
                        {
                            //Temperature Above Freezing
                            if(fTemp >= 2.0)
                            {
                                //Rain Only Spawn
                                if(iRain == 1)
                                {
                                    if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                    else{NESS_DeactivateSpawn(oWaypoint);}
                                }
                                //No Rain Spawn
                                else if(iRain == 2)
                                {
                                    if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                    else{NESS_ActivateSpawn(oWaypoint);}
                                }
                                //No Rain Preference
                                else
                                {NESS_ActivateSpawn(oWaypoint);}
                            }
                            //Temperature Below Freezing
                            else
                            {NESS_DeactivateSpawn(oWaypoint);}
                        }
                        //Winter Only Spawn
                        else if(iSeason == 2)
                        {
                            //Temperature Below Freezing
                            if(fTemp < 2.0)
                            {
                                //Rain Only Spawn
                                if(iRain == 1)
                                {
                                    if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                    else{NESS_DeactivateSpawn(oWaypoint);}
                                }
                                //No Rain Spawn
                                else if(iRain == 2)
                                {
                                    if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                    else{NESS_ActivateSpawn(oWaypoint);}
                                }
                                //No Rain Preference
                                else
                                {NESS_ActivateSpawn(oWaypoint);}
                            }
                            //Temperature Below Freezing
                            else
                            {NESS_DeactivateSpawn(oWaypoint);}
                        }
                        //No Winter/Summer Preference
                        else
                        {
                            //Rain Only Spawn
                            if(iRain == 1)
                            {
                                if(fRain > 0.0){NESS_ActivateSpawn(oWaypoint);}
                                else{NESS_DeactivateSpawn(oWaypoint);}
                            }
                            //No Rain Spawn
                            else if(iRain == 2)
                            {
                                if(fRain > 0.0){NESS_DeactivateSpawn(oWaypoint);}
                                else{NESS_ActivateSpawn(oWaypoint);}
                            }
                            //No Rain Preference
                            else
                            {NESS_ActivateSpawn(oWaypoint);}
                        }
                    }
                }
            }
        }
        oWaypoint = GetNextObjectInArea(oArea);
    }
}
