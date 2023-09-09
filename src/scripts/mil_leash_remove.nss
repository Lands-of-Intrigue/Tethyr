//::///////////////////////////////////////////////
//:: Leash Remove
//:: mil_leash_remove.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Destroy the leash and collar.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Dec. 15, 2003
//:://////////////////////////////////////////////
void main()
{
    object oUser = OBJECT_SELF;
    string sID = GetLocalString(oUser, "mil_LeashID");
    object oLeash = GetObjectByTag("ControlLeash" + sID);
    object oCollar = GetObjectByTag("SubCollar" + sID);
    object oTarget = GetItemPossessor(oCollar);

    DestroyObject(oLeash);
    DestroyObject(oCollar);

    // Emote action
    string sOutput = "**" + GetName(oUser) + " has removed the rope from " + GetName(oTarget) + ".**";
    AssignCommand(oUser, SpeakString(sOutput));
}
