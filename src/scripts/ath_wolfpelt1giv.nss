/*
 *  Script generated by LS Script Generator, v.TK.0
 *
 *  For download info, please visit:
 *  http://nwvault.ign.com/View.php?view=Other.Detail&id=1502
 */
// Put this under "Actions Taken" in the conversation editor.


void main()
{
    // Get the PC who is in this conversation.
    object oPC = GetPCSpeaker();

    // Take "I_ATH_WOLFPELT" from the PC.
    DestroyObject(GetItemPossessedBy(oPC, "I_ATH_WOLFPELT"));

    // Give 5 gold to the PC.
    GiveGoldToCreature(oPC, 5);
}

