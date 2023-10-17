// tb_inc_spells
//
// By Meaglyn  05/21/20013
//
//

/*****************************
   This is the main library for Meaglyn's spell component system.

   This work stands on work by Ribualt and Trickster. Credit for the basic idea and
   most of the component items goes there.

   This is an expanded spell component system which :

   1) Supports up to two required components for a given spell,
   2) Supports material (destoyed on casting) and focus (not usually destroyed on casting) components,
   3) Stacking of misc small and misc thin items (used for components),
   4) Supports Divine Focus components, which means a Divine caster must have his/her holy symbol equipped,
   5) Supports the few spells which cost XP to cast,
   6) Supports either UMD or spell hook method
   7) Supports using a more valuable similar component in place of a missing lesser valued one and using several
      lesser valued components for a greated valued one. This is mostly used for diamond dust which used in 100gp,
      200gp and 500gp quantities.

   The system is based on 2da files so you either need to use the small hak or put the 2da files in
   override. The files are tb_spell_comps.2da and tb_spell_info.2da.  The stacking items is based
   on a change to baseitems.2da. The basic version supplied will not work with other haks which
   modify baseitems.2da. You may safely put the spell hak below the hak containing your modified
   baseitems.2da. You will then need to edit your baseitems.2da to support stacking of miscsmall
   and miscthin items. This is optional. The change is simply to change column 30 value "1" to "10"
   for rows 24 and 79.

   To use the system with spell hook:
         Import the erf.
         Set a string variable names "X2_S_UD_SPELLSCRIPT" on the module to the value "tb_spellhook"
         Add the spell hak to your module or be prepared to provide the 2das for placement in override/

   To use the system
         Import the erf.
         Copy the script zx2_pc_umdcheck to x2_pc_umdcheck (remove the leading z).
         Add the spell hak to your module or be prepared to provide the 2das for placement in override/

    You should then be sure to make components available. There is a stock component merchant in the system
    which sells all the components. This includes a standin holy symbol. You probably want to remove that and
    make Holy Symbols available to Divine casters in some other manner (from the appropriate temple, at first
    cleric level etc). You will want to make the spellbook available to arcane casters and the prayer book
    available to divine casters. These are strictly informational so feel free to copy and edit them as needed.
    (maybe differentiating them by level or whatever).

    Be sure to rebuild you module after adding the system.


    The system can be disabled either by the SPELL_USE_COMPONENTS constant below or
    setting the int variable "NO_SPELL_COMPONENTS" to TRUE (non-zero) on the module.

    Focus component loss: By default Focuse components have a 3% chance per level of the cast spell
    of being destroyed in casting. This is controlled by the SPELL_FOCUS_COMP_LOSS_PERC
    setting below. Making that 0 will prevent Focus component loss as will disabling it with
    the SPELL_FOCUS_COMP_LOSS constant. Divine Focus (holy symbol) components are not subject
    to random focus component loss.

    Debug: Enable or disable the debug statements with the SPELL_DEBUG constant. You may want to
    comment the calls the spell_debug out for production use. The debug calls are not generally
    multiplayer friendly (they use GetFirstPC()).

    Holy Symbols: The system can integrate with pantheon systems which have unique holy symbol items for
    different divine casters. This is enabled in two ways. The pantheon system can arrange to set a
    variable (defined in SPELL_HOLYSYMBOL_TAG_VAR) on the PC which contains the tag of the PC's holy
    symbol item. You may also set SPELL_HOLYSYMBOL_NAME_VAR to a string which is used in place
    of "Your Holy Symbol" in "Your Holy Symbol must be equipped...".

    In addition if this is not set the system will try to execute the script defined as a variable
    on the module (name as defined in this constant: SPELL_GET_HOLYSYMBOL_SCRIPT). The script is
    executed as the PC. It should arrange to set the SPELL_HOLYSYMBOL_TAG_VAR variable appropriately
    before it completes. It can also set SPELL_HOLYSYMBOL_NAME_VAR.

    Holy symbols must be equippable items in either hand or neck slots.
    The Holy Symbol check can be globally disabled by setting  SPELL_USE_HOLYSYMBOLS to FALSE.


    Domains: domains grant divine spell casters spells from the arcane list which normally have arcane based
    components. This system takes the approach that those spells are just the same effect but are still divine
    cast spells. All such spells that do not have a divine spell counterpart, that is all the "arcane -only"
    domain granted spells required holy symbol instead of the listed material components. This is also done
    for the druid and ranger spells like cat's grace and stoneskin which do not have divine spell listings.


    The included tb_spellhook script includes a hooking mechanism itself. The module string variable
    "spell_hook_pre_script" can be set to a script name. This will be executed as the caster before the spell
    component check. The script should use SetExecutedScriptReturnValue and set a value of X2_EXECUTE_SCRIPT_END
    to fail the spell or X2_EXECUTE_SCRIPT_CONTINUE to proceed to the next checks. The script may also optionally
    set a string "spell_hook_message" on the caller which will be displayed as floating text on the creature if
    the return value is  X2_EXECUTE_SCRIPT_END.


 */
#include "x2_inc_switches"
#include "nw_i0_spells"


