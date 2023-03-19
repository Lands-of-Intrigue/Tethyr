//::///////////////////////////////////////////////
//:: Leash Follow
//:: mil_leash_follow.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Force the holder of the collar to follow the holder of the leash.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Dec. 15, 2003
//:://////////////////////////////////////////////
void main()
{
    object oUser = GetPCSpeaker();
    string sID = GetLocalString(oUser, "mil_LeashID");
    object oLeash = GetObjectByTag("ControlLeash" + sID);
    object oCollar = GetObjectByTag("SubCollar" + sID);
    object oTarget = GetItemPossessor(oCollar);

    if (GetIsObjectValid(oTarget))  {
        if (GetLocalInt(oTarget, "mil_IsLeashed")) {
            DeleteLocalInt(oTarget, "mil_IsLeashed");
            // Make them follow.
            AssignCommand(oTarget, ClearAllActions());

            // Emote action
            string sOutput = "**" + GetName(oUser) + " has removed the rope attached to " + GetName(oTarget) + ".**";
            AssignCommand(oUser, SpeakString(sOutput));
        } else {
            SetLocalInt(oTarget, "mil_IsLeashed", TRUE);

            // Make them follow.
            AssignCommand(oTarget, ActionForceFollowObject(oUser, 0.5));

            // Emote action
            string sOutput = "**" + GetName(oUser) + " has attached a rope to " + GetName(oTarget) + ".**";
            AssignCommand(oUser, SpeakString(sOutput));
        }
    }
}
