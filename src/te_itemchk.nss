int StartingConditional()
{
    // Get the PC who is involved in this conversation
    object oPC = GetPCSpeaker();

    // The PC must possess "BrostCountyRegistration".
    if ( GetItemPossessedBy(oPC, "BrostCountyRegistration") == OBJECT_INVALID )
        return FALSE;

    // If we make it this far, we have passed all tests.
    return TRUE;
}