// These may be changed as needed
const int SPELL_USE_COMPONENTS       = TRUE;
const int SPELL_USE_HOLYSYMBOLS      = TRUE;
const int SPELL_FOCUS_COMP_LOSS      = TRUE;
const int SPELL_FOCUS_COMP_LOSS_PERC = 3;
const int SPELL_DEBUG = FALSE;
const string SPELL_HOLYSYMBOL_TAG_VAR = "sp_holy_symbol_tag";
const string SPELL_HOLYSYMBOL_NAME_VAR = "sp_holy_symbol_name";
const string SPELL_GET_HOLYSYMBOL_SCRIPT = "sp_holy_symbol_script";


// no need to set DF to focus it's implied.
const int SPELL_COMP_TYPE_MATERIAL           = 0;
const int SPELL_COMP_TYPE_FOCUS              = 1;
const int SPELL_COMP_TYPE_XP                 = 2;

// this one is never used in a 2da lookup
const int SPELL_COMP_XP               = -1;
// Note these are 2da lines (tb_spell_comps) so the have to be correct...
const int SPELL_COMP_NONE             = 0;
const int SPELL_COMP_DIVINE_FOCUS     = 1;
const int SPELL_COMP_TINYARCHTARG     = 2;
const int SPELL_COMP_TINYBAGANDCANDLE = 3;
const int SPELL_COMP_BLACK_ONYX_5     = 4;
const int SPELL_COMP_BLACK_ONYX_10    = 5;
const int SPELL_COMP_BLACK_ONYX_15    = 6;
const int SPELL_COMP_BLACKPEARLPOWDER = 7;
const int SPELL_COMP_BLOOD            = 8;
const int SPELL_COMP_BULL_HAIR        = 9;
const int SPELL_COMP_CAT_FUR          = 10;
const int SPELL_COMP_CHAOTICRELIQ     = 11;
const int SPELL_COMP_EMPTY_COCOON     = 12;
const int SPELL_COMP_MULTICOLOREDSAND = 13;
const int SPELL_COMP_CRYSTAL_BEAD     = 14;
const int SPELL_COMP_CRYSTAL_CONE     = 15;
const int SPELL_COMP_CURED_LEATHER    = 16;
const int SPELL_COMP_DART             = 17;
const int SPELL_COMP_DIAMOND_DUST_5   = 18;
const int SPELL_COMP_DIAMOND_DUST_2   = 19;
const int SPELL_COMP_DIAMOND_DUST     = 20;
const int SPELL_COMP_DUST             = 21;
const int SPELL_COMP_EAGLE_FEATHERS   = 22;
const int SPELL_COMP_EARTH            = 23;
const int SPELL_COMP_EGG_SHELL        = 24;
const int SPELL_COMP_EYELASH_IN_GUM   = 25;
const int SPELL_COMP_EYE_OINTMENT     = 26;
const int SPELL_COMP_FOX_HAIRS        = 27;
const int SPELL_COMP_FURANDCRYSTALROD = 28;
const int SPELL_COMP_DIAMOND_5k       = 29;
const int SPELL_COMP_DIAMOND_10k      = 30;
const int SPELL_COMP_FIREAGATE        = 31;
const int SPELL_COMP_GRANITE_DUST     = 32;
const int SPELL_COMP_GRAVEYARD_DIRT   = 33;
const int SPELL_COMP_GUANO            = 34;
const int SPELL_COMP_HOLY_PARCHMENT   = 35;
const int SPELL_COMP_HOLY_RELIQUARY   = 36;
const int SPELL_COMP_INCENSE          = 37;
const int SPELL_COMP_IVORYSTRIPS      = 38;
const int SPELL_COMP_PIECE_OF_IRON    = 39;
const int SPELL_COMP_JADE_CIRCLET     = 40;
const int SPELL_COMP_LAWFUL_RELIQUARY = 41;
const int SPELL_COMP_LICORICE_ROOT    = 42;
const int SPELL_COMP_LIME_WATER       = 43;
const int SPELL_COMP_LEATHER_GLOVE    = 44;
const int SPELL_COMP_LEATHER_THONG    = 45;
const int SPELL_COMP_LUMP_OF_COAL     = 46;
const int SPELL_COMP_METAL_BAR        = 47;
const int SPELL_COMP_MINIATURE_CLOAK  = 48;
const int SPELL_COMP_MINERAL_SPHERES  = 49;
const int SPELL_COMP_DROP_MOLASSES    = 50;
const int SPELL_COMP_NUT_SHELLS       = 51;
const int SPELL_COMP_OILY_FLINT       = 52;
const int SPELL_COMP_OWL_FEATHERS     = 53;
const int SPELL_COMP_PEARL_DUST       = 54;
const int SPELL_COMP_PEAS_AND_HOOF    = 55;
const int SPELL_COMP_PHOSPHOR_MOSS    = 56;
const int SPELL_COMP_PHOSPHORUS       = 57;
const int SPELL_COMP_TINYPLATINUMSWORD= 58;
const int SPELL_COMP_PORKRIND         = 59;
const int SPELL_COMP_POWDERED_CRYSTAL = 60;
const int SPELL_COMP_RHUBARB_ADDER    = 61;
const int SPELL_COMP_POWDERED_SILVER  = 62;
const int SPELL_COMP_ROSE_PETALS      = 63;
const int SPELL_COMP_ROTTEN_EGG       = 64;
const int SPELL_COMP_RUBY_DUST        = 65;
const int SPELL_COMP_SILVERHOLYSYMBOL = 66;
const int SPELL_COMP_SILVER_PINS      = 67;
const int SPELL_COMP_SMALL_HORN       = 68;
const int SPELL_COMP_SPIDER_WEB       = 69;
const int SPELL_COMP_BIT_OF_SPONGE    = 70;
const int SPELL_COMP_SULFUR           = 71;
const int SPELL_COMP_SUNSTONE         = 72;
const int SPELL_COMP_TALC             = 73;
const int SPELL_COMP_TARTS_AND_FEATHER= 74;
const int SPELL_COMP_TENTACLE         = 75;
const int SPELL_COMP_UNHOLY_RELIQ     = 76;
const int SPELL_COMP_WHITE_FEATHER    = 77;
const int SPELL_COMP_WOOL             = 78;
const int SPELL_COMP_BIT_OF_BONE      = 79;
const int SPELL_COMP_POT_BULLSTR      = 80;
const int SPELL_COMP_HORSE_HAIR       = 81;
const int SPELL_COMP_CERAMIC_CONE     = 82;
const int SPELL_COMP_PIECEOFSHELL     = 83;
const int SPELL_COMP_OBSIDIAN         = 84;
const int SPELL_COMP_TETHIRSHADEALE   = 85;
const int SPELL_COMP_BLACKRIBBONS     = 86;
const int SPELL_COMP_LODESTONE        = 87;
const int SPELL_COMP_VIALOFTEARS      = 88;
const int SPELL_COMP_SMALLDRUM        = 89;
const int SPELL_COMP_REDDRAGONSCALE   = 90;
const int SPELL_COMP_PRAYERBOOK       = 91;



