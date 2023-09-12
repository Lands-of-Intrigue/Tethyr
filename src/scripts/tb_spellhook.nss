// tb_spellhoook
// Set this in a string variable "X2_S_UD_SPELLSCRIPT" on the module
//

#include "x2_inc_switches"
#include "tb_inc_spells"

void main() {
    //Determine who is casting this spell..
    object oCaster = OBJECT_SELF;
    int nSpell = GetSpellId();
    object oItem = GetSpellCastItem();
    object oTarget = GetSpellTargetObject();

    // Items do not require components
    if (GetIsObjectValid(oItem)) {
        if (GetIsObjectValid(oTarget) && spellGetIsHealing(nSpell)) {
            // Do something for healing potions etc
        }
        return;
    }

    // Call module defined "spell_hook_pre_script" if present
    string sScript = GetLocalString(GetModule(), "spell_hook_pre_script");
    if (sScript != "") {
        DeleteLocalString(OBJECT_SELF, "spell_hook_message");
        if (ExecuteScriptAndReturnInt(sScript,OBJECT_SELF)) {
            string sMsg = GetLocalString(OBJECT_SELF, "spell_hook_message");
            if (sMsg != "")
                FloatingTextStringOnCreature(sMsg, OBJECT_SELF);
            SetModuleOverrideSpellScriptFinished();
            DeleteLocalString(OBJECT_SELF, "spell_hook_message");
            return;
        }
    }

    // If the component check fails then fail the spell
    // component check will handle any feedback
    spell_debug("Spellhook calling checkComponents", oCaster);
    if (!checkSpellComponents(nSpell, oCaster)) {
	 spell_debug("Spellhook - spell denied", oCaster);
        SetModuleOverrideSpellScriptFinished();
    } else {
	 spell_debug("Spellhook - spell allowed", oCaster);
    }

    if (GetIsObjectValid(oTarget) && spellGetIsHealing(nSpell)) {
        // Do something for healing spells
    }
}
