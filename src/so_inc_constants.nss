//Global constants:

const string MODULE_VERSION="POTM_1_61L";
const string MODULE_PREVIOUS_VERSION="POTM_1_61K";
const float REST_DURATION=15.0;
const int MINUTES_PER_HOUR=6;
const string WORLD_COUNTER="World_Counter";
const int MAX_LEVEL_DIFFERENCE=10;
const string WORLD_YEAR="World_Year";
const float BUFF_TIME_DURATION_BUFFER=60.0;

const float BUFF_TIME_DURATION_BUFFER_LONG=360.0;

const string GENERIC_INITIALIZED = "Initialized";
const string GENERIC_SETUP_DONE = "SetupDone";
const string GENERIC_IS_GENERIC = "Generic";
const string GENERIC_VALID="Valid";

const string DATABASE_MODULE="POTM";
const string DATABASE_CLOCK="_CLOCK";
const string DATABASE_CHAR_COUNT="_CHAR_COUNT";
const string DATABASE_DM_ACCOUNTS="_DM_ACCOUNTS";
const string DATABASE_MODULE_PLAYER_COUNT="PLAYER_COUNT";
const string DATABASE_MODULE_TIME="CURRENT_TIME";
const string DATABASE_POPULATION="_DYNAMIC_FACTION";
const string DATABASE_POPULATION_POWER="DYNAMIC_FACTION_POWER";
const string DATABASE_POPULATION_LAST_UPDATE="DYNAMIC_FACTION_LAST_UPDATE";
const string DATABASE_POPULATION_CURRENT_SETUP="DYNAMIC_FACTION_POPULATION_SETUP";
const string DATABASE_VAMPIRE_COFFINS="VAMPIRE_COFFINS";
const string DATABASE_VAMPIRE_COFFIN_STATE="VampireCoffinState";
const int DATABASE_VAMPIRE_COFFIN_STATE_NOT_SET=0;
const int DATABASE_VAMPIRE_COFFIN_STATE_DESTROYED=1;
const int DATABASE_VAMPIRE_COFFIN_STATE_INTACT=2;

const string DATABASE_PC_ID="PlayerID";

const string DATABASE_PC_SKIN_TAG="rl_pcskin";


const string MODULE_PLAYER="PLAYER_";
const string MODULE_PLAYER_CORPSE="PLAYER_CORPSE_";

const string MODULE_DM_ACCOUNT="DM_ACCOUNT";

const string MODULE_PLAYER_DAMAGE_TAKEN="DAMAGE_TAKEN";


const string TEMP_STRING="TEMP_STRING";
const string TEMP_INT="TEMP_INT";
const string TEMP_OBJECT="TEMP_OBJECT";

const int SEASON_SPRING=1;
const int SEASON_SUMMER=2;
const int SEASON_FALL=3;
const int SEASON_WINTER=4;

const string SPAWN_PROBABILITY="Probability";
const string SPAWN_EXCLUDE_SPRING="ExcludeSpring";
const string SPAWN_EXCLUDE_SUMMER="ExcludeSummer";
const string SPAWN_EXCLUDE_FALL="ExcludeFall";
const string SPAWN_EXCLUDE_WINTER="ExcludeWinter";


const int DAWN_START_HOUR=6;
const int DAWN_END_HOUR=7;
const int DUSK_START_HOUR=18;
const int DUSK_END_HOUR=19;


//Custom Tokens:

const int CUSTOM_TOKEN_POPULATION_NAME=2000;
const int CUSTOM_TOKEN_POPULATION_CURRENT_POWER=2001;
const int CUSTOM_TOKEN_POPULATION_POWER_INCREASE_CONSTANT=2002;
const int CUSTOM_TOKEN_POPULATION_POWER_INCREASE_PERCENT=2003;

const int CUSTOM_TOKEN_FACTION_TOOL_TARGET_NAME=2100;
const int CUSTOM_TOKEN_FACTION_TOOL_TARGET_RANK=2101;
const int CUSTOM_TOKEN_FACTION_TOOL_TARGET_MARK=2102;
const int CUSTOM_TOKEN_FACTION_TOOL_FEEDBACK=2103;

