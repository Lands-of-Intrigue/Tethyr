//::///////////////////////////////////////////////
//:: rest_include
//:://////////////////////////////////////////////
/*
    MAGUS REST SYSTEM - INCLUDE
    DO NOT EDIT UNCONFIGURABLE PARTS OF THIS FILE


    SPECIALLY MARKED CONSTANTS, FUNCTIONS AND INCLUDES MAY BE ADJUSTED BY USER

    EXPLANATION
    Rest restrictions are assumed to be on module wide
    (unless module int REST_UNRESTRICTED = 1 )
    Rest in an area can be restricted or unrestricted
        : area int REST_RESTRICTED = 1
            - set rest restrictions in a specific area, when rest is unrestricted module wide
        : area int REST_UNRESTRICTED = 1
            - remove rest restrictions in a specific area, when rest is restricted module wide

    Rest Restriction rules
    Can be completely rewritten. See ResterRequirements()

    Example Rules included in this config file are as follows:
        : can only rest once every 8 game hours
        : comfortable rest (regain ALL hitpoints and spells) has the following requirements:
            - warmth:   resistance versus cold required in cold conditions (eg. outdoors at night)
            - food:     must have eaten recently, or have food to consume while resting
            - bedroll:  required when sleeping in the wild unless the character is accustomed to it

*/
//:://////////////////////////////////////////////
//:: Creator   : The Magus (2013 july 13)
//:: Modified  : henesua (2014 june 1) pulled all includes into one to make this lean
//:://////////////////////////////////////////////

// INCLUDES --------------------------------------------------------------------

// used for configurable functions
// the following includes may contain functions or constants which you have defined elsewhere
// if that is the case feel free to use your own includes and delete these provided
#include "x3_inc_skin"
#include "food_include"
//#include "nwnx_funcs_inc"

// includes for add on systems. add or remove these as needed
// Magus' Camp System - campfires and campsites (also includes Magus' Food System)
//#include "camp_include"


// CONSTANTS -------------------------------------------------------------------

// ========= CONFIGURABLE ===============

// REST REQUIREMENTS - MAX NUMBER OF TESTS
// number of tests to perform when resting. see ResterRequirements(int nTest)
// rest rules are tested in order from 1 to the value of LAST_REST_TEST
const int LAST_REST_TEST            = 4;

// SPELL LIMITS
// the flag REST_LIMIT_SPELLS when applied in ResterRequirements() triggers the limit of spells recovered by the pc
// you can apply limits to the level of spells that a PC recovers during rest by reducing their ability scores
// turn off particular spell limits permanently by adjusting one or more of the following values to 0
const int REST_SPELL_LIMIT_INT      = 0;
const int REST_SPELL_LIMIT_WIS      = 0;
const int REST_SPELL_LIMIT_CHA      = 0;
// also see REST_NO_SPELL_LIMIT_ in rest_globals as a means to temporarily turn off spell limits for a PC
// SPELL ABILITY DAMAGE MINIMUMS and MAXIMUMS
const int REST_MAX_DAMAGE_INT       = 10;
const int REST_MIN_DAMAGE_INT       = 1;
const int REST_MAX_DAMAGE_WIS       = 10;
const int REST_MIN_DAMAGE_WIS       = 1;
const int REST_MAX_DAMAGE_CHA       = 10;
const int REST_MIN_DAMAGE_CHA       = 1;

// REST PREPARATORY ACTIONS/SCRIPTS
// add or change or remove these as you see fit
// see ResterPrepares ()
// each codeblock in ResterPrepares() is an action specified by index

// these first two are for MAGUS CAMP SYSTEM
const int REST_ACTION_MAKE_CAMPFIRE = 1;
const int REST_ACTION_LIGHT_CAMPFIRE= 2;


// TIME
// adjust to your module's time settings
// 30 assumes the typical module setting of 2 minutes per game hour
const int IGMINUTES_PER_RLMINUTE    = 225;


// USER ADDED VALUES (OR EXAMPLES OF SUCH)

// Test 1 of RestRequirements() determines whether enough time has passed since the last rest by this PC
// See GetIsTimeToRest() this value is used in ResterFinishesRest() to establish when the PC can rest again
// 1+ = minutes required between rests OR  0 = no required time between rests
int GAME_MINUTES_BETWEEN_RESTS   = IGMINUTES_PER_RLMINUTE * 3; // the number is REAL MINUTES.
// local set on rester to track when they may next rest. Changing the value makes no difference as it is merely a label for a local variable.
const string NEXT_REST_TIME     = "REST_NEXT";

// Test 2 of RestRequirements() determines whether the resting PC is cold
// set area variable int "AREA_COLD" = 1 to specify that the area is cold (see GetIsCold() )
const string AREA_COLD          = "AREA_COLD";