//----------------------------------
// Entry point prototypes
//
// This is the main entry point for spell hook or UMD code to check the given spell for component use.
// It returns TRUE if the caster can cast the spell (either because there is no component needed or
// caster satisfies all component requirements). If returning TRUE and there are components the components are
// consumed. If returning FALSE the spell should be failed. Feedback is provided as to why the spell was disallowed.
int checkSpellComponents(int nSpellID, object oCaster);

// Returns true if the spell is considered a healing spell.
int spellGetIsHealing(int nSpellID);

// This can be called from the module load routine.
// It checks if the 2da files are present and if not it
// disables spell components and logs a message to that effect.
void spellCheck2das();

//---------------------------------------
// Mostly internal functions

// get the spell component information from the 2da file for the given spell.
// bArcane should be TRUE if the spell is arcane.
// On return if stRet.nComp1 ==  SPELL_COMP_NONE then no component is required.
struct spell_st spellGetSpellComponents(int nSpellID, int bArcane = TRUE);

// Returns true if nClass is an arcane spell user
// Only valid spell casting classes should be here...
int spellCasterArcane(int nClass);

// This tries to figure out the caster's deity and get the
// correct holy symbol tag. It returns "HolySymbol" if nothing
// else is found.
string spellGetHolySymbolTag(object oCaster);


// 2da routines
// Get a string to use in no-component messages. Includes the component's article
// if any. This is mostly a cosmetic routine.
// oCaster is used to find deity specific holy symbol names
string spellGetCompName(object oCaster, int nCompID, int bLower = FALSE);

int spellGetCompPlural(int nCompID);
string spellGetCompTag(int nCompID);

// Get the basic level of a cast spell. Used for random focus component loss check.
int spellGetInnateLevel(int nSpellID);

//This checks to see if the spell being cast is NOT Hostile...
int GetIsNonHostileSpell(int nSpell);

//---------------------------------------


// This can be controlled here or comment out the calls.
void spell_debug(string sMsg, object oPC = OBJECT_INVALID) {
    if (!SPELL_DEBUG) return;

    if (!GetIsObjectValid(oPC))
        oPC = GetFirstPC();

    SendMessageToPC(oPC, sMsg);
}


struct spell_st {
    int nComp1;
    int nType1;
    int nNumVal1;
    int nComp2;
    int nType2;
};

struct spell_comp_st {
    object oComp;
    string sComp;
    int nNum;
};

// get the spell component information from the 2da file for the given spell.
// bArcane should be TRUE if the spell is arcane.
// On return if stRet.nComp1 ==  SPELL_COMP_NONE then no component is required.
struct spell_st spellGetSpellComponents(int nSpellID, int bArcane = TRUE) {

    struct spell_st stRet;
    stRet.nComp1 = SPELL_COMP_NONE;
    stRet.nComp2 = SPELL_COMP_NONE;
    stRet.nType1 = SPELL_COMP_TYPE_MATERIAL;
    stRet.nType2 = SPELL_COMP_TYPE_MATERIAL;
    stRet.nNumVal1 = 0;

