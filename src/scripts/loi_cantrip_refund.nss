#include "inc_spell_func"
#include "nwnx_events"
#include "nwnx_creature"

void main()
{
    object oPC = OBJECT_SELF;

    int nSpell = StringToInt(NWNX_Events_GetEventData("SPELL_ID"));
    int nSL = SFGetInnateSpellLevelByClass(nSpell, CLASS_TYPE_WIZARD);
    int nMetamagic = StringToInt(NWNX_Events_GetEventData("METAMAGIC"));

    if (nSL == 0 && nMetamagic == METAMAGIC_NONE)
    {
        int nCasterClassIndex = StringToInt(NWNX_Events_GetEventData("CLASS"));
        int nCasterClass = GetClassByPosition(nCasterClassIndex + 1);

        if (nCasterClass == CLASS_TYPE_SORCERER)
        {
            // just reset slots to maximum
            int nMaxSlots = NWNX_Creature_GetMaxSpellSlots(oPC, CLASS_TYPE_SORCERER, 0);
            NWNX_Creature_SetRemainingSpellSlots(oPC, CLASS_TYPE_SORCERER, 0, nMaxSlots);
        }

        if (nCasterClass == CLASS_TYPE_WIZARD)
        {
            // get the index of the last slot
            int nSlot = GetMemorizedSpellCountByLevel(oPC, CLASS_TYPE_WIZARD, 0);

            // loop down the cantrips section of the spellbook
            // if you find one with the same id as cast, refund it
            // index bounds 0 <= nIndex < GetMemorizedSpellCountByLevel()
            int i;
            for (i = 0; i < nSlot; i++)
            {
                if (GetMemorizedSpellId(oPC, CLASS_TYPE_WIZARD, 0, i) == nSpell)
                {
                    SetMemorizedSpellReady(oPC, CLASS_TYPE_WIZARD, 0, i, TRUE);
                }
            }
        }
    }
}