const int CUSTOM_TOKEN_COUNCILLORS_TOOL_TARGET_NAME=2150;

const int CUSTOM_TOKEN_DM_TOOL_MONSTROUS_SETUP_TARGET_NAME=2600;

const int CUSTOM_TOKEN_CRAFTING_CXP_SMELTING=2700;
const int CUSTOM_TOKEN_CRAFTING_CXP_SMITHING_BASIC=2701;
const int CUSTOM_TOKEN_CRAFTING_CXP_HIDE_CURING=2702;
const int CUSTOM_TOKEN_CRAFTING_CXP_LEATHER_BOILING=2703;
const int CUSTOM_TOKEN_CRAFTING_CXP_LEATHERWORKING=2704;
const int CUSTOM_TOKEN_CRAFTING_CXP_CARPENTRY=2705;
const int CUSTOM_TOKEN_CRAFTING_CXP_WOODWORKING=2706;
const int CUSTOM_TOKEN_CRAFTING_CXP_SMITHING_GILDING=2710;

const int CUSTOM_TOKEN_CRAFTING_LEVEL_SMELTING=2750;
const int CUSTOM_TOKEN_CRAFTING_LEVEL_SMITHING_BASIC=2751;
const int CUSTOM_TOKEN_CRAFTING_LEVEL_HIDE_CURING=2752;
const int CUSTOM_TOKEN_CRAFTING_LEVEL_LEATHER_BOILING=2753;
const int CUSTOM_TOKEN_CRAFTING_LEVEL_LEATHERWORKING=2754;
const int CUSTOM_TOKEN_CRAFTING_LEVEL_CARPENTRY=2755;
const int CUSTOM_TOKEN_CRAFTING_LEVEL_WOODWORKING=2756;
const int CUSTOM_TOKEN_CRAFTING_LEVEL_SMITHING_GILDING=2760;

const int CUSTOM_TOKEN_DM_TOOL_CORRUPTION_SETUP_TARGET_NAME=3000;
const int CUSTOM_TOKEN_DM_TOOL_CORRUPTION_SETUP_TARGET_STAGE=3001;
const int CUSTOM_TOKEN_DM_TOOL_CORRUPTION_SETUP_TARGET_GIFT_1=3002;
const int CUSTOM_TOKEN_DM_TOOL_CORRUPTION_SETUP_TARGET_GIFT_2=3003;
const int CUSTOM_TOKEN_DM_TOOL_CORRUPTION_SETUP_TARGET_CURSE_1=3004;
const int CUSTOM_TOKEN_DM_TOOL_CORRUPTION_SETUP_TARGET_CURSE_2=3005;

const int CUSTOM_TOKEN_WEATHER=3100;

//Death system constants:

const string DATABASE_PC_DEATH_STATE="DEATH_STATE";
const string DATABASE_PC_DEATH_LOCATION_X="DEATH_STORED_LOCATION_X";
const string DATABASE_PC_DEATH_LOCATION_Y="DEATH_STORED_LOCATION_Y";
const string DATABASE_PC_DEATH_LOCATION_Z="DEATH_STORED_LOCATION_Z";
const string DATABASE_PC_DEATH_LOCATION_AREA_TAG="DEATH_STORED_LOCATION_AREA_TAG";
const string DATABASE_PC_DEATH_LOCATION_FACING="DEATH_STORED_LOCATION_FACING";
const string DATABASE_PC_DEATH_LOCATION_SERVER="DEATH_STORED_LOCATION_SERVER";
const string DATABASE_PC_DEATH_LOCATION_AREA_NAME="DEATH_STORED_LOCATION_AREA_NAME";
const string DATABASE_PC_DEATH_TIME="DEATH_TIME";
const string DATABASE_PC_DEATH_IRREVOCABLE_WOUND="DEATH_IRREVOCABLE_WOUND";
const string DATABASE_PC_DEATH_BURNED_CORPSE="DEATH_BURNED_CORPSE";
const string DATABASE_PC_DEATH_RAISED="DEATH_RAISED";
const string DATABASE_PC_DEATH_RESURRECTED="DEATH_RESURRECTED";
const string DATABASE_PC_DEATH_REPERCUSSION="DEATH_REPERCUSSION";