    // For now just a switch - ideally a 2da lookup or 2...
    if (bArcane) {
        string sTmp = Get2DAString("tb_spell_info", "aComp1", nSpellID);
        // no arcane component
        spell_debug("Comp1 check for " + IntToString(nSpellID) + " got (" + sTmp + ") from 2da");
        if (sTmp == "")
            return stRet;

        stRet.nComp1 = StringToInt(sTmp);
        sTmp = Get2DAString("tb_spell_info", "aType1", nSpellID);
        if (sTmp == "F")
            stRet.nType1 = SPELL_COMP_TYPE_FOCUS;
    else if (sTmp == "X") {
        stRet.nType1 = SPELL_COMP_TYPE_XP;
        stRet.nComp1 = SPELL_COMP_XP;
    }

        // Check for a second component
        sTmp = Get2DAString("tb_spell_info", "aComp2", nSpellID);
        if (sTmp != "") {
              stRet.nComp2 = StringToInt(sTmp);
              sTmp = Get2DAString("tb_spell_info", "aType2", nSpellID);
              if (sTmp == "F")
              stRet.nType2 = SPELL_COMP_TYPE_FOCUS;
          else if (sTmp == "X") {
              stRet.nType2 = SPELL_COMP_TYPE_XP;
              stRet.nComp2 = SPELL_COMP_XP;
          }

        }
        // Get the number or value field.
        stRet.nNumVal1 = StringToInt( Get2DAString("tb_spell_info", "aNumVal1", nSpellID));

        return stRet;
    }

    // divine cast spells
    // Domain spells that are normally on the arcane lists are given DF in this system.
    string sTmp = Get2DAString("tb_spell_info", "dComp1", nSpellID);
    // no component
    if (sTmp == "")
        return stRet;

    stRet.nComp1 = StringToInt(sTmp);
    sTmp = Get2DAString("tb_spell_info", "dType1", nSpellID);
    if (sTmp == "F")
        stRet.nType1 = SPELL_COMP_TYPE_FOCUS;
    else if (sTmp == "X") {
        stRet.nType1 = SPELL_COMP_TYPE_XP;
        stRet.nComp1 = SPELL_COMP_XP;
    }

    // Check for a second component
    sTmp = Get2DAString("tb_spell_info", "dComp2", nSpellID);
    if (sTmp != "") {
        stRet.nComp2 = StringToInt(sTmp);
        sTmp = Get2DAString("tb_spell_info", "dType2", nSpellID);
        if (sTmp == "F")
            stRet.nType2 = SPELL_COMP_TYPE_FOCUS;
    else if (sTmp == "X") {
        stRet.nType2 = SPELL_COMP_TYPE_XP;
        stRet.nComp2 = SPELL_COMP_XP;
    }

    }
    // Get the number or value field.
    // Uses the same column as arcane. It applies to the first component if not DIVINE FOCUS, then the second
    // For XP type components this will be the XP cost.
    stRet.nNumVal1 = StringToInt( Get2DAString("tb_spell_info", "aNumVal1", nSpellID));

    return stRet;
}


// Only valid spell casting classes should be here...
int spellCasterArcane(int nClass) {

    //arcane = bard, wizard, sorcerer
    if (nClass == CLASS_TYPE_BARD           ||
        nClass == CLASS_TYPE_WIZARD         ||
        nClass == CLASS_TYPE_SORCERER       ||
        nClass == CLASS_TYPE_ARCANE_ARCHER  ||
        nClass == CLASS_TYPE_ASSASSIN       ||
        nClass == CLASS_TYPE_HARPER         ||
        nClass == CLASS_TYPE_PALEMASTER)
        return TRUE;

    // divine = cleric, druid, paladin, ranger
    return FALSE;
}


// This tries to figure out the caster's deity and get the
// correct holy symbol tag. It returns "HolySymbol" if nothing
// else is found.
string spellGetHolySymbolTag(object oCaster) {

    // Try to find a custom tag
    string sTag = GetLocalString(oCaster,SPELL_HOLYSYMBOL_TAG_VAR);
    if (sTag != "")
        return sTag;

    // If not and there is a script run that and try again
    string sScript = GetLocalString(GetModule(), SPELL_GET_HOLYSYMBOL_SCRIPT);
    if (sScript != "") {
        ExecuteScript(sScript, oCaster);
        sTag = GetLocalString(oCaster, SPELL_HOLYSYMBOL_TAG_VAR);
        if (sTag != "")
            return sTag;
    }

    if(GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oCaster)) == "te_cleric_equip")
    {
        return "te_cleric_equip";
    }
    else if(GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oCaster)) == "te_elvenpan")
    {
        return "te_elvenpan";
    }
    else if(GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oCaster)) == "te_dwarvenpan")
    {
        return "te_dwarvenpan";
    }
    else if(GetTag(GetItemInSlot(INVENTORY_SLOT_ARMS,oCaster)) == "te_cleric_equip")
    {
        return "te_cleric_equip";
    }
    else
    {
        return "HolySymbol";
    }

    // otherwise return the default.
    return "HolySymbol";
}


int spellGetCompPlural(int nCompID) {
    string sRet = Get2DAString("tb_spell_comps","Plural",nCompID);
    if (sRet == "1")
        return TRUE;
    return FALSE;
}

string spellGetCompTag(int nCompID) {
    string sRet = Get2DAString("tb_spell_comps","CompTag",nCompID);
    return sRet;
}