// Test 3 of RestRequirements() determines whether the PC has had enough to eat - see GetIsHungry() in food_configure
// and if they are hungry, they need to eat a food item in inventory
// ----------- see food_include ----------

// Test 4 of RestRequirements() determines whether the PC is comfortable sleeping on the ground
// a bedroll may or may not be required depending on the PC - see GetNeedsBedToRestComfortably()
// Tag for bed roll item - an item with the bedroll tag can be used as a bed roll
const string TAG_BEDROLL        = "bedroll";    // see GetHasBed()



// ================= NOT CONFIGURABLE ==================

// COLORS
const string RED        = "<cþ  >";
const string PINK       = "<cÒdd>";
const string YELLOW     = "<cþ× >";

// RESTRICTING REST
// set these local integers on the module and areas to explicitly declare whether resting is restricted
// the assumption is that module wide resting is restricted
// to remove rest restriction only in a specific area set int REST_UNRESTRICTED = 1 on that area
// if you wish to set resting as unrestricted module wide set int REST_UNRESTRICTED = 1 on the module
// to ensure that an area has rest restriction rules set int REST_RESTRICTED = 1 on that area
const string REST_RESTRICTED        = "REST_RESTRICTED";
const string REST_UNRESTRICTED      = "REST_UNRESTRICTED";
// local used to store which rest restrictions are ignored here
const string REST_SHELTER           = "REST_SHELTER";
const int    REST_IGNORE_TIME       = 1;
const int    REST_IGNORE_WARMTH     = 2;
const int    REST_IGNORE_BED        = 4;
const int    REST_IGNORE_FOOD       = 8;

// local int that when set on the PC prevents temporary ability score damage while resting
const string REST_NO_SPELL_LIMIT_INT= "REST_NO_SPELL_LIMIT_INT";
const string REST_NO_SPELL_LIMIT_WIS= "REST_NO_SPELL_LIMIT_WIS";
const string REST_NO_SPELL_LIMIT_CHA= "REST_NO_SPELL_LIMIT_CHA";

// locals set on rester by the rest system
const string REST_TEST_RESULTS      = "REST_RESULTS";
const string CAUSE_OF_REST_FAILURE  = "REST_FAIL_ID";
const string DESCRIBE_REST          = "REST_FEEDBACK_STRING";
const string REST_FATIGUE           = "REST_FATIGUE";
const string REST_HP                = "REST_HITPOINTS";

const string REST_PREPARATION_COUNT = "PREPARATION_COUNT";
const string REST_PREPARATION_      = "PREPARATION_";
const string REST_CONSUME_COUNT     = "CONSUME_COUNT";
const string REST_CONSUME_          = "CONSUME_";

// REST SYSTEM FLAGS
// Flags which are set in response to test results (each is a bit which can be set or removed)
// each flag when found on the rester determines how the rester's rest proceeds
// see function TestRestRules in file aa_rest_config
const int REST_POSTPONE             = 1; // cancel the rest action (see RestStarted() in rest_include )
const int REST_PREPARE              = 2; // set up an action for rester to perform when rest is cancelled (you should also set the postpone flag) (see RestPreparation() in rest_include )
const int REST_CONSUME              = 4; // destroy the item (see RestConsumeItems() in rest_include )
const int REST_UNCOMFORTABLE        = 8; // signal fatigue (but you must script responses to fatigue) (see RestComfortable() in rest_include )
const int REST_LIMIT_HP             = 16;// limit HP restored  (see RestLimitHP() in rest_include )
const int REST_LIMIT_SPELLS         = 32;// limit spell levels restored (see RestLimitSpells() in rest_include )


// FUNCTION DECLARATIONS -------------------------------------------------------

// ========== CONFIGURABLE ===========
// these functions should not be deleted, and must keep their names, types, and arguments
// you may however alter the contents of these functions
// if only specific parts of a function are configurable those parts are marked with CONFIGURABLE

