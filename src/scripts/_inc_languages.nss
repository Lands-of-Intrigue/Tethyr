//::///////////////////////////////////////////////
//:: _inc_languages
//:://////////////////////////////////////////////
/*
    essential constants and functions for languages used in PW

    Custom Script Systems incorporated:
    (Dungeon Master Friendly Initiative (DMFI)  -- this include extends DMFI)

*/
//:://////////////////////////////////////////////
//:: Created: henesua (2015 dec 31)
//:: Modified:
//:://////////////////////////////////////////////

#include "x0_i0_match"

#include "dmfi_string_inc"

#include "te_functions"

// CONSTANTS -------------------------------------------------------------------

const int LANG_FIRST        = 1;
const int LANG_SYLVAN       = 1; // Sylvan
const int LANG_GNOME        = 2; // Gnim - Gnomish
const int LANG_COMMON       = 3; // Common
const int LANG_DWARF        = 4; // Dethek - Dwarvish
const int LANG_ORC          = 5; // Daraktan - Orcish
const int LANG_GOBLIN       = 6; // Ghukliak - Goblin
const int LANG_DRACONIC     = 7; // Auld Wormish - Draconic
const int LANG_ANIMAL       = 8; // Animal Sounds
const int LANG_THIEVESCANT  = 9; // <-- Needs dialects so that it is unique per guild.
const int LANG_CELESTIAL    = 10; // Good
const int LANG_ALZHEDO      = 11; // Alzhedo - calimshan, halflings in hillsedge
const int LANG_INFERNAL     = 12; // Evil
const int LANG_ELF          = 13; // Espruar
const int LANG_UNDERCOMMON  = 14; // Undercommon
const int LANG_NETHER       = 15; // Loross - Noble Netherese (dead language)
const int LANG_DRUID        = 16; // Druidic
const int LANG_SILENCE      = 17; // only spoken in zones of silence or by the mute
const int LANG_MULHORANDI   = 18; // Mulhorandi - Thay etc...
const int LANG_ZHENT        = 19; // Tharian - Zhents, Phlan etc...
const int LANG_UNDERWATER   = 20; // only spoken by people who can not speak... underwater
const int LANG_JOTUN        = 21; // Giants
const int LANG_LAST         = 21;

// must make a lore check of at least this to recognize the language.
const int LORE_SYLVAN       = 17; // Sylvan
const int LORE_GNOME        = 10; // Gnim - Gnomish
const int LORE_COMMON       =  1; // Common
const int LORE_DWARF        = 10; // Dethek - Dwarvish
const int LORE_ORC          =  5; // Daraktan - Orcish
const int LORE_GOBLIN       = 15; // Ghukliak - Goblin
const int LORE_DRACONIC     = 40; // Auld Wormish - Draconic
const int LORE_ANIMAL       =  1; // Animal Sounds
const int LORE_THIEVESCANT  = 35; // <-- Needs dialects so that it is unique per guild.
const int LORE_CELESTIAL    = 25; // Good
const int LORE_ALZHEDO      = 10; // Alzhedo - calimshan, halflings in hillsedge
const int LORE_INFERNAL     = 25; // Evil
const int LORE_ELF          = 10; // Espruar
const int LORE_UNDERCOMMON  = 25; // Undercommon
const int LORE_NETHER       = 40; // Loross - Noble Netherese (dead language)
const int LORE_DRUID        = 40; // Druidic
const int LORE_SILENCE      =  1; // only spoken in zones of silence or by the mute
const int LORE_MULHORANDI   = 10; // Mulhorandi - Thay etc...
const int LORE_ZHENT        = 15; // Tharian - Zhents, Phlan etc...
const int LORE_UNDERWATER   =  1; // only spoken by people who can not speak... underwater
const int LORE_JOTUN        = 15; // Giants

const string LANG_SYL_OBJ = "hlslang_1";
const string LANG_GNM_OBJ = "hlslang_2";
const string LANG_HAF_OBJ = "hlslang_3";
const string LANG_DWA_OBJ = "hlslang_4";
const string LANG_ORC_OBJ = "hlslang_5";
const string LANG_GOB_OBJ = "hlslang_6";
const string LANG_DRG_OBJ = "hlslang_7";
const string LANG_ANI_OBJ = "hlslang_8";
const string LANG_ROG_OBJ = "hlslang_9";
const string LANG_CEL_OBJ = "hlslang_10";
const string LANG_ABS_OBJ = "hlslang_11";
const string LANG_IFN_OBJ = "hlslang_12";
const string LANG_ELF_OBJ = "hlslang_13";
// no objects for the new languages

// used for the language known triggers.
const string LANGK_SYL = "syl";
const string LANGK_GNM = "gni";
const string LANGK_COM = "com";
const string LANGK_DWA = "det";
const string LANGK_ORC = "orc";
const string LANGK_GOB = "ghu";
const string LANGK_DRG = "dra";
const string LANGK_ANI = "ani";
const string LANGK_ROG = "rog";
const string LANGK_CEL = "cel";
const string LANGK_ALZ = "alz";
const string LANGK_IFN = "inf";
const string LANGK_ELF = "esp";
const string LANGK_UND = "und";
const string LANGK_NET = "lor";
const string LANGK_DRU = "dru";
// silence can not be learned (maybe lip reading someday?)
const string LANGK_MUL = "mul";
const string LANGK_ZHE = "tha";
// underwater noises can not be learned
const string LANGK_JOT = "jot";

// language names
const string LANG_SYL_DESC = "Sylvan";
const string LANG_GNM_DESC = "Gnim";
const string LANG_COM_DESC = "Common";
const string LANG_DWA_DESC = "Dethek";
const string LANG_ORC_DESC = "Daraktan";
const string LANG_GOB_DESC = "Ghukliak";
const string LANG_DRG_DESC = "Draconic";
const string LANG_ANI_DESC = "Animal Noises";
const string LANG_ROG_DESC = "Rogue's Cant";
const string LANG_CEL_DESC = "Celestial";
const string LANG_ALZ_DESC = "Alzhedo";
const string LANG_IFN_DESC = "Infernal";
const string LANG_ELF_DESC = "Espruar";
const string LANG_UND_DESC = "Undercommon";
const string LANG_NET_DESC = "Loross";
const string LANG_DRU_DESC = "Druidic";
const string LANG_SIL_DESC = "Silence";
const string LANG_MUL_DESC = "Mulhorandi";
const string LANG_ZHE_DESC = "Tharian";
const string LANG_UWN_DESC = "Underwater Noises";
const string LANG_JOT_DESC = "Jotun";

// FUNCTIONS -------------------------------------------------------------------

// DECLARATIONS

// relays to nearby players the conversation in appropriate language and translation  - [FILE: _inc_languages]
void NPCSpeakForAllToHear(string sChat, int nLang, object oExclude);

// Sets up languages for starting PC based on race/class - [FILE: _inc_languages]
void InitializeDefaultStartingLanguages(object oPC=OBJECT_SELF);
// Sets up languages for spawned NPC based on race/class and local vars - [FILE: _inc_languages]
void InitializeNPCLanguages();

// - [FILE: _inc_languages]
int GetSpeaksLanguage(object pc, int lang, int only_understands=TRUE);
// - [FILE: _inc_languages]
void SetSpeaksLanguage(object pc, int lang, int understand);
// - [FILE: _inc_languages]
string GetLanguageName(int lang);
// - [FILE: _inc_languages]
string LanguageToName(string sLang);
// - [FILE: _inc_languages]
int GetLanguageID(string sLang);
// - [FILE: _inc_languages]
int GetLoreToRecognizeLanguage(int Lang);
// - [FILE: _inc_languages]
int GetCurrentLanguageSpoken(object pc);
// - [FILE: _inc_languages]
void SetCurrentLanguageSpoken(object pc, int lang, int bVerbose=TRUE, int bOverride=FALSE);
// - [FILE: _inc_languages]
void ListKnownLanguages(object pc);
// - [FILE: _inc_languages]
void ListKnownLanguagestoDMs(object pc);
// - [FILE: _inc_languages]
string GetLanguageList(object oPC);
// - [FILE: _inc_languages]
int GetCountLanguagesKnown(object oPC);
// returns altered speach state if PC can not speak - [File: _inc_languages]
int GetCanNotSpeak(object oPC);
//Relocated from dmfi_plychat_fnc - [file: _inc_languages]
string ConvertCustom(string sLetter, int iRotate);
//Relocated from dmfi_plychat_fnc - [file: _inc_languages]
string ProcessCustom(string sPhrase, int iLanguage);
//Relocated from dmfi_plychat_fnc - [file: _inc_languages]
// skipping declarations of many language functions called by TranslateCommonToLanguage.
// should these be moved to a separate include?
string TranslateCommonToLanguage(int iLang, string sText);
//[file: _inc_languages]
void subTranslateToLanguage(string sSaid, object oShouter, int nVolume,
                            object oMaster, int iTranslate, string sLanguageName,
                            object oEavesdrop);
//[file: _inc_languages]
// nLang enables caller to restrict language used
string TranslateToLanguage(string sSaid, object oShouter, int nVolume, object oMaster, int nLang=0);
//Relocated from dmfi_plychat_fnc - Relocated from dmfi_plychat_fnc - [file: _inc_languages]
int GetDefaultRacialLanguage(object oPC);

// IMPLEMENTATION