// Get a string to use in no-component messages. Includes the component's article
// if any. This is mostly a cosmetic routine.
string spellGetCompName(object oCaster, int nCompID, int bLower = FALSE) {

    // Check for a specific string from an external system
    if (nCompID == SPELL_COMP_DIVINE_FOCUS) {
        string sName =  GetLocalString(oCaster, SPELL_HOLYSYMBOL_NAME_VAR);
        if (sName != "")
            return sName;

        string sScript = GetLocalString(GetModule(), SPELL_GET_HOLYSYMBOL_SCRIPT);
        if (sScript != "") {
            ExecuteScript(sScript, oCaster);
            sName = GetLocalString(oCaster, SPELL_HOLYSYMBOL_NAME_VAR);
            if (sName != "")
                return sName;
        }
    }


    string sRet = Get2DAString("tb_spell_comps","Name",nCompID);
    string sArt = Get2DAString("tb_spell_comps","Article",nCompID);

    if (sRet == "")
        return "a component";

    if (sArt != "") {
        if (bLower)
            return GetStringLowerCase(sArt) + " " + sRet;
        else
            return sArt + " " + sRet;
    }
    else
        return sRet;

}


// This can be called from the module load routine.
// It checks if the 2da files are present and if not it
// disables spell components and logs a message to that effect.
void spellCheck2das() {
     struct spell_st info = spellGetSpellComponents(SPELL_AID, FALSE);
     if (info.nComp1 != SPELL_COMP_DIVINE_FOCUS) {
        string sMsg = "Unable to locate spell component 2da files - components disabled.";
        SendMessageToPC(GetFirstPC(), sMsg);
        WriteTimestampedLogEntry(sMsg);
        SetLocalInt(GetModule(), "NO_SPELL_COMPONENTS", 1);
     }
     spell_debug("Found Spell 2da files.");
}


// ------- these next three are in TB_INC_UTIL but are here to
// keep the spell system independent of other libraries.
// returns the number of items with the given tag carried by oCreature
// counting stacked items as 1 unless bStack is TRUE.
int GetNumItemsByTag(object oCreature, string sTag, int bStack = FALSE) {
    int nCount = 0;
    int i;

    object oItem = GetFirstItemInInventory(oCreature);
    while (GetIsObjectValid(oItem)) {
        if (sTag == GetTag(oItem)) {
            if (bStack)
                nCount += GetItemStackSize(oItem);
            else
                nCount ++;
        }

        oItem = GetNextItemInInventory(oCreature);
    }

    // Count equipped items too
    for (i = 0; i < NUM_INVENTORY_SLOTS; ++i) {
        oItem = GetItemInSlot(i, oCreature);
        if (GetIsObjectValid(oItem)
        && (GetTag(oItem) == sTag)) {
             if (bStack)
                nCount += GetItemStackSize(oItem);
            else
                nCount ++;
        }
    }

   return nCount;
}

// destroy nNum of sTag item in oTarget's inventory.
// This will start with unequipped inventory and then look in equipped items.
// It will handle stacked items.
// Return value is the number of item in nNum it did not remove.
// So a return of 0 is expected when all required items were found.
int DestroyNumItems(object oTarget, string sTag, int nNum = 1) {
    object oItem = GetFirstItemInInventory(oTarget);
        while (GetIsObjectValid(oItem) && nNum > 0) {

        if (GetTag(oItem) == sTag) {
            int nCurStack = GetItemStackSize(oItem);
            if (nCurStack > nNum) {
                SetItemStackSize(oItem, nCurStack - nNum);
                return 0; // we're done.
            }
            // stack is <= nNum take them all and adjust nNum.
            DestroyObject(oItem);
            nNum -= nCurStack;
        }
        oItem = GetNextItemInInventory(oTarget);
        }

    if (nNum == 0) return 0;


    // check the equipment slots for the item
    int x;
    for (x = 0; x < NUM_INVENTORY_SLOTS; x++) {
        oItem = GetItemInSlot(x, oTarget);
        if (GetIsObjectValid(oItem)
            && (GetTag(oItem) == sTag)) {
            int nCurStack = GetItemStackSize(oItem);
            if (nCurStack > nNum) {
                SetItemStackSize(oItem, nCurStack - nNum);
                return 0; // we're done.
            }
            DestroyObject(oItem);
            nNum -= nCurStack;
            if (nNum == 0)
                return 0;
        }
    }

    return nNum;
}

int GetIdentifiedValue(object oItem) {
    int bIdentified = GetIdentified(oItem);

    // If not already, set to identfied
    if (!bIdentified)
        SetIdentified(oItem, TRUE);
    int nGP=GetGoldPieceValue(oItem);

    // Re-set the identification flag to its original
    SetIdentified(oItem, bIdentified);

    return nGP;
}
//----------------------

// Returns true if the spell is considered a healing spell.
int spellGetIsHealing(int nSpellID) {
    switch (nSpellID) {
    case SPELL_CURE_CRITICAL_WOUNDS:
    case SPELL_CURE_LIGHT_WOUNDS:
    case SPELL_CURE_MINOR_WOUNDS:
    case SPELL_CURE_MODERATE_WOUNDS:
    case SPELL_CURE_SERIOUS_WOUNDS:
    case SPELL_HEAL:
    case SPELL_HEALING_CIRCLE: // this one won't work right as it's AOE
    case SPELL_MASS_HEAL:     // this one won't work right as it's AOE
    case SPELL_NATURES_BALANCE: //  this one won't work right as it's AOE
    case SPELL_AURAOFGLORY: //  this one won't work right as it's AOE
        return TRUE;
    }

    return FALSE;
}