// configure your tests for resting here. returns a bit flag [FILE: rest_include]
// each rule will be tested in order from 1 until LAST_REST_TEST (see constants above) is reached.
int ResterRequirements(int nTest);
// Feedback string for failed rest to be given to character [FILE: rest_include]
string ResterFailureText(int nTestFailed);
// Caller Begins a Successful Rest. [FILE: rest_include]
// Customize rest beginning here
void ResterBeginsRest();
// Caller Fails to Rest Successfully. [FILE: rest_include]
// Customize rest cancellation here
void ResterFailsToRest();
// Caller Finishes Resting Successfully. [FILE: rest_include]
// Customize rest completion here
void ResterFinishesRest();
// configure how consumables affect the character (if at all). [FILE: rest_include]
// returns TRUE if the item needs to be destroyed
int ResterConsumes(object oConsume);
// configure rest preparation scripts here. [FILE: rest_include]
// each code block that is executed enters the action queue of the resting PC
void ResterPrepares(int nScript);
// wrapper function for Getting a persistent fatigue value [FILE: rest_include]
// returns a count of consecutive number of uncomfortable rests.
int ResterGetFatigue(object oRester=OBJECT_SELF);
// wrapper function for Setting a persistent fatigue value [FILE: rest_include]
// sets the count of consecutive uncomfortable rests.
void ResterSetFatigue(int nFatigue, object oRester=OBJECT_SELF);
// Configure max spell level recovered when resting. [FILE: rest_include]
// see RestLimitSpells() in rest_include
// the flag REST_LIMIT_SPELLS triggers execution of RestLimitSpells()
int ResterMaxSpellLevelRecovered();
// Configure the amount of damage to apply after a rest. [FILE: rest_include]
// this can be used to limit HP recovery while resting
// see RestLimitHP() in rest_include
// the flag REST_LIMIT_HP triggers execution of RestLimitHP()
int ResterDamageLimitsHPRecovery();

// ........ Individual Rest Tests (user configurable)

// Returns TRUE if enough time has passed since last rest [FILE: rest_include]
int GetIsTimeToRest(object oPC=OBJECT_SELF);
// Returns TRUE if oPC is cold (needs a fire to rest) [FILE: rest_include]
int GetIsCold(object oPC=OBJECT_SELF);
// Returns TRUE if oPC needs a bed to rest [FILE: rest_include]
int GetNeedsBedToRestComfortably(object oPC=OBJECT_SELF);

// ........ You may have already defined similar functions ........

// Returns TRUE if oPC has a bed to rest on [FILE: rest_include]
int GetHasBed(object oPC=OBJECT_SELF);

// ========== END CONFIGURABLE ============



// ========== NOT CONFIGURABLE ============

// REST SUB-EVENTS ............................

// Rest Event Begins. Executes on Resting PC [FILE: rest_include]
void RestStarted();
// Rest Event Is Cancelled. Executes on Resting PC [FILE: rest_include]
void RestCanceled();
// Rest Event Completes. Executes on Resting PC [FILE: rest_include]
void RestFinished();

// REST RULE HANDLING .........................

// returns TRUE if resting is unrestricted for oRester under current circumstances [FILE: rest_include]
int GetRestUnrestricted(object oRester=OBJECT_SELF);
// Tests rest requirements for caller and returns the results. [FILE: rest_include]
// result is an integer containing flags to be tested with bitwise operators
// see rest_globals under the REST TEST FLAGS heading for constants to use
int TestRestRequirements();

// REST RESULTS .................................

// Consume items required for resting. Executes on Resting PC [FILE: rest_include]
// this function should not be deleted nor have its name changed
void RestConsumeItems();
// Iterate through preparatory actions prior to resting. Executes on Resting PC [FILE: rest_include]
void RestPreparation();
// Track fatigue in number of consecutive uncomfortable rests. Executes on Resting PC [FILE: rest_include]
void RestComfortable(int bSuccess=TRUE);
// Limit spell levels memorized. Executes on Resting PC [FILE: rest_include]
void RestLimitSpells();
// Limit HP recovered by percentage. Executes on Resting PC [FILE: rest_include]
void RestLimitHP();

// REST SYSTEM UTILITIES .........................

// Provide feedback to explain rest results. Executes on Resting PC [FILE: rest_include]
void RestFeedback(int nRestSuccess=TRUE);
// Clean up locals set on rester. Executes on Resting PC [FILE: rest_include]
void RestGarbageCollection();
// Rester adds item to array of items to consume while resting [FILE: rest_include]
// see ResterConsumes
void ResterAddConsumable(object oConsumable);

// Put a preparatory script in rester's action queue. [FILE: rest_include]
// the preparatory action script is executed from a code block see ResterPrepares
void ResterAddPreparatoryAction(int nPrepScript);

// Time utility. [FILE: rest_include]
int GetCumulativeMinutes();

// FUNCTION IMPLEMENTATIONS ----------------------------------------------------

// ============== CONFIGURABLE =======================================