void NPCSpeakForAllToHear(string sChat, int nLang, object oExclude)
{
    // no need for translation if speaking common
    if(nLang==LANG_COMMON)
    {
        SpeakString(sChat);
        return;
    }

    string sSpoken      = TranslateCommonToLanguage(nLang, sChat);
    SpeakString(sSpoken);

    string sNameLan     = GetLanguageName(nLang);
    location lLoc       = GetLocation(OBJECT_SELF);
    object oArea        = GetAreaFromLocation(lLoc);
    object oEavesdrop   = GetFirstPC();
    float fDistance     = 20.0f;
    while(GetIsObjectValid(oEavesdrop))
    {
      if(oEavesdrop!=oExclude)
      {
        // taken from DMFI translate
        if(     oArea==GetArea(oEavesdrop)
            &&  GetDistanceBetweenLocations(lLoc, GetLocation(oEavesdrop))<=fDistance
          )
        {
            if(nLang==LANG_THIEVESCANT && GetStringLength(sChat)>25)
                sChat = GetStringLeft(sChat, 25);
            subTranslateToLanguage(sChat, OBJECT_SELF, TALKVOLUME_TALK, OBJECT_SELF, nLang, sNameLan, oEavesdrop);
        }
      }
        oEavesdrop = GetNextPC();
    }
}

void InitializeDefaultStartingLanguages(object oPC=OBJECT_SELF)
{
    if(GetSkinInt(oPC, "LANGUAGE_INIT"))
        return;

    SetSpeaksLanguage(oPC, LANG_COMMON, TRUE);
    SetCurrentLanguageSpoken(oPC, LANG_COMMON, FALSE);

    int nRace   = GetRacialType(oPC);
    int nClass  = GetClassByPosition(1, oPC);
    switch(nClass)
    {
        case CLASS_TYPE_DRUID:
            SetSpeaksLanguage(oPC, LANG_DRUID, TRUE);
        break;
        case CLASS_TYPE_ROGUE:
            SetSpeaksLanguage(oPC, LANG_THIEVESCANT, TRUE);
        break;
    }
    switch(nRace)
    {
        case RACIAL_TYPE_DWARF:
            SetSpeaksLanguage(oPC, LANG_DWARF, TRUE);
        break;
        case RACIAL_TYPE_ELF:
            SetSpeaksLanguage(oPC, LANG_ELF, TRUE);
        break;
        case RACIAL_TYPE_GNOME:
            SetSpeaksLanguage(oPC, LANG_GNOME, TRUE);
        break;
        case RACIAL_TYPE_HALFLING:
            SetSpeaksLanguage(oPC, LANG_ALZHEDO, TRUE);
        break;
        case RACIAL_TYPE_HALFORC:
            SetSpeaksLanguage(oPC, LANG_ORC, TRUE);
        break;
        default:

        break;
    }

    SetSkinInt(oPC, "LANGUAGE_INIT", TRUE);
    ListKnownLanguages(oPC);
}