// Return TRUE if oCaster can afford to lose nXP without de-leveling
int spellCheckXP(object oCaster, int nXP) {

    int nCurXP = GetXP(oCaster);
    int nHitDice = GetHitDice(oCaster);
    int nLevel = 500*nHitDice*(nHitDice - 1);

    if ((nCurXP - nLevel) >= nXP)
        return TRUE;

        return FALSE;
}

// Take the given number of XPs from the caster.
// Assumes spellCheckXP has passed.
void spellTakeXP(object oCaster, int nXP) {
    int nCurXP = GetXP(oCaster);
    SetXP(oCaster, nCurXP - nXP);
}

// Get the basic level of a cast spell. Used for random focus component loss check.
int spellGetInnateLevel(int nSpellID) {
    return StringToInt(Get2DAString("spells", "Innate", nSpellID));
}

// Non divine focus components may be destroyed on casting.
// By default there is a 3% chance per innate spell level of this happening.
void spellCheckDestroyFocus(int nSpellID, object oItem, object oCaster) {

    if (!SPELL_FOCUS_COMP_LOSS)
        return;

    int nLev = spellGetInnateLevel(nSpellID);

    nLev *= SPELL_FOCUS_COMP_LOSS_PERC;

    spell_debug("Checking for focus item loss " + GetName(oItem) + " chance = " + IntToString(nLev), oCaster);
    if (Random(100) < nLev) {
        FloatingTextStringOnCreature("The magical energies of the spell destroyed your " + GetName(oItem) + "!" , oCaster);
        DestroyObject(oItem);
    }
}


// Some components can be substituted for others.
int spellCompHasAlt(int nComp) {
    if (nComp == SPELL_COMP_BLACK_ONYX_5
        || nComp == SPELL_COMP_BLACK_ONYX_10
        || nComp == SPELL_COMP_DIAMOND_DUST
        || nComp == SPELL_COMP_DIAMOND_DUST_2
        || nComp == SPELL_COMP_DIAMOND_DUST_5
        || SPELL_COMP_DIAMOND_5k
        || SPELL_COMP_DIAMOND_10k
        ) {
        spell_debug("SpellcompHasAlt returns true for " + IntToString(nComp));
        return TRUE;
    }
    return FALSE;
}


// This gets any alternate component and sets the number, object and tag
// In the case that number is > 1 the object is just one (possibly stacked)
// copy of the object. It's filled in to be sure later code finds a valid object here.
struct spell_comp_st spellGetAlternateComponent(object oCaster, int nComp) {
    struct spell_comp_st stRet;
    stRet.nNum = 1;
    string sTag;

    if (nComp == SPELL_COMP_DIAMOND_DUST) {
        stRet.sComp = spellGetCompTag( SPELL_COMP_DIAMOND_DUST_2);
        stRet.oComp = GetItemPossessedBy(oCaster, stRet.sComp);
        if (GetIsObjectValid(stRet.oComp)) {
            return stRet;
        }
        stRet.sComp = spellGetCompTag( SPELL_COMP_DIAMOND_DUST_5);
        stRet.oComp = GetItemPossessedBy(oCaster, stRet.sComp);

        // just return it. If invalid then no component was found.
        return stRet;
    }
    if (nComp == SPELL_COMP_DIAMOND_DUST_2) {
        // Check for 2x100gp
        stRet.sComp = spellGetCompTag(SPELL_COMP_DIAMOND_DUST);
        stRet.nNum = 2;
        int nNum =  GetNumItemsByTag(oCaster, stRet.sComp, TRUE);
        if (nNum >= stRet.nNum ) {
            stRet.oComp = GetItemPossessedBy(oCaster, stRet.sComp);
            if (!GetIsObjectValid(stRet.oComp))
            spell_debug("Object invalid should not happen here", oCaster);
            return stRet;
        }
        // or 1x 500gp diamond dusts
        stRet.sComp = spellGetCompTag( SPELL_COMP_DIAMOND_DUST_5);
        stRet.oComp = GetItemPossessedBy(oCaster, stRet.sComp);
        stRet.nNum = 1;
        // just return it. If invalid then no component was found.
        return stRet;
    }
    if (nComp == SPELL_COMP_DIAMOND_DUST_5) {
        // Check for 5x100gp
        stRet.sComp = spellGetCompTag(SPELL_COMP_DIAMOND_DUST);
        stRet.nNum = 5;
        int nNum =  GetNumItemsByTag(oCaster, stRet.sComp, TRUE);
        if (nNum >= stRet.nNum ) {
            stRet.oComp = GetItemPossessedBy(oCaster, stRet.sComp);
            return stRet;
        }
        // or 3x 200gp diamond dusts
        stRet.sComp = spellGetCompTag(SPELL_COMP_DIAMOND_DUST_2);
        stRet.nNum = 3;
        nNum =  GetNumItemsByTag(oCaster, stRet.sComp, TRUE);
        if (nNum >= stRet.nNum ) {
            stRet.oComp = GetItemPossessedBy(oCaster, stRet.sComp);
            return stRet;
        }
        // just return it. If invalid then no component was found.
        return stRet;
    }

