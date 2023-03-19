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

/*
    //1 Handed Trident
    NWNX_Weapon_SetWeaponFocusFeat(300,1072);
    NWNX_Weapon_SetWeaponSpecializationFeat(300,1073);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(300,1074);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(300,1075);
    NWNX_Weapon_SetEpicWeaponFocusFeat(300,1076);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(300,1077);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(300,1078);
    NWNX_Weapon_SetWeaponOfChoiceFeat(300,1079);

    //Assassin's Dagger
    NWNX_Weapon_SetWeaponFocusFeat(309,90);
    NWNX_Weapon_SetWeaponSpecializationFeat(309,128);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(309,52);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(309,496);
    NWNX_Weapon_SetEpicWeaponFocusFeat(309,620);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(309,658);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(309,710);
    NWNX_Weapon_SetWeaponOfChoiceFeat(309,920);

    //Light Mace
    NWNX_Weapon_SetWeaponFocusFeat(312,94);
    NWNX_Weapon_SetWeaponSpecializationFeat(312,132);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(312,56);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(312,500);
    NWNX_Weapon_SetEpicWeaponFocusFeat(312,624);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(312,662);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(312,714);
    NWNX_Weapon_SetWeaponOfChoiceFeat(312,921);

    //Heavy Mace
    NWNX_Weapon_SetWeaponFocusFeat(317,94);
    NWNX_Weapon_SetWeaponSpecializationFeat(317,132);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(317,56);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(317,500);
    NWNX_Weapon_SetEpicWeaponFocusFeat(317,624);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(317,662);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(317,714);
    NWNX_Weapon_SetWeaponOfChoiceFeat(317,921);

    //Balanced Quarter Staff
    NWNX_Weapon_SetWeaponFocusFeat(500,97);
    NWNX_Weapon_SetWeaponSpecializationFeat(500,134);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(500,58);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(500,502);
    NWNX_Weapon_SetEpicWeaponFocusFeat(500,626);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(500,664);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(500,716);
    NWNX_Weapon_SetWeaponOfChoiceFeat(500,923);

    //Longsword
    NWNX_Weapon_SetWeaponFocusFeat(319,106);
    NWNX_Weapon_SetWeaponSpecializationFeat(319,144);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(319,68);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(319,512);
    NWNX_Weapon_SetEpicWeaponFocusFeat(319,636);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(319,674);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(319,726);
    NWNX_Weapon_SetWeaponOfChoiceFeat(319,928);

    //Longsword 2
    NWNX_Weapon_SetWeaponFocusFeat(330,106);
    NWNX_Weapon_SetWeaponSpecializationFeat(330,144);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(330,68);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(330,512);
    NWNX_Weapon_SetEpicWeaponFocusFeat(330,636);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(330,674);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(330,726);
    NWNX_Weapon_SetWeaponOfChoiceFeat(330,928);

    //Greatsword
    NWNX_Weapon_SetWeaponFocusFeat(320,107);
    NWNX_Weapon_SetWeaponSpecializationFeat(320,145);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(320,69);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(320,513);
    NWNX_Weapon_SetEpicWeaponFocusFeat(320,634);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(320,675);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(320,727);
    NWNX_Weapon_SetWeaponOfChoiceFeat(320,929);

    //Kukri 2
    NWNX_Weapon_SetWeaponFocusFeat(313,118);
    NWNX_Weapon_SetWeaponSpecializationFeat(313,156);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(313,80);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(313,524);
    NWNX_Weapon_SetEpicWeaponFocusFeat(313,648);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(313,686);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(313,738);
    NWNX_Weapon_SetWeaponOfChoiceFeat(313,881);

    //Sai
    NWNX_Weapon_SetWeaponFocusFeat(303,1500);
    NWNX_Weapon_SetWeaponSpecializationFeat(303,1501);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(303,1502);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(303,1503);
    NWNX_Weapon_SetEpicWeaponFocusFeat(303,1504);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(303,1505);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(303,1506);
    NWNX_Weapon_SetWeaponOfChoiceFeat(303,1507);

    //Nunchaku
    NWNX_Weapon_SetWeaponFocusFeat(304,1508);
    NWNX_Weapon_SetWeaponSpecializationFeat(304,1509);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(304,1510);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(304,1511);
    NWNX_Weapon_SetEpicWeaponFocusFeat(304,1512);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(304,1513);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(304,1514);
    NWNX_Weapon_SetWeaponOfChoiceFeat(304,1515);

    //Falchion
    NWNX_Weapon_SetWeaponFocusFeat(305,1516);
    NWNX_Weapon_SetWeaponSpecializationFeat(305,1517);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(305,1518);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(305,1519);
    NWNX_Weapon_SetEpicWeaponFocusFeat(305,1520);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(305,1521);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(305,1522);
    NWNX_Weapon_SetWeaponOfChoiceFeat(305,1523);

    //Sap
    NWNX_Weapon_SetWeaponFocusFeat(308,1524);
    NWNX_Weapon_SetWeaponSpecializationFeat(308,1525);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(308,1526);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(308,1527);
    NWNX_Weapon_SetEpicWeaponFocusFeat(308,1528);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(308,1529);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(308,1530);
    NWNX_Weapon_SetWeaponOfChoiceFeat(308,1531);

    //Katar
    NWNX_Weapon_SetWeaponFocusFeat(310,1532);
    NWNX_Weapon_SetWeaponSpecializationFeat(310,1533);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(310,1534);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(310,1535);
    NWNX_Weapon_SetEpicWeaponFocusFeat(310,1536);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(310,1537);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(310,1538);
    NWNX_Weapon_SetWeaponOfChoiceFeat(310,1539);

    //Maul
    NWNX_Weapon_SetWeaponFocusFeat(318,1540);
    NWNX_Weapon_SetWeaponSpecializationFeat(318,1541);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(318,1542);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(318,1543);
    NWNX_Weapon_SetEpicWeaponFocusFeat(318,1544);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(318,1545);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(318,1546);
    NWNX_Weapon_SetWeaponOfChoiceFeat(318,1547);

    //Chakram
    NWNX_Weapon_SetWeaponFocusFeat(323,1548);
    NWNX_Weapon_SetWeaponSpecializationFeat(323,1549);
    NWNX_Weapon_SetWeaponImprovedCriticalFeat(323,1550);
    NWNX_Weapon_SetEpicWeaponDevastatingCriticalFeat(323,1551);
    NWNX_Weapon_SetEpicWeaponFocusFeat(323,1552);
    NWNX_Weapon_SetEpicWeaponSpecializationFeat(323,1553);
    NWNX_Weapon_SetEpicWeaponOverwhelmingCriticalFeat(323,1554);
    NWNX_Weapon_SetWeaponOfChoiceFeat(323,1555);  */

    NWNX_Damage_SetDamageEventScript("te_on_damage",OBJECT_INVALID);
    NWNX_Damage_SetAttackEventScript("te_on_attack",OBJECT_INVALID);