int ResterRequirements(int nTest)
{
    int nResult;

    // CONFIGURABLE
    // you may change code within a code block
    // and you may add or remove code blocks
    // LAST_REST_TEST is the index of the last code block to execute (see constants above)

    // This function defines the rest requirements for a player with active rest restrictions
    // each code block is a requirement (aka test) for resting
    // the results of success or failure are up to you
    // but are limited to REST SYSTEM FLAGS unless you create your own bitwise flags,
    // and implement a function that runs when the flag is tripped.
    // these custom rest results should be executed on rest completion (see ResterFailsToRest() and ResterFinishesRest() )

    // "nTest" identifies which code block to execute
    // this function is called recursively by TestRestRequirements() in the file rest_include
    // which means that the code blocks are executed in order until LAST_REST_TEST is reached (see constants above)
    // the first test which results in REST_POSTPONE will also end recursion in TestRestRequirements() (meaning that that code block will be the last executed)
    // in this way tests with a lower index have a higher priority
    // see REST SYSTEM FLAGS in rest_globals for a list of possible results

    int nShelter = GetLocalInt(OBJECT_SELF,REST_SHELTER);

    // require HOURS_BETWEEN_RESTS
    if( nTest==1 && !(nShelter&REST_IGNORE_TIME) )
    {
        if(!GetIsTimeToRest())
        {
            nResult |= REST_POSTPONE; // current rest action will be cancelled
            SetLocalInt(OBJECT_SELF, CAUSE_OF_REST_FAILURE, nTest);// setup explanation for why the PC can not rest
        }
    }
    // require WARMTH if the PC is COLD
    else if(nTest==2 && !(nShelter&REST_IGNORE_WARMTH) )
    {
        if(GetIsCold())
        {
            /*
            // THE MAGUS' CAMP SYSTEM
            // Search for firewood in inventory, and store results on PC for use later
            object oFirewood   = GetFirewoodInInventory();
            SetLocalObject(OBJECT_SELF, CAMP_FIREWOOD, oFirewood);
            // determine if a nearby campsite is unlit
            if(GetIsNearCamp()==1)
            {
                nResult |= REST_POSTPONE; // current rest action will be cancelled
                SetLocalInt(OBJECT_SELF, CAUSE_OF_REST_FAILURE, nTest);// setup explanation for why a campfire has to be light

                nResult |= REST_PREPARE; // pc will conduct an action (to prepare for rest)
                ResterAddPreparatoryAction(REST_ACTION_LIGHT_CAMPFIRE); // give PC the "light campfire" action
            }
            // determine whether PC is able to make a campfire
            else if(oFirewood!=OBJECT_INVALID && GetCanCreatureMakeCampfire())
            {
                nResult |= REST_POSTPONE; // current rest action will be cancelled
                SetLocalInt(OBJECT_SELF, CAUSE_OF_REST_FAILURE, nTest);// setup explanation for why a campfire has to be built

                nResult |= REST_PREPARE; // pc will conduct an action (to prepare for rest)
                ResterAddPreparatoryAction(REST_ACTION_MAKE_CAMPFIRE); // give PC the "make campfire" action
            }
            else
            */
            {
                string sResponse    = GetLocalString(OBJECT_SELF,DESCRIBE_REST);
                if(sResponse=="")
                    sResponse   = RED+"You rest uncomfortably.";
                SetLocalString(OBJECT_SELF,DESCRIBE_REST, sResponse+" "+PINK+"It is cold." );

                // rest will proceed but be uncomfortable
                nResult |= REST_UNCOMFORTABLE;  // uncomfortable rest (fatigue)
                nResult |= REST_LIMIT_HP;       // limit hp recovered
                nResult |= REST_LIMIT_SPELLS;   // limit spells recovered
            }
        }
    }
    // require FOOD
    else if(nTest==3 && !(nShelter&REST_IGNORE_FOOD) )
    {
        /* MAGUS FOOD SYSTEM
        // this is more robust way to do food
        // otherwise ignore
        if(GetIsHungry())
        {
            object oFood    = GetFoodInInventory();
            if(oFood!=OBJECT_INVALID)
            {
                ResterAddConsumable(oFood);   // add oFood to the list of items to consume when resting
                nResult |= REST_CONSUME;    // consume items required for rest
            }
        }
        */
        object oFood    = GetItemPossessedBy(OBJECT_SELF,"food");
        if(GetIsObjectValid(oFood))
        {
            ResterAddConsumable(oFood); // add oFood to the list of items to consume when resting
            nResult |= REST_CONSUME;    // consume items required for rest
        }
        else
        {
            string sResponse    = GetLocalString(OBJECT_SELF,DESCRIBE_REST);
            if(sResponse=="")
                sResponse   = RED+"You rest uncomfortably.";
            SetLocalString(OBJECT_SELF,DESCRIBE_REST, sResponse+" "+PINK+"You are hungry." );

            // rest will proceed but be uncomfortable
            nResult |= REST_UNCOMFORTABLE;  // uncomfortable rest (fatigue)
            nResult |= REST_LIMIT_HP;       // limit hp recovered
         }
    }
    // require BED
    else if(nTest==4 && !(nShelter&REST_IGNORE_BED) )
    {
        if(GetNeedsBedToRestComfortably()&&!GetHasBed())
        {
            string sResponse    = GetLocalString(OBJECT_SELF,DESCRIBE_REST);
            if(sResponse=="")
                sResponse   = RED+"You rest uncomfortably.";
            SetLocalString(OBJECT_SELF,DESCRIBE_REST, sResponse+" "+PINK+"The ground is hard without a bed roll." );

            // rest will proceed but be uncomfortable
            nResult |= REST_UNCOMFORTABLE;  // uncomfortable rest (fatigue)
            nResult |= REST_LIMIT_SPELLS;   // limit spells recovered
        }
    }

    return nResult;
}

