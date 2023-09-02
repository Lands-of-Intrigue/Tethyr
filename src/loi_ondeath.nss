#include "nw_i0_plot"
#include "loi_functions"
#include "te_afflic_func"
#include "NWNX_Creature"
#include "nwnx_webhook"
#include "nwnx_webhook_rch"
#include "nwnx_time"
#include "habd_include"

void main()
{
    object oPC = GetLastPlayerDied();
    object oKiller = GetLastKiller();
    object oArea = GetArea(oPC);
    location lLoc = GetLocation(GetObjectByTag("WP_UndeadDeath"));
    int nTimestamp = GetCalendarYear()*10000+GetCalendarMonth()*100+GetCalendarDay();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    string sJoinMsg = GetPCPlayerName(oPC)+"/"+GetPCPublicCDKey(oPC) + " has just died.";
    string sAfflictionMsg;

    if(GetArea(oPC)== OBJECT_INVALID)
    {
        return;
    }

    if(GetTag(GetArea(oPC)) == "CityofJudgement")
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)),oPC);
        return;
    }

    if(GetLocalInt(oKiller,"SUBDUAL") == 1)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(1),oPC);
        return;
    }
    else
    {
        if(GetPCDeadStatus(oPC) != 1)
        {
            if (GetPCAffliction(oPC) == 2)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)/2),oPC);
                RemoveEffects(oPC);

                SetPCAffliction(oPC,3);
                Affliction_Items(oPC,3);

                NWNX_Creature_AddFeat(oPC, 1414);
                NWNX_Creature_AddFeat(oPC, 1415);
                NWNX_Creature_AddFeat(oPC, 1422);
                NWNX_Creature_AddFeat(oPC, 1423);
                NWNX_Creature_AddFeat(oPC, 1424);

               sAfflictionMsg = "Vampire Thrall to Vampire";
               //sAfflictionMsg += " vampire thrall.";
               //NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sAfflictionMsg, GetName(oPC));
            }
            else if (GetPCAffliction(oPC) == 3)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)),oPC);
                RemoveEffects(oPC);

                SetCreatureAppearanceType(oPC, 1099);
                SetPCAffliction(oPC,8);
                Affliction_Items(oPC,8);

                NWNX_Creature_RemoveFeat(oPC, 1414);
                NWNX_Creature_RemoveFeat(oPC, 1415);
                NWNX_Creature_RemoveFeat(oPC, 1422);
                NWNX_Creature_RemoveFeat(oPC, 1423);
                NWNX_Creature_RemoveFeat(oPC, 1424);

                SetLocalInt(oItem,"UndeadRespawn",nTimestamp+1);
                TeleportObjectToLocation(oPC,lLoc);
                sAfflictionMsg = "Vampire to Mist";
               //sAfflictionMsg += " vampire.";
               //NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sAfflictionMsg, GetName(oPC));
            }
            else if (GetPCAffliction(oPC) == 6)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)),oPC);
                RemoveEffects(oPC);

                SetPCAffliction(oPC,4);
                Affliction_Items(oPC,4);

                if(GetGender(oPC) == GENDER_MALE)
                {
                    SetCreatureAppearanceType(oPC,3548);
                }
                else
                {
                    SetCreatureAppearanceType(oPC,3541);
                }
                NWNX_Creature_AddFeat(oPC, 1414);
                NWNX_Creature_AddFeat(oPC, 1415);
                NWNX_Creature_AddFeat(oPC, 1422);
                NWNX_Creature_AddFeat(oPC, 1423);
                NWNX_Creature_AddFeat(oPC, 1424);

                sAfflictionMsg = "Drider to Drider Vampire";
            }
            else if (GetPCAffliction(oPC) == 7)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)),oPC);
                RemoveEffects(oPC);
                CreateUndeadPCBody(oPC, TRUE);
                if(GetItemPossessedBy(oPC,"te_phylactery") != OBJECT_INVALID)
                {
                    DestroyObject(GetItemPossessedBy(oPC,"te_phylactery"));
                    SetLocalInt(oItem,"UndeadRespawn",nTimestamp+1);
                    TeleportObjectToLocation(oPC,lLoc);
                }
                else
                {
                    TeleportObjectToLocation(oPC,GetWaypointLocation("wp_respawn_fugue"));
                    SetPCDeadStatus(oPC,1);
                }
                //NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sJoinMsg, GetName(oPC));
                sAfflictionMsg = "Lich to Ash";
            }
            else if (GetPCAffliction(oPC) == 5)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
                RemoveEffects(oPC);
                CreateUndeadPCBody(oPC, TRUE);

                if(GetLocalInt(oItem,"nReven") == TRUE)
                {
                    SetLocalInt(oItem,"UndeadRespawn",nTimestamp+1);
                    TeleportObjectToLocation(oPC,lLoc);
                }
                else
                {
                    TeleportObjectToLocation(oPC,GetWaypointLocation("wp_respawn_fugue"));
                    SetPCDeadStatus(oPC,1);
                }
                sAfflictionMsg = "Revenant to Ash";
               //sAfflictionMsg += " revenant.";
               //NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sAfflictionMsg, GetName(oPC));
            }
            else if (GetPCAffliction(oPC) == 8)
            {
                //Respawn PC
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
                RemoveEffects(oPC);
                CreateUndeadPCBody(oPC, TRUE);
                TeleportObjectToLocation(oPC,GetWaypointLocation("wp_respawn_fugue"));
                SetPCDeadStatus(oPC,1);
                sAfflictionMsg = "Mist to Ash";
            }
            else if (GetPCAffliction(oPC) == 4)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
                RemoveEffects(oPC);
                CreateUndeadPCBody(oPC, TRUE);
                TeleportObjectToLocation(oPC,GetWaypointLocation("wp_respawn_fugue"));
                SetPCDeadStatus(oPC,1);
                sAfflictionMsg = "Drider Vampire to Ash";
            }
            else
            {
                int iHPs = GetCurrentHitPoints(oPC);
                if (iHPs < 1 && iHPs >= -25)
                {
                    object oMod = GetModule();
                    string sID = GetPCPlayerName(oPC)+GetName(oPC);
                    int iState = GetLocalInt(oMod,HABD_PLAYER_STATE+sID);
                    if (iState == HABD_STATE_PLAYER_ALIVE)
                    {
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(),oPC); //sets PC to 1 HP
                        int nHeal = -6;   //should heal the player to -5 so that bleed script will take over
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHeal), oPC);
                    }
                }

                NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, sJoinMsg, GetName(oPC));

                if(GetTag(oArea) != "CityofJudgement")
                {
                    //Create Player Corpse
                    CreatePCBody(oPC, TRUE);
                }
                //Respawn PC
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
                RemoveEffects(oPC);

                //Area Handler
                location lTarget;
                if (GetPCAffliction(oPC) == 4)
                    {
                        lTarget = GetWaypointLocation("wp_respawn_fugue"); //PLACEHOLDER NOT DONE
                    }
                else {lTarget = GetWaypointLocation("wp_respawn_fugue");}

                //Teleport PC
                if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
                TeleportObjectToLocation(oPC, lTarget);
                //Set Player Data Object iPCDead 1
                SetPCDeadStatus(oPC, 1);
                //if (GetHitDice(oPC) >= 15)
                //{
                    //if (GetLocalInt(oItem,"DeathTracker") == 5)
                    //{
                        //SetLocalInt(oItem,"PermaDeath", TRUE);
                    //}
                    //else
                    //{
                        //SendMessageToPC(oPC, "You have died! After Level 10, Deaths have increased consequences. Your base Constitution Score has been decreased by one due to the strain on your mind and body. After this happens 5 times, you will be unable to be revived. Permanately Dead.");
                        //SetLocalInt(oItem,"DeathTracker", GetLocalInt(oItem,"DeathTracker") + 1);
                        //NWNX_Creature_SetRawAbilityScore(oPC, ABILITY_CONSTITUTION, NWNX_Creature_GetRawAbilityScore(oPC, ABILITY_CONSTITUTION)-1);
                    //}
                //}
            }

            struct NWNX_WebHook_Message sJoinMessage;
            sJoinMessage.sUsername = "Player Logs";
            sJoinMessage.sTitle = "Player Death!";
            sJoinMessage.sColor = "#0000FF";
            sJoinMessage.sAuthorName = GetName(oPC);
            sJoinMessage.sDescription = "**" + GetName(oPC) + "** has died! **"+GetName(oArea)+"**!";
            sJoinMessage.sField1Name = "Playername";
            sJoinMessage.sField1Value = GetPCPlayerName(oPC);
            sJoinMessage.iField1Inline = TRUE;
            sJoinMessage.sField2Name = "IP";
            sJoinMessage.sField2Value = GetPCIPAddress(oPC);
            sJoinMessage.iField2Inline = TRUE;
            sJoinMessage.sField3Name = "CDKey";
            sJoinMessage.sField3Value = GetPCPublicCDKey(oPC);
            sJoinMessage.iField3Inline = TRUE;
            sJoinMessage.sField4Name = "Undead State Change";
            sJoinMessage.sField4Value = sAfflictionMsg;
            sJoinMessage.iField4Inline = FALSE;
            sJoinMessage.sField4Name = "Area";
            sJoinMessage.sField4Value = GetName(oArea);
            sJoinMessage.iField4Inline = FALSE;
            sJoinMessage.sFooterText = "Knights of Noromath Player Event";
            sJoinMessage.iTimestamp = NWNX_Time_GetTimeStamp();
            string sConstructedMsg = NWNX_WebHook_BuildMessageForWebHook("discordapp.com", WEBHOOK_EVENT_CHANNEL, sJoinMessage);
            NWNX_WebHook_SendWebHookHTTPS("discordapp.com",WEBHOOK_EVENT_CHANNEL, sConstructedMsg);
        }
    }
}