const float DATABASE_PC_DEATH_RETURN_COST_BASE_CONSTANT=10.0;
const float DATABASE_PC_DEATH_RETURN_COST_BUFFER_RATIO=0.1;

const string DATABASE_PC_PERSISTENT_VFX="PERSISTENT_VFX";
const string DATABASE_PC_PERSISTENT_VFX2="PERSISTENT_VFX2";
const string DATABASE_PC_PERSISTENT_VFX3="PERSISTENT_VFX3";

const string CORPSE_PLAYER_ID="PLAYER_ID";
const string CORPSE_PLAYER_NAME="PLAYER_NAME";

const string NPC_HEALER_TAG="NPC_HEALER";
const int NPC_HEALER_RAISE_COST=100;
const int NPC_HEALER_RESURRECTION_COST=500;


const int nBleeding = 1;
const int nStable = 2;
const int nDead = 3;
const int nSpirit = 4;
const int nWell = 0;
//const string sState = "dying_state";

const float fRound = 6.0f;
const string sStable = "Your wounds stopped bleeding";
const string sBleeding = "You are bleeding to death.";
const string sDead = "Your surroundings have changed. You can see very little through the thick, swirling mists. Somewhere in the distance, you spot a faint shaft of light.";
const string sWell = "You're okay";

const int nNumberOfDeadWPLow = 3;
const int nNumberOfDeadWPMid = 3;
const int nNumberOfDeadWPHigh = 6;
const int nNumberOfNELevels=1;

const string sDeadWP = "NE_PORTAL_";
const string sRespawnWP = "WP_SPAWNPOINT_";

const string sCorpseTag = "item_corpse";
const string sCorpseBluePrint = "corpse";
const string sCorpseBluePrintFemale="corpse_f";
const string sCorpseBluePrintRemains="corpse_r";
//const string sDeadPlayer = "deadPlayer";
const float fTeleportDelay = 6.0;

const string PC_VAMPIRE_DEAD="VampireDead";

const string PC_VAMPIRE_COFFIN="VampireCoffin";
const string PC_VAMPIRE_COFFIN_STATE="VampireCoffinState";
const int PC_VAMPIRE_COFFIN_STATE_NOT_SET=0;
const int PC_VAMPIRE_COFFIN_STATE_DESTROYED=1;
const int PC_VAMPIRE_COFFIN_STATE_INTACT=2;
const string PC_VAMPIRE_COFFIN_OWNER_ID="OwnerID";
const string PC_VAMPIRE_COFFIN_BLUEPRINT="rl_pcvampire_coffin";

//XP System constants:

const float XP_SYSTEM_RANGE=30.0;
const float XP_SYSTEM_MODIFIER=10.0;
const int XP_SYSTEM_PARTYSIZE_MIN=5;
const int XP_SYSTEM_MAX_BUFFER_SIZE=10000;
const int XP_SYSTEM_MIN_BUFFER_SIZE=0;
const int XP_SYSTEM_MAX_HOURLY_GAIN=3;
const float XP_SYSTEM_MAX_CR_DIFFERENCE=4.0;
const float XP_SYSTEM_EXPONENTIAL_MODIFIER=2.0;
const float XP_SYSTEM_CR_MODIFIER=2.0;



const string DATABASE_PC_XP_BUFFER_UPDATE_TIME="XP_BUFFER_UPDATE_TIME";
const string DATABASE_PC_XP_BUFFER="XP_BUFFER";
const string DATABASE_PC_XP_BANK="XP_BANK";
const string DATABASE_PC_XP="CURRENT_XP";
const string DATABASE_PC_RPXP="CURRENT_RPXP";
const string DATABASE_PC_LEVEL="XP_LEVEL";


//Resting and tradeskill System constants:

const string DATABASE_PC_WOUNDS_BANDAGED="WOUNDS_BANDAGED";
const string DATABASE_PC_MEAL_TIME="MEAL_TIME";