string ResterFailureText(int nTestFailed)
{
    // CONFIGURABLE
    // CUSTOMIZE THE RESPONSES AS YOU SEE FIT
    // the index of each block/case correlates with the index of blocks in ResterRequirements()
    // these messages appear for the player when a rest requirement resulted in a REST_POSTPONE flag
    int time = (GetLocalInt(OBJECT_SELF, NEXT_REST_TIME)-GetCumulativeMinutes())/IGMINUTES_PER_RLMINUTE;
    if(time<=0)
        time = 2;
    switch(nTestFailed)
    {
        // test: tired/time limit
        case 1:
            return (    RED+"You may only rest once every "+IntToString(GAME_MINUTES_BETWEEN_RESTS)+" game minutes. "
                        +PINK+"Try again in approximately " +YELLOW+ IntToString(time)+" real minutes."
                   );
        break;
        // test: cold (stops to build or use a campfire)
        case 2:
            return (    RED+"You are cold."
                   );
        break;
        case 5:
            return (    RED+"You are unable to rest while holding your breath."
                   );
        break;
    }

    return (RED+"You are unable to rest.");
}

void ResterBeginsRest()
{
    // CONFIGURE for start of a successful rest
    // this is a good place to do vfx changes like black outs etc...

}

void ResterFailsToRest()
{
    // CONFIGURE for rest cancelation events (ie. occurs when you postpone rest)

}

void ResterFinishesRest()
{
    // CONFIGURE for successful completion of rest
    // this is a good place to track state on the player related to rest


    // Sets up time for next rest to check against in "GetIsTimeToRest"
    // assumes time between rests is calculated in game minutes
    if(!GetRestUnrestricted())
        SetLocalInt(OBJECT_SELF, NEXT_REST_TIME, GetCumulativeMinutes()+(GAME_MINUTES_BETWEEN_RESTS) );

}

int ResterConsumes(object oConsume)
{
  // most items will need to be explicitly destroyed which is why bDestroy is set to TRUE.
  // for items which will destroy themselves, set bDestroy to FALSE in their section below
    int bDestroy    = TRUE;

// Configure what each item does when consumed
// (eg. you may want certain items to "activate" their special powers)

    return bDestroy;
}

void ResterPrepares(int nScript)
{
// Configure each code block to suit your rest system
// these are typicaly actions which need to be completed prior to resting (eg. building a campfire in a cold environment)

    /*
    // script 1 -- REST_ACTION_MAKE_CAMPFIRE ---
    if(nScript==REST_ACTION_MAKE_CAMPFIRE)
    {
        // THE MAGUS' CAMP SYSTEM
        CamperCreatesCampsite(GetLocation(OBJECT_SELF), GetLocalObject(OBJECT_SELF,CAMP_FIREWOOD));
    }
    // script 2 -- REST_ACTION_LIGHT_CAMPFIRE ---
    else if(nScript==REST_ACTION_LIGHT_CAMPFIRE)
    {
        // THE MAGUS' CAMP SYSTEM
        CamperUsesCampfire();
    }
    else
    */
    // script -- write your own ... ---
    if(nScript==1)
    {

    }
    // script x -- there can be any number of these preparation scripts ---
}

int ResterGetFatigue(object oRester=OBJECT_SELF)
{
    return GetSkinInt(oRester, REST_FATIGUE);
}

void ResterSetFatigue(int nFatigue, object oRester=OBJECT_SELF)
{
    SetSkinInt(oRester, REST_FATIGUE, nFatigue);
}

int ResterMaxSpellLevelRecovered()
{
    // maximum spell level to allow the PC to recover
    int nMaxSpellLevel = 9;

    // fatigue = # of consecutive uncomfortable rests
    int nFatigue    = ResterGetFatigue();

    // max spell level is reduced by 1 for every point of fatigue
    nMaxSpellLevel     -= nFatigue;
    // always allow PCs to memorize spell levels 0-2
    if(nMaxSpellLevel<2)
        nMaxSpellLevel = 2;

    return nMaxSpellLevel;
}

