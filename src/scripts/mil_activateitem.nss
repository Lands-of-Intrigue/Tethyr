//::///////////////////////////////////////////////
//:: Activate Item
//:: mil_activateitem.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Called when an item is activated within the module.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On:
//:://////////////////////////////////////////////
void main()
{
    object oItem        = GetItemActivated();
    object oPC          = GetItemActivator();
    object oTarget      = GetItemActivatedTarget();
    location lLocation  = GetItemActivatedTargetLocation();
    string sItemTag     = GetTag(oItem);

    if (FindSubString(sItemTag, "Blindfold") >= 0)    {
    // Blindfold
        ExecuteScript("mil_consentitem", oPC);
    }   else if (FindSubString(sItemTag, "Gag") >= 0)    {
    // Gag
        ExecuteScript("mil_consentitem", oPC);
    }   else if (FindSubString(sItemTag, "Rope") >= 0)    {
    // Rope
        ExecuteScript("mil_consentitem", oPC);
    }   else if (FindSubString(sItemTag, "BlankCollar") >= 0)    {
    // Blank Collar
        ExecuteScript("mil_consentitem", oPC);
    }   else if (FindSubString(sItemTag, "TickleFeather") >= 0)    {
    // Tickle Feather
        AssignCommand(oPC, SpeakString("**Tickle Tickle Tickle**"));
        PlayVoiceChat(VOICE_CHAT_LAUGH, oTarget);
    }   else if (FindSubString(sItemTag, "ControlLeash") >= 0)    {
    // Control Leash
        string sID = GetStringRight(sItemTag, 16);
        object oCollar = GetObjectByTag("SubCollar" + sID);

        if(GetIsObjectValid(oCollar)) {
            SetCustomToken(9805, GetName(GetItemPossessor(oCollar)));
            SetLocalString(oPC, "mil_LeashID", sID);

            AssignCommand(oPC, ActionStartConversation(oPC, "mil_controlleash", TRUE));
        } else {
            SendMessageToPC(oPC, "The shackles associated with this rope are not availible.");
        }
    }
}
