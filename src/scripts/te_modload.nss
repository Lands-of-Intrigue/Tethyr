//:://////////////////////////////////////////////
//:: OnClientLeave
//:: TE_ClientLeave
//:: Function(D20) 2016
//:://////////////////////////////////////////////
//::///////////////////////////////////////////////
//:: Example XP2 OnLoad Script
//:: x2_mod_def_load
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnModuleLoad Event

    This example script demonstrates how to tweak the
    behavior of several subsystems in your module.

    For more information, please check x2_inc_switches
    which holds definitions for several variables that
    can be set on modules, creatures, doors or waypoints
    to change the default behavior of Bioware scripts.

    Warning:
    Using some of these switches may change your games
    balancing and may introduce bugs or instabilities. We
    recommend that you only use these switches if you
    know what you are doing. Consider these features
    unsupported!

    Please do NOT report any bugs you experience while
    these switches have been changed from their default
    positions.

    Make sure you visit the forums at nwn.bioware.com
    to find out more about these scripts.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////
#include "inc_spell_func"
#include "x2_inc_switches"
#include "x2_inc_restsys"
#include "sas_include"
#include "_inc_loot"
#include "te_settle_inc"
#include "nwnx_weapon"
#include "nwnx_damage"
#include "nwnx_webhook"
#include "spawn_cfg_group"
#include "nwnx_admin"
#include "nwnx_events"
#include "nwnx_skill"


