//::///////////////////////////////////////////////
//:: DMFI - OnPlayerChat event handler
//:: dmfi_onplychat
//:://////////////////////////////////////////////
/*
  Event handler for the module-level OnPlayerChat event. Manages scripter-added
  event scripts.
*/
//:://////////////////////////////////////////////
//:: Created By: Merle, with help from mykael22000 and tsunami282
//:: Created On: 2007.12.12
//:://////////////////////////////////////////////
//:: 2007.12.27 tsunami282 - implemented hooking tree

#include "dmfi_plychat_inc"
#include "mk_inc_editor"
#include "te_lang"
#include "subdual_inc"
#include "so_inc_weather"
#include "nwnx_rename"
#include "nwnx_player"
#include "ex_i0_date_time"
#include "tf_handler"
#include "dmfi_dmwx_inc"
#include "nwnx_chat"
#include "nwnx_admin"
#include "nwnx_webhook"
#include "sfpb_config"
#include "gs_inc_fixture"
#include "te_functions"
#include "gs_inc_shop"

const string DMFI_PLAYERCHAT_SCRIPTNAME = "dmfi_plychat_exe";

////////////////////////////////////////////////////////////////////////
void main()
{
    object oPC = GetPCChatSpeaker();
    object oPlayer = oPC;

////////////////////////////////////////////////////////////////////////
// MK Crafting System -- CCOH
////////////////////////////////////////////////////////////////////////

    string sChatMessage = GetPCChatMessage();

    int bEditorRunning = GetLocalInt(oPC, g_varEditorRunning);
    if (bEditorRunning) // the editor is running
    {
        int bUseOnPlayerChatEvent =
            GetLocalInt(oPC, g_varEditorUseOnPlayerChatEvent);

        if (bUseOnPlayerChatEvent)
        {
            SetLocalString(oPC, g_varEditorChatMessageString, sChatMessage);

            // the following line is not required but will make everything
            // look much better.
            SetPCChatMessage(""); // delete the message so it does not
                                  // appear above the player's head
        }
        return;
    }


/////////////////////////////////////////////////////////////////////
//Writing System by Bongo, December 2008. OnPlayerChat Script.///////
/////////////////////////////////////////////////////////////////////
//This script stores players chat messages as string when the commands are used.
  /*
  if(GetStringLeft(sChatMessage, 1)=="#")
  {
    string sCommand = GetStringLeft(sChatMessage, 3);
    if((sCommand=="#T#")||(sCommand=="#W#")||(sCommand=="#S#")||(sCommand=="#C#"))
      {
        string sIdentity = GetStringLeft(sChatMessage, 3);
        DeleteLocalString(oPC, sIdentity);
        DeleteLocalString(oPC, "#E#");
        DelayCommand(0.5, SetLocalString(oPC, sIdentity, sChatMessage));
        SendMessageToPC(oPC, sChatMessage);
        SetPCChatMessage("");
        return;
      }
    else if((sCommand=="#E#")||(sCommand=="#R#")||(sCommand=="#F#"))
      {
        DeleteLocalString(oPC, "#E#");
        DelayCommand(0.5, SetLocalString(oPC, "#E#", sChatMessage));
        SendMessageToPC(oPC, sChatMessage);
        SetPCChatMessage("");
        return;
      }
  }
  */
/////////////////////////////////////////////////////////////////////
//Default DMFI Lines. ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////
    if((GetIsDM(oPC) == TRUE ) || (GetIsDMPossessed(oPC) == TRUE))
    {
        int nVolume = GetPCChatVolume();
        object oShouter = GetPCChatSpeaker();

        int bInvoke;
        string sChatHandlerScript;
        int maskChannels;
        // int bListenAll;
        object oRunner;
        int bAutoRemove;
        int bDirtyList = FALSE;
        int iHook;
        object oMod = GetModule();
        // SendMessageToPC(GetFirstPC(), "OnPlayerChat - process hooks");
        int nHooks = GetLocalArrayUpperBound(oMod, DMFI_CHATHOOK_HANDLE_ARRAYNAME);
        for (iHook = nHooks; iHook > 0; iHook--) // reverse-order execution, last hook gets first dibs
        {
            // SendMessageToPC(GetFirstPC(), "OnPlayerChat -- process hook #" + IntToString(iHook));
            maskChannels = GetLocalArrayInt(oMod, DMFI_CHATHOOK_CHANNELS_ARRAYNAME, iHook);
            // SendMessageToPC(GetFirstPC(), "OnPlayerChat -- channel heard=" + IntToString(nVolume) + ", soughtmask=" + IntToString(maskChannels));
            if (((1 << nVolume) & maskChannels) != 0) // right channel
            {
                // SendMessageToPC(GetFirstPC(), "OnPlayerChat --- channel matched");

                bInvoke = FALSE;
                if (GetLocalArrayInt(oMod, DMFI_CHATHOOK_LISTENALL_ARRAYNAME, iHook) != FALSE)
                {
                    bInvoke = TRUE;
                }
                else
                {
                    object oDesiredSpeaker = GetLocalArrayObject(oMod, DMFI_CHATHOOK_SPEAKER_ARRAYNAME, iHook);
                    if (oShouter == oDesiredSpeaker) bInvoke = TRUE;
                }
                if (bInvoke) // right speaker
                {
                    // SendMessageToPC(GetFirstPC(), "OnPlayerChat --- speaker matched");
                    sChatHandlerScript = GetLocalArrayString(oMod, DMFI_CHATHOOK_SCRIPT_ARRAYNAME, iHook);
                    oRunner = GetLocalArrayObject(oMod, DMFI_CHATHOOK_RUNNER_ARRAYNAME, iHook);
                    // SendMessageToPC(GetFirstPC(), "OnPlayerChat --- executing script '" + sChatHandlerScript + "' on object '" + GetName(oRunner) +"'");
                    ExecuteScript(sChatHandlerScript, oRunner);
                    bAutoRemove = GetLocalArrayInt(oMod, DMFI_CHATHOOK_AUTOREMOVE_ARRAYNAME, iHook);
                    if (bAutoRemove)
                    {
                        // SendMessageToPC(GetFirstPC(), "OnPlayerChat --- scheduling autoremove");
                        bDirtyList = TRUE;
                        SetLocalArrayInt(oMod, DMFI_CHATHOOK_HANDLE_ARRAYNAME, iHook, 0);
                    }
                }
            }
        }

        if (bDirtyList) DMFI_ChatHookRemove(0);

        // always execute the DMFI parser
        ExecuteScript(DMFI_PLAYERCHAT_SCRIPTNAME, OBJECT_SELF);
    }


    if((GetPCChatVolume() == TALKVOLUME_TALK)||(GetPCChatVolume()==TALKVOLUME_WHISPER))
    {

        string sOriginal = GetPCChatMessage();
        object oWhisp;
        location lWhisSource = GetLocation(oPC);
        string sMessage;
        object oArea = GetArea(oPC);

        if(GetStringLeft(sOriginal,1) != "-")
        {
            if(GetLocalInt(oPC,"nXPReward") != 1 && (GetIsPC(oPC)== TRUE))
            {
                if(GetStringLength(sOriginal) > 35)
                {
                    SetLocalInt(oPC,"nXPReward", 1);
                }
            }

            if(GetLocalInt(oPC,"LangOn") == 1)
            {
                int iLangSpoken = GetLocalInt(oPC,"LangSpoken");
                string LANGCOLOR = "<c�E�>";
                object oArea = GetArea(oPC);
                string sName = GetName(oPC);


                if(GetLocalInt(oPC,"nDisguiseName") == 1)
                {
                    sName = NWNX_Rename_GetPCNameOverride(oPC);
                }

                string sSpeaking = GetLanguageName(iLangSpoken);

                NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, "Translated ("+sSpeaking+"): "+sOriginal, GetName(oPC));

                string sTranslate = LANGCOLOR+sName+" ("+sSpeaking+"): "+sOriginal+"</c>";
                string sColorOut = GetColorForLanguage(iLangSpoken);
                string sOutput=sColorOut+TranslateCommonToLanguage(iLangSpoken,sOriginal)+COLOR_END;

                object oListener = GetFirstObjectInArea(oArea);
                object oItem;

                object oPlayers = GetFirstPC();

                while (GetIsObjectValid(oPlayers))
                {
                    if (GetIsDM(oPlayers)||GetIsDMPossessed(oPlayers))
                    {
                        DelayCommand(0.3,SendMessageToPC(oPlayers,sTranslate));
                    }
                    oPlayers = GetNextPC();
                }

                if(GetPCChatVolume()==TALKVOLUME_TALK)
                {
                    while (GetIsObjectValid(oListener))
                    {
                        if (GetIsPC(oListener))
                        {
                            if(GetObjectHeard(oPC,oListener))
                            {
                                if(GetIsDM(oListener) != TRUE)
                                {
                                    oItem = GetItemPossessedBy(oListener,"PC_Data_Object");
                                    if(GetLocalInt(oItem,IntToString(iLangSpoken)) == 1)
                                    {
                                        DelayCommand(0.3,SendMessageToPC(oListener,sTranslate));
                                    }
                                }
                            }
                        }
                        oListener=GetNextObjectInArea(oArea);
                    }
                }
                else if (GetPCChatVolume()==TALKVOLUME_WHISPER)
                {
                    oWhisp = GetFirstObjectInShape(SHAPE_SPHERE,10.0f,lWhisSource,FALSE,OBJECT_TYPE_CREATURE);
                    while (GetIsObjectValid(oWhisp))
                    {
                         if(GetObjectHeard(oPC,oWhisp)||GetDistanceBetween(oPC,oWhisp) <= 3.0f)
                         {
                            if(GetIsDM(oWhisp) != TRUE)
                            {
                                oItem = GetItemPossessedBy(oWhisp,"PC_Data_Object");
                                if(GetLocalInt(oItem,IntToString(iLangSpoken)) == 1)
                                {
                                    DelayCommand(0.3,SendMessageToPC(oWhisp,sTranslate));
                                }
                            }
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) > 3.0f && GetDistanceBetween(oPC,oWhisp) < 3.5f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 5)
                         {
                            if(GetIsDM(oWhisp) != TRUE)
                            {
                                oItem = GetItemPossessedBy(oWhisp,"PC_Data_Object");
                                if(GetLocalInt(oItem,IntToString(iLangSpoken)) == 1)
                                {
                                    NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOutput,oPC,oWhisp);
                                    DelayCommand(0.3,SendMessageToPC(oWhisp,sTranslate));
                                }
                            }
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) >= 3.5f && GetDistanceBetween(oPC,oWhisp) < 4.5f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 10)
                         {
                            if(GetIsDM(oWhisp) != TRUE)
                            {
                                oItem = GetItemPossessedBy(oWhisp,"PC_Data_Object");
                                if(GetLocalInt(oItem,IntToString(iLangSpoken)) == 1)
                                {
                                    NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOutput,oPC,oWhisp);
                                    DelayCommand(0.3,SendMessageToPC(oWhisp,sTranslate));
                                }
                            }
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) >= 4.5f && GetDistanceBetween(oPC,oWhisp) < 5.5f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 15)
                         {
                            if(GetIsDM(oWhisp) != TRUE)
                            {
                                oItem = GetItemPossessedBy(oWhisp,"PC_Data_Object");
                                if(GetLocalInt(oItem,IntToString(iLangSpoken)) == 1)
                                {
                                    NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOutput,oPC,oWhisp);
                                    DelayCommand(0.3,SendMessageToPC(oWhisp,sTranslate));
                                }
                            }
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) >= 5.5f && GetDistanceBetween(oPC,oWhisp) < 6.5f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 20)
                         {
                            if(GetIsDM(oWhisp) != TRUE)
                            {
                                oItem = GetItemPossessedBy(oWhisp,"PC_Data_Object");
                                if(GetLocalInt(oItem,IntToString(iLangSpoken)) == 1)
                                {
                                    NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOutput,oPC,oWhisp);
                                    DelayCommand(0.3,SendMessageToPC(oWhisp,sTranslate));
                                }
                            }
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) >= 6.5f && GetDistanceBetween(oPC,oWhisp) < 7.5f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 25)
                         {
                            if(GetIsDM(oWhisp) != TRUE)
                            {
                                oItem = GetItemPossessedBy(oWhisp,"PC_Data_Object");
                                if(GetLocalInt(oItem,IntToString(iLangSpoken)) == 1)
                                {
                                    NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOutput,oPC,oWhisp);
                                    DelayCommand(0.3,SendMessageToPC(oWhisp,sTranslate));
                                }
                            }
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) >= 7.5f && GetDistanceBetween(oPC,oWhisp) < 8.5f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 30)
                         {
                            if(GetIsDM(oWhisp) != TRUE)
                            {
                                oItem = GetItemPossessedBy(oWhisp,"PC_Data_Object");
                                if(GetLocalInt(oItem,IntToString(iLangSpoken)) == 1)
                                {
                                    NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOutput,oPC,oWhisp);
                                    DelayCommand(0.3,SendMessageToPC(oWhisp,sTranslate));
                                }
                            }
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) >= 8.5f && GetDistanceBetween(oPC,oWhisp) < 9.5f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 35)
                         {
                            if(GetIsDM(oWhisp) != TRUE)
                            {
                                oItem = GetItemPossessedBy(oWhisp,"PC_Data_Object");
                                if(GetLocalInt(oItem,IntToString(iLangSpoken)) == 1)
                                {
                                    NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOutput,oPC,oWhisp);
                                    DelayCommand(0.3,SendMessageToPC(oWhisp,sTranslate));
                                }
                            }
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) >= 9.5f && GetDistanceBetween(oPC,oWhisp) < 10.0f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 40)
                         {
                            if(GetIsDM(oWhisp) != TRUE)
                            {
                                oItem = GetItemPossessedBy(oWhisp,"PC_Data_Object");
                                if(GetLocalInt(oItem,IntToString(iLangSpoken)) == 1)
                                {
                                    NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOutput,oPC,oWhisp);
                                    DelayCommand(0.3,SendMessageToPC(oWhisp,sTranslate));
                                }
                            }
                         }
                         oWhisp = GetNextObjectInShape(SHAPE_SPHERE,10.0f,lWhisSource,FALSE,OBJECT_TYPE_CREATURE);
                    }
                }
                SetPCChatMessage(sOutput);
            }
            else if(GetStringLeft(sOriginal,1) == "!")
            {
                object oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC,1);
                if(oAnimal != OBJECT_INVALID)
                {
                    sMessage = GetStringRight(sOriginal,GetStringLength(sOriginal)-1);
                    AssignCommand(oAnimal,ActionSpeakString(sMessage,GetPCChatVolume()));
                    SetPCChatMessage("");
                    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, "Possessing Animal Companion ("+GetName(oAnimal)+"): "+sMessage, GetName(oPC));
                }
            }
            else if(GetStringLeft(sOriginal,1) == "@")
            {
                object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC,1);
                if(oFamiliar != OBJECT_INVALID)
                {
                    sMessage = GetStringRight(sOriginal,GetStringLength(sOriginal)-1);
                    AssignCommand(oFamiliar,ActionSpeakString(sMessage,GetPCChatVolume()));
                    SetPCChatMessage("");
                    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, "Possessing Familiar ("+GetName(oFamiliar)+"): "+sMessage, GetName(oPC));
                }
            }
            else if(GetStringLeft(sOriginal,1) == "^")
            {
                object oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED,oPC,1);
                if(oSummoned != OBJECT_INVALID)
                {
                    sMessage = GetStringRight(sOriginal,GetStringLength(sOriginal)-1);
                    AssignCommand(oSummoned,ActionSpeakString(sMessage,GetPCChatVolume()));
                    SetPCChatMessage("");
                    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, "Possessing Summon ("+GetName(oSummoned)+"): "+sMessage, GetName(oPC));
                }
            }
            else if(GetStringLeft(sOriginal,1) == "%")
            {
                object oDominate = GetAssociate(ASSOCIATE_TYPE_DOMINATED,oPC,1);
                if(oDominate != OBJECT_INVALID)
                {
                    sMessage = GetStringRight(sOriginal,GetStringLength(sOriginal)-1);
                    AssignCommand(oDominate,ActionSpeakString(sMessage,GetPCChatVolume()));
                    SetPCChatMessage("");
                    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, "Possessing Dominated ("+GetName(oDominate)+"): "+sMessage, GetName(oPC));
                }
            }
            else if(GetStringLeft(sOriginal,1) == "$")
            {
                object oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,1);
                if(oHenchman != OBJECT_INVALID)
                {
                    sMessage = GetStringRight(sOriginal,GetStringLength(sOriginal)-1);
                    AssignCommand(oHenchman,ActionSpeakString(sMessage,GetPCChatVolume()));
                    SetPCChatMessage("");
                    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, "Possessing Henchman ("+GetName(oHenchman)+"): "+sMessage, GetName(oPC));
                }
            }
            else
            {
                if(GetPCChatVolume()==TALKVOLUME_WHISPER)
                {
                    oWhisp = GetFirstObjectInShape(SHAPE_SPHERE,10.0f,lWhisSource,FALSE,OBJECT_TYPE_CREATURE);

                    while (GetIsObjectValid(oWhisp))
                    {
                         if(GetDistanceBetween(oPC,oWhisp) > 3.0f && GetDistanceBetween(oPC,oWhisp) < 3.5f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 5)
                         {
                            NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOriginal,oPC,oWhisp);
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) >= 3.5f && GetDistanceBetween(oPC,oWhisp) < 4.5f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 10)
                         {
                            NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOriginal,oPC,oWhisp);
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) >= 4.5f && GetDistanceBetween(oPC,oWhisp) < 5.5f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 15)
                         {
                            NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOriginal,oPC,oWhisp);
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) >= 5.5f && GetDistanceBetween(oPC,oWhisp) < 6.5f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 20)
                         {
                            NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOriginal,oPC,oWhisp);
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) >= 6.5f && GetDistanceBetween(oPC,oWhisp) < 7.5f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 25)
                         {
                            NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOriginal,oPC,oWhisp);
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) >= 7.5f && GetDistanceBetween(oPC,oWhisp) < 8.5f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 30)
                         {
                            NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOriginal,oPC,oWhisp);
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) >= 8.5f && GetDistanceBetween(oPC,oWhisp) < 9.5f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 35)
                         {
                            NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOriginal,oPC,oWhisp);
                         }
                         else if(GetDistanceBetween(oPC,oWhisp) >= 9.5f && GetDistanceBetween(oPC,oWhisp) < 10.0f && GetSkillRank(SKILL_LISTEN,oWhisp,FALSE) >= 40)
                         {
                            NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_WHISPER,sOriginal,oPC,oWhisp);
                         }

                          oWhisp = GetNextObjectInShape(SHAPE_SPHERE,10.0f,lWhisSource,FALSE,OBJECT_TYPE_CREATURE);
                    }
                }
            }

        }
        else
        {
            sChatMessage = GetStringRight(sChatMessage,GetStringLength(sOriginal)-1);
            string sDisguiseName = GetStringRight(sChatMessage,GetStringLength(sOriginal)-6);
            SetPCChatMessage("");
            object oDataObject = GetItemPossessedBy(oPC,"PC_Data_Object");

            string sCurrCommandArg = parseArgs(sChatMessage,0);
            sCurrCommandArg = GetStringLowerCase(sCurrCommandArg);
            string sCommandArg2 = parseArgs(sChatMessage,1);
            sCommandArg2 = GetStringLowerCase(sCommandArg2);
            string sCommandArg3 = parseArgs(sChatMessage,2);
            sCommandArg3 = GetStringLowerCase(sCommandArg3);

            int nD20 = d20(1);
            string sCrit = "";
            string sRollString = CYAN;
            if(nD20 == 1)  {sCrit = DARKRED+"\nCritical Failure!"+COLOR_END;}

            if(sCurrCommandArg == "help"||sCurrCommandArg == "HELP"||sCurrCommandArg == "Help")
            {
                string sHelpCommand ="SP Console Command List: \n";
                sHelpCommand += "-help : Gives Command List \n";
                sHelpCommand += "! : Allows you to speak as a valid animal companion. Syntax: !<text>\n";
                sHelpCommand += "@ : Allows you to speak as a valid familiar. Syntax: @<text>\n";
                sHelpCommand += "^ : Allows you to speak as a valid summoned creature. (Use Henchman command if not working) Syntax: ^<text>\n";
                sHelpCommand += "% : Allows you to speak as a valid dominated creature. Syntax: %<text>\n";
                sHelpCommand += "$ : Allows you to speak as a valid henchman. (Use this command if summoned creatures not working) Syntax: $<text>\n";
                sHelpCommand += "-animation : Allows you to change your animation style for combat. Does not work while mounted. Certain styles are gated. To see styles available, use \"-animation list\".\n";
                sHelpCommand += "-debuff : Allows you to completely remove all spells you have cast on yourself. Syntax: -debuff \n";
                sHelpCommand += "-decloak : Allows you to remove only the invisibility effect you have cast on yourself. Syntax: -decloak \n";
                sHelpCommand += "-delete : Allows you to delete a character from your vault. Syntax: -delete \n";
                sHelpCommand += "-disguise : Allows you to disguise yourself using the various toggles on the examine system. (Class Standing, Strength, Dexterity, and Constitution) Syntax: -disguise \"Command\" Use -disguise help for full list.\n";
                sHelpCommand += "-emote : Allows you to emote doing a particular action. For a full list of available emotes, use \"-emote list\". Syntax: -emote \"Action\" Ex: -emote sit \n";
                if(GetLevelByClass(47,oPC)>=1)
                {
                    sHelpCommand += "-essence : Allows you to change your Eldritch Blast's essence. Syntax: -essence \"essence\" Ex: -ess frightful \n";
                }
                sHelpCommand += "-joust : Allows you to use the Jousting animation instead of standard riding animation. Syntax: -joust \"on/off\" \n";
                if(GetLevelByClass(CLASS_TYPE_MONK,oPC)>=1)
                {
                    sHelpCommand += "-ki : Returns your current ki level.\n";
                }
                sHelpCommand += "-lang / -speak : Sets new language to speak. Normal speech going forward will be in that language. To no longer speak a language, use \"-lang common\" Syntax: -lang \"language\" Ex: -lang Alzhedo \n";
                sHelpCommand += "-murder : Perform a coup de grace on the targeted bleeding out PC. \n";
                sHelpCommand += "-name : If disguise is on, this will allow you to change your displayed name. This will not persist across reset or log-out/crash. Syntax: - name \"Disguise Name\" Ex: -name Malcolm Reed \n";
                if(GetHasFeat(1203,oPC) == TRUE || GetLevelByClass(CLASS_TYPE_DRUID,oPC) >= 13 || GetHasFeat(1458,oPC) == TRUE)
                {
                    sHelpCommand += "-pheno : Allows you to toggle your phenotype on the fly, switching between large and normal. Syntax: -pheno. \n";
                }
                sHelpCommand += "-place : Allows you to update the name or description of a placeable. Functions similarly to the writing system. Type \"-place help\" for all available commands. Syntax: -place. \n";
                sHelpCommand += "-piety : Returns your current divine standing in the form of piety (0-100)\n";
                sHelpCommand += "-proficiency : Allows you to select a proficiency if the conversation does not appear for you the first time.\n";
                sHelpCommand += "-rest : Gives next rest time. \n";
                sHelpCommand += "-rename : Allows you to change the name and description of an object in your inventory. Type \"-rename help\" for all available commands. Syntax: -rename.\n";
                sHelpCommand += "-roll : Privately rolls a desired skill or ability. For full list of available rolls, use \"-roll list\" Syntax: -roll \"Ability/Skill/Save\" Ex: -roll will \n";
                sHelpCommand += "-spellfire : Displays the number of charges in your spellfire mana pool. Syntax: -spellfire\n";
                if(GetLevelByClass(CLASS_TYPE_MONK,oPC)>1)
                {
                    sHelpCommand += "-style : Allows you to cycle through the available styles for your monk order, use \"-style list\" to display all available styles. Use \"-style <type>\" to activate a particular style. \n";
                    sHelpCommand += "Use \"-style off\" to turn off your monk style and stop draining ki.\n";
                }
                sHelpCommand += "-subdual : Tells you whether Subdual mode is on or off. Type \"-subdual on\" to turn subdual mode on. Type \"-subdual off\" to turn subdual mode off.\n";
                sHelpCommand += "-time : Tells you the precise time IG when Timepiece item is in inventory. \n";
                if(GetHasFeat(1439,oPC) == TRUE)
                {
                    sHelpCommand += "-track : Tracks creatures down within a given area and populates their location if you successfully find their tracks. Type \"-track\" to use this proficiency. Ex: -track \n";
                }
                sHelpCommand += "-walk : Sets your character to ALWAYS walk when you travel. Useful for elves. Syntax: -walk. \n";
                sHelpCommand += "-weather : Gives the standard weather feedback message that displays on entry. Syntax: -weather.\n";
                sHelpCommand += "-write : Access to the writing menu for editing pieces of paper in game. Type \"-write help\" for all available commands. Syntax: -write.\n";
                if(GetHasFeat(1599,oPC) == TRUE)
                {
                    sHelpCommand +="-weave : Gives the general state of the weave in the area.\n";
                }
                if(GetIsDM(oPC) == TRUE)
                {
                    sHelpCommand +="-adddeadmagic : adds the specified number to the dead magic of the area (Adding dead magic increases the chance of spell failure).\n";
                    sHelpCommand +="-removedeadmagic : removes the specified number to the dead magic of the area (Removing dead magic decreases the chance of spell failure).\n";
                    sHelpCommand +="-addwildmagic : adds the specified number to the wild magic of the area (Adding wild magic increases the chance of wild events).\n";
                    sHelpCommand +="-removewildmagic : removes the specified number to the wild magic of the area (Removing wild magic decreases the chance of wild events).\n";
                    sHelpCommand +="-shopset : sets the price for the given shop unique string., ARG2 = UNIQUE STRING, ARG3 = PRICE\n";
                }
                // sHelpCommand +="-bug : Gives a bug report to the DMs";
                SendMessageToPC(oPC,sHelpCommand);
            }
            else if(sCurrCommandArg == "shout")
            {
                string sNewOriginal = GetStringRight(sChatMessage,GetStringLength(sOriginal)-7);
                int iLangShout = GetLocalInt(oPC,"LangSpoken");
                object oShoutArea = GetArea(oPC);
                string sShoutName = GetName(oPC);

                if(GetLocalInt(oPC,"nDisguiseName") == 1)
                {
                    sShoutName = NWNX_Rename_GetPCNameOverride(oPC);
                }

                string sShouting = GetLanguageName(iLangShout);

                if(GetLocalInt(oPC,"LangOn") == 1)
                {
                    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_CHAT_CHANNEL, "Translated ("+sShouting+"): "+sNewOriginal, GetName(oPC));
                }

                string sTranslateShout = "<c�E�>"+sShoutName+" ("+sShouting+"): "+sNewOriginal+"</c>";
                string sColorShout = GetColorForLanguage(iLangShout);
                string sShoutOutput=sColorShout+TranslateCommonToLanguage(iLangShout,sNewOriginal)+COLOR_END;

                object oShout = GetFirstPC();
                object oShoutData;

                while(GetIsObjectValid(oShout))
                {
                    if(GetIsDM(oShout) || GetIsDMPossessed(oShout))
                    {
                        DelayCommand(0.3,SendMessageToPC(oShout,sTranslateShout));
                    }

                    if(GetArea(oShout) == oShoutArea)
                    {
                        oShoutData = GetItemPossessedBy(oShout,"PC_Data_Object");
                        NWNX_Chat_SendMessage(NWNX_CHAT_CHANNEL_PLAYER_TALK,sShoutOutput,oPC,oShout);
                        if(GetLocalInt(oShoutData,IntToString(iLangShout)) == 1)
                        {
                            DelayCommand(0.3,SendMessageToPC(oShout,sTranslateShout));
                        }
                    }
                }
            }
            else if(sCurrCommandArg == "essence" || sCurrCommandArg =="ess" || sCurrCommandArg =="warlock" || sCurrCommandArg == "war")
            {
                if(GetLevelByClass(47,oPC) >= 1)
                {
                    int nEssence = GetLocalInt(oPC,"nEssence");

                    if((sCommandArg2 == "frightful" || sCommandArg2 == "fright") && GetHasFeat(1575,oPC) == TRUE)
                    {
                        if(GetLocalInt(oPC,"nEssence") == 1055) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
                        else {SetLocalInt(oPC,"nEssence",1055);  SendMessageToPC(oPC,"You are now using Frightful Blast essence.");}
                    }
                    else if((sCommandArg2 == "sickening" || sCommandArg2 == "sick") && GetHasFeat(1576,oPC) == TRUE)
                    {
                        if(GetLocalInt(oPC,"nEssence") == 1056) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
                        else {SetLocalInt(oPC,"nEssence",1056);  SendMessageToPC(oPC,"You are now using Sickening Blast essence.");}
                    }
                    else if((sCommandArg2 == "brimstone" || sCommandArg2 == "brim"|| sCommandArg2 == "fire") && GetHasFeat(1577,oPC) == TRUE)
                    {
                        if(GetLocalInt(oPC,"nEssence") == 1057) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
                        else {SetLocalInt(oPC,"nEssence",1057);  SendMessageToPC(oPC,"You are now using Brimstone Blast essence.");}
                    }
                    else if((sCommandArg2 == "hellrime" || sCommandArg2 == "hell"|| sCommandArg2 == "cold") && GetHasFeat(1578,oPC) == TRUE)
                    {
                        if(GetLocalInt(oPC,"nEssence") == 1058) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
                        else {SetLocalInt(oPC,"nEssence",1058);  SendMessageToPC(oPC,"You are now using Hellrime Blast essence.");}
                    }
                    else if((sCommandArg2 == "vitriolic" || sCommandArg2 == "vitr"|| sCommandArg2 == "acid") && GetHasFeat(1579,oPC) == TRUE)
                    {
                        if(GetLocalInt(oPC,"nEssence") == 1059) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
                        else {SetLocalInt(oPC,"nEssence",1059);  SendMessageToPC(oPC,"You are now using Vitriolic Blast essence.");}
                    }
                    else if((sCommandArg2 == "bewitching" || sCommandArg2 == "bewitch") && GetHasFeat(1580,oPC) == TRUE)
                    {
                        if(GetLocalInt(oPC,"nEssence") == 1060) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
                        else {SetLocalInt(oPC,"nEssence",1060);  SendMessageToPC(oPC,"You are now using Bewitching Blast essence.");}
                    }
                    else if((sCommandArg2 == "utterdark" || sCommandArg2 == "utter"|| sCommandArg2 == "neg") && GetHasFeat(1581,oPC) == TRUE)
                    {
                        if(GetLocalInt(oPC,"nEssence") == 1061) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
                        else {SetLocalInt(oPC,"nEssence",1061);  SendMessageToPC(oPC,"You are now using Utterdark Blast essence.");}
                    }
                    else if((sCommandArg2 == "repelling" || sCommandArg2 == "repel") && GetHasFeat(1582,oPC) == TRUE)
                    {
                        if(GetLocalInt(oPC,"nEssence") == 1062) {SetLocalInt(oPC,"nEssence",0); SendMessageToPC(oPC,"You are no longer using an essence.");}
                        else {SetLocalInt(oPC,"nEssence",1062);  SendMessageToPC(oPC,"You are now using Repelling Blast essence.");}
                    }
                    else if(sCommandArg2 == "none" || sCommandArg2 == "off")
                    {
                        SendMessageToPC(oPC,"Essence type set to none.");
                        SetLocalInt(oPC,"nEssence",0);
                    }
                    else
                    {
                        SendMessageToPC(oPC,"Essence type not recognized - Essence set to None.");
                    }
                }
                else
                {
                    SendMessageToPC(oPC,"Command not available to non-warlocks.");
                }
            }
            else if(sCurrCommandArg == "rename")
            {
                object oRenameObject = GetLocalObject(oPC,"ObjectEdit");
                string sObjText;
                string sItemDesc;
                if(GetIsObjectValid(oRenameObject) != TRUE && GetItemPossessor(oRenameObject) != oPC)
                {
                    SendMessageToPC(oPC,"You must select an object with the Combiner (silver star) tool to be able to edit the name or description of an object.");
                    return;
                }

                if(sCommandArg2 == "help")
                {
                    SendMessageToPC(oPC,"The Rename Command allows you to edit the title and description of any valid item in your inventory.\nThe following commands are available:\nhelp - gives this help message\ntitle - changes the title of an item\nadd - adds your text in addition to the text already on the item\nnew - overwrites all text on the item as your text\nline - starts your added text on new line.");
                }
                else if(sCommandArg2 == "title")
                {
                    sObjText = GetStringRight(sChatMessage,GetStringLength(sOriginal)-14);
                    SetName(oRenameObject,sObjText);
                    SendMessageToPC(oPC,"Title of item set as: "+sObjText);
                }
                else if(sCommandArg2 == "add")
                {
                    sObjText = GetStringRight(sChatMessage,GetStringLength(sOriginal)-12);
                    sItemDesc = GetDescription(oRenameObject,FALSE,TRUE);
                    SetDescription(oRenameObject,sItemDesc+" "+sObjText,TRUE);
                    SendMessageToPC(oPC,"Text added to item as: "+sObjText);
                }
                else if(sCommandArg2 == "line")
                {
                    sObjText = GetStringRight(sChatMessage,GetStringLength(sOriginal)-13);
                    sItemDesc = GetDescription(oRenameObject,FALSE,TRUE);
                    SetDescription(oRenameObject,sItemDesc+"\n"+sObjText,TRUE);
                    SendMessageToPC(oPC,"Text added to new line of item description as: "+sObjText);
                }
                else if(sCommandArg2 == "new")
                {
                    sObjText = GetStringRight(sChatMessage,GetStringLength(sOriginal)-12);
                    sItemDesc = GetDescription(oRenameObject,FALSE,TRUE);
                    SetDescription(oRenameObject,sObjText,TRUE);
                    SendMessageToPC(oPC,"New description given to line of item description as: "+sObjText);
                }
            }
            else if(sCurrCommandArg == "proficiency"|| sCurrCommandArg == "prof")
            {
                if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Prof") >= 1)
                {
                    SendMessageToPC(oPC,"Please choose an additional proficiency. Proficiencies cannot be banked, and will become void if you do not choose an additional proficiency.");
                    AssignCommand(oPC,ActionStartConversation(oPC,"te_prof_lvl",TRUE,FALSE));
                }
                else
                {
                    SendMessageToPC(oPC,"You do not have any proficiencies that may be selected.");
                }
            }
            else if(sCurrCommandArg == "mastery")
            {
                if(     sCommandArg2 == "necromancy"    || sCommandArg2 == "nec" ) SendMessageToPC(oPC,IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Necromancy"))+" spellmastery in necromancy.");
                else if(sCommandArg2 == "transmutation" || sCommandArg2 == "tra" ) SendMessageToPC(oPC,IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Transmutation"))+" spellmastery in transmutation.");
                else if(sCommandArg2 == "abjuration"    || sCommandArg2 == "abj" ) SendMessageToPC(oPC,IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Abjuration"))+" spellmastery in abjuration.");
                else if(sCommandArg2 == "divination"    || sCommandArg2 == "div" ) SendMessageToPC(oPC,IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Divination"))+" spellmastery in divination.");
                else if(sCommandArg2 == "conjuration"   || sCommandArg2 == "con" ) SendMessageToPC(oPC,IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Conjuration"))+" spellmastery in conjuration.");
                else if(sCommandArg2 == "enchantment"   || sCommandArg2 == "enc" ) SendMessageToPC(oPC,IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Enchantment"))+" spellmastery in enchantment.");
                else if(sCommandArg2 == "evocation"     || sCommandArg2 == "evo" ) SendMessageToPC(oPC,IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Evocation"))+" spellmastery in evocation.");
                else if(sCommandArg2 == "illusion"      || sCommandArg2 == "ill" ) SendMessageToPC(oPC,IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"Illusion"))+" spellmastery in illusion.");
            }
            else if(sCurrCommandArg == "murder")
            {
                object oTarget = GetCurrentInteractionTarget();
                // if the target is a player who is bleeding out
                if (GetIsPlayerCharacter(oTarget) == TRUE && GetCurrentHitPoints(oTarget) < 1)
                {
                    // KILL THEM
                    SetPlotFlag(oTarget, FALSE);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectDamage(100,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_PLUS_FIVE), oTarget);

                    SendMessageToPC(oTarget,"You have been murdered.");
                    SendMessageToPC(oPC,"You have murdered "+GetName(oTarget)+".");
                    FloatingTextStringOnCreature(GetName(oTarget)+" has been murdered in cold blood.", oTarget);
                }
                else
                {
                    SendMessageToPC(oPC,"Invalid murder target. Ctrl+click a bleeding out player character.");
                }
            }
            else if(sCurrCommandArg == "mythic")
            {
                SendMessageToPC(oPC,"A new point in each skill is achieved at 1000, 2000, 4000, and 8000 Mythic Points.");
                SendMessageToPC(oPC,IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicSTR"))+" Mythic Strength Points");
                SendMessageToPC(oPC,IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicDEX"))+" Mythic Dexterity Points");
                SendMessageToPC(oPC,IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicCON"))+" Mythic Constitution Points");
                SendMessageToPC(oPC,IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicINT"))+" Mythic Intelligence Points");
                SendMessageToPC(oPC,IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicWIS"))+" Mythic Wisdom Points");
                SendMessageToPC(oPC,IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"MythicCHA"))+" Mythic Charisma Points");
            }
            else if(sCurrCommandArg == "animation" || sCurrCommandArg == "anim" || sCurrCommandArg == "anime")
            {
                if(sCommandArg2 == "list")
                {
                    string sAnimList = "You are able to use the following combat styles:\n";

                    if(GetLevelByClass(CLASS_TYPE_DRUID,oPC)   >= 1 ||
                       GetLevelByClass(CLASS_TYPE_FIGHTER,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_RANGER,oPC)  >= 1 ||
                       GetLevelByClass(CLASS_TYPE_PALADIN,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_CLERIC,oPC)  >= 1)
                    {
                        sAnimList += "- Sword Master\n";
                    }
                    if(GetLevelByClass(CLASS_TYPE_DRUID,oPC)   >= 1 ||
                       GetLevelByClass(CLASS_TYPE_FIGHTER,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_RANGER,oPC)  >= 1 ||
                       GetLevelByClass(CLASS_TYPE_PALADIN,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_CLERIC,oPC)  >= 1)
                    {
                        sAnimList += "- Brute\n";
                    }
                    if(GetLevelByClass(CLASS_TYPE_DRUID,oPC)   >= 1 ||
                       GetLevelByClass(CLASS_TYPE_FIGHTER,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_RANGER,oPC)  >= 1 ||
                       GetLevelByClass(CLASS_TYPE_PALADIN,oPC) >= 1)
                    {
                        sAnimList += "- Soldier's Stance\n";
                    }
                    if(GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_RANGER,oPC)   >= 1 ||
                       GetLevelByClass(CLASS_TYPE_ROGUE,oPC)    >= 1 )
                    {
                        sAnimList += "- Twin Jambiyas\n";
                    }
                    if(GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)   >= 1 ||
                       GetLevelByClass(CLASS_TYPE_BARD,oPC)      >= 1 ||
                       GetLevelByClass(CLASS_TYPE_RANGER,oPC)    >= 1 ||
                       GetLevelByClass(CLASS_TYPE_BLACKCOAT,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_ROGUE,oPC)     >= 1 )
                    {
                        sAnimList += "- Duelist\n";
                    }
                    if(GetLevelByClass(CLASS_TYPE_CLERIC,oPC)    >= 1 ||
                       GetLevelByClass(CLASS_TYPE_WIZARD,oPC)    >= 1 ||
                       GetLevelByClass(CLASS_TYPE_SORCERER,oPC)  >= 1 ||
                       GetLevelByClass(CLASS_TYPE_SPELLFIRE,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_DRUID,oPC)     >= 1 ||
                       GetLevelByClass(CLASS_TYPE_WARLOCK,oPC)   >= 1 )
                    {
                        sAnimList += "- Arcane\n";
                    }
                    sAnimList += "To activate a fighting style, type \"-animation <style>\", EX: \"-style duelist\" activates Duelist animations.\n";
                    sAnimList += "To deactivate a fighting style, type \"-animation none\".";
                    SendMessageToPC(oPC,sAnimList);
                }
                else if(sCommandArg2 == "none")
                {
                    if(HorseGetIsMounted(oPC) != TRUE &&
                      (GetPhenoType(oPC) == 50|| GetPhenoType(oPC) == 51||GetPhenoType(oPC) == 52||GetPhenoType(oPC) == 53||GetPhenoType(oPC) == 54||
                       GetPhenoType(oPC) == 55||GetPhenoType(oPC) == 56)
                      )
                    {
                        SetPhenoType(0,oPC);
                    }
                    else{SendMessageToPC(oPC,"Command is unavailable while mounted.");}
                }
                else if(sCommandArg2 == "sword" || sCommandArg2 == "master"|| sCommandArg2 == "kensei")
                {
                    if(GetLevelByClass(CLASS_TYPE_DRUID,oPC)   >= 1 ||
                       GetLevelByClass(CLASS_TYPE_FIGHTER,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_RANGER,oPC)  >= 1 ||
                       GetLevelByClass(CLASS_TYPE_PALADIN,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_CLERIC,oPC)  >= 1)
                    {
                        if(HorseGetIsMounted(oPC) != TRUE)
                        {
                            SetPhenoType(50,oPC);
                            SendMessageToPC(oPC,"Fighting Style: Sword Master.");
                        }
                        else{SendMessageToPC(oPC,"Command is unavailable while mounted.");}
                    }
                }
                else if(sCommandArg2 == "brute" || sCommandArg2 == "heavy")
                {
                    if(GetLevelByClass(CLASS_TYPE_DRUID,oPC)   >= 1 ||
                       GetLevelByClass(CLASS_TYPE_FIGHTER,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_RANGER,oPC)  >= 1 ||
                       GetLevelByClass(CLASS_TYPE_PALADIN,oPC) >= 1)
                    {
                        if(HorseGetIsMounted(oPC) != TRUE)
                        {
                            SetPhenoType(52,oPC);
                            SendMessageToPC(oPC,"Fighting Style: Brute.");
                        }
                        else{SendMessageToPC(oPC,"Command is unavailable while mounted.");}
                    }
                }
                else if(sCommandArg2 == "fence" || sCommandArg2 == "duelist" || sCommandArg2 == "duel")
                {
                    if(GetLevelByClass(CLASS_TYPE_FIGHTER,oPC)   >= 1 ||
                       GetLevelByClass(CLASS_TYPE_BARD,oPC)      >= 1 ||
                       GetLevelByClass(CLASS_TYPE_RANGER,oPC)    >= 1 ||
                       GetLevelByClass(CLASS_TYPE_BLACKCOAT,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_ROGUE,oPC)     >= 1 )
                    {
                        if(HorseGetIsMounted(oPC) != TRUE)
                        {
                            SetPhenoType(53,oPC);
                            SendMessageToPC(oPC,"Fighting Style: Duelist.");
                        }
                        else{SendMessageToPC(oPC,"Command is unavailable while mounted.");}
                    }
                }
                else if(sCommandArg2 == "warrior" || sCommandArg2 == "soldier"|| sCommandArg2 == "phalanx" || sCommandArg2 == "soldier's")
                {
                    if(GetLevelByClass(CLASS_TYPE_DRUID,oPC)   >= 1 ||
                       GetLevelByClass(CLASS_TYPE_FIGHTER,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_RANGER,oPC)  >= 1 ||
                       GetLevelByClass(CLASS_TYPE_PALADIN,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_CLERIC,oPC)  >= 1)
                    {
                        if(HorseGetIsMounted(oPC) != TRUE)
                        {
                            SetPhenoType(56,oPC);
                            SendMessageToPC(oPC,"Fighting Style: Soldier's Stance.");
                        }
                        else{SendMessageToPC(oPC,"Command is unavailable while mounted.");}
                    }
                }
                else if(sCommandArg2 == "assassin" || sCommandArg2 == "jambiya"|| sCommandArg2 == "twin"|| sCommandArg2 == "jambiyas")
                {
                    if(GetLevelByClass(CLASS_TYPE_ASSASSIN,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_RANGER,oPC)   >= 1 ||
                       GetLevelByClass(CLASS_TYPE_ROGUE,oPC)    >= 1 )
                    {
                        if(HorseGetIsMounted(oPC) != TRUE)
                        {
                            SetPhenoType(51,oPC);
                            SendMessageToPC(oPC,"Fighting Style: Twin Jambiyas.");
                        }
                        else{SendMessageToPC(oPC,"Command is unavailable while mounted.");}
                    }
                }
                else if(sCommandArg2 == "arcane" || sCommandArg2 == "levitation"|| sCommandArg2 == "magic")
                {
                    if(GetLevelByClass(CLASS_TYPE_CLERIC,oPC)    >= 1 ||
                       GetLevelByClass(CLASS_TYPE_WIZARD,oPC)    >= 1 ||
                       GetLevelByClass(CLASS_TYPE_SORCERER,oPC)  >= 1 ||
                       GetLevelByClass(CLASS_TYPE_SPELLFIRE,oPC) >= 1 ||
                       GetLevelByClass(CLASS_TYPE_DRUID,oPC)     >= 1 ||
                       GetLevelByClass(CLASS_TYPE_WARLOCK,oPC)   >= 1 )
                    {
                        if(HorseGetIsMounted(oPC) != TRUE)
                        {
                            SetPhenoType(54,oPC);
                            SendMessageToPC(oPC,"Fighting Style: Arcane.");
                        }
                        else{SendMessageToPC(oPC,"Command is unavailable while mounted.");}
                    }
                }
                else
                {
                    SendMessageToPC(oPC,"Command not recognized. Self destruct activated. Type \"-animation list\" for a list of available animations.");
                }
            }
            else if(sCurrCommandArg == "ki")
            {
                SendMessageToPC(oPC,"Your ki level is currently "+IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"KiLevel"))+".");
            }
            else if(sCurrCommandArg == "pheno")
            {
                if(sCommandArg2 == "fix")
                {
                    if(HorseGetIsMounted(oPC) != TRUE) {SetPhenoType(0,oPC);}
                }

                int nPheno = StringToInt(sCommandArg2);
                if(HorseGetIsMounted(oPC) != TRUE && GetIsDM(oPC) == TRUE)
                {
                    SetPhenoType(nPheno,oPC);
                    return;
                }

                if(HorseGetIsMounted(oPC) != TRUE)
                {
                    if(GetHasFeat(1203,oPC) == TRUE || GetLevelByClass(CLASS_TYPE_DRUID,oPC) >= 13 || GetHasFeat(1458,oPC) == TRUE)
                    {
                        if(GetPhenoType(oPC) == PHENOTYPE_NORMAL)
                        {
                            SetPhenoType(PHENOTYPE_BIG,oPC);
                            SendMessageToPC(oPC,"Phenotype set to large.");
                        }
                        else
                        {
                            SetPhenoType(PHENOTYPE_NORMAL,oPC);
                            SendMessageToPC(oPC,"Phenotype set to normal.");
                        }
                    }
                }
            }
            else if(sCurrCommandArg == "style")
            {
                if((GetLevelByClass(CLASS_TYPE_MONK,oPC) >= 1 && HorseGetIsMounted(oPC) != TRUE)|| GetIsDM(oPC) == TRUE)
                {
                    SendMessageToPC(oPC,"Your ki level is currently "+IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"KiLevel"))+".");
                    if(sCommandArg2 == "list"||sCommandArg2 == "help")
                    {
                        string MonkList = "Your deity has revealed the following martial arts styles:\n";
                        if(GetHasFeat(DEITY_Sune,oPC) == TRUE || GetHasFeat(DEITY_Selune,oPC) == TRUE || GetHasFeat(DEITY_Lathander,oPC) == TRUE)
                        {
                            MonkList += "- Flaming Fist\n";
                        }
                        if(GetHasFeat(DEITY_Sune,oPC) == TRUE || GetHasFeat(DEITY_Selune,oPC) == TRUE || GetHasFeat(DEITY_Lathander,oPC) == TRUE || GetHasFeat(DEITY_Shar,oPC) == TRUE)
                        {
                            MonkList += "- Eclipse\n";
                        }
                        if(GetHasFeat(DEITY_Shar,oPC) == TRUE)
                        {
                            MonkList += "- Cobra\n";
                        }
                        if(GetHasFeat(DEITY_Azuth,oPC) == TRUE)
                        {
                            MonkList += "- Deva\n";
                        }
                        if(GetHasFeat(DEITY_Ilmater,oPC) == TRUE)
                        {
                            MonkList += "- Eagle\n";
                        }
                        MonkList += "To activate a fighting style, type \"-style <style>\", EX: \"-style flaming\" activates Flaming Fist.\n";
                        MonkList += "To deactivate a fighting style, type \"-style none\".";
                        SendMessageToPC(oPC,MonkList);
                    }
                    else if(sCommandArg2 == "flame" || sCommandArg2 == "flaming" || sCommandArg2 == "sun"|| sCommandArg2 == "soul")
                    {
                        if(GetHasFeat(DEITY_Sune,oPC) == TRUE || GetHasFeat(DEITY_Selune,oPC) == TRUE || GetHasFeat(DEITY_Lathander,oPC) == TRUE)
                        {
                            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"KiLevel")>=5 || GetIsDM(oPC) == TRUE)
                            {
                                SetLocalInt(oPC,"MonkStyle",1);
                                if(GetPhenoType(oPC) == 0){SetPhenoType(58,oPC);}
                                SendMessageToPC(oPC,"You are now using Flaming Fist style martial arts. You will consume ki while in this stance.");
                            }
                            else {SendMessageToPC(oPC,"Your ki is too low to begin using this style.");}
                        }
                        else {SendMessageToPC(oPC,"You are not trained in this style.");}
                    }
                    else if(sCommandArg2 == "eclipse" || sCommandArg2 == "moon")
                    {
                        if(GetHasFeat(DEITY_Sune,oPC) == TRUE || GetHasFeat(DEITY_Selune,oPC) == TRUE || GetHasFeat(DEITY_Lathander,oPC) == TRUE || GetHasFeat(DEITY_Shar,oPC) == TRUE)
                        {
                            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"KiLevel")>=5 || GetIsDM(oPC) == TRUE)
                            {
                                SetLocalInt(oPC,"MonkStyle",2);
                                if(GetPhenoType(oPC) == 0){SetPhenoType(59,oPC);}
                                SendMessageToPC(oPC,"You are now using Eclipse style martial arts. You will consume ki while in this stance.");
                            }
                            else {SendMessageToPC(oPC,"Your ki is too low to begin using this style.");}
                        }
                    }
                    else if(sCommandArg2 == "cobra" || sCommandArg2 == "snake" || sCommandArg2 == "shar")
                    {
                        if(GetHasFeat(DEITY_Shar,oPC) == TRUE)
                        {
                            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"KiLevel")>=5 || GetIsDM(oPC) == TRUE)
                            {
                                SetLocalInt(oPC,"MonkStyle",3);
                                if(GetPhenoType(oPC) == 0){SetPhenoType(57,oPC);}
                                SendMessageToPC(oPC,"You are now using Cobra style martial arts. You will consume ki while in this stance.");
                            }
                            else {SendMessageToPC(oPC,"Your ki is too low to begin using this style.");}
                        }
                        else {SendMessageToPC(oPC,"You are not trained in this style.");}
                    }
                    else if(sCommandArg2 == "deva" || sCommandArg2 == "divine" || sCommandArg2 == "azuth" || sCommandArg2 == "magic")
                    {
                        if(GetHasFeat(DEITY_Azuth,oPC) == TRUE)
                        {
                            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"KiLevel")>=5 || GetIsDM(oPC) == TRUE)
                            {
                                SetLocalInt(oPC,"MonkStyle",4);
                                if(GetPhenoType(oPC) == 0){SetPhenoType(58,oPC);}
                                SendMessageToPC(oPC,"You are now using Deva style martial arts. You will consume ki while in this stance.");
                            }
                            else {SendMessageToPC(oPC,"Your ki is too low to begin using this style.");}
                        }
                        else {SendMessageToPC(oPC,"You are not trained in this style.");}
                    }
                    else if(sCommandArg2 == "eagle" || sCommandArg2 == "bird")
                    {
                        if(GetHasFeat(DEITY_Ilmater,oPC) == TRUE)
                        {
                            if(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"KiLevel")>=5 || GetIsDM(oPC) == TRUE)
                            {
                                SetLocalInt(oPC,"MonkStyle",5);
                                if(GetPhenoType(oPC) == 0){SetPhenoType(60,oPC);}
                                SendMessageToPC(oPC,"You are now using Eagle style martial arts. You will consume ki while in this stance.");
                            }
                            else {SendMessageToPC(oPC,"Your ki is too low to begin using this style.");}
                        }
                        else {SendMessageToPC(oPC,"You are not trained in this style.");}
                    }
                    else if(sCommandArg2 == "none" || sCommandArg2 == "off")
                    {
                        SetLocalInt(oPC,"MonkStyle",0);
                        if(GetPhenoType(oPC) == 50||GetPhenoType(oPC) == 57||GetPhenoType(oPC) == 58||GetPhenoType(oPC) == 59||GetPhenoType(oPC) == 60){SetPhenoType(0,oPC);}
                        SendMessageToPC(oPC,"You are no longer using a martial arts style. You will no longer consume ki.");
                    }
                    else
                    {
                        SendMessageToPC(oPC,"I'm sorry Dave, I can't do that. Type \"-style list\" for a list of all available styles.");
                    }
                }
                else
                {
                    SendMessageToPC(oPC,"Command is unavailable while mounted or untrained in martial arts.");
                }
            }
            else if(sCurrCommandArg == "place")
            {
                string sDoctext;
                object oPaper = GetLocalObject(oPC,"Placeable");
                string sDescription;

                if(GetIsObjectValid(oPaper) == FALSE)
                {
                    SendMessageToPC(oPC,"You must select a valid persistent placeable.");
                    return;
                }

                if(GetDistanceToObject(oPaper) > 5.0f)
                {
                    SendMessageToPC(oPC,"You are too far away from the placeable you are attempting to edit.");
                    return;
                }

                if(sCommandArg2 == "help")
                {
                    SendMessageToPC(oPC,"The Place Command allows you to edit the title and description of any valid persistent placeable.\nThe following commands are available:\nhelp - gives this help message\ntitle - changes the title of a placeable\nadd - adds your text in addition to the text already on the placeable\nnew - overwrites all text on the placeable as your text\nline - starts your added text on new line.");
                }
                else if(sCommandArg2 == "title") //-write title : 13 characters
                {
                    gsFXDeleteFixture(GetTag(GetArea(oPC)),oPaper);
                    sDoctext = GetStringRight(sChatMessage,GetStringLength(sOriginal)-13);
                    SetName(oPaper,sDoctext);
                    SendMessageToPC(oPC,"Title of placeable set as: "+sDoctext);
                    gsFXSaveFixture(GetTag(GetArea(oPC)),oPaper);
                }
                else if(sCommandArg2 == "add") //-write add : 11 characters
                {
                    gsFXDeleteFixture(GetTag(GetArea(oPC)),oPaper);
                    sDoctext = GetStringRight(sChatMessage,GetStringLength(sOriginal)-11);
                    sDescription = GetDescription(oPaper,FALSE,TRUE);
                    SetDescription(oPaper,sDescription+" "+sDoctext,TRUE);
                    SendMessageToPC(oPC,"Text added to placeable as: "+sDoctext);
                    gsFXSaveFixture(GetTag(GetArea(oPC)),oPaper);
                }
                else if(sCommandArg2 == "line") //-write new : 12 characters
                {
                    gsFXDeleteFixture(GetTag(GetArea(oPC)),oPaper);
                    sDoctext = GetStringRight(sChatMessage,GetStringLength(sOriginal)-12);
                    sDescription = GetDescription(oPaper,FALSE,TRUE);
                    SetDescription(oPaper,sDescription+"\n"+sDoctext,TRUE);
                    SendMessageToPC(oPC,"Text added to new line of placeable description as: "+sDoctext);
                    gsFXSaveFixture(GetTag(GetArea(oPC)),oPaper);
                }
                else if(sCommandArg2 == "new") //-write new : 11 characters
                {
                    gsFXDeleteFixture(GetTag(GetArea(oPC)),oPaper);
                    sDoctext = GetStringRight(sChatMessage,GetStringLength(sOriginal)-11);
                    sDescription = GetDescription(oPaper,FALSE,TRUE);
                    SetDescription(oPaper,sDoctext,TRUE);
                    SendMessageToPC(oPC,"New description given to line of placeable description as: "+sDoctext);
                    gsFXSaveFixture(GetTag(GetArea(oPC)),oPaper);
                }
            }
            else if(sCurrCommandArg == "delete")
            {
                if(abs(GetLocalInt(oPC,"DeleteStamp") - NWNX_Time_GetTimeStamp()) > 60)
                {
                    SendMessageToPC(oPC,"WARNING! You are about to delete your character from your vault. If you are sure you want to proceed, type \"-delete\" again to confirm that this is your desire.");
                    SetLocalInt(oPC,"DeleteStamp",NWNX_Time_GetTimeStamp());
                }
                else
                {
                    string sID     = SF_GetPlayerID(oPC);
                    //Brost
                    string sBank   = GetCampaignString("Settlement","sBrost_sBank");
                    string sBank_Coffer = sBank+"Coffers";
                    int nBanked    = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID + sBank);

                    if(nBanked > 0)
                    {
                        DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                        SetCampaignInt(GetName(GetModule()),sBank_Coffer,nBanked);
                    }
                    else {DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);}

                    //South Spire
                    sBank   = GetCampaignString("Settlement","sSpire_sBank");
                    sBank_Coffer = sBank+"Coffers";
                    nBanked    = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID + sBank);

                    if(nBanked > 0)
                    {
                        DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                        SetCampaignInt(GetName(GetModule()),sBank_Coffer,nBanked);
                    }
                    else {DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);}

                    //Tejarn Gate
                    sBank = GetCampaignString("Settlement","sTejarn_sBank");
                    sBank_Coffer = sBank+"Coffers";
                    nBanked    = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                    if(nBanked > 0)
                    {
                        DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                        SetCampaignInt(GetName(GetModule()),sBank_Coffer,nBanked);
                    }
                    else {DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);}

                    //Swamprise
                    sBank = GetCampaignString("Settlement","sSwamp_sBank");
                    sBank_Coffer = sBank+"Coffers";
                    nBanked    = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                    if(nBanked > 0)
                    {
                        DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                        SetCampaignInt(GetName(GetModule()),sBank_Coffer,nBanked);
                    }
                    else {DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);}

                    //Lockwood Falls
                    sBank = GetCampaignString("Settlement","sLock_sBank");
                    sBank_Coffer = sBank+"Coffers";
                    nBanked    = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                    if(nBanked > 0)
                    {
                        DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                        SetCampaignInt(GetName(GetModule()),sBank_Coffer,nBanked);
                    }
                    else {DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);}

                    //Golden Lion Company
                    sBank = GetCampaignString("Settlement","sMerc1_sBank");
                    sBank_Coffer = sBank+"Coffers";
                    nBanked    = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                    if(nBanked > 0)
                    {
                        DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                        SetCampaignInt(GetName(GetModule()),sBank_Coffer,nBanked);
                    }
                    else {DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);}

                    //Undead
                    sBank = GetCampaignString("Settlement","sUndead_sBank");
                    sBank_Coffer = sBank+"Coffers";
                    nBanked    = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                    if(nBanked > 0)
                    {
                        DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                        SetCampaignInt(GetName(GetModule()),sBank_Coffer,nBanked);
                    }
                    else {DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);}

                    //Outlaw
                    sBank = GetCampaignString("Settlement","sOutlaw1_sBank");
                    sBank_Coffer = sBank+"Coffers";
                    nBanked    = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                    if(nBanked > 0)
                    {
                        DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                        SetCampaignInt(GetName(GetModule()),sBank_Coffer,nBanked);
                    }
                    else {DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);}

                    //Outlaw
                    sBank = GetCampaignString("Settlement","sOutlaw2_sBank");
                    sBank_Coffer = sBank+"Coffers";
                    nBanked    = GetCampaignInt(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                    if(nBanked > 0)
                    {
                        DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);
                        SetCampaignInt(GetName(GetModule()),sBank_Coffer,nBanked);
                    }
                    else {DeleteCampaignVariable(GetName(GetModule()), DATABASE_GOLD + sID + sBank);}

                    NWNX_Administration_DeletePlayerCharacter(oPC,TRUE);
                }
            }
            else if(sCurrCommandArg == "piety")
            {
                string sPiety = IntToString(GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"),"nPiety"));
                SendMessageToPC(oPC,"Your Piety is currently "+sPiety+".");
            }
            else if(sCurrCommandArg == "write")
            {
                string sDoctext;
                object oPaper = GetLocalObject(oPC,"oPaper");
                string sDescription;
                object oQuill = GetItemPossessedBy(oPC,"bv_oai_quill");
                object oInk = GetItemPossessedBy(oPC,"InkWell");
                object oSeal = GetItemPossessedBy(oPC,"HouseRing");;
                object oSealWax = GetItemPossessedBy(oPC,"SealingWax");

                int nUniqueMessageNumber = GetLocalInt(oPaper,"nUnique");
                int nGetUniqueNumber = GetCampaignInt("MessageDatabase","MessageUnique");
                if(nGetUniqueNumber == 0)
                {
                    SetCampaignInt("MessageDatabase","MessageUnique",1000000000000000);
                    nGetUniqueNumber = GetCampaignInt("MessageDatabase","MessageUnique");
                }
                else
                {
                    SetCampaignInt("MessageDatabase","MessageUnique",nGetUniqueNumber+1);
                }

                if(nUniqueMessageNumber == 0)
                {
                    nUniqueMessageNumber = nGetUniqueNumber;
                    SetLocalInt(oPaper,"MessageUnique",nUniqueMessageNumber);
                }

                if(GetIsObjectValid(oQuill) == FALSE)
                {
                    SendMessageToPC(oPC,"You must have a quill in order to modify any document.");
                    return;
                }

                if(GetIsObjectValid(oInk) == FALSE)
                {
                    SendMessageToPC(oPC,"You must have ink in order to modify any document.");
                    return;
                }

                if(GetIsObjectValid(oPaper) == FALSE || GetItemPossessor(oPaper) != oPC)
                {
                    SendMessageToPC(oPC,"No valid paper found...Select valid paper by using a valid paper/document object on yourself.");
                    return;
                }
                else
                {
                    if(GetLocalInt(oPaper,"Sealed") == 1)
                    {
                        SendMessageToPC(oPC,"You cannot edit or doctor a document after it has been sealed.");
                        return;
                    }

                    if(sCommandArg2 == "help")
                    {
                        SendMessageToPC(oPC,"The Write Command allows you to edit the title and description of any valid paper documents.\nThe following commands are available:\nhelp - gives this help message\ntitle - changes the title of a document\nadd - adds your text in addition to the text already on the document\nnew - overwrites all text on the document as your text\nline - starts your added text on new line.");
                    }
                    else if(sCommandArg2 == "title") //-write title : 13 characters
                    {
                        sDoctext = GetStringRight(sChatMessage,GetStringLength(sOriginal)-13);
                        SetName(oPaper,sDoctext);
                        SetItemCharges(oInk,GetItemCharges(oInk)-1);
                        SendMessageToPC(oPC,"Title of document set as: "+sDoctext);
                    }
                    else if(sCommandArg2 == "add") //-write add : 11 characters
                    {
                        sDoctext = GetStringRight(sChatMessage,GetStringLength(sOriginal)-11);
                        sDescription = GetDescription(oPaper,FALSE,TRUE);
                        SetDescription(oPaper,sDescription+" "+sDoctext,TRUE);
                        SetItemCharges(oInk,GetItemCharges(oInk)-1);
                        SendMessageToPC(oPC,"Text added to document as: "+sDoctext);
                    }
                    else if(sCommandArg2 == "line") //-write new : 12 characters
                    {
                        sDoctext = GetStringRight(sChatMessage,GetStringLength(sOriginal)-12);
                        sDescription = GetDescription(oPaper,FALSE,TRUE);
                        SetDescription(oPaper,sDescription+"\n"+sDoctext,TRUE);
                        SetItemCharges(oInk,GetItemCharges(oInk)-1);
                        SendMessageToPC(oPC,"Text added to new line of document as: "+sDoctext);
                    }
                    else if(sCommandArg2 == "new") //-write new : 11 characters
                    {
                        sDoctext = GetStringRight(sChatMessage,GetStringLength(sOriginal)-11);
                        sDescription = GetDescription(oPaper,FALSE,TRUE);
                        SetDescription(oPaper,sDoctext,TRUE);
                        SetItemCharges(oInk,GetItemCharges(oInk)-1);
                        SendMessageToPC(oPC,"New description given to line of document as: "+sDoctext);
                    }
                    else if(sCommandArg2 == "seal") //oSealWax
                    {
                        if(GetItemPossessedBy(oPC,"te_writknight") == OBJECT_INVALID && GetHasFeat(BACKGROUND_MIDDLE,oPC) != TRUE && GetHasFeat(BACKGROUND_UPPER,oPC) != TRUE)
                        {
                            SendMessageToPC(oPC,"You do not possess the expertise required to seal this document.");
                            return;
                        }

                        if(GetIsObjectValid(oSeal) == FALSE)
                        {
                            SendMessageToPC(oPC,"You must have a seal in order to seal this document.");
                            return;
                        }
                        if(GetIsObjectValid(oSealWax) == FALSE)
                        {
                            SendMessageToPC(oPC,"You must have a sealing wax in order to seal this document.");
                            return;
                        }

                        string sSignName = GetName(oPC);

                        if(GetLocalInt(oPC,"nDisguiseName") == 1 && GetIsDM(oPC) != TRUE)
                        {
                            sSignName = GetLocalString(oPC,"sOriginalName");
                        }

                        SetLocalInt(oPaper,"Sealed",1);
                        SetLocalString(oPaper,"SealName",sSignName);
                        sDoctext = "This document bears the seal of "+sSignName+".";
                        sDescription = GetDescription(oPaper,FALSE,TRUE);
                        SetDescription(oPaper,sDescription+"\n"+sDoctext,TRUE);
                        SetItemCharges(oSealWax,GetItemCharges(oSealWax)-1);
                        SendMessageToPC(oPC,"You have sealed your document.");
                    }
                }
            }
            else if(sCurrCommandArg == "joust")
            {
                if(HorseGetIsMounted(oPC) == TRUE)
                {
                    if(sCommandArg2 == "on")
                    {
                        HorseSetPhenotype(oPC,TRUE);
                    }
                    else
                    {
                        HorseSetPhenotype(oPC,FALSE);
                    }
                }
            }
            else if(sCurrCommandArg == "spellfire")
            {
                if(GetLevelByClass(49,oPC) >= 1 || GetLevelByClass(48,oPC)>=1)
                {
                    SendMessageToPC(oPC,"You have "+IntToString(GetLocalInt(GetItemPossessedBy(oPC, "PC_Data_Object"),"nMana"))+" charges of Spellfire.");
                }
            }
            else if(sCurrCommandArg == "time")
            {
                SendMessageToPC(oPC,"You must have a valid time keeping device to use this command.");
            }
            //else if(sCurrCommandArg == "manage" || sCurrCommandArg == "door")  EDITED BY SURREAL CAUSE BAD
            //{
                //object oDoor = GetNearestObject(OBJECT_TYPE_DOOR,oPC,1);
                //if(GetDistanceBetween(oPC,oDoor) > 5.0f)
                //{
                    //SendMessageToPC(oPC,"You are too far away from an interactable door.");
               //}
                //else
                //{
                    //if(GetLocalString(oDoor,"sUnique") != "")
                    //{
                        //AssignCommand(oDoor,ActionStartConversation(oPC,"te_door",TRUE)); //Start conversation with options to rent/open lock/break down door.
                    //}
                    //else
                    //{
                        //SendMessageToPC(oPC,"There is no nearby door that is configured for the Keep Management System.");
                    //}
                //}
            //}
            else if(sCurrCommandArg == "look")
            {
                int nLastTrack = GetLocalInt(oPC,"nTrackLast");
                int nTimeNow = (GetTimeHour()*100+GetTimeMinute());
                int nTimeDiff = abs(nLastTrack-nTimeNow);
                if(nTimeDiff <= 2)
                {
                    SendMessageToPC(oPC,"You may only track something once per minute.");
                }
                else
                {
                    if(HorseGetIsMounted(oPC) == TRUE)
                    {
                        SendMessageToPC(oPC,"You may not track while mounted.");
                    }
                    else
                    {
                        AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 6.0));
                        DelayCommand(6.5,TF_Looking(oPC));
                        SetLocalInt(oPC,"nTrackLast",nTimeNow);
                    }
                }
            }
            else if(sCurrCommandArg == "track" || sCurrCommandArg == "TRACK" || sCurrCommandArg == "Track")
            {
                if(GetHasFeat(1439,oPC) == TRUE)
                {
                    int nLastTrack = GetLocalInt(oPC,"nTrackLast");
                    int nTimeNow = (GetTimeHour()*100+GetTimeMinute());
                    int nTimeDiff = abs(nLastTrack-nTimeNow);
                    if(nTimeDiff <= 2)
                    {
                        SendMessageToPC(oPC,"You may only track something once per minute.");
                    }
                    else
                    {
                        if(HorseGetIsMounted(oPC) == TRUE)
                        {
                            SendMessageToPC(oPC,"You may not track while mounted.");
                        }
                        else
                        {
                            AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 6.0));
                            DelayCommand(6.5,TF_TrackRun(oPC));
                            SetLocalInt(oPC,"nTrackLast",nTimeNow);
                        }
                    }
                }
                else{SendMessageToPC(oPC,"You do not have the tracking proficiency.");}
            }
            else if(sCurrCommandArg == "name" || sCurrCommandArg == "NAME")
            {
                if(GetLocalInt(oPC,"iDisguise") == 1)
                {
                   if(GetLocalInt(oPC,"nDisguiseName") == 0)
                   {
                        SetLocalInt(oPC,"nDisguiseName",1);
                        SetLocalString(oPC,"sOriginalName",GetName(oPC));
                        SendMessageToPC(oPC,"You are now disguising your name as "+sDisguiseName+".");
                        NWNX_Rename_SetPCNameOverride(oPC,sDisguiseName,"","");

                   }
                   else
                   {
                        SetLocalInt(oPC,"nDisguiseName",0);
                        SendMessageToPC(oPC,"You are no longer disguising your name!");
                        NWNX_Rename_SetPCNameOverride(oPC,GetLocalString(oPC,"sOriginalName"),"","");
                   }
                }
                else
                {
                    SendMessageToPC(oPC,"You may not disguise your name unless you are disguising yourself using the -disguise command");
                }
            }
            else if(sCurrCommandArg == "disguise")
            {
                 if(sCommandArg2 == "help" || sCommandArg2 == "HELP" || sCommandArg2 == "Help")
                {
                    string sDisHelp = "Disguise on Lands of Intrigue - Tethyr currently supports the following commands: \n";
                    sDisHelp += "- on/off - Turns your disguise on or off. If this setting is off, you are not disguised. Syntax: -disguise on \n";
                    sDisHelp += "- class <off/low/mid/up> - Sets your disguise to be of a certain class standing. Syntax: -disguise class up \n";
                    sDisHelp += "- str <0/1/2/3/4> - Sets your disguise for your apparent strength. THIS CANNOT EXCEED YOUR CAPABILITY. Syntax: -diguise str 1 \n";
                    sDisHelp += "- con <0/1/2/3/4> - Sets your disguise for your apparent constitution. THIS CANNOT EXCEED YOUR CAPABILITY. Syntax: -diguise con 1 \n";
                    sDisHelp += "- dex <0/1/2/3/4> - Sets your disguise for your apparent dexterity. THIS CANNOT EXCEED YOUR CAPABILITY. Syntax: -diguise dex 1 \n";
                    sDisHelp += "- name <DisguiseName> - Sets your disguise name. Syntax: -name Malcolm Reed";
                    SendMessageToPC(oPC,sDisHelp);
                }
                else if(sCommandArg2 == "on" ||  sCommandArg2 == "ON" || sCommandArg2 == "On")
                {
                    SendMessageToPC(oPC,"Disguise on.");
                    SetLocalInt(oPC,"iDisguise",1);
                }
                else if(sCommandArg2 == "off" ||  sCommandArg2 == "OFF" || sCommandArg2 == "Off")
                {
                    SendMessageToPC(oPC,"Disguise off. All disguise values set to return accurate results.");
                    SetLocalInt(oPC,"nDisguiseName",0);
                    SetLocalInt(oPC,"nDisSTR",0);
                    SetLocalInt(oPC,"nDisCON",0);
                    SetLocalInt(oPC,"nDisDEX",0);
                    SetLocalInt(oPC,"iDisguise",0);
                    NWNX_Rename_SetPCNameOverride(oPC,GetLocalString(oPC,"sOriginalName"),"","");
                }
                else if(sCommandArg2 == "class" ||  sCommandArg2 == "Class" || sCommandArg2 == "CLASS")
                {
                    if(sCommandArg3 == "off"){SetLocalInt(oPC,"nDisStand",0); SendMessageToPC(oPC,"Class Standing Disguise off.");}
                    else if(sCommandArg3 == "low"){SetLocalInt(oPC,"nDisStand",1); SendMessageToPC(oPC,"Class Standing Disguise Lower Class.");}
                    else if(sCommandArg3 == "mid"){SetLocalInt(oPC,"nDisStand",2); SendMessageToPC(oPC,"Class Standing Disguise Middle Class.");}
                    else if(sCommandArg3 == "up") {SetLocalInt(oPC,"nDisStand",3); SendMessageToPC(oPC,"Class Standing Disguise Upper Class.");}
                }
                else if(sCommandArg2 == "STR" ||  sCommandArg2 == "str" || sCommandArg2 == "Str")
                {
                    if(sCommandArg3 == "0") {SetLocalInt(oPC,"nDisSTR",0); SendMessageToPC(oPC,"Disguising Strength off.");}
                    else if(sCommandArg3 == "1") {SetLocalInt(oPC,"nDisSTR",1); SendMessageToPC(oPC,"Disguising Strength low.");}
                    else if(sCommandArg3 == "2") {SetLocalInt(oPC,"nDisSTR",2); SendMessageToPC(oPC,"Disguising Strength mid.");}
                    else if(sCommandArg3 == "3") {SetLocalInt(oPC,"nDisSTR",3); SendMessageToPC(oPC,"Disguising Strength high.");}
                    else if(sCommandArg3 == "4") {SetLocalInt(oPC,"nDisSTR",4); SendMessageToPC(oPC,"Disguising Strength extreme.");}
                }
                else if(sCommandArg2 == "CON" ||  sCommandArg2 == "con" || sCommandArg2 == "Con")
                {
                    if(sCommandArg3 == "0") {SetLocalInt(oPC,"nDisCON",0); SendMessageToPC(oPC,"Disguising Constitution off.");}
                    else if(sCommandArg3 == "1") {SetLocalInt(oPC,"nDisCON",1); SendMessageToPC(oPC,"Disguising Constitution low.");}
                    else if(sCommandArg3 == "2") {SetLocalInt(oPC,"nDisCON",2); SendMessageToPC(oPC,"Disguising Constitution mid.");}
                    else if(sCommandArg3 == "3") {SetLocalInt(oPC,"nDisCON",3); SendMessageToPC(oPC,"Disguising Constitution high.");}
                    else if(sCommandArg3 == "4") {SetLocalInt(oPC,"nDisCON",4); SendMessageToPC(oPC,"Disguising Constitution extreme.");}
                }
                else if(sCommandArg2 == "DEX" ||  sCommandArg2 == "dex" || sCommandArg2 == "Dex")
                {
                    if(sCommandArg3 == "0") {SetLocalInt(oPC,"nDisDEX",0);    SendMessageToPC(oPC,"Disguising Dexterity off.");}
                    else if(sCommandArg3 == "1") {SetLocalInt(oPC,"nDisDEX",1); SendMessageToPC(oPC,"Disguising Dexterity low.");}
                    else if(sCommandArg3 == "2") {SetLocalInt(oPC,"nDisDEX",2);  SendMessageToPC(oPC,"Disguising Dexterity mid.");}
                    else if(sCommandArg3 == "3") {SetLocalInt(oPC,"nDisDEX",3);  SendMessageToPC(oPC,"Disguising Dexterity high.");}
                    else if(sCommandArg3 == "4") {SetLocalInt(oPC,"nDisDEX",4);  SendMessageToPC(oPC,"Disguising Dexterity extreme.");}
                }
                else
                {
                    string sDisguiseReturn;
                    if(GetLocalInt(oPC,"iDisguise") == 1)       {sDisguiseReturn+= "You are disguising yourself.\n";}
                    else                                        {sDisguiseReturn+= "You are not disguising yourself.\n";}
                    if(GetLocalInt(oPC,"nDisStand") == 0)       {sDisguiseReturn+= "You are not disguising your class standing.\n";}
                    else if(GetLocalInt(oPC,"nDisStand") == 1)  {sDisguiseReturn+= "You are disguising yourself as lower class standing.\n";}
                    else if(GetLocalInt(oPC,"nDisStand") == 2)  {sDisguiseReturn+= "You are disguising yourself as middle class standing.\n";}
                    else if(GetLocalInt(oPC,"nDisStand") == 3)  {sDisguiseReturn+= "You are disguising yourself as upper class standing.\n";}
                    if (GetLocalInt(oPC,"nDisSTR") == 0)        {sDisguiseReturn+= "You are disguising not your Strength.\n";}
                    else if (GetLocalInt(oPC,"nDisSTR") == 1)   {sDisguiseReturn+= "You are disguising your Strength as low.\n";}
                    else if (GetLocalInt(oPC,"nDisSTR") == 2)   {sDisguiseReturn+= "You are disguising your Strength as middle.\n";}
                    else if (GetLocalInt(oPC,"nDisSTR") == 3)   {sDisguiseReturn+= "You are disguising your Strength as high.\n";}
                    else if (GetLocalInt(oPC,"nDisSTR") == 4)   {sDisguiseReturn+= "You are disguising your Strength as extreme.\n";}
                    if (GetLocalInt(oPC,"nDisCON") == 0)        {sDisguiseReturn+= "You are disguising not your Constitution.\n";}
                    else if (GetLocalInt(oPC,"nDisCON") == 1)   {sDisguiseReturn+= "You are disguising your Constitution as low.\n";}
                    else if (GetLocalInt(oPC,"nDisCON") == 2)   {sDisguiseReturn+= "You are disguising your Constitution as middle.\n";}
                    else if (GetLocalInt(oPC,"nDisCON") == 3)   {sDisguiseReturn+= "You are disguising your Constitution as high.\n";}
                    else if (GetLocalInt(oPC,"nDisCON") == 4)   {sDisguiseReturn+= "You are disguising your Constitution as extreme.\n";}
                    if (GetLocalInt(oPC,"nDisDEX") == 0)        {sDisguiseReturn+= "You are disguising not your Dexterity.\n";}
                    else if (GetLocalInt(oPC,"nDisDEX") == 1)   {sDisguiseReturn+= "You are disguising your Dexterity as low.\n";}
                    else if (GetLocalInt(oPC,"nDisDEX") == 1)   {sDisguiseReturn+= "You are disguising your Dexterity as middle.\n";}
                    else if (GetLocalInt(oPC,"nDisDEX") == 1)   {sDisguiseReturn+= "You are disguising your Dexterity as high.\n";}
                    else if (GetLocalInt(oPC,"nDisDEX") == 1)   {sDisguiseReturn+= "You are disguising your Dexterity as extreme.\n";}
                    SendMessageToPC(oPC,sDisguiseReturn);
                }
            }
            else if(sCurrCommandArg == "rest"||sCurrCommandArg == "Rest"||sCurrCommandArg == "REST")
            {
                string REST_IN_SHIFTS = "You cannot rest while another party member is resting, sleep in shifts.";
                string NOT_TIRED = " is not tired enough.";
                string TOO_SOON = "Its Too Soon in the Game to Rest please wait ";
                string NO_REST_TOWN = "The local authorities require you to rest in an inn-room or other suitable location.";
                string BUY_A_ROOM = "You need to buy a room at the Inn or find some other accommodations.";
                string BED_REST_LATER = " You can rest in a comfortable bed at ";
                string WILD_REST_LATER = " or you can rest in the wilds at ";
                string BED_REST_ONLY = " You can rest in a comfortable bed ";
                string NO_REST_HERE = "You cannot rest here.";
                string REST_MONSTERS = "You cannot rest, there are monsters nearby!";
                string REST_POORLY = "Your rest was poor or uncomfortable, you did not recover completely.";

                int bREST_BED = CheckDateStringExpired(oPC, "REST_BED");
                int bREST_ROUGH = CheckDateStringExpired(oPC, "REST_ROUGH");
                string sRestedText = GetName(oPC) + NOT_TIRED;

                if(GetIsObjectValid(oPC) && bREST_BED == TRUE && bREST_ROUGH == FALSE)
                {
                AssignCommand(oPC, ClearAllActions());
                sRestedText += BED_REST_ONLY;
                sRestedText += WILD_REST_LATER;
                sRestedText = sRestedText + ConvertDateString(oPC, "REST_ROUGH");
                SendMessageToPC(oPC,sRestedText);
                }
                else if(GetIsObjectValid(oPC) && bREST_BED == FALSE && bREST_ROUGH == FALSE)
                {
                AssignCommand(oPC, ClearAllActions());
                sRestedText += BED_REST_LATER;
                sRestedText = sRestedText + ConvertDateString(oPC, "REST_BED");
                sRestedText += WILD_REST_LATER;
                sRestedText = sRestedText + ConvertDateString(oPC, "REST_ROUGH");
                SendMessageToPC(oPC,sRestedText);
                }
                else
                {
                    SendMessageToPC(oPC,"You are able to rest in a bed or in the wild.");
                }

            }
            else if(sCurrCommandArg == "walk"||sCurrCommandArg == "Walk"||sCurrCommandArg == "WALK")
            {
                if(GetLocalInt(oPC,"walk") == 0)
                {
                    NWNX_Player_SetAlwaysWalk(oPC,TRUE);
                    SetLocalInt(oPC,"walk", 1);
                }
                else
                {
                    NWNX_Player_SetAlwaysWalk(oPC,FALSE);
                    SetLocalInt(oPC,"walk", 0);
                }
            }
            else if(sCurrCommandArg == "weather" || sCurrCommandArg == "WEATHER" || sCurrCommandArg == "Weather")
            {
                SendMessageToPC(oPC,GetWeatherFeedback(oPC));
            }
            else if( sCurrCommandArg == "debuff" || sCurrCommandArg == "Debuff" || sCurrCommandArg == "DEBUFF")
            {
                effect eSpell = GetFirstEffect(oPC);

                while (GetIsEffectValid(eSpell))
                {
                    if(GetEffectCreator(eSpell) == oPC)
                    {
                        RemoveEffect(oPC, eSpell);
                    }

                    eSpell = GetNextEffect(oPC);
                }
            }
            else if( sCurrCommandArg == "decloak" || sCurrCommandArg == "Decloak" || sCurrCommandArg == "DECLOAK")
            {
                effect eSpell = GetFirstEffect(oPC);

                while (GetIsEffectValid(eSpell))
                {
                    if(GetEffectType(eSpell) == EFFECT_TYPE_INVISIBILITY)
                    {
                        RemoveEffect(oPC, eSpell);
                    }

                    eSpell = GetNextEffect(oPC);
                }
            }
            else if( sCurrCommandArg == "emote" || sCurrCommandArg == "Emote" || sCurrCommandArg == "EMOTE")
            {
                if(sCommandArg2 == "list")
                {
                    SendMessageToPC(oPC,"Available Emotes: \n attention\n bite\n bored\n bow\n cast\n celebrate\n conjure\n cower\n cross\n crouch\n dance\n dance2\n drink\n drink2\n drunk\n fall backwards\n fall forward\n gather\n grapple\n greet\n headscratch\n honor\n laugh\n laydown1\n laydown2\n laydown3\n listen\n look\n meditate\n pickup ground\n pickup waist\n plead\n point\n pushup\n read\n salute\n shock\n sit\n sit2\n smoke\n spasm\n stop\n taunt\n think\n tired\n worship");
                }
                else if(sCommandArg2 == "bow")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_BOW, 1.0));
                else if(sCommandArg2 == "smoke")
                    SmokePipe(oPlayer);
                else if(sCommandArg2 == "dance2")
                    EmoteDance(oPlayer);
                else if(sCommandArg2 == "drink")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0));
                else if(sCommandArg2 == "cast")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 10000.0));
                else if(sCommandArg2 == "conjure")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CONJURE2, 1.0, 10000.0));
                else if(sCommandArg2 == "greet")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_GREETING, 1.0));
                else if(sCommandArg2 == "bored")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0));
                else if(sCommandArg2 == "headscratch" || sCommandArg2 == "confused")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0));
                else if(sCommandArg2 == "read")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_READ, 1.0));
                else if(sCommandArg2 == "salute")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_SALUTE, 1.0));
                else if(sCommandArg2 == "spasm")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_SPASM, 1.0, 10000.0));
                else if(sCommandArg2 == "taunt")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0));
                else if(sCommandArg2 == "celebrate")
                    AssignCommand(oPlayer, PlayAnimation(111-Random(3), 1.0));  //ANIMATION_FIREFORGET_VICTORY1(2)(3)
                else if(sCommandArg2 == "fall")
                {
                    if(sCommandArg3 == "forward" || sCommandArg3 == "front" || sCommandArg3 == "down")
                        AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 10000.0));
                    else if(sCommandArg3 == "backward" || sCommandArg3 == "back")
                        AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 10000.0));
                    else
                        SendMessageToPC(oPC,"I'm sorry Dave, I can't do that. Type \"-emote list\" for a list of all available emotes.");
                }
                else if(sCommandArg2 == "pickup" || sCommandArg2 == "get")
                {
                    sCurrCommandArg = parseArgs(sChatMessage, 2); //Get where to pickup at

                    if(sCommandArg3 == "ground" || sCommandArg2 == "low")
                        AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 10000.0));
                    else if(sCommandArg3 == "waist" || sCommandArg2 == "mid")
                        AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 10000.0));
                    else
                         SendMessageToPC(oPC,"I'm sorry Dave, I can't do that. Type \"-emote list\" for a list of all available emotes.");
                }
                else if(sCommandArg2 == "laydown")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 10000.0));
                else if(sCommandArg2 == "falldown")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 10000.0));
                else if(sCommandArg2 == "listen")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 10000.0));
                else if(sCommandArg2 == "look")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0, 10000.0));
                else if(sCommandArg2 == "meditate"||sCommandArg2 == "pray")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 10000.0));
                else if(sCommandArg2 == "stop")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_PAUSE, 1.0, 10000.0));
                else if(sCommandArg2 == "drunk")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 10000.0));
                else if(sCommandArg2 == "tired")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 10000.0));
                else if(sCommandArg2 == "laugh")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 10000.0));
                else if(sCommandArg2 == "plead")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 10000.0));
                else if(sCommandArg2 == "worship")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 10000.0));
                else if(sCommandArg2 == "sit")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 10000.0));
                else if(sCommandArg2 == "shock")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM1, 1.0, 10000.0));
               // else if(sCommandArg2 == "guitar")
               //     AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM2, 1.0, 10000.0));
                else if(sCommandArg2 == "drink")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM3, 1.0, 10.0));
                else if(sCommandArg2 == "honor")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM4, 1.0, 10000.0));
                else if(sCommandArg2 == "pushup")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM5, 1.0, 10000.0));
                else if(sCommandArg2 == "dance")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM6, 1.0, 10000.0));
                else if(sCommandArg2 == "attention")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM7, 1.0, 10000.0));
                else if(sCommandArg2 == "sit2")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM8, 1.0, 10000.0));
                else if(sCommandArg2 == "grapple")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM9, 1.0, 10000.0));
                else if(sCommandArg2 == "bite")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM10, 1.0, 10000.0));
                else if(sCommandArg2 == "point")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM11, 1.0, 10000.0));
                else if(sCommandArg2 == "think")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM12, 1.0, 10000.0));
                else if(sCommandArg2 == "cower")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM13, 1.0, 10000.0));
                else if(sCommandArg2 == "cross")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM14, 1.0, 10000.0));
                else if(sCommandArg2 == "laydown1")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM15, 1.0, 10000.0));
                else if(sCommandArg2 == "laydown2")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM16, 1.0, 10000.0));
                else if(sCommandArg2 == "crouch")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM17, 1.0, 10000.0));
               // else if(sCommandArg2 == "c18")
               //     AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM18, 1.0, 10000.0));
                else if(sCommandArg2 == "gather")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM19, 1.0, 10000.0));
                else if(sCommandArg2 == "laydown3")
                    AssignCommand(oPlayer, PlayAnimation(ANIMATION_LOOPING_CUSTOM20, 1.0, 10000.0));
                else
                {
                    SendMessageToPC(oPC,"I'm sorry Dave, I can't do that. Type \"-emote list\" for a list of all available emotes.");
                }
            }
            else if(sCurrCommandArg == "roll" || sCurrCommandArg == "Roll" || sCurrCommandArg == "ROLL")
            {
                sRollString = GetName(oPC)+" ("+GetPCPlayerName(oPC)+"):\n";
                int nDiceConvert = StringToInt(sCommandArg3);
                if (sCommandArg2 == "d2" || sCommandArg2 == "D2")
                {
                    sRollString += "Dice Roll - "+sCommandArg3+"D2 Result: "+IntToString(d2(StringToInt(sCommandArg3)));
                }
                else if (sCommandArg2 == "d3" || sCommandArg2 == "D3")
                {

                    sRollString += "Dice Roll - "+sCommandArg3+"D3 Result: "+IntToString(d3(StringToInt(sCommandArg3)));
                }
                else if (sCommandArg2 == "d4" || sCommandArg2 == "D4")
                {

                    sRollString += "Dice Roll - "+sCommandArg3+"D4 Result: "+IntToString(d4(StringToInt(sCommandArg3)));
                }
                else if (sCommandArg2 == "d6" || sCommandArg2 == "D6")
                {

                    sRollString += "Dice Roll - "+sCommandArg3+"D4 Result: "+IntToString(d6(StringToInt(sCommandArg3)));
                }
                else if (sCommandArg2 == "d8" || sCommandArg2 == "D8")
                {

                    sRollString += "Dice Roll - "+sCommandArg3+"D6 Result: "+IntToString(d8(StringToInt(sCommandArg3)));
                }
                else if (sCommandArg2 == "d10" || sCommandArg2 == "D10")
                {

                    sRollString += "Dice Roll - "+sCommandArg3+"D10 Result: "+IntToString(d10(StringToInt(sCommandArg3)));
                }
                else if (sCommandArg2 == "d12" || sCommandArg2 == "D12")
                {

                    sRollString += "Dice Roll - "+sCommandArg3+"D12 Result: "+IntToString(d12(StringToInt(sCommandArg3)));
                }
                else if (sCommandArg2 == "d20" || sCommandArg2 == "D20")
                {

                    sRollString += "Dice Roll - "+sCommandArg3+"D20 Result: "+IntToString(d20(StringToInt(sCommandArg3)));
                }
                else if (sCommandArg2 == "d100" || sCommandArg2 == "D100")
                {

                    sRollString += "Dice Roll - "+sCommandArg3+"D100 Result: "+IntToString(d100(StringToInt(sCommandArg3)));
                }
                else if(sCommandArg2 == "will" || sCommandArg2 == "Will" || sCommandArg2 == "WILL")
                {
                    sRollString += "Will Save  - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetWillSavingThrow(oPC))+" Total: "+IntToString(nD20+GetWillSavingThrow(oPC));
                }
                else if(sCommandArg2 == "reflex" || sCommandArg2 == "ref" || sCommandArg2 == "REF" || sCommandArg2 == "Ref" || sCommandArg2 == "REFLEX")
                {
                    sRollString += "Reflex Save - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetReflexSavingThrow(oPC))+" Total: "+IntToString(nD20+GetReflexSavingThrow(oPC));
                }
                else if(sCommandArg2 == "fort" || sCommandArg2 == "fortitude"|| sCommandArg2 == "Foritude"|| sCommandArg2 == "Fort" || sCommandArg2 == "FORTITUDE" || sCommandArg2 == "FORT")
                {
                    sRollString += "Fortitude Save - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetFortitudeSavingThrow(oPC))+" Total: "+IntToString(nD20+GetFortitudeSavingThrow(oPC));
                }
                else if(sCommandArg2 == "animal" || sCommandArg2 == "ANIMAL" || sCommandArg2 == "ani" || sCommandArg2 == "Ani")
                {
                    sRollString += "Animal Empathy Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_ANIMAL_EMPATHY, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_ANIMAL_EMPATHY, oPC));
                }
                else if(sCommandArg2 == "appraise")
                {
                    sRollString += "Appraise Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_APPRAISE, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_APPRAISE, oPC));
                }
                else if(sCommandArg2 == "bluff")
                {
                    sRollString += "Bluff Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_BLUFF, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_BLUFF, oPC));
                }
                else if(sCommandArg2 == "concentration")
                {
                    sRollString += "Concentration Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_CONCENTRATION, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_CONCENTRATION, oPC));
                }
                else if(sCommandArg2 == "disable")
                {
                    sRollString += "Disable Trap Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_DISABLE_TRAP, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_DISABLE_TRAP, oPC));
                }
                else if(sCommandArg2 == "discipline")
                {
                    sRollString += "Discipline Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_DISCIPLINE, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_DISCIPLINE, oPC));
                }
                else if(sCommandArg2 == "heal")
                {
                    sRollString += "Heal Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_HEAL, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_HEAL, oPC));
                }
                else if(sCommandArg2 == "hide")
                {
                    sRollString += "Hide Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_HIDE, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_HIDE, oPC));
                }
                else if(sCommandArg2 == "intimidate")
                {
                    sRollString += "Intimidate Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_INTIMIDATE, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_INTIMIDATE, oPC));
                }
                else if(sCommandArg2 == "listen")
                {
                    sRollString += "Listen Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_LISTEN, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_LISTEN, oPC));
                }
                else if(sCommandArg2 == "lore"||sCommandArg2 == "know"||sCommandArg2 == "knowledge")
                {
                    sRollString += "Lore / Knowledge Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_LORE, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_LORE, oPC));
                }
                else if(sCommandArg2 == "move")
                {
                    sRollString += "Move Silently Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_MOVE_SILENTLY, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_MOVE_SILENTLY, oPC));
                }
                else if(sCommandArg2 == "open")
                {
                    sRollString += "Open Lock Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_OPEN_LOCK, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_OPEN_LOCK, oPC));
                }
                else if(sCommandArg2 == "parry")
                {
                    sRollString += "Parry Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_PARRY, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_PARRY, oPC));
                }
                else if(sCommandArg2 == "perform")
                {
                    sRollString += "Perform Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_PERFORM, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_PERFORM, oPC));
                }
                else if(sCommandArg2 == "persuade" || sCommandArg2 == "diplomacy"|| sCommandArg2 == "diplo")
                {
                    sRollString += "Diplomacy Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_PERSUADE, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_PERSUADE, oPC));
                }
                else if(sCommandArg2 == "pick" || sCommandArg2 == "sleight" )
                {
                    sRollString += "Sleight of Hand / Pick Pocket Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_PICK_POCKET, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_PICK_POCKET, oPC));
                }
                else if(sCommandArg2 == "ride")
                {
                    sRollString += "Ride Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_RIDE, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_RIDE, oPC));
                }
                else if(sCommandArg2 == "search")
                {
                    sRollString += "Search Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_SEARCH, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_SEARCH, oPC));
                }
                else if(sCommandArg2 == "spot")
                {
                    sRollString += "Spot Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_SPOT, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_SPOT, oPC));
                }
                else if(sCommandArg2 == "set")
                {
                    sRollString += "Set Trap Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_SET_TRAP, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_SET_TRAP, oPC));
                }
                else if(sCommandArg2 == "spellcraft")
                {
                    sRollString += "Spellcraft Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_SPELLCRAFT, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_SPELLCRAFT, oPC));
                }
                else if(sCommandArg2 == "taunt")
                {
                    sRollString += "Taunt Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_TAUNT, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_TAUNT, oPC));
                }
                else if(sCommandArg2 == "umd")
                {
                    sRollString += "Use Magical Device Check - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_USE_MAGIC_DEVICE, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_USE_MAGIC_DEVICE, oPC));
                }
                else if(sCommandArg2 == "tumble")
                {
                    sRollString += "Tumble  - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetSkillRank(SKILL_TUMBLE, oPC))+" Total: "+IntToString(nD20+GetSkillRank(SKILL_TUMBLE, oPC));
                }
                else if(sCommandArg2 == "str" || sCommandArg2 == "strength" || sCommandArg2 == "STR" || sCommandArg2 == "Strength")
                {
                    sRollString += "Strength  - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetAbilityModifier(ABILITY_STRENGTH, oPC))+" Total: "+IntToString(nD20+GetAbilityModifier(ABILITY_STRENGTH, oPC));
                }
                else if(sCommandArg2 == "dex" || sCommandArg2 == "dexterity" || sCommandArg2 == "DEX" || sCommandArg2 == "Dexterity")
                {
                    sRollString += "Dexterity  - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetAbilityModifier(ABILITY_DEXTERITY, oPC))+" Total: "+IntToString(nD20+GetAbilityModifier(ABILITY_DEXTERITY, oPC));
                }
                else if(sCommandArg2 == "int" || sCommandArg2 == "intelligence" || sCommandArg2 == "INT" || sCommandArg2 == "Intelligence")
                {
                    sRollString += "Intelligence  - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC))+" Total: "+IntToString(nD20+GetAbilityModifier(ABILITY_INTELLIGENCE, oPC));
                }
                else if(sCommandArg2 == "con" || sCommandArg2 == "constitution" || sCommandArg2 == "CON" || sCommandArg2 == "Constitution")
                {
                    sRollString += "Constitution  - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetAbilityModifier(ABILITY_CONSTITUTION, oPC))+" Total: "+IntToString(nD20+GetAbilityModifier(ABILITY_CONSTITUTION, oPC));
                }
                else if(sCommandArg2 == "wis" || sCommandArg2 == "wisdom" || sCommandArg2 == "WIS" || sCommandArg2 == "Wisdom")
                {
                    sRollString += "Wisdom  - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetAbilityModifier(ABILITY_WISDOM, oPC))+" Total: "+IntToString(nD20+GetAbilityModifier(ABILITY_WISDOM, oPC));
                }
                else if(sCommandArg2 == "cha" || sCommandArg2 == "charisma" || sCommandArg2 == "CHA" || sCommandArg2 == "Charisma")
                {
                    sRollString += "Charisma  - 1d20:"+IntToString(nD20)+" + Modifier: "+IntToString(GetAbilityModifier(ABILITY_CHARISMA, oPC))+" Total: "+IntToString(nD20+GetAbilityModifier(ABILITY_CHARISMA, oPC));
                }
                else
                {
                    sRollString += "Error processing. Try again.";
                }

                sRollString += sCrit+COLOR_END;
                SendMessageToPC(oPC,sRollString);
                SendMessageToAllDMs("Name: "+GetName(oPC)+" rolling! \n"+sRollString);

                object oDicePC = GetFirstPC();
                while (GetIsObjectValid(oDicePC))
                {
                    if (GetIsDM(oDicePC)||GetIsDMPossessed(oDicePC))
                    {
                        DelayCommand(0.3,SendMessageToPC(oDicePC,sRollString));
                    }
                    oDicePC = GetNextPC();
                }

            }
            else if(sCurrCommandArg == "rollp" || sCurrCommandArg == "Rollp" || sCurrCommandArg == "ROLLp"|| sCurrCommandArg == "RollP" || sCurrCommandArg == "ROLLP" || sCurrCommandArg == "rollP")
            {
                SendMessageToPC(oPC,"Coming Soon.");
            }
            else if(sCurrCommandArg == "subdual")
            {
                int nSub = GetLocalInt(oPC,"SUBDUAL");

                if(sCommandArg2 == "on" || sCommandArg2 == "ON" || sCommandArg2 == "On")
                {
                    SetLocalInt(oPC,"SUBDUAL",1);
                    SendMessageToPC(oPC,"Subdual Mode is now ON.");
                }
                else if (sCommandArg2 == "off" || sCommandArg2 == "OFF" || sCommandArg2 == "Off")
                {
                    SetLocalInt(oPC,"SUBDUAL",0);
                    SendMessageToPC(oPC,"Subdual Mode is now OFF.");
                }
                else
                {
                    if(nSub == 1){SendMessageToPC(oPC,"Subdual Mode is ON.");}
                    if(nSub == 0){SendMessageToPC(oPC,"Subdual Mode is OFF.");}
                }
            }
            else if(sCurrCommandArg == "dice")
            {
                SendMessageToPC(oPC,"Coming Soon.");
            }
            else if(sCurrCommandArg == "disguise")
            {
                SendMessageToPC(oPC,"Coming Soon.");
            }
            else if(sCurrCommandArg == "emote")
            {
                SendMessageToPC(oPC,"Coming Soon.");
            }
            else if (sCurrCommandArg == "lang" || sCurrCommandArg == "Lang" || sCurrCommandArg == "Language" || sCurrCommandArg == "language" || sCurrCommandArg == "speak" || sCurrCommandArg == "Speak")
            {
                if(sCommandArg2 == "list" || sCommandArg2 == "List" || sCommandArg2 == "LIST")
                {
                    string sList = "You are able to speak the following languages:\n";
                    if(GetLocalInt(oDataObject,"1") == 1)
                    {
                        sList += "- Elven\n";
                    }
                    if(GetLocalInt(oDataObject,"2") == 1)
                    {
                        sList += "- Gnomish\n";
                    }
                    if(GetLocalInt(oDataObject,"3") == 1)
                    {
                        sList += "- Halfling\n";
                    }
                    if(GetLocalInt(oDataObject,"4") == 1)
                    {
                        sList += "- Dwarven\n";
                    }
                    if(GetLocalInt(oDataObject,"5") == 1)
                    {
                        sList += "- Orc\n";
                    }
                    if(GetLocalInt(oDataObject,"6") == 1)
                    {
                        sList += "- Goblin\n";
                    }
                    if(GetLocalInt(oDataObject,"7") == 1)
                    {
                        sList += "- Draconic\n";
                    }
                    if(GetLocalInt(oDataObject,"8") == 1)
                    {
                        sList += "- Animal\n";
                    }
                    if(GetLocalInt(oDataObject,"9") == 1)
                    {
                        sList += "- Thieves Cant\n";
                    }
                    if(GetLocalInt(oDataObject,"10") == 1)
                    {
                        sList += "- Celestial\n";
                    }
                    if(GetLocalInt(oDataObject,"11") == 1)
                    {
                        sList += "- Abyssal\n";
                    }
                    if(GetLocalInt(oDataObject,"12") == 1)
                    {
                        sList += "- Infernal\n";
                    }
                    if(GetLocalInt(oDataObject,"13") == 1)
                    {
                        sList += "- Drow/Xanalress\n";
                    }
                    if(GetLocalInt(oDataObject,"14") == 1)
                    {
                        sList += "- Drudic\n";
                    }
                    if(GetLocalInt(oDataObject,"22") == 1)
                    {
                        sList += "- Illuskan\n";
                    }
                    if(GetLocalInt(oDataObject,"23") == 1)
                    {
                        sList += "- Alzhedo\n";
                    }
                    if(GetLocalInt(oDataObject,"27") == 1)
                    {
                        sList += "- Mulhorandi\n";
                    }
                    if(GetLocalInt(oDataObject,"30") == 1)
                    {
                        sList += "- Rashemi\n";
                    }
                    if(GetLocalInt(oDataObject,"38") == 1)
                    {
                        sList += "- Talfiric\n";
                    }
                    if(GetLocalInt(oDataObject,"27") == 1)
                    {
                        sList += "- Chessentan\n";
                    }
                    if(GetLocalInt(oDataObject,"46") == 1)
                    {
                        sList += "- Undercommon\n";
                    }
                    if(GetLocalInt(oDataObject,"38") == 1)
                    {
                        sList += "- Chondathan\n";
                    }
                    if(GetLocalInt(oDataObject,"56") == 1)
                    {
                        sList += "- Damaran\n";
                    }
                    if(GetLocalInt(oDataObject,"64") == 1)
                    {
                        sList += "- Duergar\n";
                    }
                    if(GetLocalInt(oDataObject,"64") == 1)
                    {
                        sList += "- Drow Sign Language\n";
                    }
                    SendMessageToPC(oPC,sList);
                }
                else if(sCommandArg2 == "com" || sCommandArg2 == "Com" || sCommandArg2 == "common" || sCommandArg2 == "Common")
                {
                    SetLocalInt(oPC,"LangOn",0);
                    SetLocalInt(oPC,"LangSpoken",0);
                    SendMessageToPC(oPC,"You are now speaking Thorass.");
                }

                /////////////////////////////////////////////////////
                //Planar Languages
                /////////////////////////////////////////////////////
                else if(sCommandArg2 == "aby" || sCommandArg2 == "Aby" || sCommandArg2 == "abyssal" || sCommandArg2 == "Abyssal")
                {
                    if((GetLocalInt(oDataObject,"11") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",11);
                            SendMessageToPC(oPC,"You are now speaking Abyssal.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "inf" || sCommandArg2 == "Inf" || sCommandArg2 == "infernal" || sCommandArg2 == "Infernal")
                {
                    if((GetLocalInt(oDataObject,"12") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",12);
                            SendMessageToPC(oPC,"You are now speaking Infernal.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "Cel" || sCommandArg2 == "cel" || sCommandArg2 == "Celestial" || sCommandArg2 == "celestial")
                {
                    if((GetLocalInt(oDataObject,"10") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",10);
                            SendMessageToPC(oPC,"You are now speaking Celestial.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                    /////////////////////////////////////////////////////
                    //Class Languages
                    /////////////////////////////////////////////////////

                else if(sCommandArg2 == "dru" || sCommandArg2 == "Dru" || sCommandArg2 == "druidic" || sCommandArg2 == "Druidic")
                {
                    if((GetLocalInt(oDataObject,"14") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",14);
                            SendMessageToPC(oPC,"You are now speaking Druidic.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "ani" || sCommandArg2 == "Ani" || sCommandArg2 == "Animal" || sCommandArg2 == "animal")
                {
                    if((GetLocalInt(oDataObject,"8") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",8);
                            SendMessageToPC(oPC,"You are now grunting and growling like an Animal.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "thi" || sCommandArg2 == "Thi" || sCommandArg2 == "Thieves" || sCommandArg2 == "thieves")
                {
                    if((GetLocalInt(oDataObject,"9") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",9);
                            SendMessageToPC(oPC,"You are now signing in Thieves Cant.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You do not know Thieves Cant.");
                        }
                }

                    /////////////////////////////////////////////////////
                    //Racial Languages
                    /////////////////////////////////////////////////////
                else if(sCommandArg2 == "Elv" || sCommandArg2 == "elv" || sCommandArg2 == "Elven" || sCommandArg2 == "elven")
                {
                    if((GetLocalInt(oDataObject,"1") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",1);
                            SendMessageToPC(oPC,"You are now speaking Elven.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "Gno" || sCommandArg2 == "gno" || sCommandArg2 == "Gnomish" || sCommandArg2 == "gnomish")
                {
                    if((GetLocalInt(oDataObject,"2") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",2);
                            SendMessageToPC(oPC,"You are now speaking Gnomish.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "hal" || sCommandArg2 == "Hal" || sCommandArg2 == "Halfling" || sCommandArg2 == "halfling")
                {
                    if((GetLocalInt(oDataObject,"3") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",3);
                            SendMessageToPC(oPC,"You are now speaking Halfling.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "dwa" || sCommandArg2 == "Dwa" || sCommandArg2 == "Dwarven" || sCommandArg2 == "dwarven")
                {
                    if((GetLocalInt(oDataObject,"4") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",4);
                            SendMessageToPC(oPC,"You are now speaking Dwarven.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "Orc" || sCommandArg2 == "orc" || sCommandArg2 == "Orcish" || sCommandArg2 == "Orcish")
                {
                    if((GetLocalInt(oDataObject,"5") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",5);
                            SendMessageToPC(oPC,"You are now speaking Orcish.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "gob" || sCommandArg2 == "Gob" || sCommandArg2 == "Goblin" || sCommandArg2 == "goblin")
                {
                    if((GetLocalInt(oDataObject,"6") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",6);
                            SendMessageToPC(oPC,"You are now speaking Goblin.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "Xanalress" || sCommandArg2 == "xanalress" || sCommandArg2 == "xan" || sCommandArg2 == "Xan" ||
                        sCommandArg2 == "Drow" || sCommandArg2 == "drow" || sCommandArg2 == "dro" || sCommandArg2 == "Dro"                                                                                                                 )
                {
                    if((GetLocalInt(oDataObject,"13") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",13);
                            SendMessageToPC(oPC,"You are now speaking Xanalress.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "sign" || sCommandArg2 == "Sign" || sCommandArg2 == "Drowsign" || sCommandArg2 == "drowsign")
                {
                    if((GetLocalInt(oDataObject,"81") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",81);
                            SendMessageToPC(oPC,"You are now using Drow Sign Language.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You do not know Drow Sign Language.");
                        }
                }
                else if(sCommandArg2 == "und" || sCommandArg2 == "Und" || sCommandArg2 == "Undercommon" || sCommandArg2 == "undercommon")
                {
                    if((GetLocalInt(oDataObject,"46") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",46);
                            SendMessageToPC(oPC,"You are now speaking Undercommon.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "Due" || sCommandArg2 == "due" || sCommandArg2 == "duergar" || sCommandArg2 == "Duergar")
                {
                    if((GetLocalInt(oDataObject,"64") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",64);
                            SendMessageToPC(oPC,"You are now speaking Duergar.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }

                    /////////////////////////////////////////////////////
                    //Human Languages
                    /////////////////////////////////////////////////////
                }
                else if(sCommandArg2 == "Illuskan" || sCommandArg2 == "illuskan" || sCommandArg2 == "Ill" || sCommandArg2 == "ill")
                {
                    if((GetLocalInt(oDataObject,"22") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",22);
                            SendMessageToPC(oPC,"You are now speaking Illuskan.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "Alzhedo" || sCommandArg2 == "alzhedo" || sCommandArg2 == "alz" || sCommandArg2 == "Alz"|| sCommandArg2 == "calishite"||sCommandArg2 == "Calishite")
                {
                    if((GetLocalInt(oDataObject,"23") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",23);
                            SendMessageToPC(oPC,"You are now speaking Alzhedo.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "ima" || sCommandArg2 == "Ima" || sCommandArg2 == "Imaskar" || sCommandArg2 == "imaskar")
                {
                    if((GetLocalInt(oDataObject,"24") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",24);
                            SendMessageToPC(oPC,"You are now speaking Imaskar.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "Lantanese" || sCommandArg2 == "lantanese" || sCommandArg2 == "lan" || sCommandArg2 == "Lan")
                {
                    if((GetLocalInt(oDataObject,"25") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",25);
                            SendMessageToPC(oPC,"You are now speaking Lantanese.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "Mulhorandi" || sCommandArg2 == "mulhorandi" || sCommandArg2 == "mul" || sCommandArg2 == "Mul")
                {
                    if((GetLocalInt(oDataObject,"27") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",27);
                            SendMessageToPC(oPC,"You are now speaking Mulhorandi.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "ras" || sCommandArg2 == "Ras" || sCommandArg2 == "rashemi" || sCommandArg2 == "Rashemi")
                {
                    if((GetLocalInt(oDataObject,"30") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",30);
                            SendMessageToPC(oPC,"You are now speaking Rashemi.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "Talfiric" || sCommandArg2 == "talfiric" || sCommandArg2 == "tal" || sCommandArg2 == "Tal")
                {
                    if((GetLocalInt(oDataObject,"38") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",38);
                            SendMessageToPC(oPC,"You are now speaking Talfiric.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "Che" || sCommandArg2 == "che" || sCommandArg2 == "Chessentan" || sCommandArg2 == "chessentan")
                {
                    if((GetLocalInt(oDataObject,"44") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",44);
                            SendMessageToPC(oPC,"You are now speaking Chessentan.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "cho" || sCommandArg2 == "Cho" || sCommandArg2 == "Chondathan" || sCommandArg2 == "chondathan")
                {
                    if((GetLocalInt(oDataObject,"53") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",53);
                            SendMessageToPC(oPC,"You are now speaking Chondathan.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "chu" || sCommandArg2 == "Chu" || sCommandArg2 == "Chultan" || sCommandArg2 == "chultan")
                {
                    if((GetLocalInt(oDataObject,"55") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",55);
                            SendMessageToPC(oPC,"You are now speaking Chultan.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else if(sCommandArg2 == "Dam" || sCommandArg2 == "dam" || sCommandArg2 == "damaran" || sCommandArg2 == "Damaran")
                {
                    if((GetLocalInt(oDataObject,"56") == 1)||(GetLocalInt(oPC,"Tongues") == 1)||(GetIsDM(oPC) == TRUE )|| (GetIsDMPossessed(oPC) == TRUE))
                        {
                            SetLocalInt(oPC,"LangOn",1);
                            SetLocalInt(oPC,"LangSpoken",56);
                            SendMessageToPC(oPC,"You are now speaking Damaran.");
                        }
                        else
                        {
                            SendMessageToPC(oPC,"You cannot speak this language");
                        }
                }
                else
                {
                    SendMessageToPC(oPC, "Command not recognized. Use \"-help\" for a complete list of commands and syntax.");
                }

            }
            else if (sCurrCommandArg == "Weave" || sCurrCommandArg == "weave" || sCurrCommandArg == "WEAVE")
            {
                int oDead = GetCampaignInt("Deadmagic",GetTag(oArea));
                if (GetIsDM(oPC) || GetIsDMPossessed(oPC))
                {
                    SendMessageToPC(oPC, "Exact value is: " + IntToString(oDead));
                }
                if (GetHasFeat(1599, oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC))
                {
                    if (oDead >=95)
                    {
                        SendMessageToPC(oPC,"The weave here is damaged enough that you sense nothing.");
                    }
                    else if (oDead >=66)
                    {
                        SendMessageToPC(oPC,"The weave here is extremely damaged.");
                    }
                    else if (oDead >=33)
                    {
                        SendMessageToPC(oPC,"The weave here is moderately damaged.");
                    }
                    else
                    {
                        SendMessageToPC(oPC,"The weave here is fairly healthy.");
                    }
                }
            }
            else if ((sCurrCommandArg == "adddeadmagic" || sCurrCommandArg == "AddDeadMagic" || sCurrCommandArg == "ADDDEADMAGIC" || sCurrCommandArg == "Adddeadmagic") && GetIsDM(oPC))
            {
                int oDead = GetCampaignInt("Deadmagic",GetTag(oArea));
                SetCampaignInt("Deadmagic",GetTag(oArea),oDead + StringToInt(sCommandArg2));
                SendMessageToPC(oPC, "New Dead Magic: " + IntToString(oDead + StringToInt(sCommandArg2)));
            }
            else if ((sCurrCommandArg == "removedeadmagic" || sCurrCommandArg == "RemoveDeadMagic" || sCurrCommandArg == "REMOVEDEADMAGIC" || sCurrCommandArg == "Removedeadmagic") && GetIsDM(oPC))
            {
                int oDead = GetCampaignInt("Deadmagic",GetTag(oArea));
                SetCampaignInt("Deadmagic",GetTag(oArea),oDead - StringToInt(sCommandArg2));
                SendMessageToPC(oPC, "New Dead Magic: " + IntToString(oDead + StringToInt(sCommandArg2)));
            }
            else if ((sCurrCommandArg == "addwildmagic" || sCurrCommandArg == "AddWildMagic" || sCurrCommandArg == "ADDWILDMAGIC" || sCurrCommandArg == "Addwildmagic") && GetIsDM(oPC))
            {
                int oDead = GetCampaignInt("Wildmagic",GetTag(oArea));
                SetCampaignInt("Wildmagic",GetTag(oArea),oDead + StringToInt(sCommandArg2));
                SendMessageToPC(oPC, "New Wild Magic: " + IntToString(oDead + StringToInt(sCommandArg2)));
            }
            else if ((sCurrCommandArg == "removewildmagic" || sCurrCommandArg == "RemoveWildMagic" || sCurrCommandArg == "REMOVEWILDMAGIC" || sCurrCommandArg == "Removewildmagic") && GetIsDM(oPC))
            {
                int oDead = GetCampaignInt("Deadmagic",GetTag(oArea));
                SetCampaignInt("Wildmagic",GetTag(oArea),oDead - StringToInt(sCommandArg2));
                SendMessageToPC(oPC, "New Wild Magic: " + IntToString(oDead + StringToInt(sCommandArg2)));
            }
            else if ((sCurrCommandArg == "shopset" || sCurrCommandArg == "ShopSet" || sCurrCommandArg == "SHOPSET" || sCurrCommandArg == "Shopset") && GetIsDM(oPC))
            {
                string sUnique = sCommandArg2;
                int nPrice = StringToInt(sCommandArg3);
                SetCampaignInt("GS_SHOP", "PRICE_"+sUnique, nPrice);
            }
            else if (sCurrCommandArg == "bug" || sCurrCommandArg == "Bug" || sCurrCommandArg == "BUG")
            {
                //  NWNX_WebHook_SendWebHookHTTPS("discordapp.com", WEBHOOK_BUG_CHANNEL, "Bug Message: " + sChatMessage, GetName(oPC));
                SendMessageToPC(oPC,"Please visit https://landsofintrigue.guildtag.com/ to log a bug in the forums.");
            }
            else
            {
                SendMessageToPC(oPC, "Command not recognized. Use \"-help\" for a complete list of commands and syntax.");
            }
        }

    }
    else if(GetPCChatVolume() == TALKVOLUME_PARTY)
    {
        if(!GetIsDM(oPC))
        {
            SetPCChatMessage("");
        }
    }
}



�
