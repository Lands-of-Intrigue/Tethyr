/*
 *  Script generated by LS Script Generator, v.TK.0
 *
 *  For download info, please visit:
 *  http://nwvault.ign.com/View.php?view=Other.Detail&id=1502
 */
// Put this under "Actions Taken" in the conversation editor.


void main()
{
    object oTarget;

    // Get the PC who is in this conversation.
    object oPC = GetPCSpeaker();

    // Find the location to which to teleport.
    oTarget = GetWaypointByTag("WP_START_BROST");

    // Teleport the PC.
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, JumpToObject(oTarget));
    SendMessageToPC(oPC, "<c�  >You ride one of the rear wagons away from the checkpoint.  The ride is bumpy and uncomfortable, but you arrive at Tejarn Gate much quicker than you would have on foot.  Upon your arrival you aid in the unloading of cargo and then are left to your own device.");
}
