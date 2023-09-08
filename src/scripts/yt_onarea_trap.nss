//::///////////////////////////////////////////////
//:: Name       Random Trap Disabler v1.0
//:: FileName   yt_randomtrap
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  PLACE THIS SCRIPT IN THE OnAreaEnter handler (or
  execute it from the default OnAreaEnter script) of
  each area in which there will be traps which need
  to be randomly disabled.  It is designed to be called only when the very first
  PC enters the area since the last module load.

  This script cycles through all objects in an area
  and based on the percentage chance to disable supplied
  in the tag on a trap, will either disable the trap
  or allow it to remain enabled.

  Trap Names and Tags should be preceded by "trap_" to indicate
  that the object is indeed a trap and expedite the process of
  cyclcing through all objects in an area.

  Trap names (which are what appear in the item palette)
  should begin with "trap_" followed by some descriptive text.
  For Example: "trap_strong_acid"

  The tags of traps placed into an area should have the same
  name as the palette trap they were made from plus a 2-3 digit
  suffix which indicates the chance that the trap will be disabled.
  For Example: tag = "trap_strong_acid_05" would have a 5% chance
  of being disabled.  The random roll would have to be a 4 or lower
  for the trap to be disabled.

  The number at the end of the trap tag will be compared to a Random
  value between 0 and 99.

  NOTE: This script will not function properly in the starting area of a
        single-player mod, as all scripts in the first area of the mod are fired
        before the PC is actually created.  The PC needs to have entered the
        area before the script fires, as happens when transition between areas.

        This should not present a problem for a served multiplayer version of a
        mod with this script.

*/
//:://////////////////////////////////////////////
//:: Created By:  Ythaniel (ythaniel@hotmail.com)
//:: Created On:  10/14/05
//:://////////////////////////////////////////////
void main()
{
    // SpawnScriptDebugger();

    //Check self (the area) to see if this script has run once since the module
    //  was last loaded
    int nRunOnce = GetLocalInt(OBJECT_SELF, "RunOnce");
    if (nRunOnce == TRUE) { return; }

    object oPC = GetFirstPC();
    //Debug
    SendMessageToPC(oPC, "Traps in area being configured");

    object oTrap = GetFirstObjectInArea();
    string sTag = GetTag(oTrap);
    string sPrefix = GetStringLeft(sTag,5);  //Get the first 5 letters of string
    string sPercent;
    int nPercent;
    int nRandom;

    //Make sure the object is valid
    while(GetIsObjectValid(oTrap))
    {
        //Make sure the object has not yet been checked
        if (GetLocalInt(oTrap,"checked") == 0)
        {
            if (sPrefix == "trap_")
            {
                //The rightmost 2 characters on the trap tag should indicate the
                //  the chance that the trap will be disabled.
                sPercent = GetStringRight(sTag,2);
                nPercent = StringToInt(sPercent);

                //Generate chance of disabling the trap
                nRandom = Random(100);

                //if the random roll is less than the chance of being disabled
                // then the trap is disabled
                if (nRandom < nPercent)
                {
                    SetTrapDisabled(oTrap);
                    SetLocalInt(oTrap, "Checked", 1);
                    //Debug
                    SendMessageToPC(oPC, "Trap " + sTag + " disabled.");
                }
                else
                {
                    //Debug
                    SendMessageToPC(oPC, "Trap " + sTag + " not disabled.");
                }
            }
        }
        //Get the next trap and its relavent attributes
        oTrap = GetNextObjectInArea();
        sTag = GetTag(oTrap);
        sPrefix = GetStringLeft(sTag,5);
    }

    //Indicate that the traps in the area have been disabled.
    SetLocalInt(OBJECT_SELF, "RunOnce", TRUE);
}