const string PLAYER_DAMAGE_TAKEN="DamageTaken";
const string DATABASE_PC_REST_TIME_1="REST_TIME_1";
const string DATABASE_PC_REST_TIME_2="REST_TIME_2";
const string DATABASE_PC_REST_TIME_3="REST_TIME_3";
const string DATABASE_PC_AMOUNT_OF_RATIONS="RATIONS";
const string CAMP_CAMPFIRE_TAG="FIRE";
const string CAMP_CAMPFIRE_FIRE="FIRE";


const string FLAMES_AMOUNT="Flames_Amount";

//Population System constants:

const string POPULATION="DynamicFaction";
const string POPULATION_SPAWNPOINT_TAG="DynamicFactionSpawn";
const string POPULATION_COUNT="COUNT";
const string POPULATION_LEADER="LEADER";
const string sLimbo="LIMBO";

const string POPULATION_SETUP="PopulationSetup";
const string POPULATION_SETUP_CURRENT="PopulationSetupCurrent";
const string POPULATION_SETUP_COUNT="PopulationSetupCount";


const string POPULATION_SETUP_BASH_DC_MODIFIER="BashDCModifier";
const string POPULATION_SETUP_LOCK_DC_MODIFIER="LockDCModifier";
const string POPULATION_SETUP_TREASURE_SIZE_MODIFIER="TreasureSizeModifier";
const string POPULATION_SETUP_BASE_TRAP_TYPE="BaseTrapType";
const string POPULATION_SETUP_IS_PRIMITIVE="Primitive";

const string POPULATION_SETUP_STANDARD_PLACEABLE="StandardPlaceable";
const string POPULATION_SETUP_STANDARD_DESCRIPTION="StandardDescription";
const string POPULATION_SETUP_STANDARD_TREASURY="StandardTreasury";



const string POPULATION_SETUP_AREA_FOG_RED="AreaFogRed";
const string POPULATION_SETUP_AREA_FOG_GREEN="AreaFogGreen";
const string POPULATION_SETUP_AREA_FOG_BLUE="AreaFogBlue";
const string POPULATION_SETUP_AREA_FOG_AMOUNT="AreaFogAmount";
const string POPULATION_SETUP_AREA_AMBIENT_SOUND="AreaAmbientSound";
const string POPULATION_SETUP_AREA_BACKGROUND_MUSIC="AreaBackgroundMusic";
const string POPULATION_SETUP_AREA_COMBAT_MUSIC="AreaCombatMusic";




const string POPULATION_TEMPLATE_WAYPOINT_PREFIX="dfw_";
const string POPULATION_TEMPLATE_WAYPOINT_SPAWN="Template";
const string POPULATION_TEMPLATE_WAYPOINT_USER_COUNT="UserCount";



const string AREA_SINK_HOLE_LEVEL="SinkHoleLevel";
const string AREA_NO_REST="NoRest";
const string AREA_MAIN_POPULATION="MainPopulation";



const string SPAWN_SPAWNPOINT="SpawnPoint";

//Cross server system constants:

const string SERVER_ID="SERVER_ID";

const int SERVER_MAIN_LOGIN=0;
const int SERVER_BAROVIA_WEST=1;
const int SERVER_BAROVIA_EAST=2;

const string SERVER_LOGIN_IP="localhost:5121";
const string SERVER_BAROVIA_WEST_IP="localhost:5122";
const string SERVER_BAROVIA_EAST_IP="localhost:5123";

const string SERVER_PASS="zarovich";

const string SERVER_LOGIN_LAST_STORED="LOGIN_LAST";
const string SERVER_LOGIN_LAST_SAFE="LOGIN_LAST_SAFE";
const string SERVER_LOGIN_FACTION_BASE="LOGIN_FACTION_BASE";


//PC database constants

const string DATABASE_PC_LOCATION_X="STORED_LOCATION_X";
const string DATABASE_PC_LOCATION_Y="STORED_LOCATION_Y";
const string DATABASE_PC_LOCATION_Z="STORED_LOCATION_Z";
const string DATABASE_PC_LOCATION_FACING="STORED_LOCATION_FACING";
const string DATABASE_PC_LOCATION_AREA_TAG="STORED_LOCATION_AREA_TAG";
const string DATABASE_PC_LOCATION_SERVER="STORED_LOCATION_SERVER";
const string DATABASE_PC_LOCATION_AREA_NAME="STORED_LOCATION_AREA_NAME";