    // Other alternate cases
    if (nComp == SPELL_COMP_BLACK_ONYX_5) {
        stRet.sComp = spellGetCompTag(SPELL_COMP_BLACK_ONYX_15);
        stRet.oComp = GetItemPossessedBy(oCaster, stRet.sComp);
        // just return it. If invalid then no component was found.
        return stRet;
    }
    if (nComp == SPELL_COMP_BLACK_ONYX_10) {
        stRet.sComp = spellGetCompTag(SPELL_COMP_BLACK_ONYX_5);
        stRet.oComp = GetItemPossessedBy(oCaster, stRet.sComp);
        if (GetIsObjectValid(stRet.oComp)) {
            return stRet;
        }
        stRet.sComp = spellGetCompTag(SPELL_COMP_BLACK_ONYX_15);
        stRet.oComp = GetItemPossessedBy(oCaster, stRet.sComp);
        // just return it. If invalid then no component was found.
        return stRet;
    }

    if (nComp == SPELL_COMP_DIAMOND_5k) {
        stRet.sComp = spellGetCompTag(SPELL_COMP_DIAMOND_10k);
        stRet.oComp = GetItemPossessedBy(oCaster, stRet.sComp);
        // just return it. If invalid then no component was found.
        return stRet;
    }

    /* This code would allow the use of 2 5000gp diamonds for resurrection
    if (nComp == SPELL_COMP_DIAMOND_10k) {
        stRet.sComp = spellGetCompTag(SPELL_COMP_DIAMOND_5k);
        stRet.nNum = 2;
        int nNum =  GetNumItemsByTag(oCaster, stRet.sComp);
        if (nNum >=     stRet.nNum ) {
            stRet.oComp = GetItemPossessedBy(oCaster, stRet.sComp);
            // just return it. If invalid then no component was found.
            return stRet;
        }
    }
    */

    return stRet;
}

string spellGetNoXPString(object oCaster, int nComp1, int nComp2) {
    if (nComp2 == SPELL_COMP_NONE) {
        return "This spell requires more of your life energy than you can spare at this time...";
    }
    // TODO - this should be different if failing due to XP versus no comp1.
    return "This spell requires " +  spellGetCompName(oCaster, nComp1) + " and an expediture of your life energy...";
}


// This returns a string to display when the components are not satisfied.
//
string spellGetNoCompString(object oCaster, int nComp1, int nComp2 = SPELL_COMP_NONE) {
    if (nComp1 ==  SPELL_COMP_NONE) return "";


    if (nComp1 == SPELL_COMP_XP || nComp2 == SPELL_COMP_XP)
        return spellGetNoXPString(oCaster, nComp1, nComp2);

    if (nComp2 == SPELL_COMP_NONE) {
        int nPlural = spellGetCompPlural(nComp1);
        if (nPlural)
        return spellGetCompName(oCaster, nComp1) + " are required to cast this spell!";
        else
        return spellGetCompName(oCaster, nComp1) + " is required to cast this spell!";
    }

    return spellGetCompName(oCaster, nComp1) + " and "
        + spellGetCompName(oCaster, nComp2, TRUE) + " are required to cast this spell!";
}


// This get the tag, number and first copy of the required object.
struct spell_comp_st spellGetUsableComp(object oCaster, int nComp, int nVal) {
    struct spell_comp_st stRet;
    stRet.nNum = 1;

    // Handle Divine focus
    if (nComp == SPELL_COMP_DIVINE_FOCUS) {
        if (SPELL_USE_HOLYSYMBOLS) {
            stRet.sComp = spellGetHolySymbolTag(oCaster);
            spell_debug("Got divine focus spell tag = " + stRet.sComp, oCaster);
            stRet.oComp = GetItemPossessedBy(oCaster, stRet.sComp);
        } else {
         stRet.sComp = "HolySymbol";
         spell_debug("Got divine focus spell Disabled tag = " + stRet.sComp, oCaster);
         stRet.oComp = oCaster; // this is just to ensure the return object is valid when holy symbols are disabled.
        }
        return stRet;
    }
    if (nComp == SPELL_COMP_XP) {
        stRet.nNum = nVal;
        if (spellCheckXP(oCaster, nVal)) {
            stRet.oComp = oCaster;
            return stRet;
        }
        stRet.oComp = OBJECT_INVALID;
        return stRet;

    }

    stRet.sComp = spellGetCompTag(nComp);
    spell_debug("Comp1 tag ==  (" + stRet.sComp + ")", oCaster);
    stRet.oComp = GetItemPossessedBy(oCaster, stRet.sComp);

    // check for an alternate component
    if (!GetIsObjectValid(stRet.oComp) && spellCompHasAlt(nComp)) {
        spell_debug("Not found with original tag checking alternate", oCaster);
        return spellGetAlternateComponent(oCaster, nComp);
    }
    return stRet;
}


