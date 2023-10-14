#include "nwnx_time"
#include "loi_xp"

void main()
{
    object oPC = GetLastSpellCaster();
    object oData = GetItemPossessedBy(oPC, "PC_Data_Object");
    int nCandle = GetLocalInt(oData, "QuestDWCandle");
    int nTimeNow = NWNX_Time_GetTimeStamp();
    if (GetLastSpell() == SPELL_BURNING_HANDS
    || GetLastSpell() == SPELL_COMBUST
    || GetLastSpell() == SPELL_FLAME_STRIKE
    || GetLastSpell() == SPELL_FLAME_ARROW
    || GetLastSpell() == SPELL_FLAME_LASH
    || GetLastSpell() == SPELL_CONTINUAL_FLAME
    || GetLastSpell() == SPELL_FLARE
    || GetLastSpell() == SPELL_INFERNO
    || GetLastSpell() == SPELL_FIREBALL
    || GetLastSpell() == SPELL_SHADES_FIREBALL
    || GetLastSpell() == SPELL_GRENADE_FIRE
    || GetLastSpell() == SPELL_SEARING_LIGHT
    || GetLastSpell() == SPELLABILITY_HELL_HOUND_FIREBREATH
    || GetLastSpell() == SPELLABILITY_CONE_FIRE
    || GetLastSpell() == SPELLABILITY_BOLT_FIRE
    || GetLastSpell() == SPELLABILITY_AA_IMBUE_ARROW
    || GetLastSpell() == 911
    || GetLastSpell() == 901)
    {
        if (GetTag(GetArea(OBJECT_SELF)) == "bcstfli")
        {
            if (GetLocalInt(OBJECT_SELF, "Active") != 1)
            {
                SetLocalInt(OBJECT_SELF, "Active", 1);
                SetLocalInt(OBJECT_SELF, "TimeOpened",nTimeNow+(60*90));
                PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_WHITE_20), OBJECT_SELF, 3.0);
                if (nCandle < 10)
                {
                    AwardXP(oPC, 5);
                    SetLocalInt(GetItemPossessedBy(oPC, "PC_Data_Object"), "QuestDWCandle", nCandle+1);
                }
                if (GetLocalInt(GetNearestObjectByTag("tn_dwcandle", OBJECT_SELF, 1), "Active") == 1)
                {
                    object oDoor1 = GetNearestObjectByTag("tn_spookydoor", OBJECT_SELF, 1);
                    object oDoor2 = GetNearestObjectByTag("tn_spookydoor", OBJECT_SELF, 2);
                    ActionOpenDoor(oDoor1);
                    SetLocalInt(oDoor1, "TimeOpened",nTimeNow+(60*90));
                    ActionOpenDoor(oDoor2);
                    SetLocalInt(oDoor2, "TimeOpened",nTimeNow+(60*90));
                }
            }
        }
    }
}
