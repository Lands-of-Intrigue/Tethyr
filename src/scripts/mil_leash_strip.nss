//::///////////////////////////////////////////////
//:: Leash Strip
//:: mil_leash_strip.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Force the holder of the collar to remove thier armor.
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

    if (GetLocalInt(oTarget, "mil_IsLeashed")) {
        AssignCommand(oTarget, ClearAllActions());
        AssignCommand(oTarget, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CHEST, oTarget)));
        ExecuteScript("mil_wearnaked", oTarget);
        AssignCommand(oTarget, ActionForceFollowObject(oUser, 0.0));
    } else {
        AssignCommand(oTarget, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CHEST, oTarget)));
        ExecuteScript("mil_wearnaked", oTarget);
    }

    // Emote action
    string ToSpeak = "**" +GetName(oUser) + " has stripped the armor from  " + GetName(oTarget) + ".**";
    AssignCommand(oUser, SpeakString(ToSpeak, TALKVOLUME_TALK));
}