void InitializeNPCLanguages()
{
    int nRacialType = GetRacialType(OBJECT_SELF);

    if(nRacialType<7)
        InitializeDefaultStartingLanguages(OBJECT_SELF);
    else if(nRacialType==RACIAL_TYPE_GIANT)
    {
        SetSpeaksLanguage(OBJECT_SELF, LANG_JOTUN, TRUE);
        SetCurrentLanguageSpoken(OBJECT_SELF, LANG_JOTUN);
    }
    else if( nRacialType==RACIAL_TYPE_FEY )
    {
        SetSpeaksLanguage(OBJECT_SELF, LANG_SYLVAN, TRUE);
        SetSpeaksLanguage(OBJECT_SELF, LANG_ELF, TRUE);
        SetSpeaksLanguage(OBJECT_SELF, LANG_DRUID, TRUE);
        SetCurrentLanguageSpoken(OBJECT_SELF, LANG_SYLVAN);
    }
    else if( nRacialType==RACIAL_TYPE_HUMANOID_GOBLINOID )
    {
        SetSpeaksLanguage(OBJECT_SELF, LANG_GOBLIN, TRUE);
        SetCurrentLanguageSpoken(OBJECT_SELF, LANG_GOBLIN);
    }
    else if( nRacialType==RACIAL_TYPE_HUMANOID_ORC )
    {
        SetSpeaksLanguage(OBJECT_SELF, LANG_ORC, TRUE);
        SetCurrentLanguageSpoken(OBJECT_SELF, LANG_ORC);
    }
    else if( nRacialType==RACIAL_TYPE_ABERRATION   )
    {
        SetSpeaksLanguage(OBJECT_SELF, LANG_UNDERCOMMON, TRUE);
        SetCurrentLanguageSpoken(OBJECT_SELF, LANG_UNDERCOMMON);
    }
    else if(    nRacialType==RACIAL_TYPE_DRAGON
            ||  nRacialType==RACIAL_TYPE_HUMANOID_REPTILIAN
               )
    {
        SetSpeaksLanguage(OBJECT_SELF, LANG_UNDERCOMMON, TRUE);
        SetSpeaksLanguage(OBJECT_SELF, LANG_DRACONIC, TRUE);
        SetCurrentLanguageSpoken(OBJECT_SELF, LANG_DRACONIC);
    }
    else if(    nRacialType==RACIAL_TYPE_DRAGON
            ||  nRacialType==RACIAL_TYPE_HUMANOID_REPTILIAN
               )
    {
        SetSpeaksLanguage(OBJECT_SELF, LANG_UNDERCOMMON, TRUE);
        SetSpeaksLanguage(OBJECT_SELF, LANG_DRACONIC, TRUE);
        SetCurrentLanguageSpoken(OBJECT_SELF, LANG_DRACONIC);
    }
    else if(    nRacialType==RACIAL_TYPE_OUTSIDER
            ||  nRacialType==RACIAL_TYPE_ELEMENTAL
           )
    {
        SetSpeaksLanguage(OBJECT_SELF, LANG_CELESTIAL, TRUE);
        SetSpeaksLanguage(OBJECT_SELF, LANG_INFERNAL, TRUE);
    }
    else if(    nRacialType==RACIAL_TYPE_ANIMAL
            ||  nRacialType==RACIAL_TYPE_BEAST
            ||  nRacialType==RACIAL_TYPE_MAGICAL_BEAST
            ||  nRacialType==RACIAL_TYPE_SHAPECHANGER
           )
    {
        SetSpeaksLanguage(OBJECT_SELF, LANG_ANIMAL, TRUE);
        SetCurrentLanguageSpoken(OBJECT_SELF, LANG_ANIMAL);
    }

    if(GetLocalInt(OBJECT_SELF, "LANG_SYLVAN"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_SYLVAN, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_GNOME"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_GNOME, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_COMMON"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_COMMON, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_DWARF"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_DWARF, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_ORC"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_ORC, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_GOBLIN"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_GOBLIN, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_DRACONIC"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_DRACONIC, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_ANIMAL"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_ANIMAL, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_THIEVESCANT"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_THIEVESCANT, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_CELESTIAL"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_CELESTIAL, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_ALZHEDO"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_ALZHEDO, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_INFERNAL"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_INFERNAL, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_ELF"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_ELF, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_UNDERCOMMON"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_UNDERCOMMON, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_NETHER"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_NETHER, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_DRUID"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_DRUID, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_MULHORANDI"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_MULHORANDI, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_ZHENT"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_ZHENT, TRUE);
    if(GetLocalInt(OBJECT_SELF, "LANG_JOTUN"))
        SetSpeaksLanguage(OBJECT_SELF, LANG_JOTUN, TRUE);
}

int GetSpeaksLanguage(object oPC, int nLang, int only_understands=TRUE)
{
    int bSpeaks;
    if(!nLang)
        nLang=3;
    if(     GetHasFeat(FEAT_MONK_TALK,oPC)
        ||  GetHasSpellEffect(SPELL_TONGUES,oPC)
        ||  (only_understands && GetHasSpellEffect(SPELL_COMPREHEND,oPC))
        ||(     nLang==LANG_ANIMAL
            &&  GetHasSpellEffect( SPELL_SPEAK_WITH_ANIMALS, oPC )// speak with animals
          )
      )
    {
        bSpeaks = TRUE;
    }
    else
        bSpeaks = GetSkinInt(oPC, LANGUAGE_KNOWN + IntToString(nLang));

    return bSpeaks;
}

void SetSpeaksLanguage(object oPC, int nLang, int bUnderstand)
{
    SetSkinInt(oPC , LANGUAGE_KNOWN + IntToString(nLang), bUnderstand);

}

string GetLanguageName(int lang)
{
    switch (lang)
    {
        case LANG_SYLVAN:      return LANG_SYL_DESC;
        case LANG_GNOME:       return LANG_GNM_DESC;
        case LANG_COMMON:      return LANG_COM_DESC;
        case LANG_DWARF:       return LANG_DWA_DESC;
        case LANG_ORC:         return LANG_ORC_DESC;
        case LANG_GOBLIN:      return LANG_GOB_DESC;
        case LANG_DRACONIC:    return LANG_DRG_DESC;
        case LANG_ANIMAL:      return LANG_ANI_DESC;
        case LANG_THIEVESCANT: return LANG_ROG_DESC;
        case LANG_CELESTIAL:   return LANG_CEL_DESC;
        case LANG_ALZHEDO:     return LANG_ALZ_DESC;
        case LANG_INFERNAL:    return LANG_IFN_DESC;
        case LANG_ELF:         return LANG_ELF_DESC;
        case LANG_UNDERCOMMON: return LANG_UND_DESC;
        case LANG_NETHER:      return LANG_NET_DESC;
        case LANG_DRUID:       return LANG_DRU_DESC;
        case LANG_SILENCE:     return LANG_SIL_DESC;
        case LANG_MULHORANDI:  return LANG_MUL_DESC;
        case LANG_ZHENT:       return LANG_ZHE_DESC;
        case LANG_UNDERWATER:  return LANG_UWN_DESC;
        case LANG_JOTUN:       return LANG_JOT_DESC;
        break;
        default: break;
    }
    return "Default";
}

string LanguageToName(string sLang)
{
    sLang   = GetStringLowerCase(GetStringLeft(sLang,3));

         if (sLang == LANGK_SYL) return LANG_SYL_DESC;
    else if (sLang == LANGK_GNM) return LANG_GNM_DESC;
    else if (sLang == LANGK_COM) return LANG_COM_DESC;
    else if (sLang == LANGK_DWA) return LANG_DWA_DESC;
    else if (sLang == LANGK_ORC) return LANG_ORC_DESC;
    else if (sLang == LANGK_GOB) return LANG_GOB_DESC;
    else if (sLang == LANGK_DRG) return LANG_DRG_DESC;
    else if (sLang == LANGK_ANI) return LANG_ANI_DESC;
    else if (sLang == LANGK_ROG) return LANG_ROG_DESC;
    else if (sLang == LANGK_CEL) return LANG_CEL_DESC;
    else if (sLang == LANGK_ALZ) return LANG_ALZ_DESC;
    else if (sLang == LANGK_IFN) return LANG_IFN_DESC;
    else if (sLang == LANGK_ELF) return LANG_ELF_DESC;
    else if (sLang == LANGK_UND) return LANG_UND_DESC;
    else if (sLang == LANGK_NET) return LANG_NET_DESC;
    else if (sLang == LANGK_DRU) return LANG_DRU_DESC;
    else if (sLang == LANGK_MUL) return LANG_MUL_DESC;
    else if (sLang == LANGK_ZHE) return LANG_ZHE_DESC;
    else if (sLang == LANGK_JOT) return LANG_JOT_DESC;
    else return "unknown";
}

int GetLanguageID(string sLang)
{
         if (sLang == LANGK_SYL) return LANG_SYLVAN;
    else if (sLang == LANGK_GNM) return LANG_GNOME;
    else if (sLang == LANGK_COM) return LANG_COMMON;
    else if (sLang == LANGK_DWA) return LANG_DWARF;
    else if (sLang == LANGK_ORC) return LANG_ORC;
    else if (sLang == LANGK_GOB) return LANG_GOBLIN;
    else if (sLang == LANGK_DRG) return LANG_DRACONIC;
    else if (sLang == LANGK_ANI) return LANG_ANIMAL;
    else if (sLang == LANGK_ROG) return LANG_THIEVESCANT;
    else if (sLang == LANGK_CEL) return LANG_CELESTIAL;
    else if (sLang == LANGK_ALZ) return LANG_ALZHEDO;
    else if (sLang == LANGK_IFN) return LANG_INFERNAL;
    else if (sLang == LANGK_ELF) return LANG_ELF;
    else if (sLang == LANGK_UND) return LANG_UNDERCOMMON;
    else if (sLang == LANGK_NET) return LANG_NETHER;
    else if (sLang == LANGK_DRU) return LANG_DRUID;
    else if (sLang == LANGK_MUL) return LANG_MULHORANDI;
    else if (sLang == LANGK_ZHE) return LANG_ZHENT;
    else if (sLang == LANGK_JOT) return LANG_JOTUN;

    else return -1;
}

int GetLoreToRecognizeLanguage(int Lang)
{
    switch (Lang)
    {
        case LANG_SYLVAN:      return LORE_SYLVAN;
        case LANG_GNOME:       return LORE_GNOME;
        case LANG_COMMON:      return LORE_COMMON;
        case LANG_DWARF:       return LORE_DWARF;
        case LANG_ORC:         return LORE_ORC;
        case LANG_GOBLIN:      return LORE_GOBLIN;
        case LANG_DRACONIC:    return LORE_DRACONIC;
        case LANG_ANIMAL:      return LORE_ANIMAL;
        case LANG_THIEVESCANT: return LORE_THIEVESCANT;
        case LANG_CELESTIAL:   return LORE_CELESTIAL;
        case LANG_ALZHEDO:     return LORE_ALZHEDO;
        case LANG_INFERNAL:    return LORE_INFERNAL;
        case LANG_ELF:         return LORE_ELF;
        case LANG_UNDERCOMMON: return LORE_UNDERCOMMON;
        case LANG_NETHER:      return LORE_NETHER;
        case LANG_DRUID:       return LORE_DRUID;
        case LANG_SILENCE:     return LORE_SILENCE;
        case LANG_MULHORANDI:  return LORE_MULHORANDI;
        case LANG_ZHENT:       return LORE_ZHENT;
        case LANG_UNDERWATER:  return LORE_UNDERWATER;
        case LANG_JOTUN:       return LORE_JOTUN;
    }
    return 99;
}

int GetCurrentLanguageSpoken(object pc)
{
    return GetSkinInt(pc, LANGUAGE_SPOKEN_ID);
}

void SetCurrentLanguageSpoken(object pc, int lang, int bVerbose=TRUE, int bOverride=FALSE)
{
    if(     bOverride
        ||  GetSpeaksLanguage(pc, lang, FALSE)
        ||  lang == LANG_COMMON
        ||  GetIsDM(pc)
        ||  GetIsDMPossessed(pc)
      )
    {
        SetSkinInt(pc, LANGUAGE_SPOKEN_ID, lang);
        if(bVerbose)
            SendMessageToPC(pc, PINK+"You are speaking "+YELLOW+ GetLanguageName(lang) +PINK+".");
    }
    else if(bVerbose)
    {
        SendMessageToPC(pc, RED+"You do not know how to speak "+YELLOW+ GetLanguageName(lang) +RED+".");
    }
}

void ListKnownLanguages(object pc)
{
    int i;
    for (i = LANG_FIRST; i <= LANG_LAST; i++)
    {
        if ( GetSpeaksLanguage(pc, i) || GetIsDM(pc) || GetIsDMPossessed(pc))
            SendMessageToPC(pc, PINK+"You understand "+YELLOW+ GetLanguageName(i) +PINK+".");
    }
    i = GetCurrentLanguageSpoken(pc);
    SendMessageToPC(pc, PINK+"You are speaking "+YELLOW+ GetLanguageName(i) +PINK+".");
}

void ListKnownLanguagestoDMs(object pc)
{
    int i;
    for (i = LANG_FIRST; i <= LANG_LAST; i++)
    {
        if (GetSpeaksLanguage(pc, i) || GetIsDM(pc) || GetIsDMPossessed(pc))
            SendMessageToAllDMs(PINK+GetName(pc)+" understands "+YELLOW+ GetLanguageName(i));
    }
    i = GetCurrentLanguageSpoken(pc);
    SendMessageToAllDMs(PINK+GetName(pc)+" is speaking "+YELLOW+ GetLanguageName(i));
}

string GetLanguageList(object oPC)
{
    string sList;
    int i;
    for (i = LANG_FIRST; i <= LANG_LAST; i++)
    {
        if ( GetSpeaksLanguage(oPC, i, FALSE))
            sList+= GetLanguageName(i)+", ";
    }

    return GetStringLeft(sList, GetStringLength(sList)-2);
}

int GetCountLanguagesKnown(object oPC)
{
    int i, nCount;
    for (i = LANG_FIRST; i <= LANG_LAST; i++)
    {
        if ( GetSpeaksLanguage(oPC, i, FALSE))
            nCount++;
    }

    return nCount;
}

// Int representing type of altered speach
int GetCanNotSpeak(object oPC)
{
    // nAlt Values
    //  0       speach unaltered
    //  1       rendered silent
    //  2       speaks in animal noises
    //  3       berserking lycanthrope
    //  4       scrying
    //  5       underwater garbled

    int nAlt  = FALSE;
    int nType;

    if(GetHasSpellEffect(SPELL_SILENCE, oPC) || GetHasEffect(EFFECT_TYPE_SILENCE, oPC))
    {
        nAlt = 1; // complete silence
    }
    else if(GetIsObjectValid( GetLocalObject(oPC, "LYCANTHROPY_BEAST") ))
    {
        nAlt = 3; // berserking animal
    }
    else if(GetLocalInt(oPC, "SCRYING")>=2) // 2 and above means: so immersed that you can not talk
    {
        nAlt = 4; // scrying
    }
    else if(GetLocalInt(oPC,"UNDERWATER_EFFECTS")&IMPACT_SPEECH)
    {
        nAlt = 5; // garbled
    }
    else
    {
        nType   = GetAppearanceType(oPC);
        nAlt    = StringToInt(Get2DAString("appearance_x", "ALT_SPEECH", nType));
        if(   ((GetLevelByClass(CLASS_TYPE_SHIFTER, oPC) )&& (nAlt==2 || nAlt==1))
            ||( nAlt==2
                &&  (   GetLevelByClass(CLASS_TYPE_DRUID, oPC)>11
                    ||  GetHasSpellEffect(SPELL_SPEAK_WITH_ANIMALS, oPC)
                    )
              )
            || GetHasFeat(FEAT_MONK_TALK,oPC)
          )
        {
            nAlt = FALSE;
        }
    }

    return nAlt;
}

////////////////////////////////////////////////////////////////////////
string ConvertCustom(string sLetter, int iRotate)
{

        sLetter = GetStringLeft(sLetter, 1);

    //Functional groups for custom languages
    //Vowel Sounds: a, e, i, o, u
    //Hard Sounds: b, d, k, p, t
    //Sibilant Sounds: c, f, s, q, w
    //Soft Sounds: g, h, l, r, y
    //Hummed Sounds: j, m, n, v, z
    //Oddball out: x, the rarest letter in the alphabet

    string sTranslate = "aeiouAEIOUbdkptBDKPTcfsqwCFSQWghlryGHLRYjmnvzJMNVZxX";
    int iTrans = FindSubString(sTranslate, sLetter);
    if (iTrans == -1) return sLetter; //return any character that isn't on the cipher

    //Now here's the tricky part... recalculating the offsets according functional
    //letter group, to produce an huge variety of "new" languages.

    int iOffset = iRotate % 5;
    int iGroup = iTrans / 5;
    int iBonus = iTrans / 10;
    int iMultiplier = iRotate / 5;
    iOffset = iTrans + iOffset + (iMultiplier * iBonus);

    return GetSubString(sTranslate, iGroup * 5 + iOffset % 5, 1);
}//end ConvertCustom

////////////////////////////////////////////////////////////////////////
string ProcessCustom(string sPhrase, int iLanguage)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertCustom(GetStringLeft(sPhrase, 1), iLanguage);
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertDrow(string sLetter)
{

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "il";
    case 26: return "Il";
    case 1: return "f";
    case 27: return "F";
    case 2: return "st";
    case 28: return "St";
    case 3: return "w";
    case 4: return "a";
    case 5: return "o";
    case 6: return "v";
    case 7: return "ir";
    case 33: return "Ir";
    case 8: return "e";
    case 9: return "vi";
    case 35: return "Vi";
    case 10: return "go";
    case 11: return "c";
    case 12: return "li";
    case 13: return "l";
    case 14: return "e";
    case 15: return "ty";
    case 41: return "Ty";
    case 16: return "r";
    case 17: return "m";
    case 18: return "la";
    case 44: return "La";
    case 19: return "an";
    case 45: return "An";
    case 20: return "y";
    case 21: return "el";
    case 47: return "El";
    case 22: return "ky";
    case 48: return "Ky";
    case 23: return "'";
    case 24: return "a";
    case 25: return "p'";
    case 29: return "W";
    case 30: return "A";
    case 31: return "O";
    case 32: return "V";
    case 34: return "E";
    case 36: return "Go";
    case 37: return "C";
    case 38: return "Li";
    case 39: return "L";
    case 40: return "E";
    case 42: return "R";
    case 43: return "M";
    case 46: return "Y";
    case 49: return "'";
    case 50: return "A";
    case 51: return "P'";

    default: return sLetter;
    } return "";
}

string ProcessDrow(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertDrow(GetStringLeft(sPhrase, 1));

        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertDruidic(string sLetter)
{

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "iel";
        case 26: return "Iel";
        case 1: return "afel";
        case 27: return "Afel";
        case 2: return "nyn";
        case 28: return "Nyn";
        case 3: return "yn";
        case 29: return "Yn";
        case 4: return "aias";
        case 30: return "Aias";
        case 5: return "onn";
        case 31: return "Onn";
        case 6: return "avain";
        case 32: return "Avain";
        case 7: return "ire";
        case 33: return "Ire";
        case 8: return "esti";
        case 34: return "Esti";
        case 9: return "que";
        case 35: return "Que";
        case 10: return "nis";
        case 36: return "Nis";
        case 11: return "cy";
        case 37: return "Cy";
        case 12: return "asel";
        case 38: return "Asel";
        case 13: return "ilam";
        case 39: return "Ilam";
        case 14: return "ernar";
        case 40: return "Ernar";
        case 15: return "yth";
        case 41: return "Yth";
        case 16: return "ahal";
        case 42: return "Ahal";
        case 17: return "umil";
        case 43: return "Umil";
        case 18: return "olan";
        case 44: return "Olan";
        case 19: return "uanna";
        case 45: return "Uanna";
        case 20: return "yrn";
        case 46: return "Yrn";
        case 21: return "ele";
        case 47: return "Ele";
        case 22: return "llae";
        case 48: return "Llae";
        case 23: return "'";
        case 49: return "'";
        case 24: return "nae";
        case 50: return "Nae";
        case 25: return "athas";
        case 51: return "Athas";

        default: return sLetter;
    }
    return "";
}

string ProcessDruidic(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertDruidic(GetStringLeft(sPhrase, 1));

        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertNether(string sLetter)
{ // Vives Aelvish

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        case 0: return "ael";
        case 26: return "Ael";
        case 1: return "fi";
        case 27: return "Fi";
        case 2: return "nai";
        case 28: return "Nai";
        case 3: return "wyn";
        case 29: return "Wyn";
        case 4: return "aer";
        case 30: return "Aer";
        case 5: return "or";
        case 31: return "Or";
        case 6: return "vil";
        case 32: return "Vil";
        case 7: return "iat";
        case 33: return "Iat";
        case 8: return "eir";
        case 34: return "Eir";
        case 9: return "quis";
        case 35: return "Quis";
        case 10: return "nim";
        case 36: return "Nim";
        case 11: return "cael";
        case 37: return "Cael";
        case 12: return "seh";
        case 38: return "Seh";
        case 13: return "lue";
        case 39: return "Lue";
        case 14: return "eli";
        case 40: return "Eli";
        case 15: return "tahl";
        case 41: return "Tahl";
        case 16: return "hu";
        case 42: return "Hu";
        case 17: return "mai";
        case 43: return "Mai";
        case 18: return "lam";
        case 44: return "Lam";
        case 19: return "ansa";
        case 45: return "Ansa";
        case 20: return "ya";
        case 46: return "Ya";
        case 21: return "eli";
        case 47: return "Eli";
        case 22: return "ah";
        case 48: return "Ah";
        case 23: return "'";
        case 49: return "'";
        case 24: return "ansr";
        case 50: return "Ansr";
        case 25: return "jar";
        case 51: return "Jar";

        default: return sLetter;
    }
    return "";
}

string ProcessNether(string sPhrase)
{ // Vives Aelvish
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertNether(GetStringLeft(sPhrase, 1));

        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertLeetspeak(string sLetter)
{

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "4";
    case 26: return "4";
    case 1: return "8";
    case 27: return "8";
    case 2: return "(";
    case 28: return "(";
    case 3: return "|)";
    case 29: return "|)";
    case 4: return "3";
    case 30: return "3";
    case 5: return "f";
    case 31: return "F";
    case 6: return "9";
    case 32: return "9";
    case 7: return "h";
    case 33: return "H";
    case 8: return "!";
    case 34: return "!";
    case 9: return "j";
    case 35: return "J";
    case 10: return "|<";
    case 36: return "|<";
    case 11: return "1";
    case 37: return "1";
    case 12: return "m";
    case 38: return "m";
    case 13: return "n";
    case 39: return "n";
    case 14: return "0";
    case 40: return "0";
    case 15: return "p";
    case 41: return "P";
    case 16: return "Q";
    case 42: return "Q";
    case 17: return "R";
    case 43: return "R";
    case 18: return "5";
    case 44: return "5";
    case 19: return "7";
    case 45: return "7";
    case 20: return "u";
    case 46: return "U";
    case 21: return "v";
    case 47: return "v";
    case 22: return "w";
    case 48: return "w";
    case 23: return "x";
    case 49: return "X";
    case 24: return "y";
    case 50: return "Y";
    case 25: return "2";
    case 51: return "2";
    default: return sLetter;
    }
    return "";
}//end ConvertLeetspeak

////////////////////////////////////////////////////////////////////////
string ProcessLeetspeak(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertLeetspeak(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertInfernal(string sLetter)
{

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "o";
    case 1: return "c";
    case 2: return "r";
    case 3: return "j";
    case 4: return "a";
    case 5: return "v";
    case 6: return "k";
    case 7: return "r";
    case 8: return "y";
    case 9: return "z";
    case 10: return "g";
    case 11: return "m";
    case 12: return "z";
    case 13: return "r";
    case 14: return "y";
    case 15: return "k";
    case 16: return "r";
    case 17: return "n";
    case 18: return "k";
    case 19: return "d";
    case 20: return "'";
    case 21: return "r";
    case 22: return "'";
    case 23: return "k";
    case 24: return "i";
    case 25: return "g";
    case 26: return "O";
    case 27: return "C";
    case 28: return "R";
    case 29: return "J";
    case 30: return "A";
    case 31: return "V";
    case 32: return "K";
    case 33: return "R";
    case 34: return "Y";
    case 35: return "Z";
    case 36: return "G";
    case 37: return "M";
    case 38: return "Z";
    case 39: return "R";
    case 40: return "Y";
    case 41: return "K";
    case 42: return "R";
    case 43: return "N";
    case 44: return "K";
    case 45: return "D";
    case 46: return "'";
    case 47: return "R";
    case 48: return "'";
    case 49: return "K";
    case 50: return "I";
    case 51: return "G";
    default: return sLetter;
    }
    return "";
}//end ConvertInfernal

////////////////////////////////////////////////////////////////////////
string ProcessInfernal(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertInfernal(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertShadows(string sLetter)
{

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);
        switch (iTrans)
    {
    /*a*/case 0:    return "i";
    /*A*/case 26:   return "I";
    /*b*/case 1:    return "s";
    /*B*/case 27:   return "S";
    /*c*/case 2:    return "h";
    /*C*/case 28:   return "H";
    /*d*/case 3:    return "s";
    /*D*/case 29:   return "S";
    /*e*/case 4:    return "i";
    /*E*/case 30:   return "I";
    /*f*/case 5:    return "m";
    /*F*/case 31:   return "M";
    /*g*/case 6:    return "s";
    /*G*/case 32:   return "S";
    /*h*/case 7:    return "h";
    /*H*/case 33:   return "H";
    /*i*/case 8:    return "i";
    /*I*/case 34:   return "I";
    /*j*/case 9:    return "s";
    /*J*/case 35:   return "S";
    /*k*/case 10:   return "s";
    /*K*/case 36:   return "S";
    /*l*/case 11:   return "m";
    /*L*/case 37:   return "M";
    /*m*/case 12:   return "m";
    /*M*/case 38:   return "M";
    /*n*/case 13:   return "m";
    /*N*/case 39:   return "M";
    /*o*/case 14:   return "ah";
    /*O*/case 40:   return "Ah";
    /*p*/case 15:   return "s";
    /*P*/case 41:   return "S";
    /*q*/case 16:   return "s";
    /*Q*/case 42:   return "S";
    /*r*/case 17:   return "h";
    /*R*/case 43:   return "H";
    /*s*/case 18:   return "h";
    /*S*/case 44:   return "H";
    /*t*/case 19:   return "s";
    /*T*/case 45:   return "S";
    /*u*/case 20:   return "i";
    /*U*/case 46:   return "I";
    /*v*/case 21:   return "m";
    /*V*/case 47:   return "M";
    /*w*/case 22:   return "m";
    /*W*/case 48:   return "M";
    /*x*/case 23:   return "s";
    /*X*/case 49:   return "S";
    /*y*/case 24:   return "eh";
    /*Y*/case 50:   return "Eh";
    /*z*/case 25:   return "h";
    /*Z*/case 51:   return "H";
    default: return sLetter;
    } return "";
    /*  // Was Abyssal
    switch (iTrans)
    {
    case 27: return "N";
    case 28: return "M";
    case 29: return "G";
    case 30: return "A";
    case 31: return "K";
    case 32: return "S";
    case 33: return "D";
    case 35: return "H";
    case 36: return "B";
    case 37: return "L";
    case 38: return "P";
    case 39: return "T";
    case 40: return "E";
    case 41: return "B";
    case 43: return "N";
    case 44: return "M";
    case 45: return "G";
    case 48: return "B";
    case 51: return "T";
    case 0: return "oo";
    case 26: return "OO";
    case 1: return "n";
    case 2: return "m";
    case 3: return "g";
    case 4: return "a";
    case 5: return "k";
    case 6: return "s";
    case 7: return "d";
    case 8: return "oo";
    case 34: return "OO";
    case 9: return "h";
    case 10: return "b";
    case 11: return "l";
    case 12: return "p";
    case 13: return "t";
    case 14: return "e";
    case 15: return "b";
    case 16: return "ch";
    case 42: return "Ch";
    case 17: return "n";
    case 18: return "m";
    case 19: return "g";
    case 20: return  "ae";
    case 46: return  "Ae";
    case 21: return  "ts";
    case 47: return  "Ts";
    case 22: return "b";
    case 23: return  "bb";
    case 49: return  "Bb";
    case 24: return  "ee";
    case 50: return  "Ee";
    case 25: return "t";
    default: return sLetter;
    }
    return "";
    */
}//end ConvertShadows

////////////////////////////////////////////////////////////////////////
string ProcessShadows(string sPhrase)
{ // Was Abyssal
    string sOutput;
    int iToggle;
    while (GetStringLength(sPhrase))
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertShadows(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertCelestial(string sLetter)
{

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "a";
    case 1: return "p";
    case 2: return "v";
    case 3: return "t";
    case 4: return "el";
    case 5: return "b";
    case 6: return "w";
    case 7: return "r";
    case 8: return "i";
    case 9: return "m";
    case 10: return "x";
    case 11: return "h";
    case 12: return "s";
    case 13: return "c";
    case 14: return "u";
    case 15: return "q";
    case 16: return "d";
    case 17: return "n";
    case 18: return "l";
    case 19: return "y";
    case 20: return "o";
    case 21: return "j";
    case 22: return "f";
    case 23: return "g";
    case 24: return "z";
    case 25: return "k";
    case 26: return "A";
    case 27: return "P";
    case 28: return "V";
    case 29: return "T";
    case 30: return "El";
    case 31: return "B";
    case 32: return "W";
    case 33: return "R";
    case 34: return "I";
    case 35: return "M";
    case 36: return "X";
    case 37: return "H";
    case 38: return "S";
    case 39: return "C";
    case 40: return "U";
    case 41: return "Q";
    case 42: return "D";
    case 43: return "N";
    case 44: return "L";
    case 45: return "Y";
    case 46: return "O";
    case 47: return "J";
    case 48: return "F";
    case 49: return "G";
    case 50: return "Z";
    case 51: return "K";
    default: return sLetter;
    }
    return "";
}//end ConvertCelestial

////////////////////////////////////////////////////////////////////////
string ProcessCelestial(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertCelestial(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertGoblin(string sLetter)
{

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    /*a*/case 0:     return "u";
    /*A*/case 26:    return "U";
    /*b*/case 1:     return "ve";
    /*B*/case 27:    return "Ve";
    /*c*/case 2:     return "k\EC";
    /*C*/case 28:    return "K\EC";
    /*d*/case 3:     return "t";
    /*D*/case 29:    return "T";
    /*e*/case 4:     return "'";
    /*E*/case 30:    return "'";
    /*f*/case 5:     return "\F1";
    /*F*/case 31:    return "\D1";
    /*g*/case 6:     return "kh";
    /*G*/case 32:    return "Kh";
    /*h*/case 7:     return "r";
    /*H*/case 33:    return "R";
    /*i*/case 8:     return "o";
    /*I*/case 34:    return "O";
    /*j*/case 9:     return "ch";
    /*J*/case 35:    return "Ch";
    /*k*/case 10:    return "g";
    /*K*/case 36:    return "G";
    /*l*/case 11:    return "h";
    /*L*/case 37:    return "H";
    /*m*/case 12:    return "ts";
    /*M*/case 38:    return "Ts";
    /*n*/case 13:    return "tz";
    /*N*/case 39:    return "Tz";
    /*o*/case 14:    return "u";
    /*O*/case 40:    return "U";
    /*p*/case 15:    return "v";
    /*P*/case 41:    return "V";
    /*q*/case 16:    return "kw";
    /*Q*/case 42:    return "Kw";
    /*r*/case 17:    return "n";
    /*R*/case 43:    return "N";
    /*s*/case 18:    return "gu";
    /*S*/case 44:    return "Gu";
    /*t*/case 19:    return "dh";
    /*T*/case 45:    return "Dh";
    /*u*/case 20:    return "\FC";
    /*U*/case 46:    return "\DC";
    /*v*/case 21:    return "";
    /*V*/case 47:    return "";
    /*w*/case 22:    return "'";
    /*W*/case 48:    return "'";
    /*x*/case 23:    return "";
    /*X*/case 49:    return "";
    /*y*/case 24:    return "o";
    /*Y*/case 50:    return "O";
    /*z*/case 25:    return "gh";
    /*Z*/case 51:    return "Gh";
    /*'*/case 52:    return " \D6";
    default:    return sLetter;
    }
    return "";
}//end ConvertGoblin

////////////////////////////////////////////////////////////////////////
string ProcessGoblin(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertGoblin(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertDraconic(string sLetter)
{
    // :::::::::: SSLIISYA :::::::::: // from vives

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
        /*a*/ case 0: return "ye";
        /*A*/ case 26: return "Ye";
        /*b*/ case 1: return "k";
        /*B*/ case 27: return "K";
        /*c*/ case 2: return "id y'a";
        /*C*/ case 28: return "Id y'a";
        /*d*/ case 3: return "g";
        /*D*/ case 29: return "G";
        /*e*/ case 4: return "is";
        /*E*/ case 30: return "Is";
        /*f*/ case 5: return "v";
        /*F*/ case 31: return "V";
        /*g*/ case 6: return " ez";
        /*G*/ case 32: return " Ez";
        /*h*/ case 7: return "es ";
        /*H*/ case 33: return "Es ";
        /*i*/ case 8: return "aya";
        /*I*/ case 34: return "Aya";
        /*j*/ case 9: return "h";
        /*J*/ case 35: return "H";
        /*k*/ case 10: return "th'a";
        /*K*/ case 36: return "Th'a";
        /*l*/ case 11: return "s";
        /*L*/ case 37: return "S";
        /*m*/ case 12: return "sla ";
        /*M*/ case 38: return "Sla ";
        /*n*/ case 13: return " ssli";
        /*N*/ case 39: return " Ssli";
        /*o*/ case 14: return "az u";
        /*O*/ case 40: return "Az u";
        /*p*/ case 15: return "su";
        /*P*/ case 41: return "Su";
        /*q*/ case 16: return "l";
        /*Q*/ case 42: return "L";
        /*r*/ case 17: return "yas ";
        /*R*/ case 43: return "Yas ";
        /*s*/ case 18: return "z";
        /*S*/ case 44: return "Z";
        /*t*/ case 19: return "li's";
        /*T*/ case 45: return "Li's";
        /*u*/ case 20: return "is";
        /*U*/ case 46: return "Is";
        /*v*/ case 21: return "sz";
        /*V*/ case 47: return "Sz";
        /*w*/ case 22: return "sh";
        /*W*/ case 48: return "Sh";
        /*x*/ case 23: return "c";
        /*X*/ case 49: return "C";
        /*y*/ case 24: return "isa";
        /*Y*/ case 50: return "Isa";
        /*z*/ case 25: return "n";
        /*Z*/ case 51: return "N";

        default: return sLetter;
    }
    return "";
    /*

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "e";
    case 26: return "E";
    case 1: return "po";
    case 27: return "Po";
    case 2: return "st";
    case 28: return "St";
    case 3: return "ty";
    case 29: return "Ty";
    case 4: return "i";
    case 5: return "w";
    case 6: return "k";
    case 7: return "ni";
    case 33: return "Ni";
    case 8: return "un";
    case 34: return "Un";
    case 9: return "vi";
    case 35: return "Vi";
    case 10: return "go";
    case 36: return "Go";
    case 11: return "ch";
    case 37: return "Ch";
    case 12: return "li";
    case 38: return "Li";
    case 13: return "ra";
    case 39: return "Ra";
    case 14: return "y";
    case 15: return "ba";
    case 41: return "Ba";
    case 16: return "x";
    case 17: return "hu";
    case 43: return "Hu";
    case 18: return "my";
    case 44: return "My";
    case 19: return "dr";
    case 45: return "Dr";
    case 20: return "on";
    case 46: return "On";
    case 21: return "fi";
    case 47: return "Fi";
    case 22: return "zi";
    case 48: return "Zi";
    case 23: return "qu";
    case 49: return "Qu";
    case 24: return "an";
    case 50: return "An";
    case 25: return "ji";
    case 51: return "Ji";
    case 30: return "I";
    case 31: return "W";
    case 32: return "K";
    case 40: return "Y";
    case 42: return "X";
    default: return sLetter;
    }
    return "";
    */
}//end ConvertDraconic

////////////////////////////////////////////////////////////////////////
string ProcessDraconic(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertDraconic(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertDwarf(string sLetter)
{ // Dwarf

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    /*a*/case 0:    return "az";
    /*A*/case 26:   return "Az";
    /*b*/case 1:    return "po";
    /*B*/case 27:   return "Po";
    /*c*/case 2:    return "zi";
    /*C*/case 28:   return "Zi";
    /*d*/case 3:    return "t";
    /*D*/case 29:   return "T";
    /*e*/case 4:    return "a";
    /*E*/case 30:   return "A";
    /*r*/case 5:    return "wa";
    /*F*/case 31:   return "Wa";
    /*g*/case 6:    return "k";
    /*G*/case 32:   return "K";
    /*h*/case 7:    return "'";
    /*H*/case 33:   return "'";
    /*i*/case 8:    return "a";
    /*I*/case 34:   return "A";
    /*j*/case 9:    return "dr";
    /*J*/case 35:   return "Dr";
    /*k*/case 10:   return "g";
    /*K*/case 36:   return "G";
    /*l*/case 11:   return "n";
    /*L*/case 37:   return "N";
    /*m*/case 12:   return "l";
    /*M*/case 38:   return "L";
    /*n*/case 13:   return "r";
    /*N*/case 39:   return "R";
    /*o*/case 14:   return "ur";
    /*O*/case 40:   return "Ur";
    /*p*/case 15:   return "rh";
    /*P*/case 41:   return "Rh";
    /*q*/case 16:   return "k";
    /*Q*/case 42:   return "K";
    /*r*/case 17:   return "h";
    /*R*/case 43:   return "H";
    /*s*/case 18:   return "th";
    /*S*/case 44:   return "Th";
    /*t*/case 19:   return "k";
    /*T*/case 45:   return "K";
    /*u*/case 20:   return "'";
    /*U*/case 46:   return "'";
    /*v*/case 21:   return "g";
    /*V*/case 47:   return "G";
    /*w*/case 22:   return "zh";
    /*W*/case 48:   return "Zh";
    /*x*/case 23:   return "q";
    /*X*/case 49:   return "Q";
    /*y*/case 24:   return "o";
    /*Y*/case 50:   return "O";
    /*z*/case 25:   return "j";
    /*Z*/case 51:   return "J";
    default: return sLetter;
    } return "";
}//end ConvertDwarf

////////////////////////////////////////////////////////////////////////
string ProcessDwarf(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertDwarf(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertElven(string sLetter)
{

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "il";
    case 26: return "Il";
    case 1: return "f";
    case 2: return "ny";
    case 28: return "Ny";
    case 3: return "w";
    case 4: return "a";
    case 5: return "o";
    case 6: return "v";
    case 7: return "ir";
    case 33: return "Ir";
    case 8: return "e";
    case 9: return "qu";
    case 35: return "Qu";
    case 10: return "n";
    case 11: return "c";
    case 12: return "s";
    case 13: return "l";
    case 14: return "e";
    case 15: return "ty";
    case 41: return "Ty";
    case 16: return "h";
    case 17: return "m";
    case 18: return "la";
    case 44: return "La";
    case 19: return "an";
    case 45: return "An";
    case 20: return "y";
    case 21: return "el";
    case 47: return "El";
    case 22: return "am";
    case 48: return "Am";
    case 23: return "'";
    case 24: return "a";
    case 25: return "j";

    case 27: return "F";
    case 29: return "W";
    case 30: return "A";
    case 31: return "O";
    case 32: return "V";
    case 34: return "E";
    case 36: return "N";
    case 37: return "C";
    case 38: return "S";
    case 39: return "L";
    case 40: return "E";
    case 42: return "H";
    case 43: return "M";
    case 46: return "Y";
    case 49: return "'";
    case 50: return "A";
    case 51: return "J";

    default: return sLetter;
    } return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessElven(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertElven(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertGnome(string sLetter)
{ // modified Arnheim Goblin

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    /*a*/case 0:     return "o";
    /*A*/case 26:    return "O";
    /*b*/case 1:     return "ve";
    /*B*/case 27:    return "Ve";
    /*c*/case 2:     return "sk";
    /*C*/case 28:    return "Sk";
    /*d*/case 3:     return "t";
    /*D*/case 29:    return "T";
    /*e*/case 4:     return "u";
    /*E*/case 30:    return "U";
    /*f*/case 5:     return "\F1";
    /*F*/case 31:    return "\D1";
    /*g*/case 6:     return "ch";
    /*G*/case 32:    return "Ch";
    /*h*/case 7:     return "r";
    /*H*/case 33:    return "R";
    /*i*/case 8:     return "o";
    /*I*/case 34:    return "O";
    /*j*/case 9:     return "sh";
    /*J*/case 35:    return "Sh";
    /*k*/case 10:    return "g";
    /*K*/case 36:    return "G";
    /*l*/case 11:    return "h";
    /*L*/case 37:    return "H";
    /*m*/case 12:    return "s";
    /*M*/case 38:    return "S";
    /*n*/case 13:    return "z";
    /*N*/case 39:    return "Z";
    /*o*/case 14:    return "a";
    /*O*/case 40:    return "A";
    /*p*/case 15:    return "v";
    /*P*/case 41:    return "V";
    /*q*/case 16:    return "q";
    /*Q*/case 42:    return "Q";
    /*r*/case 17:    return "n";
    /*R*/case 43:    return "N";
    /*s*/case 18:    return "ngh";
    /*S*/case 44:    return "Ngh";
    /*t*/case 19:    return "th";
    /*T*/case 45:    return "Th";
    /*u*/case 20:    return "e";
    /*U*/case 46:    return "E";
    /*v*/case 21:    return "b";
    /*V*/case 47:    return "B";
    /*w*/case 22:    return "p";
    /*W*/case 48:    return "P";
    /*x*/case 23:    return "la";
    /*X*/case 49:    return "La";
    /*y*/case 24:    return "\E0";
    /*Y*/case 50:    return "\C1";
    /*z*/case 25:    return "gh";
    /*Z*/case 51:    return "Gh";
    /*'*/case 52:    return "s \D6";
    default:    return sLetter;
    }
    return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessGnome(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertGnome(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertAlzhedo(string sLetter)
{

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
//cipher based on Al Baed -> English
    case 0: return "e";
    case 1: return "p";
    case 2: return "s";
    case 3: return "t";
    case 4: return "i";
    case 5: return "w";
    case 6: return "k";
    case 7: return "n";
    case 8: return "u";
    case 9: return "v";
    case 10: return "g";
    case 11: return "c";
    case 12: return "l";
    case 13: return "r";
    case 14: return "y";
    case 15: return "b";
    case 16: return "x";
    case 17: return "h";
    case 18: return "m";
    case 19: return "d";
    case 20: return "o";
    case 21: return "f";
    case 22: return "z";
    case 23: return "q";
    case 24: return "a";
    case 25: return "j";
    case 26: return "E";
    case 27: return "P";
    case 28: return "S";
    case 29: return "T";
    case 30: return "I";
    case 31: return "W";
    case 32: return "K";
    case 33: return "N";
    case 34: return "U";
    case 35: return "V";
    case 36: return "G";
    case 37: return "C";
    case 38: return "L";
    case 39: return "R";
    case 40: return "Y";
    case 41: return "B";
    case 42: return "X";
    case 43: return "H";
    case 44: return "M";
    case 45: return "D";
    case 46: return "O";
    case 47: return "F";
    case 48: return "Z";
    case 49: return "Q";
    case 50: return "A";
    case 51: return "J";
    default: return sLetter;
    } return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessAlzhedo(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertAlzhedo(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertOrc(string sLetter)
{
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    /*a*/case 0:    return "az";
    /*A*/case 26:   return "A";
    /*b*/case 1:    return "po";
    /*B*/case 27:   return "Po";
    /*c*/case 2:    return "zhi";
    /*C*/case 28:   return "Zhi";
    /*d*/case 3:    return "nsh";
    /*D*/case 29:   return "N";
    /*e*/case 4:    return "ha";
    /*E*/case 30:   return "H";
    /*f*/case 5:    return "w";
    /*F*/case 31:   return "Wa";
    /*g*/case 6:    return "k";
    /*G*/case 32:   return "K";
    /*h*/case 7:    return "a";
    /*H*/case 33:   return "'";
    /*i*/case 8:    return "a";
    /*I*/case 34:   return "Az";
    /*j*/case 9:    return "dr";
    /*J*/case 35:   return "Dr";
    /*k*/case 10:   return "g";
    /*K*/case 36:   return "G";
    /*l*/case 11:   return "n";
    /*L*/case 37:   return "N";
    /*m*/case 12:   return "l";
    /*M*/case 38:   return "L";
    /*n*/case 13:   return "r";
    /*N*/case 39:   return "R";
    /*o*/case 14:   return "u";
    /*O*/case 40:   return "Uz";
    /*p*/case 15:   return "rh";
    /*P*/case 41:   return "Rh";
    /*q*/case 16:   return "ko";
    /*Q*/case 42:   return "Ko";
    /*r*/case 17:   return "h";
    /*R*/case 43:   return "Ha";
    /*s*/case 18:   return "thaz";
    /*S*/case 44:   return "Tha";
    /*t*/case 19:   return "nh";
    /*T*/case 45:   return "Nh";
    /*u*/case 20:   return "";
    /*U*/case 46:   return "'";
    /*v*/case 21:   return "z";
    /*V*/case 47:   return "Z";
    /*w*/case 22:   return "sh";
    /*W*/case 48:   return "Sh";
    /*x*/case 23:   return "kw";
    /*X*/case 49:   return "Kw";
    /*y*/case 24:   return "";
    /*Y*/case 50:   return "'";
    /*z*/case 25:   return "y";
    /*Z*/case 51:   return "Y";
    default: return sLetter;
    } return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessOrc(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertOrc(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertJotun(string sLetter)
{
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    // momdified vives ORCLUN
    switch (iTrans)
    {
/*a*/case 0: return "a";
    case 26: return "Ja";
/*b*/case 1: return "p";
    case 27: return "P";
/*c*/case 2: return "k";
    case 28: return "K";
/*d*/case 3: return "t";
    case 29: return "T";
/*e*/case 4: return "o";
    case 30: return "O";
/*f*/case 5: return "j";
    case 31: return "Ji";
/*g*/case 6: return "k";
    case 32: return "K";
/*h*/case 7: return "r";
    case 33: return "R";
/*i*/case 8: return "e";
    case 34: return "Je";
/*j*/case 9: return "m";
    case 35: return "M";
/*k*/case 10: return "g";
    case 36: return "G";
/*l*/case 11: return "j";
    case 37: return "J";
/*m*/case 12: return "r";
    case 38: return "R";
/*n*/case 13: return "k";
    case 39: return "K";
/*o*/case 14: return "u";
    case 40: return "Ju";
/*p*/case 15: return "b";
    case 41: return "B";
/*q*/case 16: return "k";
    case 42: return "K";
/*r*/case 17: return "h";
    case 43: return "H";
/*s*/case 18: return "g";
    case 44: return "G";
/*t*/case 19: return "n";
    case 45: return "N";
/*u*/case 20: return "oo";
    case 46: return "Oo";
/*v*/case 21: return "g";
    case 47: return "G";
/*w*/case 22: return "r";
    case 48: return "R";
/*x*/case 23: return "r";
    case 49: return "R";
/*y*/case 24: return "j";
    case 50: return "Jo";
/*z*/case 25: return "m";
    case 51: return "M";
    default: return sLetter;
    } return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessJotun(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertJotun(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertAnimal(string sLetter)
{

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    if(iTrans>-1 && iTrans<52)
        return "'";
    else
        return sLetter;
}

////////////////////////////////////////////////////////////////////////
string ProcessAnimal(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertAnimal(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ProcessCant(string sLetter)
{

        sLetter = GetStringLeft(sLetter, 1);

    if (sLetter == "a" || sLetter == "A") return "*shields eyes*";
    if (sLetter == "b" || sLetter == "B") return "*blusters*";
    if (sLetter == "c" || sLetter == "C") return "*coughs*";
    if (sLetter == "d" || sLetter == "D") return "*furrows brow*";
    if (sLetter == "e" || sLetter == "E") return "*examines ground*";
    if (sLetter == "f" || sLetter == "F") return "*frowns*";
    if (sLetter == "g" || sLetter == "G") return "*glances up*";
    if (sLetter == "h" || sLetter == "H") return "*hangs head*";
    if (sLetter == "i" || sLetter == "I") return "*looks bored*";
    if (sLetter == "j" || sLetter == "J") return "*rubs chin*";
    if (sLetter == "k" || sLetter == "K") return "*scratches ear*";
    if (sLetter == "l" || sLetter == "L") return "*clicks tongue*"; // changed from looks around
    if (sLetter == "m" || sLetter == "M") return "*mmm hmm*";
    if (sLetter == "n" || sLetter == "N") return "*nods*";
    if (sLetter == "o" || sLetter == "O") return "*grins*";
    if (sLetter == "p" || sLetter == "P") return "*smiles*";
    if (sLetter == "q" || sLetter == "Q") return "*shivers*";
    if (sLetter == "r" || sLetter == "R") return "*rolls eyes*";
    if (sLetter == "s" || sLetter == "S") return "*picks nose*";  // Barnas is not playing, so picks nose is back
    if (sLetter == "t" || sLetter == "T") return "*slight turn*";
    if (sLetter == "u" || sLetter == "U") return "*glances idly*";
    if (sLetter == "v" || sLetter == "V") return "*runs hand through hair*";
    if (sLetter == "w" || sLetter == "W") return "*wrinkles nose*"; //passes gas
    if (sLetter == "x" || sLetter == "X") return "*stretches*";
    if (sLetter == "y" || sLetter == "Y") return "*yawns*";
    if (sLetter == "z" || sLetter == "Z") return "*shrugs*";

    return "*nods*";
}

////////////////////////////////////////////////////////////////////////
string ConvertSylvan(string sLetter)
{

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "i";
    case 1: return "ri";
    case 2: return "ba";
    case 3: return "ma";
    case 4: return "i";
    case 5: return "mo";
    case 6: return "yo";
    case 7: return "f";
    case 8: return "ya";
    case 9: return "ta";
    case 10: return "m";
    case 11: return "t";
    case 12: return "r";
    case 13: return "j";
    case 14: return "nu";
    case 15: return "wi";
    case 16: return "bo";
    case 17: return "w";
    case 18: return "ne";
    case 19: return "na";
    case 20: return "li";
    case 21: return "v";
    case 22: return "ni";
    case 23: return "ya";
    case 24: return "mi";
    case 25: return "og";
    case 26: return "I";
    case 27: return "Ri";
    case 28: return "Ba";
    case 29: return "Ma";
    case 30: return "I";
    case 31: return "Mo";
    case 32: return "Yo";
    case 33: return "F";
    case 34: return "Ya";
    case 35: return "Ta";
    case 36: return "M";
    case 37: return "T";
    case 38: return "R";
    case 39: return "J";
    case 40: return "Nu";
    case 41: return "Wi";
    case 42: return "Bo";
    case 43: return "W";
    case 44: return "Ne";
    case 45: return "Na";
    case 46: return "Li";
    case 47: return "V";
    case 48: return "Ni";
    case 49: return "Ya";
    case 50: return "Mi";
    case 51: return "Og";
    default: return sLetter;
    } return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessSylvan(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertSylvan(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertZhent(string sLetter)
{

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "a";
    case 1: return "s";
    case 2: return "n";
    case 3: return "y";
    case 4: return "ov";
    case 5: return "d";
    case 6: return "sk";
    case 7: return "fr";
    case 8: return "u";
    case 9: return "o";
    case 10: return "f";
    case 11: return "r";
    case 12: return "z";
    case 13: return "s";
    case 14: return "o";
    case 15: return "j";
    case 16: return "sk";
    case 17: return " ";
    case 18: return "or";
    case 19: return "ka";
    case 20: return "o";
    case 21: return "ka";
    case 22: return "ma";
    case 23: return "o";
    case 24: return "oj";
    case 25: return "y";
    case 26: return "A";
    case 27: return "S";
    case 28: return "N";
    case 29: return "Y";
    case 30: return "Ov";
    case 31: return "D";
    case 32: return "Sk";
    case 33: return "Fr";
    case 34: return "U";
    case 35: return "O";
    case 36: return "F";
    case 37: return "R";
    case 38: return "Z";
    case 39: return "S";
    case 40: return "O";
    case 41: return "J";
    case 42: return "Sk";
    case 43: return "M";
    case 44: return "Or";
    case 45: return "Ka";
    case 46: return "O";
    case 47: return "Ka";
    case 48: return "Ma";
    case 49: return "O";
    case 50: return "Oj";
    case 51: return "Y";
    default: return sLetter;
    } return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessZhent(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertZhent(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

////////////////////////////////////////////////////////////////////////
string ConvertMulhorandi(string sLetter)
{ // was Mulhorandi

        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "ri";
    case 1: return "dj";
    case 2: return "p";
    case 3: return "al";
    case 4: return "a";
    case 5: return "j";
    case 6: return "y";
    case 7: return "u";
    case 8: return "o";
    case 9: return "f";
    case 10: return "ch";
    case 11: return "d";
    case 12: return "t";
    case 13: return "m";
    case 14: return "eh";
    case 15: return "k";
    case 16: return "ng";
    case 17: return "sh";
    case 18: return "th";
    case 19: return "s";
    case 20: return "e";
    case 21: return "z";
    case 22: return "p";
    case 23: return "qu";
    case 24: return "o";
    case 25: return "z";
    case 26: return "Ri";
    case 27: return "Dj";
    case 28: return "P";
    case 29: return "Al";
    case 30: return "A";
    case 31: return "J";
    case 32: return "Y";
    case 33: return "U";
    case 34: return "O";
    case 35: return "F";
    case 36: return "Ch";
    case 37: return "D";
    case 38: return "T";
    case 39: return "M";
    case 40: return "Eh";
    case 41: return "K";
    case 42: return "Ng";
    case 43: return "Sh";
    case 44: return "Th";
    case 45: return "S";
    case 46: return "E";
    case 47: return "Z";
    case 48: return "P";
    case 49: return "Qu";
    case 50: return "O";
    case 51: return "Z";
    default: return sLetter;
    } return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessMulhorandi(string sPhrase)
{ // was Mulhorandi
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertMulhorandi(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

string ConvertUnderwater(string sLetter)
{
        sLetter = GetStringLeft(sLetter, 1);
    string sTranslate = "aehiloruvyzAEFHIOSUVYZ";
    int iTrans = FindSubString(sTranslate, sLetter);

    switch (iTrans)
    {
    case 0: return "abl";
    case 1: return "ebl";
    case 2: return "hb";
    case 3: return "ibl";
    case 4: return "lbl";
    case 5: return "obl";
    case 6: return "rb";
    case 7: return "oob";
    case 8: return "vb";
    case 9: return "hybl";
    case 10: return "zb";
    case 11: return "Alb";
    case 12: return "Elb";
    case 13: return "Vfb";
    case 14: return "Hblb";
    case 15: return "Ilb";
    case 16: return "Olb";
    case 17: return "Sbb";
    case 18: return "Vbl";
    case 19: return "Hybl";
    case 20: return "Zbl";
    default: return sLetter;
    } return "";
}

string ProcessUnderwater(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertUnderwater(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}

// MAGUS ///////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////
string ConvertSilence(string sLetter)
{
    if (sLetter == "." || sLetter == "!" || sLetter == "?" || sLetter == ",")
        return " ";
    else
        return "";
}

////////////////////////////////////////////////////////////////////////
string ProcessSilence(string sPhrase)
{
    string sOutput;
    int iToggle;
    while (sPhrase!="")
    {
        if (GetStringLeft(sPhrase,1) == "*")
            iToggle = abs(iToggle - 1);
        if (iToggle)
            sOutput = sOutput + GetStringLeft(sPhrase,1);
        else
            sOutput = sOutput + ConvertSilence(GetStringLeft(sPhrase, 1));
        sPhrase = GetStringRight(sPhrase, GetStringLength(sPhrase)-1);
    }
    return sOutput;
}
/////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////
string TranslateCommonToLanguage(int iLang, string sText)
{
    switch (iLang)
    {
    case LANG_SYLVAN: //Sylvan
        return ProcessSylvan(sText); break;
    case LANG_GNOME: //Gnome
        return ProcessGnome(sText); break;
    case LANG_COMMON: // Common
        return sText; break;
    case LANG_DWARF: //Dwarf
        return ProcessDwarf(sText); break;
    case LANG_ORC: //Orc
        return ProcessOrc(sText); break;
    case LANG_GOBLIN: //Goblin
        return ProcessGoblin(sText); break;
    case LANG_DRACONIC: //Draconic
        return ProcessDraconic(sText); break;
    case LANG_ANIMAL: //Animal
        return ProcessAnimal(sText); break;
    case LANG_THIEVESCANT: //Thieves Cant
        return ProcessCant(sText); break;
    case LANG_CELESTIAL: //Celestial
        return ProcessCelestial(sText); break;
    case LANG_ALZHEDO: //Alzhedo
        return ProcessAlzhedo(sText); break;
    case LANG_INFERNAL: //Infernal
        return ProcessInfernal(sText); break;
    case LANG_ELF:
        return ProcessElven(sText); break;
    case LANG_UNDERCOMMON: // Undercommon - shadowy mishmash language
        return ProcessShadows(sText); break;
    case LANG_DRUID: // Druidic
        return ProcessDruidic(sText); break;
    case LANG_NETHER: // Loross - old noble netherese
        return ProcessNether(sText); break;
    case LANG_SILENCE: // SILENCE - GOLDEN
        return ProcessSilence(sText); break;
    case LANG_MULHORANDI:
        return ProcessMulhorandi(sText); break;
    case LANG_ZHENT: // Tharian, Phlan, Zhents
        return ProcessZhent(sText); break;
    case LANG_UNDERWATER: // Underwater
        return ProcessUnderwater(sText); break;
    case LANG_JOTUN: // Underwater
        return ProcessJotun(sText); break;
    case 99: //1337
        return ProcessLeetspeak(sText); break;
    default: if (iLang > 100) return ProcessCustom(sText, iLang - 100);break;
    }
    return "";
}

////////////////////////////////////////////////////////////////////////
void subTranslateToLanguage(string sSaid, object oShouter, int nVolume,
                            object oMaster, int iTranslate, string sLanguageName,
                            object oEavesdrop)
{
    string sVolume = "said";
    if (nVolume == TALKVOLUME_WHISPER) sVolume = "whispered";
    else if (nVolume == TALKVOLUME_SHOUT) sVolume = "shouted";
    else if (nVolume == TALKVOLUME_PARTY) sVolume = "said to the party";
    else if (nVolume == TALKVOLUME_SILENT_SHOUT) sVolume = "said to the DM's";

    int nAss    = GetAssociateType(oShouter);

    //Translate and Send or do Lore check
    if(    (oEavesdrop==oMaster && (nAss==ASSOCIATE_TYPE_FAMILIAR||nAss==ASSOCIATE_TYPE_ANIMALCOMPANION))
        ||  GetSpeaksLanguage(oEavesdrop, iTranslate)
        ||  GetIsDM(oEavesdrop)
        ||  GetIsDMPossessed(oEavesdrop)
      )
    {
        DelayCommand(0.1,
            SendMessageToPC(
                    oEavesdrop,
                    CYAN+GetName(oShouter) + " " + sVolume + " in " + sLanguageName + ": " + WHITE + sSaid
                )
            );
    }
    else
    {
        if (iTranslate != 9)
        {
            string sKnownLanguage;
            if( d20()+GetSkillRank(SKILL_LORE, oEavesdrop, TRUE) >= GetLoreToRecognizeLanguage(iTranslate) )
                sKnownLanguage = sLanguageName;
            else
                sKnownLanguage = "a language you do not recognize";
            DelayCommand(0.1,
                SendMessageToPC(
                        oEavesdrop,
                        CYAN+GetName(oShouter)+" "+sVolume+" something in "+sKnownLanguage+"."
                    )
                );
        }
    }
}

////////////////////////////////////////////////////////////////////////
string TranslateToLanguage(string sSaid, object oShouter, int nVolume, object oMaster, int nLang=0)
{
// arguments
//  (return) = translated text
//  sSaid = string to translate
//  oShouter = object that spoke sSaid
//  iVolume = TALKVOLUME setting of speaker
//  oMaster = master of oShouter (if oShouter has no master, oMaster should equal oShouter)

    //Gets the current language that the character is speaking
    int iTranslate;
    int nSpokenLang = GetCurrentLanguageSpoken(oShouter); // enable lip reading
    if (!nSpokenLang)
        nSpokenLang = GetDefaultRacialLanguage(oShouter);

    // Magus -- set explicit language to translate to
    if(nLang)
        iTranslate  = nLang;
    else
    {
        iTranslate  = nSpokenLang;
        nLang       = nSpokenLang;
    }

    if (!iTranslate)
    {
        DMFISendMessageToPC(oMaster, "Translator Error: your message was dropped.", FALSE, DMFI_MESSAGE_COLOR_ALERT);
        return "";
    }



    //Thieves' Cant character limit of 25
    if (iTranslate == LANG_THIEVESCANT && GetStringLength(sSaid) > 25)
        sSaid = GetStringLeft(sSaid, 25);
    string sSpeak = TranslateCommonToLanguage(iTranslate, sSaid);
    /*
    //Defines language name
    string sLanguageName = GetLanguageName(iTranslate);
    if( iTranslate==LANG_ANIMAL ||  iTranslate==LANG_SILENCE )
        sLanguageName = GetStringLowerCase(sLanguageName);
    // send speech to everyone who should be able to hear
    float fDistance = 20.0f;
    if (nVolume == TALKVOLUME_WHISPER)
        fDistance = 1.0f;

    string sVolume = "said";
    if (nVolume == TALKVOLUME_WHISPER) sVolume = "whispered";
    else if (nVolume == TALKVOLUME_SHOUT) sVolume = "shouted";
    else if (nVolume == TALKVOLUME_PARTY) sVolume = "said to the party";
    else if (nVolume == TALKVOLUME_SILENT_SHOUT) sVolume = "said to the DM's";
    string sKnownLanguage;

    // send translated message to PC's in range or DMs
    object oAreaShout   = GetArea(oShouter);
    location lLocShout  = GetLocation(oShouter);
    object oEavesdrop   = GetFirstPC();
    while (GetIsObjectValid(oEavesdrop))
    {
        if(     oAreaShout == GetArea(oEavesdrop)
            &&  !GetIsDM(oEavesdrop)
            &&  GetDistanceBetweenLocations(lLocShout, GetLocation(oEavesdrop)) <= fDistance
          )
        {
            subTranslateToLanguage(sSaid, oShouter, nVolume, oMaster, iTranslate, sLanguageName, oEavesdrop);
        }

        oEavesdrop = GetNextPC();
    }
    */
    return sSpeak;
}

////////////////////////////////////////////////////////////////////////
int GetDefaultRacialLanguage(object oPC)
{
    if(     !GetIsDM(oPC)
        &&  !GetIsDMPossessed(oPC)
        &&  !GetIsPossessedFamiliar(oPC)
        &&  GetIsPC(oPC)
      )
    {
        return LANG_COMMON;
    }

    switch (GetRacialType(oPC))
    {
    case RACIAL_TYPE_DWARF:
        return LANG_DWARF;
    break;
    case RACIAL_TYPE_ELF:
        return LANG_ELF;
    break;
    case RACIAL_TYPE_FEY:
        return LANG_SYLVAN;
    break;
    case RACIAL_TYPE_GNOME:
        return LANG_GNOME;
    break;
    case RACIAL_TYPE_HALFLING:
        return LANG_ALZHEDO;
    break;
    case RACIAL_TYPE_HUMANOID_GOBLINOID:
    case RACIAL_TYPE_HUMANOID_MONSTROUS:
        return LANG_GOBLIN;
    break;
    case RACIAL_TYPE_HUMANOID_REPTILIAN:
    case RACIAL_TYPE_DRAGON:
        return LANG_DRACONIC;
    break;
    case RACIAL_TYPE_ANIMAL:
    case RACIAL_TYPE_BEAST:
    case RACIAL_TYPE_MAGICAL_BEAST:
        return LANG_ANIMAL;
    break;
    case RACIAL_TYPE_GIANT:
        return LANG_JOTUN;
    break;
    default:
    break;
    }

    return LANG_COMMON;
}

//void main(){}