// Consume the given component or use the focus object.
void spellUseComponent(object oCaster, struct spell_comp_st st, int nSpellID, int nType) {
    if (nType == SPELL_COMP_TYPE_FOCUS) {
        spellCheckDestroyFocus(nSpellID, st.oComp, oCaster);
    }
    else if (nType == SPELL_COMP_TYPE_XP) {
        spellTakeXP(oCaster, st.nNum);
    }
    else if (nType == SPELL_COMP_TYPE_MATERIAL) {
        DestroyNumItems(oCaster, st.sComp, st.nNum);
    } else
        spell_debug("Error - unknown spell component type " + IntToString(nType));
}

void spellDumpInfo(object oCaster, struct spell_st spellInfo, int nSpellID) {

    spell_debug("Got Comp " + spellGetCompName(oCaster, spellInfo.nComp1) + " for spell "
            + Get2DAString("spells", "Label", nSpellID));
    spell_debug("comp1 = " + IntToString(spellInfo.nComp1) + " type 1 = " +   IntToString(spellInfo.nType1));
    spell_debug("comp2 = " + IntToString(spellInfo.nComp2) + " type 2 = " +   IntToString(spellInfo.nType2));
    spell_debug("nNumVal = " + IntToString(spellInfo.nNumVal1));
}

// This is the main entry point for spell hook or UMD code to check the given spell for component use.
// It returns TRUE if the caster can cast the spell (either because there is no component needed or
// caster satisfies all component requirements). If returning TRUE and there are components the components are
// consumed. If returning FALSE the spell should be failed. Feedback is provided as to why the spell was disallowed.
int checkSpellComponents(int nSpellID, object oCaster) {

        //not a PC
    if(!GetIsPC(oCaster)) {
        return TRUE;
    }

    // is a DM?
    if(GetIsDM(oCaster)) {
        return TRUE;
    }

    // Check if components disabled
    if ((!SPELL_USE_COMPONENTS) || GetLocalInt(GetModule(), "NO_SPELL_COMPONENTS")){
        spell_debug("checkSpellComps component check disabled.");
        return TRUE;
    }

    int nClass = GetLastSpellCastClass();
    int nCastLevel = GetCasterLevel(OBJECT_SELF);

    // Cantrips never need components
    if (SFGetInnateSpellLevelByClass(nSpellID, nClass) == 0)
    {
        return TRUE;
    }

    //int nNonHostile = GetIsNonHostileSpell(nSpell);
    //object sTarget = GetSpellTargetObject();
    //object oArea = GetArea(oCaster);
    struct spell_st spellInfo = spellGetSpellComponents(nSpellID, spellCasterArcane(nClass));
    spellDumpInfo(oCaster, spellInfo, nSpellID);

    if (spellInfo.nComp1 ==  SPELL_COMP_NONE) {
        spell_debug("Got no component needed - allowing spell");
        return TRUE;

    }

    struct spell_comp_st st = spellGetUsableComp(oCaster, spellInfo.nComp1, spellInfo.nNumVal1);
    if (!GetIsObjectValid(st.oComp)) {
        FloatingTextStringOnCreature(spellGetNoCompString(oCaster, spellInfo.nComp1, spellInfo.nComp2), oCaster);
        return FALSE;
    }

    // Make sure the DF is equipped - DF is always first component listed.
    // TODO  This assumes all holy symbols are tag based - could add check here for localvars if needed.
    if (spellInfo.nComp1 == SPELL_COMP_DIVINE_FOCUS && SPELL_USE_HOLYSYMBOLS) {
        if ((GetTag(GetItemInSlot(INVENTORY_SLOT_NECK, oCaster)) != st.sComp)
            &&  (GetTag(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCaster)) != st.sComp)
            &&  (GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCaster)) != st.sComp)) {
            FloatingTextStringOnCreature("Your Holy Symbol must be equipped to cast this spell!", oCaster);
            return FALSE;
        }
    }

    // More checks here - the right number and value of item etc.
    spell_debug("Got comp " + GetName(st.oComp) + " Value = " + IntToString(GetIdentifiedValue(st.oComp)));
    // Now check for and take any second components
    if (spellInfo.nComp2 != SPELL_COMP_NONE) {
        spell_debug("Got Comp " + spellGetCompName(oCaster, spellInfo.nComp2) + " for spell "
                + Get2DAString("spells", "Label", nSpellID));

        struct spell_comp_st st2 = spellGetUsableComp(oCaster, spellInfo.nComp2, spellInfo.nNumVal1);
        if (!GetIsObjectValid(st2.oComp)) {
        FloatingTextStringOnCreature(spellGetNoCompString(oCaster, spellInfo.nComp1, spellInfo.nComp2), oCaster);
            return FALSE;
        }

        // we get here we are going to return TRUE so destroy comp2 directly if needed
        // Comp2 is never DF
        spellUseComponent(oCaster, st2, nSpellID, spellInfo.nType2);
    }


    // Here we have handled any second component so...
    if (spellInfo.nComp1 != SPELL_COMP_DIVINE_FOCUS) {
        spellUseComponent(oCaster, st, nSpellID, spellInfo.nType1);
    }

    //  we had the components -
    return TRUE;
}


//This checks to see if the spell being cast is NOT Hostile...
int GetIsNonHostileSpell(int nSpell) {
    return !StringToInt(Get2DAString("spells","HostileSetting",nSpell));
}