int ResterDamageLimitsHPRecovery()
{
    // some calculations to help with your own determinations
    int nMaxHealed          = GetMaxHitPoints()-GetLocalInt(OBJECT_SELF, REST_HP);  // determine how much they are healing by resting

    float fPercentageHealed = 1.0/(1+ResterGetFatigue()); // calculate the most you want the player to heal
    float fPercentageDamage = 1.0 - fPercentageHealed; // calculate the percentage of damage as an inverse of healing limit

    int nDamage             = FloatToInt( nMaxHealed * fPercentageDamage );

    // Insurance: lets not kill them
    int nCurrent            = GetCurrentHitPoints();
    if(nDamage>=nCurrent)
        nDamage = nCurrent-1;

    return nDamage;
}

// ........ Individual Rest Tests --> used by ResterRequirements()
// you may modify these, add your own, or even delete these if you won't be using them

int GetIsTimeToRest(object oPC=OBJECT_SELF)
{
    int bTired  = FALSE;

    if( GetLocalInt(oPC, NEXT_REST_TIME)<=GetCumulativeMinutes() )
        bTired  = TRUE;

    return bTired;
}

int GetIsCold(object oPC=OBJECT_SELF)
{
    int nExposed;

    object oArea    = GetArea(oPC);

    // COLD AREAS
    if(     GetLocalInt(oArea, AREA_COLD) // area flagged as cold?
        ||  GetWeather(oArea)==WEATHER_SNOW // snowing in area?
        //|| (GetIsNight() && !GetIsAreaInterior(oArea)) // outside at night?
      )
    {
        nExposed    = TRUE;

        /*
        // MAGUS CAMP SYSTEM
        // determine whether there is a lit campfire nearby
        int nCampState  = GetIsNearCamp();
        if(nCampState==2)
        {
            nExposed    = FALSE;
        }

        // no lit campfire nearby so look for another way to stay warm...
        else
        */
        // Search for Protection from cold
        {
            // iterate through all equipped items for cold immunity or resistance properties
            int nSlot;
            object oItem    = GetItemInSlot(nSlot,oPC);
            while(GetIsObjectValid(oItem) && nSlot<=17 && nExposed)
            {
                // a check for cold weather clothing?

                // look for props : resistance or immunity to cold
                itemproperty ip = GetFirstItemProperty(oItem);
                while(GetIsItemPropertyValid(ip))
                {
                    int nType   = GetItemPropertyType(ip);
                    if( (   nType==ITEM_PROPERTY_DAMAGE_RESISTANCE
                        ||  nType==ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE
                        )
                        &&  GetItemPropertySubType(ip) == IP_CONST_DAMAGETYPE_COLD
                      )
                    {
                        nExposed = FALSE;
                        break;
                    }

                    ip = GetNextItemProperty(oItem);
                }

                nSlot++;
                oItem    = GetItemInSlot(nSlot,oPC);
            }
        }
        // end Search for Protection from cold
    }
    // end COLD AREAS

    return nExposed;
}

int GetNeedsBedToRestComfortably(object oPC=OBJECT_SELF)
{
    object oArea    = GetArea(oPC);

    // wild characters can avoid beds in natural areas
    if( GetIsAreaNatural(oArea)
        &&(     GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC)
            ||  GetLevelByClass(CLASS_TYPE_DRUID, oPC)
            ||  GetLevelByClass(CLASS_TYPE_RANGER, oPC)
          )
        // all wildlings can sleep outside
        // and dwarves and gnomes are also comfortable underground
        &&( !GetIsAreaInterior(oArea)
            ||( !GetIsAreaAboveGround(oArea)
                &&(     GetRacialType(oPC)==RACIAL_TYPE_DWARF
                    ||  GetRacialType(oPC)==RACIAL_TYPE_GNOME
                  )
              )
          )
      )
        return FALSE;

    return TRUE;
}

// ........ You may have already defined these functions ........

int GetHasBed(object oPC=OBJECT_SELF)
{
    int bHas    = FALSE;

    if( GetItemPossessedBy(oPC,TAG_BEDROLL)!=OBJECT_INVALID )
        bHas    = TRUE;

    return bHas;
}


// ============== NOT CONFIGURABLE =======================================

// REST SUB-EVENTS ............................

void RestStarted()
{
    RestGarbageCollection();

    // In an area with unrestricted resting?
    if(GetRestUnrestricted())
    {
        return;
    }
    // check resting rules
    else
    {
        int nResult = TestRestRequirements();

        // Rest cancelled
        if(nResult & REST_POSTPONE)
        {
            ClearAllActions();
            // explain why the rest action is cancelled
            RestFeedback(FALSE);
        }
        // Rest proceeds
        else
        {
            // customize rest start (successful rest)
            // good place for black out VFX and the like
            ResterBeginsRest();

            // track HP at start of rest
            SetLocalInt(OBJECT_SELF, REST_HP, GetCurrentHitPoints());

            // consume items required for rest
            if(nResult & REST_CONSUME)
                RestConsumeItems();

            if( nResult & REST_UNCOMFORTABLE )
                RestComfortable(FALSE);
            else
                RestComfortable(TRUE);

            // Was the rest not comfortable enough to replenish spells?
            if(nResult & REST_LIMIT_SPELLS)
                RestLimitSpells();

            // describe rest
            RestFeedback();
        }
    }
}