const string DATABASE_PC_LOCATION_JAILED="JAILED";


const string DATABASE_PC_MIST_LOCATION_X="MIST_STORED_LOCATION_X";
const string DATABASE_PC_MIST_LOCATION_Y="MIST_STORED_LOCATION_Y";
const string DATABASE_PC_MIST_LOCATION_Z="MIST_STORED_LOCATION_Z";
const string DATABASE_PC_MIST_LOCATION_AREA_TAG="MIST_STORED_LOCATION_AREA_TAG";
const string DATABASE_PC_MIST_LOCATION_FACING="MIST_STORED_LOCATION_FACING";
const string DATABASE_PC_MIST_LOCATION_SERVER="MIST_STORED_LOCATION_SERVER";
const string DATABASE_PC_MIST_LOCATION_AREA_NAME="MIST_STORED_LOCATION_AREA_NAME";

const string DATABASE_PC_SAFE_LOCATION_X="SAFE_STORED_LOCATION_X";
const string DATABASE_PC_SAFE_LOCATION_Y="SAFE_STORED_LOCATION_Y";
const string DATABASE_PC_SAFE_LOCATION_Z="SAFE_STORED_LOCATION_Z";
const string DATABASE_PC_SAFE_LOCATION_AREA_TAG="SAFE_STORED_LOCATION_AREA_TAG";
const string DATABASE_PC_SAFE_LOCATION_FACING="SAFE_STORED_LOCATION_FACING";
const string DATABASE_PC_SAFE_LOCATION_SERVER="SAFE_STORED_LOCATION_SERVER";
const string DATABASE_PC_SAFE_LOCATION_AREA_NAME="SAFE_STORED_LOCATION_AREA_NAME";


const string DATABASE_PC_FACTION="FACTION";
const string DATABASE_PC_SHOWN_FACTION="SHOWN_FACTION";
const string DATABASE_PC_INNATE_FACTION="INNATE_FACTION";
const string DATABASE_PC_FACTION_RANK="FACTION_RANK";
const string FACTION_RANK="FactionRank";
const string DATABASE_PC_FACTION_MARKED_AS_ENEMY="FACTION_ENEMY";
const string DATABASE_PC_FACTION_MARKED_AS_FRIEND="FACTION_FRIEND";


const string DATABASE_PC_CORRUPTION_STAGE="CORRUPTION_STAGE";

const string DATABASE_PC_CORRUPTION_GIFT_1 = "CORRUPTION_GIFT_1";
const string DATABASE_PC_CORRUPTION_GIFT_2 = "CORRUPTION_GIFT_2";
const string DATABASE_PC_CORRUPTION_CURSE_1 = "CORRUPTION_CURSE_1";
const string DATABASE_PC_CORRUPTION_CURSE_2 = "CORRUPTION_CURSE_2";

const int CORRUPTION_GIFT_OF_AGILITY=1;
const int CORRUPTION_GIFT_OF_THE_BEAST=2;
const int CORRUPTION_GIFT_OF_THE_MIND=3;
const int CORRUPTION_GIFT_OF_THE_UNNATURAL=4;
const int CORRUPTION_GIFT_OF_THE_MANIPULATOR=5;
const int CORRUPTION_GIFT_OF_THE_SEER=6;
const int CORRUPTION_GIFT_OF_THE_MIST=7;
const int CORRUPTION_GIFT_OF_DARKNESS=8;

const int CORRUPTION_CURSE_OF_ANXIETY=1;
const int CORRUPTION_CURSE_OF_MISFORTUNE=2;
const int CORRUPTION_CURSE_OF_DELUSION=3;
const int CORRUPTION_CURSE_OF_ENFEEBLEMENT=4;
const int CORRUPTION_CURSE_OF_MALADROIT=5;
const int CORRUPTION_CURSE_OF_DECREPITUDE=6;
const int CORRUPTION_CURSE_OF_OBLIVIOUSNESS=7;
const int CORRUPTION_CURSE_OF_REPUGNANCE=8;