/*    struct NWNX_SkillRanks_SkillFeat skillFeat;

    skillFeat.iSkill = SKILL_APPRAISE;
    skillFeat.iFeat = 1153;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_CONCENTRATION;
    skillFeat.iFeat = 1389;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_CONSTITUTION | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_DISCIPLINE;
    skillFeat.iFeat = 1154;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_STRENGTH | NWNX_SKILLRANKS_KEY_ABILITY_CONSTITUTION | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_DISCIPLINE;
    skillFeat.iFeat = 1464;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_STRENGTH | NWNX_SKILLRANKS_KEY_ABILITY_CONSTITUTION | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_SPELLCRAFT;
    skillFeat.iFeat = 1390;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_APPRAISE;
    skillFeat.iFeat = 1391;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_PERSUADE;
    skillFeat.iFeat = 1392;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_ANIMAL_EMPATHY;
    skillFeat.iFeat = 1393;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_WISDOM | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_APPRAISE;
    skillFeat.iFeat = 1155;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_DISCIPLINE;
    skillFeat.iFeat = 1156;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_STRENGTH | NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_DISCIPLINE;
    skillFeat.iFeat = 1157;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_STRENGTH | NWNX_SKILLRANKS_KEY_ABILITY_DEXTERITY | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_PERSUADE;
    skillFeat.iFeat = 1463;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_WISDOM | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_BLUFF;
    skillFeat.iFeat = 1460;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_PERSUADE;
    skillFeat.iFeat = 1461;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_WISDOM | NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_LORE;
    skillFeat.iFeat = 1394;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_WISDOM | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_PERSUADE;
    skillFeat.iFeat = 1158;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_SPOT;
    skillFeat.iFeat = 1159;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_WISDOM | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_INTIMIDATE;
    skillFeat.iFeat = 1160;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_STRENGTH | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_PERFORM;
    skillFeat.iFeat = 1395;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_BLUFF;
    skillFeat.iFeat = 1396;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_HEAL;
    skillFeat.iFeat = 1161;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_WISDOM | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_DISCIPLINE;
    skillFeat.iFeat = 1163;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_STRENGTH | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_DISCIPLINE;
    skillFeat.iFeat = 1469; skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_STRENGTH | NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_SPELLCRAFT;
    skillFeat.iFeat = 1466;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_WISDOM | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_RIDE;
    skillFeat.iFeat = 1162;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_DEXTERITY | NWNX_SKILLRANKS_KEY_ABILITY_CONSTITUTION | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_RIDE;
    skillFeat.iFeat = 1397; skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_DEXTERITY | NWNX_SKILLRANKS_KEY_ABILITY_CONSTITUTION | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_APPRAISE;
    skillFeat.iFeat = 1165;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_PERFORM;
    skillFeat.iFeat = 1167;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_LORE;
    skillFeat.iFeat = 1470;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_WISDOM | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_SPELLCRAFT;
    skillFeat.iFeat = 1168;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_TAUNT;
    skillFeat.iFeat = 1185;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_STRENGTH | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_SET_TRAP;
    skillFeat.iFeat = 1169;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_DEXTERITY | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_DISCIPLINE;
    skillFeat.iFeat = 1465;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_STRENGTH | NWNX_SKILLRANKS_KEY_ABILITY_WISDOM | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_SPOT;
    skillFeat.iFeat = 1170;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_WISDOM | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_DISCIPLINE;
    skillFeat.iFeat = 1172;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_STRENGTH | NWNX_SKILLRANKS_KEY_ABILITY_CONSTITUTION | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_CONCENTRATION;
    skillFeat.iFeat = 1174;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_CONSTITUTION | NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_SEARCH;
    skillFeat.iFeat = 1462;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_WISDOM | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_SPELLCRAFT;
    skillFeat.iFeat = 1176;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_WISDOM | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_PERSUADE;
    skillFeat.iFeat = 1399;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_WISDOM | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_PICK_POCKET;
    skillFeat.iFeat = 1171;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_DEXTERITY | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_DISCIPLINE;
    skillFeat.iFeat = 1468;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_STRENGTH | NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_RIDE;
    skillFeat.iFeat = 1173;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_DEXTERITY | NWNX_SKILLRANKS_KEY_ABILITY_CONSTITUTION | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_DISCIPLINE;
    skillFeat.iFeat = 1400;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_STRENGTH | NWNX_SKILLRANKS_KEY_ABILITY_DEXTERITY | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_DISCIPLINE;
    skillFeat.iFeat = 1471;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_STRENGTH | NWNX_SKILLRANKS_KEY_ABILITY_DEXTERITY | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_BLUFF;
    skillFeat.iFeat = 1401;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_CHARISMA | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);

    skillFeat.iSkill = SKILL_LISTEN;
    skillFeat.iFeat = 1467;
    skillFeat.iKeyAbilityMask = NWNX_SKILLRANKS_KEY_ABILITY_WISDOM | NWNX_SKILLRANKS_KEY_ABILITY_INTELLIGENCE | NWNX_SKILLRANKS_KEY_ABILITY_CALC_MAX;
    NWNX_SkillRanks_SetSkillFeat(skillFeat,TRUE);
*/
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


    SetLocalInt(oMod,"DEITY_Shadow_Druids",0);
    SetLocalInt(oMod,"DEITY_Finder_Wyvernspur",2);
    SetLocalInt(oMod,"DEITY_Garagos",2);
    SetLocalInt(oMod,"DEITY_Gargauth",2);
    SetLocalInt(oMod,"DEITY_Gwaeron_Windstrom",2);
    SetLocalInt(oMod,"DEITY_Hoar",2);
    SetLocalInt(oMod,"DEITY_Lurue",2);
    SetLocalInt(oMod,"DEITY_Nobanion",2);
    SetLocalInt(oMod,"DEITY_Red_Knight",2);
    SetLocalInt(oMod,"DEITY_Savras",2);
    SetLocalInt(oMod,"DEITY_Sharess",2);
    SetLocalInt(oMod,"DEITY_Shiallia",2);
    SetLocalInt(oMod,"DEITY_Siamorphe",2);
    SetLocalInt(oMod,"DEITY_Valkur",2);
    SetLocalInt(oMod,"DEITY_Velsharoon",2);
    SetLocalInt(oMod,"DEITY_Akadi",4);
    SetLocalInt(oMod,"DEITY_Chauntea",4);
    SetLocalInt(oMod,"DEITY_Cyric",4);
    SetLocalInt(oMod,"DEITY_Grumbar",4);
    SetLocalInt(oMod,"DEITY_Istisha",4);
    SetLocalInt(oMod,"DEITY_Kelemvor",4);
    SetLocalInt(oMod,"DEITY_Kossuth",4);
    SetLocalInt(oMod,"DEITY_Lathander",4);
    SetLocalInt(oMod,"DEITY_Mystra",4);
    SetLocalInt(oMod,"DEITY_Oghma",4);
    SetLocalInt(oMod,"DEITY_Shar",4);
    SetLocalInt(oMod,"DEITY_Silvanus",4);
    SetLocalInt(oMod,"DEITY_Sune",4);
    SetLocalInt(oMod,"DEITY_Talos",4);
    SetLocalInt(oMod,"DEITY_Tempus",4);
    SetLocalInt(oMod,"DEITY_Beshaba",4);
    SetLocalInt(oMod,"DEITY_Gond",4);
    SetLocalInt(oMod,"DEITY_Helm",4);
    SetLocalInt(oMod,"DEITY_Ilmater",4);
    SetLocalInt(oMod,"DEITY_Mielikki",4);
    SetLocalInt(oMod,"DEITY_Selune",4);
    SetLocalInt(oMod,"DEITY_Tymora",4);
    SetLocalInt(oMod,"DEITY_Umberlee",4);
    SetLocalInt(oMod,"DEITY_Auril",3);
    SetLocalInt(oMod,"DEITY_Azuth",3);
    SetLocalInt(oMod,"DEITY_Deneir",3);
    SetLocalInt(oMod,"DEITY_Eldath",3);
    SetLocalInt(oMod,"DEITY_Ibrandul",3);
    SetLocalInt(oMod,"DEITY_Leira",3);
    SetLocalInt(oMod,"DEITY_Lliira",3);
    SetLocalInt(oMod,"DEITY_Loviatar",3);
    SetLocalInt(oMod,"DEITY_Malar",3);
    SetLocalInt(oMod,"DEITY_Mask",3);
    SetLocalInt(oMod,"DEITY_Milil",3);
    SetLocalInt(oMod,"DEITY_Shaundakul",3);
    SetLocalInt(oMod,"DEITY_Talona",3);
    SetLocalInt(oMod,"DEITY_Torm",3);
    SetLocalInt(oMod,"DEITY_Tyr",3);
    SetLocalInt(oMod,"DEITY_Xvim",4);
    SetLocalInt(oMod,"DEITY_Dwarven_Powers",4);
    SetLocalInt(oMod,"DEITY_Elven_Powers",4);
    SetLocalInt(oMod,"DEITY_Gnomish_Powers",4);
    SetLocalInt(oMod,"DEITY_Halfling_Powers",4);
    SetLocalInt(oMod,"DEITY_Orcish_Powers",4);
    SetLocalInt(oMod,"DEITY_Underdark_Powers",4);

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
    NWNX_Administration_ClearPlayerPassword();

    NWNX_Events_SubscribeEvent("NWNX_ON_WEBHOOK_FAILED","event_webhook");
    NWNX_Events_SubscribeEvent("NWNX_ON_LEVEL_UP_AFTER","event_level");
    NWNX_Events_SubscribeEvent("NWNX_ON_DM_GIVE_GOLD_AFTER","event_dm");
    NWNX_Events_SubscribeEvent("NWNX_ON_DM_GIVE_XP_AFTER","event_dm");
    NWNX_Events_SubscribeEvent("NWNX_ON_DM_GIVE_LEVEL_AFTER","event_dm");
    NWNX_Events_SubscribeEvent("NWNX_ON_DM_GIVE_ALIGNMENT_AFTER","event_dm");
    NWNX_Events_SubscribeEvent("NWNX_ON_CLIENT_DISCONNECT_BEFORE","event_leave");
}