void RestCanceled()
{
    int nResult = GetLocalInt(OBJECT_SELF, REST_TEST_RESULTS);
    // fill action queue with preparatory action
    if(nResult & REST_PREPARE)
        RestPreparation();

    // custom cancellation
    ResterFailsToRest();

    // not a good place for garbage collection
}

void RestFinished()
{
    int nResult = GetLocalInt(OBJECT_SELF, REST_TEST_RESULTS);
    if(nResult & REST_LIMIT_HP)
        RestLimitHP();

    // customize rest completion
    // good place to track data related to resting
    ResterFinishesRest();

    RestGarbageCollection();
}


// REST RULE HANDLING .........................

int GetRestUnrestricted(object oRester=OBJECT_SELF)
{
    object oArea    = GetArea(oRester);

    // assumption is that rest is restricted unless REST_UNRESTRICTED is specified
    // when determining whether rest restrictions are active in a particular circumstance
    //  order of priority is player, area, module

    if(      GetLocalInt(oRester, REST_UNRESTRICTED) )
        return TRUE;
    else if( GetLocalInt(oRester, REST_RESTRICTED) )
        return FALSE;
    else if( GetLocalInt(oArea, REST_UNRESTRICTED) )
        return TRUE;
    else if( GetLocalInt(oArea, REST_RESTRICTED) )
        return FALSE;
    else if( GetLocalInt(GetModule(), REST_UNRESTRICTED) )
        return TRUE;
    else
        return FALSE;
}

int TestRestRequirements()
{
    int nTestResults;

    int nTest   = 1;
    while(nTest<=LAST_REST_TEST && !(nTestResults & REST_POSTPONE) )
    {
        nTestResults    |= ResterRequirements(nTest);
        nTest++;
    }

    SetLocalInt(OBJECT_SELF, REST_TEST_RESULTS, nTestResults);
    return nTestResults;
}

// REST RESULTS ..............................

void RestConsumeItems()
{
    int nCount  = GetLocalInt(OBJECT_SELF, REST_CONSUME_COUNT);
    int nIt     = 1;
    DeleteLocalInt(OBJECT_SELF, REST_CONSUME_COUNT);
    object oConsume;
    string sConsumableLabel;
    for(nIt;nIt<=nCount;nIt++)
    {
        sConsumableLabel    = REST_CONSUME_+IntToString(nIt);
        oConsume            = GetLocalObject(OBJECT_SELF, sConsumableLabel);
        DeleteLocalObject(OBJECT_SELF, sConsumableLabel);

        if(ResterConsumes(oConsume))
            // destroy the object
            DestroyObject(oConsume, 0.1);
    }
}

void RestPreparation()
{
    int nCount  = GetLocalInt(OBJECT_SELF, REST_PREPARATION_COUNT);
    DeleteLocalInt(OBJECT_SELF, REST_PREPARATION_COUNT);
    string sPreparation; int nAction;
    int nIt = 1;
    for(nIt;nIt<=nCount;nIt++)
    {
        sPreparation     = REST_PREPARATION_+IntToString(nIt);
        nAction = GetLocalInt(OBJECT_SELF, sPreparation);
        ActionDoCommand( ResterPrepares(nAction) );
        DeleteLocalInt(OBJECT_SELF, sPreparation);
    }
}

void RestComfortable(int bSuccess=TRUE)
{
    int nFatigue    = ResterGetFatigue();
    if(bSuccess)
        nFatigue    = 0;
    else
        nFatigue++;

    ResterSetFatigue(nFatigue);
}

