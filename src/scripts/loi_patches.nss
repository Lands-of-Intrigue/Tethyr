#include "nwnx_creature"
#include "loi_xp"

const int LEVEL_14_XP_TOTAL = 91000;

// This file is for things that are one offs or hacks to avoid 2da edits

void ApplyPatchesTo(object oPC);

void ApplyPatchesTo(object oPC)
{
    // if character has levels in base full caster classes
    if(GetLevelByClass(CLASS_TYPE_BARD,oPC)>=1 
        || GetLevelByClass(CLASS_TYPE_SORCERER,oPC)>=1
        || GetLevelByClass(CLASS_TYPE_WIZARD,oPC)>=1)
    {
        // and if they don't have Eschew Materials, award it to them
        if (GetHasFeat(1409,oPC) == FALSE)
        {
            NWNX_Creature_AddFeat(oPC, 1409);
        }
    }

    // apply soft cap
    int nLostXP = DelevelToSoftCap(oPC);
    if (nLostXP > 0)
    {
        FullRelevel(oPC);

        string sMessage = RED + "ALERT \n" + COLOR_END;
        sMessage += "Since you have more XP than our soft cap allows, you will receive a free relevel. \n";
        sMessage += "You may reach out to a DM to work on one special RP-centric item, with stats within reason, for your character. \n";
        sMessage += "Also, your lost XP will be made available for you to apply to an unplayed alt character. \n";
        sMessage += RED + "SCREENSHOT THIS LOG AS PROOF FOR DMS: " + COLOR_END + WHITE + IntToString(nLostXP);
        sMessage += " " + GetPCPublicCDKey(oPC) + " " + GetPCPlayerName(oPC) + " " + GetName(oPC) + COLOR_END + "\n";
        sMessage += RED + "END ALERT" + COLOR_END;
        SendMessageToPC(oPC, sMessage);
    }
}