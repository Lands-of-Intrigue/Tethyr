//:://////////////////////////////////////////////
//:: Created By:  Manuel Fierlbeck
//:: Created On:  09.12.2014
//:://////////////////////////////////////////////
//::
//:: Version of zep_stocksuse with female voices.
//::
//:://////////////////////////////////////////////

void main()
{
    // play animations; if the model doesn't have any activated / deactivated
    // animations, nothing will happen.
    if (GetLocalInt(OBJECT_SELF, "CEP_L_AMION")) {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        DeleteLocalInt(OBJECT_SELF, "CEP_L_AMION");
    } else {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetLocalInt(OBJECT_SELF, "CEP_L_AMION", 1);
    }

    // play random voice chat
    string sound;
    switch (d6()) {
        case 1: sound = "as_pl_ailingf3"; break;
        case 2: sound = "as_pl_cryingf1"; break;
        case 3: sound = "as_pl_cryingf2"; break;
        case 4: sound = "as_pl_ailingf5"; break;
        case 5: sound = "as_pl_ailingf4"; break;
        default: sound = "as_pl_hangoverf1";
    }
    object user = GetLastUsedBy();
    AssignCommand(user, PlaySound(sound));

    // To start a conversation, uncomment this line and enter the name of
    // the requested dialog between the quotation marks.
    // AssignCommand(OBJECT_SELF, ActionStartConversation(user, "", FALSE, FALSE));
}
