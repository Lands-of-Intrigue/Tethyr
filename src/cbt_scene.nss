#include "x0_i0_position"
#include "x2_inc_switches"
void main()
{

    // Make sure this is the OnAtivateItem event
    if (GetUserDefinedItemEventNumber() != X2_ITEM_EVENT_ACTIVATE)
        return;
    object oPC=GetItemActivator();
    object oScene=CreateObject(OBJECT_TYPE_PLACEABLE, "sceneofinterest", GetItemActivatedTargetLocation(), TRUE);
    object oListener=CreateObject(OBJECT_TYPE_CREATURE, "cbt_scene", GetItemActivatedTargetLocation(), TRUE);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectInvisibility(INVISIBILITY_TYPE_IMPROVED), oListener);
    SetListening(oListener,TRUE);
    SetLocalString(oListener, "character", GetName(oPC));
    SetListenPattern(oListener, "**", 19781);
    SendMessageToPC(oPC, "Please speak the scene description.");
    SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
}