const string DATABASE_PC_PLAYER_DESCRIPTION = "PLAYER_DESCRIPTION";
const string DATABASE_PC_DM_DESCRIPTION = "DM_DESCRIPTION";

const string DATABASE_PC_ECL_ADJUSTMENT = "ECL_ADJUSTMENT";

const string DATABASE_PC_TURN_RESISTANCE = "TURN_RESISTANCE";

const string DATABASE_PC_BACKGROUND_FEATS = "BACKGROUND_FEATS";

const string DATABASE_PC_BASE_RACIAL_TYPE="BaseRacialType";
const string DATABASE_PC_SUBRACE= "SUBRACE";
const string DATABASE_PC_MONSTROUS_RACE= "MONSTROUS_RACE";

const string DATABASE_PC_SUBRACE_APPROVED= "APPROVED_SUBRACE";



const int DATABASE_PC_SUBRACE_DEFAULT= -1;
const int DATABASE_PC_SUBRACE_SUN_ELF= 1;
const int DATABASE_PC_SUBRACE_WILD_ELF= 2;
const int DATABASE_PC_SUBRACE_WOOD_ELF= 3;
const int DATABASE_PC_SUBRACE_DROW= 4;

const int DATABASE_PC_SUBRACE_GOLD_DWARF= 5;
const int DATABASE_PC_SUBRACE_DUERGAR = 6;

const int DATABASE_PC_SUBRACE_AASIMAR = 7;
const int DATABASE_PC_SUBRACE_TIEFLING = 8;

const int DATABASE_PC_SUBRACE_CALIBAN = 9;

