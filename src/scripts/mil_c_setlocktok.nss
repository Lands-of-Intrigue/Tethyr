//::///////////////////////////////////////////////
//:: Condition test Set Lock Tokens
//:: mil_c_setlocktok.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    This script finds the first 5 PCes within 3 feet of the shackles.
    It then sets thier name to a custom token and assigns thier object to a local vaiable on the player.
    It always returns TRUE.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Nov. 27, 2003
//:://////////////////////////////////////////////
int StartingConditional()
{
    object      oPC                 = GetPCSpeaker();                           // The user
    object      oShackle            = GetLocalObject(oPC, "mil_Shackles");      // The Shackle
    location    lShackle            = GetLocation(oShackle);                    // The Shackle's location
    object      CurrentPC;
    int         BeginCustomToken    = 9010;
    int         LastCustomToken     = 9014;
    int         CurrentToken        = BeginCustomToken;

    // Get the first Creature within a 3 foot circle around the Lock.
    CurrentPC = GetFirstObjectInShape(SHAPE_SPHERE, 3.0, lShackle, TRUE, OBJECT_TYPE_CREATURE);

    // While the Creature is valid, and there are empty tokens remaining...
    while (GetIsObjectValid(CurrentPC) && (CurrentToken <= LastCustomToken))   {
        // Set the custom token to contain the Creatures name.
        SetCustomToken(CurrentToken, GetName(CurrentPC) + " (" + GetPCPlayerName(CurrentPC) + ")");

        // Set a local variable to contain a link to the Creature.
        SetLocalObject(oPC, "mil_PC" + IntToString(CurrentToken), CurrentPC);

        // Increase the counter and get the next Creature.
        CurrentToken++;
        CurrentPC = GetNextObjectInShape(SHAPE_SPHERE, 3.0, lShackle, TRUE, OBJECT_TYPE_CREATURE);
    }

    // If we run out of creatures before tokens, set the remain tokens to blank.
    while (CurrentToken <= LastCustomToken) {
        SetCustomToken(CurrentToken++, "");
    }

    // set custom token to contain the Lock's name.
    SetCustomToken(9005, GetName(oShackle));

    return TRUE;
}

