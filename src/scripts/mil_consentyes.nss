void main()
{
    object oTarget          = OBJECT_SELF;
    string sConversation    = GetLocalString(oTarget, "mil_Conversation");
    object oItem            = GetLocalObject(oTarget, "mil_ConversationItem");
    object oUser            = GetLocalObject(oTarget, "mil_ConversationUser");

    if ((sConversation == "Blindfold") || (sConversation == "Gag") || (sConversation == "Rope"))   {
        effect eEffect;

        if (sConversation == "Blindfold") {
            eEffect = EffectBlindness();
        } else if (sConversation == "Gag") {
            eEffect = EffectSilence();
        } else if (sConversation == "Rope") {
            eEffect = EffectSlow();
        }

        // Set Variables
        SetLocalInt(oItem, "mil_InUse", TRUE);
        SetLocalObject(oItem, "mil_Target", oTarget);
        SetLocalObject(oTarget, "mil_" + GetTag(oItem), oItem);

        // Apply Effect
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

        // Emote the action.
        string ToSpeak;

        if (sConversation == "Rope") {
            ToSpeak = "**" + GetName(oUser) + " has bound " + GetName(oTarget) + "'s hands and feet with " + GetName(oItem) + ".**";
        } else {
            ToSpeak = "**" + GetName(oUser) + " has placed a " + GetName(oItem) + " on " + GetName(oTarget) + ".**";
        }
        AssignCommand(oUser, SpeakString(ToSpeak, TALKVOLUME_TALK));
    } else if (sConversation == "BlankCollar") {
        if(GetIsPC(oTarget)) {
            // Build the ID
            string sUserCD = GetPCPublicCDKey(oUser);
            string sTargetCD = GetPCPublicCDKey(oTarget);
            string sID = sUserCD + sTargetCD;

            // Create the Sub Collar
            object oCollar = CreateObject(OBJECT_TYPE_ITEM, "mil_collar002", GetLocation(oTarget), FALSE, "SubCollar" + sID);
            object oCollar2 = CopyObject(oCollar, GetLocation(oTarget), oTarget);
            DestroyObject(oCollar);
            //AssignCommand(oTarget, ActionPickUpItem(oCollar));

            // Create the Leash
            object oLeash = CreateObject(OBJECT_TYPE_ITEM, "mil_leash001", GetLocation(oUser), FALSE, "ControlLeash" + sID);
            object oLeash2 = CopyObject(oLeash, GetLocation(oUser), oUser);
            DestroyObject(oLeash);
            //AssignCommand(oUser, ActionPickUpItem(oLeash));

            // Destroy the Blank Collar
            DestroyObject(oItem);

            // Emote the action
            string ToSpeak = "**" + GetName(oUser) + " has secured shackles upon " + GetName(oTarget) + ".**";
            AssignCommand(oUser, SpeakString(ToSpeak, TALKVOLUME_TALK));

            // Force character save
            ExportSingleCharacter(oUser);
            ExportSingleCharacter(oTarget);
        } else {
            SendMessageToPC(oUser, "You may only place shackles upon other players.");
        }

    }
}
