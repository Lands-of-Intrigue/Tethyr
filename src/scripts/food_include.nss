//::///////////////////////////////////////////////
//:: food_include
//:://////////////////////////////////////////////
/*
    MAGUS FOOD SYSTEM - INCLUDE


    include this file where you need to use the food system

*/
//:://////////////////////////////////////////////
//:: Creator   : The Magus (2013 july 13)
//:: Modified  : Henesua (2014 may 9) pulled into one include
//:://////////////////////////////////////////////

// CONSTANTS -------------------------------------------------------------------

// local set on pc to track when they will be hungry again.
const string NEXT_MEAL_TIME         = "MEAL_NEXT";
// local int set on food item to indicate how many hours it puts off hunger for the person who eats it
const string FOOD_HOURS             = "FOOD_HOURS";
// local string set on food item to provide feedback to the person who eats it (intended to enhance experience for PC)
const string FOOD_DESCRIPTION       = "FOOD_DESCRIPTION";
// local int set on food item to indicate perishability
const string FOOD_PERISHABLE        = "PERISHABLE";
// local int set on food item (by script) to indicate the minute it will perish
const string FOOD_PERISHABLE_TIME   = "PERISHABLE_TIME";

// Tag for food item - items with the food tag are considered edible
const string TAG_FOOD       = "food";
// Tag for raw meat
const string TAG_MEAT       = "meat";

// INCLUDES --------------------------------------------------------------------

#include "te_functions"

// FUNCTION DECLARATIONS -------------------------------------------------------

// Returns TRUE if oItem is food [FILE: food_include]
int GetIsFood(object oItem);
// Returns TRUE if oPC needs to eat [FILE: food_include]
int GetIsHungry(object oPC=OBJECT_SELF);
// Returns a food item in oPC inventory [FILE: food_include]
object GetFoodInInventory(object oPC=OBJECT_SELF);
// Get rawmeat in oPC inventory [FILE: food_include]
object GetRawMeatInInventory(string sTag=TAG_MEAT, object oPC=OBJECT_SELF);
// Returns a positive integer if the food is spoiled [FILE: food_include]
int GetFoodSpoilage(object oFood, int nMinute=0);
// oCreature eats a food item  [FILE: food_include]
void CreatureEatsFood(object oFood, object oCreature=OBJECT_SELF);

// FUNCTION IMPLEMENTATIONS ----------------------------------------------------

int GetIsFood(object oItem)
{
    int is_food = FALSE;

    if(GetLocalInt(oItem, FOOD_HOURS))
        is_food = TRUE;

    return is_food;
}

int GetIsHungry(object oPC=OBJECT_SELF)
{
    int bHungry = FALSE;

    if(GetLocalInt(oPC, NEXT_MEAL_TIME)<GetTimeCumulative())
        bHungry = TRUE;

    return bHungry;
}

object GetFoodInInventory(object oPC=OBJECT_SELF)
{
    object oFood    = GetFirstItemInInventory(oPC);
    while(oFood!=OBJECT_INVALID)
    {
        if(FindSubString(GetTag(oFood),TAG_FOOD)==0)
            return oFood;
        oFood    = GetNextItemInInventory(oPC);
    }
    return oFood;
}

object GetRawMeatInInventory(string sTag=TAG_MEAT, object oPC=OBJECT_SELF)
{
    object oMeat    = GetFirstItemInInventory(oPC);
    while(oMeat!=OBJECT_INVALID)
    {
        if(FindSubString(GetTag(oMeat),sTag)==0)
            return oMeat;
        oMeat    = GetNextItemInInventory(oPC);
    }
    return OBJECT_INVALID;
}

int GetFoodSpoilage(object oFood, int nMinute=0)
{
    if(!nMinute)
        nMinute     = GetTimeCumulative();
    int nPerish     = GetLocalInt(oFood,FOOD_PERISHABLE);
    int nPerishTime = GetLocalInt(oFood,FOOD_PERISHABLE_TIME);
    if(     nPerish
        &&  nPerishTime
        &&  nPerishTime<=nMinute
      )
    {
        // food is spoiled
        return TRUE;
    }
    return FALSE;
}

void SetCreatureSatiety(object oCreature, int nFoodValue, int nNow)
{
    int nSatiety    = GetLocalInt(oCreature,NEXT_MEAL_TIME); // should not be persistent, unless time is persistent
    int nTemp       = nSatiety+nFoodValue;
    int nMax        = nNow+480; // food can not satisfy for more than 8 hours

    if(!nSatiety)
        nSatiety    = nNow+nFoodValue; // fill up
    // have been hungry for so long that this food would still leave you hungry
    else if(nTemp<nNow)
        nSatiety    = nNow + 1;// so allow it to satisfy for 1 minute
    // otherwise ....
    else
    {
        // currently satisfied?
        if(nSatiety>nNow)
            nTemp = nNow+nFoodValue;// then calculate food value from current moment
        // eaten enough to increase satisfaction?
        if(nTemp>nSatiety)
        {
            // eaten more than our fill?
            if(nTemp>nMax)
            {
                // is our current fill less than max?
                if(nSatiety<nMax)
                    nSatiety    = nMax; // set our fill to Max
            }
            else
                nSatiety    = nTemp;
        }
    }

    SetLocalInt(oCreature, NEXT_MEAL_TIME, nSatiety);
}

void CreatureEatsFood(object oFood, object oCreature=OBJECT_SELF)
{
    int nNow        = GetTimeCumulative();
    int nMax        = nNow+480; // food can not satisfy for more than 8 hours
    // check for spoilage
    int nSpoilage   = GetFoodSpoilage(oFood,nNow);
    int bVomit;
    // calculate duration that food will satisfy
    int nFoodValue  = GetLocalInt(oFood, FOOD_HOURS)*60;

    string sConsumes    = GetLocalString(oFood,"FOOD_ACTION");
    if(sConsumes=="")
        sConsumes       = "consumes";

    FloatingTextStringOnCreature(LIME+GetName(oCreature)+" "+sConsumes+" "+GREEN+GetName(oFood)+".",oCreature);
    // food is spoiled
    if(nSpoilage)
    {
        if(!GetAbilityCheck(oCreature, ABILITY_CONSTITUTION, 15, FALSE))
        {

        }
    }
    else
    {
        SetCreatureSatiety(oCreature,nFoodValue,nNow);
        SendMessageToPC(oCreature,LIME+GetLocalString(oFood,"FOOD_DESCRIPTION"));

        int nSatiety    = GetLocalInt(oCreature, NEXT_MEAL_TIME);

        if(nSatiety>=nMax)
            SendMessageToPC(oCreature,LIME+"You are full.");
        else if(nSatiety>nNow)
        {
            string sSatisfaction;
            int nTemp   = (nSatiety-nNow)/60;
            if(nTemp<1){nTemp=1;sSatisfaction="less than an hour.";}
            else if(nTemp==1){sSatisfaction="an hour.";}
            else{sSatisfaction=IntToString(nTemp)+" hours.";}
            SendMessageToPC(oCreature,LIME+"That will satisfy you for "+sSatisfaction);
        }
        else
            SendMessageToPC(oCreature,LIME+"You are still hungry.");
    }

    int nStack  = GetItemStackSize(oFood);
    if(nStack==1)
        DestroyObject(oFood, 0.1);
    else
        SetItemStackSize(oFood, --nStack);

}
// void main(){}