void RestLimitSpells()
{
    int nMaxAbility = 10+ResterMaxSpellLevelRecovered();
    float fDuration = 12.0 + (GetHitDice(OBJECT_SELF)*0.5);

    // Intelligence Damage
    if(REST_SPELL_LIMIT_INT && !GetLocalInt(OBJECT_SELF,REST_NO_SPELL_LIMIT_INT))
    {
        int nIntDamage  = GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE, FALSE) - nMaxAbility;
        if(nIntDamage>REST_MAX_DAMAGE_INT)nIntDamage=REST_MAX_DAMAGE_INT;
        else if(nIntDamage<REST_MIN_DAMAGE_INT)nIntDamage=REST_MIN_DAMAGE_INT;
        effect  eFatigue1 = SupernaturalEffect( EffectAbilityDecrease(ABILITY_INTELLIGENCE, nIntDamage) );
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFatigue1, OBJECT_SELF, fDuration);
    }

    // Wisdom Damage
    if(REST_SPELL_LIMIT_WIS && !GetLocalInt(OBJECT_SELF,REST_NO_SPELL_LIMIT_WIS))
    {
        int nWisDamage  = GetAbilityScore(OBJECT_SELF, ABILITY_WISDOM, FALSE) - nMaxAbility;
        if(nWisDamage>REST_MAX_DAMAGE_WIS)nWisDamage=REST_MAX_DAMAGE_WIS;
        else if(nWisDamage<REST_MIN_DAMAGE_WIS)nWisDamage=REST_MIN_DAMAGE_WIS;
        effect  eFatigue2 = SupernaturalEffect( EffectAbilityDecrease(ABILITY_WISDOM, nWisDamage) );
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFatigue2, OBJECT_SELF, fDuration);
    }

    // Charisma Damage
    if(REST_SPELL_LIMIT_CHA && !GetLocalInt(OBJECT_SELF,REST_NO_SPELL_LIMIT_CHA))
    {
        int nChaDamage  = GetAbilityScore(OBJECT_SELF, ABILITY_CHARISMA, FALSE) - nMaxAbility;
        if(nChaDamage>REST_MAX_DAMAGE_CHA)nChaDamage=REST_MAX_DAMAGE_CHA;
        else if(nChaDamage<REST_MIN_DAMAGE_CHA)nChaDamage=REST_MIN_DAMAGE_CHA;
        effect  eFatigue3 = SupernaturalEffect( EffectAbilityDecrease(ABILITY_CHARISMA, nChaDamage) );
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFatigue3, OBJECT_SELF, fDuration);
    }
}

void RestLimitHP()
{
    int nDamage = ResterDamageLimitsHPRecovery();

    /*
    if(MODULE_NWNX_MODE)
        NWNX_ModifyCurrentHitPoints (OBJECT_SELF, -nDamage);
    else
    */
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDamage), OBJECT_SELF);

}

// REST SYSTEM UTILITIES .........................

void RestFeedback(int nRestSuccess=TRUE)
{
    if(!nRestSuccess)
    {
        FloatingTextStringOnCreature(   ResterFailureText(GetLocalInt(OBJECT_SELF,CAUSE_OF_REST_FAILURE)),
                                        OBJECT_SELF,
                                        FALSE
                                    );
    }
    else
    {
        string sDescription = GetLocalString(OBJECT_SELF,DESCRIBE_REST);
        if(sDescription!="")
            SendMessageToPC( OBJECT_SELF, sDescription );
    }
}

void RestGarbageCollection()
{
    DeleteLocalInt(OBJECT_SELF, REST_TEST_RESULTS);
    DeleteLocalInt(OBJECT_SELF, REST_HP);
    DeleteLocalInt(OBJECT_SELF, CAUSE_OF_REST_FAILURE);
    DeleteLocalString(OBJECT_SELF,DESCRIBE_REST);
    DeleteLocalInt(OBJECT_SELF, REST_CONSUME_COUNT);
    DeleteLocalInt(OBJECT_SELF, REST_PREPARATION_COUNT);
    DeleteLocalInt(OBJECT_SELF,REST_NO_SPELL_LIMIT_INT);
    DeleteLocalInt(OBJECT_SELF,REST_NO_SPELL_LIMIT_WIS);
    DeleteLocalInt(OBJECT_SELF,REST_NO_SPELL_LIMIT_CHA);
}

void ResterAddConsumable(object oConsumable)
{
    int nCount  = GetLocalInt(OBJECT_SELF, REST_CONSUME_COUNT)+1;
    SetLocalInt(OBJECT_SELF, REST_CONSUME_COUNT, nCount);
    SetLocalObject(OBJECT_SELF, REST_CONSUME_+IntToString(nCount), oConsumable);
}

void ResterAddPreparatoryAction(int nActionScript)
{
    int nCount  = GetLocalInt(OBJECT_SELF, REST_PREPARATION_COUNT)+1;
    SetLocalInt(OBJECT_SELF, REST_PREPARATION_COUNT, nCount);
    SetLocalInt(OBJECT_SELF, REST_PREPARATION_+IntToString(nCount), nActionScript);
}

int GetCumulativeMinutes()
{
    int iYear       = GetCalendarYear() - 1000; // a hack instead of setting the "epoch"

    return( ((GetTimeMinute()*IGMINUTES_PER_RLMINUTE)+ ((GetTimeHour()+((GetCalendarDay()+((GetCalendarMonth()+(iYear*12))*28))*24))*60) ) );
}