const int DATABASE_PC_SUBRACE_CANJAR= 10;
const int DATABASE_PC_SUBRACE_CORVARA= 11;
const int DATABASE_PC_SUBRACE_EQUAAR= 12;
const int DATABASE_PC_SUBRACE_KAMII= 13;
const int DATABASE_PC_SUBRACE_NAIAT= 14;
const int DATABASE_PC_SUBRACE_VATRASKA= 15;
const int DATABASE_PC_SUBRACE_ZAROVAN = 16;
const int DATABASE_PC_SUBRACE_HALF_DROW = 17;
const int DATABASE_PC_SUBRACE_SIDHELIEN = 18;
const int DATABASE_PC_SUBRACE_KAGONESTI = 19;
const int DATABASE_PC_SUBRACE_QUALINESTI = 20;
const int DATABASE_PC_SUBRACE_SILVANESTI = 21;
const int DATABASE_PC_SUBRACE_AERENAL_ELF = 22;
const int DATABASE_PC_SUBRACE_VALENAR_ELF = 23;
const int DATABASE_PC_SUBRACE_GREY_ELF = 24;
const int DATABASE_PC_SUBRACE_GRUGACH = 25;
const int DATABASE_PC_SUBRACE_SYLVAN_ELF = 26;
const int DATABASE_PC_SUBRACE_BELCADIZ_ELF = 27;
const int DATABASE_PC_SUBRACE_SHADOW_ELF = 28;
const int DATABASE_PC_SUBRACE_SHIYE_ELF = 29;
const int DATABASE_PC_SUBRACE_ANUIERAN_HUMAN = 30;
const int DATABASE_PC_SUBRACE_BRECHT_HUMAN = 31;
const int DATABASE_PC_SUBRACE_KHINASI_HUMAN = 32;
const int DATABASE_PC_SUBRACE_RJURIK_HUMAN = 33;
const int DATABASE_PC_SUBRACE_VOS_HUMAN = 34;
const int DATABASE_PC_SUBRACE_KALASHTAR = 35;
const int DATABASE_PC_SUBRACE_HALF_SIDHELIEN = 36;
const int DATABASE_PC_SUBRACE_ATHASIAN_HALF_ELF = 37;
const int DATABASE_PC_SUBRACE_CERILIAN_HALFLING = 38;
const int DATABASE_PC_SUBRACE_ATHASIAN_HALFLING = 39;
const int DATABASE_PC_SUBRACE_KENDER = 40;
const int DATABASE_PC_SUBRACE_TALENTA_HALFLING = 41;
const int DATABASE_PC_SUBRACE_TALLFELLOW_HALFLING = 42;
const int DATABASE_PC_SUBRACE_DEEP_HALFLING = 43;
const int DATABASE_PC_SUBRACE_TINKER_GNOME = 44;
const int DATABASE_PC_SUBRACE_MAD_GNOME = 45;
const int DATABASE_PC_SUBRACE_DEEP_GNOME = 46;
const int DATABASE_PC_SUBRACE_FOREST_GNOME = 47;
const int DATABASE_PC_SUBRACE_KARAMHUL = 48;
const int DATABASE_PC_SUBRACE_HALF_DWARF = 49;
const int DATABASE_PC_SUBRACE_DARK_DWARF = 50;
const int DATABASE_PC_SUBRACE_DERRO = 51;
const int DATABASE_PC_SUBRACE_MOULDER_DWARF = 52;
const int DATABASE_PC_SUBRACE_KOGOLOR_DWARF = 53;
const int DATABASE_PC_SUBRACE_DEEP_DWARF = 54;
const int DATABASE_PC_SUBRACE_ARCTIC_DWARF = 55;
const int DATABASE_PC_SUBRACE_WILD_DWARF = 56;
const int DATABASE_PC_SUBRACE_ZENYTHRI = 57;
const int DATABASE_PC_SUBRACE_TULADHARA = 58;
const int DATABASE_PC_SUBRACE_TANARUKK = 59;
const int DATABASE_PC_SUBRACE_ELF_FEYRI = 60;
const int DATABASE_PC_SUBRACE_HUMAN_APERUSA = 61;
const int DATABASE_PC_SUBRACE_KOROBOKURU = 62;
const int DATABASE_PC_SUBRACE_STAR_ELF = 63;
const int DATABASE_PC_SUBRACE_POLAR_HALFLING = 64;
const int DATABASE_PC_SUBRACE_DESERT_DWARF = 65;
const int DATABASE_PC_SUBRACE_MAZTICAN_HALFLING = 66;
const int DATABASE_PC_SUBRACE_CHAOS_GNOME = 67;
const int DATABASE_PC_SUBRACE_WHISPER_GNOME = 68;
const int DATABASE_PC_SUBRACE_DREAM_DWARF = 69;
const int DATABASE_PC_SUBRACE_GLACIER_DWARF = 70;
const int DATABASE_PC_SUBRACE_RHUI_THAUN = 71;
const int DATABASE_PC_SUBRACE_ATHASIAN_ELF = 72;
const int DATABASE_PC_SUBRACE_HALFORC_SCRO = 73;
const int DATABASE_PC_SUBRACE_ABBER_NOMAD = 74;
const int DATABASE_PC_SUBRACE_XEPH = 75;
const int DATABASE_PC_SUBRACE_LENARA = 76;

const string DATABASE_PC_UNDEAD="UNDEAD";

const int DATABASE_PC_MONSTROUS_RACE_VAMPIRE_SPAWN = 1;
const int DATABASE_PC_MONSTROUS_RACE_WEREWOLF = 2;
const int DATABASE_PC_MONSTROUS_RACE_WIGHT = 3;
const int DATABASE_PC_MONSTROUS_RACE_WERERAT = 4;
const int DATABASE_PC_MONSTROUS_RACE_GHOUL = 5;
const int DATABASE_PC_MONSTROUS_RACE_WERERAVEN = 6;
const int DATABASE_PC_MONSTROUS_RACE_MUMMY = 7;

const string DATABASE_PC_VAMPIRE_COFFIN_VALID="VampireCoffinValid";
const string DATABASE_PC_VAMPIRE_COFFIN_LOCATION_AREA="VampireCoffinLocationArea";
const string DATABASE_PC_VAMPIRE_COFFIN_LOCATION_X="VampireCoffinLocationX";
const string DATABASE_PC_VAMPIRE_COFFIN_LOCATION_Y="VampireCoffinLocationY";
const string DATABASE_PC_VAMPIRE_COFFIN_LOCATION_Z="VampireCoffinLocationZ";
const string DATABASE_PC_VAMPIRE_COFFIN_LOCATION_FACING="VampireCoffingLocationFacing";



