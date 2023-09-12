//::///////////////////////////////////////////////
//:: Consent Item
//:: mil_consentitem.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    This script sets variables then opens a conversation to see if the Item activated will be used on the Target.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Dec. 15, 2003
//:://////////////////////////////////////////////

void main()
{
    object oItem        = GetItemActivated();
    object oPC          = GetItemActivator();
    object oTarget      = GetItemActivatedTarget();
    location lLocation  = GetItemActivatedTargetLocation();
    string sItemTag     = GetTag(oItem);

    if (GetLocalInt(oItem, "mil_InUse"))    {
        // The Item is being used.
        if ((sItemTag == "Blindfold") || (sItemTag == "Gag") || (sItemTag == "Rope")) {
            int iEffect;
            oTarget = GetLocalObject(oItem, "mil_Target");

            if (sItemTag == "Blindfold") {
                iEffect = EFFECT_TYPE_BLINDNESS;
            } else if (sItemTag == "Gag") {
                iEffect = EFFECT_TYPE_SILENCE;
            } else if (sItemTag == "Rope") {
                iEffect = EFFECT_TYPE_SLOW;
            }

            if(GetIsObjectValid(oTarget))   {
                // Removed the Effect
                effect eEffect = GetFirstEffect(oTarget);

                while (GetIsEffectValid(eEffect))   {
                    if (GetEffectType(eEffect) == iEffect)    {
                        RemoveEffect(oTarget, eEffect);
                    }

                    eEffect = GetNextEffect(oTarget);
                }

                // Reset variables
                DeleteLocalObject(oItem, "mil_Target");
                DeleteLocalObject(oTarget, "mil_" + sItemTag);

                // Emote the action.
                string ToSpeak = "**" + GetName(oPC) + " has removed the " + GetName(oItem) + " from " + GetName(oTarget) + ".**";
                AssignCommand(oPC, SpeakString(ToSpeak, TALKVOLUME_TALK));
           }

           SetLocalInt(oItem, "mil_InUse", FALSE);
        }
    }   else    {
        // The Item is not being used, so use it.
        if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)    {
            SetLocalString(oTarget, "mil_Conversation", sItemTag);
            SetLocalObject(oTarget, "mil_ConversationItem", oItem);
            SetLocalObject(oTarget, "mil_ConversationUser", oPC);

            if (GetIsPC(oTarget))   {
                if (GetLocalInt(oTarget, "mil_Shackled")) {
                    ExecuteScript("mil_consentyes", oTarget);
                } else {
                    SetCustomToken(9800, GetName(oPC));
                    SetCustomToken(9801, GetName(oItem));
                    AssignCommand(oTarget, ActionStartConversation(oTarget, "mil_consent", TRUE));
                }
            }   else    {
                ExecuteScript("mil_consentyes", oTarget);
            }
        }   else    {
            SendMessageToPC(oPC, "You can only use the " + sItemTag + " on creatures.");
        }
    }
}