void main()
{
    object oArea = GetObjectByTag("te_ooc_loot");
    LootInitAreaMerchants(oArea);
    SetMaxHenchmen(5);

    NWNX_Weapon_SetWeaponIsMonkWeapon(53);
    NWNX_Weapon_SetWeaponIsMonkWeapon(50);
    NWNX_Weapon_SetWeaponIsMonkWeapon(500);
    NWNX_Weapon_SetWeaponIsMonkWeapon(1);
    NWNX_Weapon_SetWeaponIsMonkWeapon(304);
    NWNX_Weapon_SetWeaponIsMonkWeapon(303);
    NWNX_Weapon_SetWeaponIsMonkWeapon(59);
    NWNX_Weapon_SetWeaponIsMonkWeapon(0);
    NWNX_Weapon_SetWeaponIsMonkWeapon(22);

    NWNX_Damage_SetDamageEventScript("te_on_damage",OBJECT_INVALID);
    NWNX_Damage_SetAttackEventScript("te_on_attack",OBJECT_INVALID);

    object oMod = GetModule();
    int nHour, nDay, nMonth, nYear;
    if(GetCampaignInt("Dates","TIMEYEAR",oMod))
    {
        nHour=GetCampaignInt("Dates","TIMEHOUR",oMod);
        nDay=GetCampaignInt("Dates","TIMEDAY",oMod);
        nMonth=GetCampaignInt("Dates","TIMEMONTH",oMod);
        nYear=GetCampaignInt("Dates","TIMEYEAR",oMod);
        SetLocalInt(oMod,"HourStart", nHour);
        SetLocalInt(oMod,"DayStart", nDay);
        SetLocalInt(oMod,"MonthStart", nMonth);
        SetLocalInt(oMod,"YearStart", nYear);
        SetCalendar(nYear, nMonth, nDay);
        SetTime(nHour, 0, 0, 0);
    }
    else
    {
        SetLocalInt(oMod,"HourStart", GetTimeHour());
        SetLocalInt(oMod,"DayStart", GetCalendarDay());
        SetLocalInt(oMod,"MonthStart", GetCalendarMonth());
        SetLocalInt(oMod,"YearStart", GetCalendarYear());
    }


    SetLocalInt(oMod,"GROVE_MARSH",GetCampaignInt(GetName(oMod),"GROVE_MARSH"));
    SetLocalInt(oMod,"GROVE_LAKE",GetCampaignInt(GetName(oMod),"GROVE_LAKE"));
    SetLocalInt(oMod,"GROVE_ELF",GetCampaignInt(GetName(oMod),"GROVE_ELF"));
    SetLocalInt(oMod,"GROVE_SPIRE",GetCampaignInt(GetName(oMod),"GROVE_SPIRE"));
    SetLocalInt(oMod,"GROVE_TEJARN",GetCampaignInt(GetName(oMod),"GROVE_TEJARN"));
    SetLocalInt(oMod,"GROVE_OAK",GetCampaignInt(GetName(oMod),"GROVE_OAK"));

    SetupResources(GetTag(oMod));

    SetLocalFloat(oMod,"Weather_Humidity_Month_1",5.0f);
    SetLocalFloat(oMod,"Weather_Humidity_Month_2",10.0f);
    SetLocalFloat(oMod,"Weather_Humidity_Month_3",20.0f);
    SetLocalFloat(oMod,"Weather_Humidity_Month_4",70.0f);
    SetLocalFloat(oMod,"Weather_Humidity_Month_5",55.0f);
    SetLocalFloat(oMod,"Weather_Humidity_Month_6",55.0f);
    SetLocalFloat(oMod,"Weather_Humidity_Month_7",55.0f);
    SetLocalFloat(oMod,"Weather_Humidity_Month_8",60.0f);
    SetLocalFloat(oMod,"Weather_Humidity_Month_9",65.0f);
    SetLocalFloat(oMod,"Weather_Humidity_Month_10",80.0f);
    SetLocalFloat(oMod,"Weather_Humidity_Month_11",65.0f);
    SetLocalFloat(oMod,"Weather_Humidity_Month_12",20.0f);
    SetLocalFloat(oMod,"Weather_Temperature_Month_1",24.0f);
    SetLocalFloat(oMod,"Weather_Temperature_Month_2",21.0f);
    SetLocalFloat(oMod,"Weather_Temperature_Month_3",24.0f);
    SetLocalFloat(oMod,"Weather_Temperature_Month_4",28.0f);
    SetLocalFloat(oMod,"Weather_Temperature_Month_5",30.0f);
    SetLocalFloat(oMod,"Weather_Temperature_Month_6",34.0f);
    SetLocalFloat(oMod,"Weather_Temperature_Month_7",35.0f);
    SetLocalFloat(oMod,"Weather_Temperature_Month_8",40.0f);
    SetLocalFloat(oMod,"Weather_Temperature_Month_9",37.0f);
    SetLocalFloat(oMod,"Weather_Temperature_Month_10",34.0f);
    SetLocalFloat(oMod,"Weather_Temperature_Month_11",30.0f);
    SetLocalFloat(oMod,"Weather_Temperature_Month_12",28.0f);

   if (GetGameDifficulty() ==  GAME_DIFFICULTY_CORE_RULES || GetGameDifficulty() ==  GAME_DIFFICULTY_DIFFICULT)
   {
        // * Setting the switch below will enable a seperate Use Magic Device Skillcheck for
        // * rogues when playing on Hardcore+ difficulty. This only applies to scrolls
        SetModuleSwitch (MODULE_SWITCH_ENABLE_UMD_SCROLLS, TRUE);

       // * Activating the switch below will make AOE spells hurt neutral NPCS by default
       // SetModuleSwitch (MODULE_SWITCH_AOE_HURT_NEUTRAL_NPCS, TRUE);
   }

   // * AI: Activating the switch below will make the creaures using the WalkWaypoint function
   // * able to walk across areas
   // SetModuleSwitch (MODULE_SWITCH_ENABLE_CROSSAREA_WALKWAYPOINTS, TRUE);

   // * Spells: Activating the switch below will make the Glyph of Warding spell behave differently:
   // * The visual glyph will disappear after 6 seconds, making them impossible to spot
   // SetModuleSwitch (MODULE_SWITCH_ENABLE_INVISIBLE_GLYPH_OF_WARDING, TRUE);

   // * Craft Feats: Want 50 charges on a newly created wand? We found this unbalancing,
   // * but since it is described this way in the book, here is the switch to get it back...
   // SetModuleSwitch (MODULE_SWITCH_ENABLE_CRAFT_WAND_50_CHARGES, TRUE);

   // * Craft Feats: Use this to disable Item Creation Feats if you do not want
   // * them in your module
   // SetModuleSwitch (MODULE_SWITCH_DISABLE_ITEM_CREATION_FEATS, TRUE);

   // * Palemaster: Deathless master touch in PnP only affects creatures up to a certain size.
   // * We do not support this check for balancing reasons, but you can still activate it...
   // SetModuleSwitch (MODULE_SWITCH_SPELL_CORERULES_DMASTERTOUCH, TRUE);

   // * Epic Spellcasting: Some Epic spells feed on the liveforce of the caster. However this
   // * did not fit into NWNs spell system and was confusing, so we took it out...
   // SetModuleSwitch (MODULE_SWITCH_EPIC_SPELLS_HURT_CASTER, TRUE);

   // * Epic Spellcasting: Some Epic spells feed on the liveforce of the caster. However this
   // * did not fit into NWNs spell system and was confusing, so we took it out...
   // SetModuleSwitch (MODULE_SWITCH_RESTRICT_USE_POISON_TO_FEAT, TRUE);

    // * Spellcasting: Some people don't like caster's abusing expertise to raise their AC
    // * Uncommenting this line will drop expertise mode whenever a spell is cast by a player
    // SetModuleSwitch (MODULE_VAR_AI_STOP_EXPERTISE_ABUSE, TRUE);


    // * Item Event Scripts: The game's default event scripts allow routing of all item related events
    // * into a single file, based on the tag of that item. If an item's tag is "test", it will fire a
    // * script called "test" when an item based event (equip, unequip, acquire, unacquire, activate,...)
    // * is triggered. Check "x2_it_example.nss" for an example.
    // * This feature is disabled by default.
   SetModuleSwitch (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS, TRUE);

   if (GetModuleSwitchValue (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
   {
        // * If Tagbased scripts are enabled, and you are running a Local Vault Server
        // * you should use the line below to add a layer of security to your server, preventing
        // * people to execute script you don't want them to. If you use the feature below,
        // * all called item scrips will be the prefix + the Tag of the item you want to execute, up to a
        // * maximum of 16 chars, instead of the pure tag of the object.
        // * i.e. without the line below a user activating an item with the tag "test",
        // * will result in the execution of a script called "test". If you uncomment the line below
        // * the script called will be "1_test.nss"
        // SetUserDefinedItemEventPrefix("1_");

   }

   // * This initializes Bioware's wandering monster system as used in Hordes of the Underdark
   // * You can deactivate it, making your module load faster if you do not use it.
   // * If you want to use it, make sure you set "x2_mod_def_rest" as your module's OnRest Script
   // SetModuleSwitch (MODULE_SWITCH_USE_XP2_RESTSYSTEM, TRUE);

   if (GetModuleSwitchValue(MODULE_SWITCH_USE_XP2_RESTSYSTEM) == TRUE)
   {

       // * This allows you to specify a different 2da for the wandering monster system.
       // SetWanderingMonster2DAFile("des_restsystem");

       //* Do not change this line.
       WMBuild2DACache();
   }
   NESSInitializeGroups();
   AssignCommand(GetModule(), SFInitialization());
   ExecuteScript("so_init_weather",GetModule());

    //NWNX_WebHook_SendWebHookHTTPS("discordapp.com",WEBHOOK_EVENT_CHANNEL,"Module start-up complete.");
    NWNX_WebHook_SendWebHookHTTPS("discordapp.com",WEBHOOK_PUBLIC_CHANNEL,"<@&965706089167474749> The Module is now finished loading and the server is back online!");


    NWNX_Events_SubscribeEvent("NWNX_ON_WEBHOOK_FAILED","event_webhook");
    NWNX_Events_SubscribeEvent("NWNX_ON_LEVEL_UP_AFTER","event_level");
    NWNX_Events_SubscribeEvent("NWNX_ON_DM_GIVE_GOLD_AFTER","event_dm");
    NWNX_Events_SubscribeEvent("NWNX_ON_DM_GIVE_XP_AFTER","event_dm");
    NWNX_Events_SubscribeEvent("NWNX_ON_DM_GIVE_LEVEL_AFTER","event_dm");
    NWNX_Events_SubscribeEvent("NWNX_ON_DM_GIVE_ALIGNMENT_AFTER","event_dm");
    NWNX_Events_SubscribeEvent("NWNX_ON_CLIENT_DISCONNECT_BEFORE","event_leave");

    NWNX_Events_SubscribeEvent("NWNX_ON_DECREMENT_SPELL_COUNT_AFTER", "loi_cantrips");
}