const string DATABASE_PC_CLASS_PERMISSION="CLASS_PERMISSION";

const string DATABASE_PC_ORIGIN="ORIGIN";

const int DATABASE_PC_ORIGIN_BAROVIAN=1;
const int DATABASE_PC_ORIGIN_GUNDARAKITE=2;
const int DATABASE_PC_ORIGIN_RAVENLOFT_NATIVE=3;
const int DATABASE_PC_ORIGIN_OUTLANDER=4;
const int DATABASE_PC_ORIGIN_ATHASIAN=5;
const int DATABASE_PC_ORIGIN_CERILIAN=6;
const int DATABASE_PC_ORIGIN_EBERRONIAN=7;
const int DATABASE_PC_ORIGIN_TORILIAN=8;
const int DATABASE_PC_ORIGIN_MYSTARAN=9;
const int DATABASE_PC_ORIGIN_OERTHIAN=10;
const int DATABASE_PC_ORIGIN_PLANAR=11;
const int DATABASE_PC_ORIGIN_SPACEBORNE=12;
const int DATABASE_PC_ORIGIN_GOTHICEARTH=13;
const int DATABASE_PC_ORIGIN_KRYNNIAN=14;
const int DATABASE_PC_ORIGIN_UNOFFICIAL=15;


const string PLACEABLE_TRAPPED="Trapped";
const string PLACEABLE_TRAP_TYPE="TrapType";
const string PLACEABLE_TRAP_STRENGTH="TrapStrength";
const string PLACEABLE_LOCK_DC="LockDC";
const string PLACEABLE_BASH_DC="BashDC";

const string PLACEABLE_TARGET="Target";

const string PLACEABLE_CHECK_SKILL="CheckSkill";
const string PLACEABLE_CHECK_ABILITY="CheckAbility";
const string PLACEABLE_CHECK_DC="CheckDC";
const string PLACEABLE_CHECK_SUCCESS_SCRIPT="CheckSuccessScript";
const string PLACEABLE_CHECK_FAIL_SCRIPT="CheckFailScript";
const string PLACEABLE_CHECK_SUCCESS_MESSAGE="CheckSuccessMessage";
const string PLACEABLE_CHECK_FAIL_MESSAGE="CheckFailMessage";

const int SKILL_INFLUENCE=12;
const int SKILL_ANTAGONIZE=18;


const string AI_TYPE="AI_TYPE";
const string AI_HEADING="HEADING";
const string AI_ALERT_STATE="AlertState";
const string AI_ALWAYS_ALERT="AlwaysAlert";
const string AI_ANIMATION="Animation";
const string AI_BEHAVIOR="Behavior";


const int AI_TYPE_DEFAULT = 0;
const int AI_TYPE_NPC = 1;
const int AI_TYPE_SPAWN = 2;
const int AI_TYPE_SPAWN_TEMPLATE = 3;

const int AI_ANIMATION_NONE= 0 ;
const int AI_ANIMATION_AMBIENT_STATIC= 1;
const int AI_ANIMATION_AMBIENT_MOBILE= 2;
const int AI_ANIMATION_WALK_WAYPOINTS = 3;
const int AI_ANIMATION_SIT=4;

const int AI_BEHAVIOR_NORMAL= 0;
const int AI_BEHAVIOR_HERBIVORE = 1;
const int AI_BEHAVIOR_OMNIVORE = 2;
const int AI_BEHAVIOR_COMMONER = 3;
const int AI_BEHAVIOR_GUARD = 4;

const string AI_SPECIAL_AVIAN = "Avian";
const string AI_SPECIAL_INCORPOREAL = "Incorporeal";
const string AI_SPECIAL_SHAPECHANGE = "Shapechange";
const string AI_SPECIAL_SHAPECHANGE_NAME= "ShapechangeName";

const string AI_SPECIAL_VFX = "ConstantVFX";
const string AI_SPECIAL_VFX2 = "ConstantVFX2";
const string AI_SPECIAL_VFX3 = "ConstantVFX3";
const string AI_SPECIAL_CONVERSATION = "Conversation";
