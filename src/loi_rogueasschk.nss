//Basic Class Check by Surreal


int StartingConditional()
{
    // Get the PC who is involved in this conversation
    object oPC = GetPCSpeaker();

    // The PC must be one of the listed classes.
    if ( GetLevelByClass(CLASS_TYPE_ROGUE, oPC) == 0  &&
         GetLevelByClass(CLASS_TYPE_ASSASSIN, oPC) == 0 )
        return FALSE;

    // If we make it this far, we have passed all tests.
    return TRUE;
}

