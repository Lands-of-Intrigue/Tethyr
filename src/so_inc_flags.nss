//:://////////////////////////////////////////////////
//:: rl_inc_flag
/*
  Most of this is more or less inspired by x0_i0_spawncond-
  For once, i'm not gonna reinvent the wheel ;)
 */
//:://////////////////////////////////////////////////
//:: Created By: Zarathustra217
//:: Created On:
//:://////////////////////////////////////////////////

#include "so_inc_constants"


// These are the names of the local variables that hold the flags
const string FLAG_TYPE_PLACEABLE = "RL_FLAG_PLACEABLE";
const string FLAG_TYPE_PC_HIDE_BACKGROUND = "RL_FLAG_PC_HIDE_BACKGROUND";


// The available flags for placeables:
/*
Init                    1                               -Must be set
OnOff                   1                               -Sets the placeable to allow being toggled. Make sure to include the PlaceableOnOff script on the placable's OnUsed event
    OnOffVFX            1-505                           -VFX that can be toggled
    AutoDeactivate      1                               -Auto deactivates when area is emptied
    AutoActivate        1                               -Auto activates when area is emptied
    Activated           1                               -Starting Condition
ConstantEffectVFX       1-505                           -Constant VFX
ConstantEffectVFX2      1-505                           -Constant VFX
AutoClose               1                               -Auto closes when area is emptied
AutoLock                1                               -Auto locks when area is emptied
AutoUnlock              1                               -Auto unlocks when area is emptied
*/

const int FLAG_PLACEABLE_INIT              = 0x00000001;
const int FLAG_PLACEABLE_AUTODEACTIVATE    = 0x00000002;
const int FLAG_PLACEABLE_AUTOACTIVATE      = 0x00000004;
const int FLAG_PLACEABLE_ACTIVATED         = 0x00000008;
const int FLAG_PLACEABLE_AUTOCLOSE         = 0x00000010;
const int FLAG_PLACEABLE_AUTOLOCK          = 0x00000020;
const int FLAG_PLACEABLE_AUTOUNLOCK        = 0x00000040;
const int FLAG_PLACEABLE_AUTOOPEN          = 0x00000080;
const int FLAG_PLACEABLE_ONOFF             = 0x00000100;
const int FLAG_PLACEABLE_AUTORESET         = 0x00000200;
/*const int FLAG_PLACEABLE_11                = 0x00000400;
const int FLAG_PLACEABLE_12                = 0x00000800;
const int FLAG_PLACEABLE_13                = 0x00001000;
const int FLAG_PLACEABLE_14                = 0x00002000;
const int FLAG_PLACEABLE_15                = 0x00004000;
const int FLAG_PLACEABLE_16                = 0x00008000;
const int FLAG_PLACEABLE_17                = 0x00010000;
const int FLAG_PLACEABLE_18                = 0x00020000;
const int FLAG_PLACEABLE_19                = 0x00040000;
const int FLAG_PLACEABLE_20                = 0x00080000;
const int FLAG_PLACEABLE_21                = 0x00100000;
const int FLAG_PLACEABLE_22                = 0x00200000;
const int FLAG_PLACEABLE_23                = 0x00400000;
const int FLAG_PLACEABLE_24                = 0x00800000;
const int FLAG_PLACEABLE_25                = 0x01000000;
const int FLAG_PLACEABLE_26                = 0x02000000;
const int FLAG_PLACEABLE_27                = 0x04000000;
const int FLAG_PLACEABLE_28                = 0x08000000;
const int FLAG_PLACEABLE_29                = 0x10000000;
const int FLAG_PLACEABLE_30                = 0x20000000;
const int FLAG_PLACEABLE_31                = 0x40000000;
const int FLAG_PLACEABLE_32                = 0x80000000;*/


const int FLAG_PC_HIDE_BACKGROUND_DIPLOMAT = 0x00000001;
const int FLAG_PC_HIDE_BACKGROUND_SCHOLAR  = 0x00000002;
const int FLAG_PC_HIDE_BACKGROUND_SMITH    = 0x00000004;
const int FLAG_PC_HIDE_BACKGROUND_MILITARY = 0x00000008;
const int FLAG_PC_HIDE_BACKGROUND_TREASURE_HUNTER = 0x00000010;
const int FLAG_PC_HIDE_BACKGROUND_BRAWLER = 0x00000020;
const int FLAG_PC_HIDE_BACKGROUND_GNOMISH_APPRENTICE = 0x00000040;
const int FLAG_PC_HIDE_BACKGROUND_MAGICAL_SCHOLAR = 0x00000080;
const int FLAG_PC_HIDE_BACKGROUND_ACTOR    = 0x00000100;
const int FLAG_PC_HIDE_BACKGROUND_ACROBAT  = 0x00000200;
const int FLAG_PC_HIDE_BACKGROUND_SCOUT = 0x00000400;
const int FLAG_PC_HIDE_BACKGROUND_CUTPURSE = 0x00000800;
const int FLAG_PC_HIDE_BACKGROUND_STALKER  = 0x00001000;
const int FLAG_PC_HIDE_BACKGROUND_CHILD_OF_THE_WILD = 0x00002000;
/*const int FLAG_PC_HIDE_                    = 0x00004000;
const int FLAG_PC_HIDE_                    = 0x00008000;
const int FLAG_PC_HIDE_                    = 0x00010000;
const int FLAG_PC_HIDE_                    = 0x00020000;
const int FLAG_PC_HIDE_                    = 0x00040000;
const int FLAG_PC_HIDE_                    = 0x00080000;
const int FLAG_PC_HIDE_                    = 0x00100000;
const int FLAG_PC_HIDE_                    = 0x00200000;
const int FLAG_PC_HIDE_                    = 0x00400000;
const int FLAG_PC_HIDE_                    = 0x00800000;
const int FLAG_PC_HIDE_                    = 0x01000000;
const int FLAG_PC_HIDE_                    = 0x02000000;
const int FLAG_PC_HIDE_                    = 0x04000000;
const int FLAG_PC_HIDE_                    = 0x08000000;
const int FLAG_PC_HIDE_                    = 0x10000000;
const int FLAG_PC_HIDE_                    = 0x20000000;
const int FLAG_PC_HIDE_                    = 0x40000000;
const int FLAG_PC_HIDE_                    = 0x80000000;*/



// Sets the specified flag on the caller as directed.
void SetFlag(object oObject, string sFlagType, int nFlag, int bValue = TRUE);

// Returns TRUE if the specified flag has been set on the
// caller, otherwise FALSE.
int GetFlag(object oObject, string sFlagType, int nFlag);


/**********************************************************************
 * FUNCTION DEFINITIONS
 **********************************************************************/

// Sets the specified flag on the caller as directed.
/*void SetFlag(object oObject, string sFlagType, int nFlag, int bValue = TRUE)
{
    int nFlags = GetLocalInt(oObject, sFlagType);
    if (bValue == FALSE)
    {
        // Remove the given spawn-in condition
        nFlags = nFlags & ~nFlag;
        SetLocalInt(oObject, sFlagType, nFlags);
    }
    else
    {
        // Add the given spawn-in condition
        nFlags = nFlags | nFlag;
        SetLocalInt(oObject, sFlagType, nFlags);
    }
}*/
void SetFlag(object oObject, string sFlagType, int nFlag, int bValue = TRUE){
    int nFlags = GetLocalInt(oObject, sFlagType);
    SetLocalInt(oObject, sFlagType, bValue ? nFlags | nFlag : nFlags & ~nFlag);
}

/*// Returns TRUE if the specified flag has been set on the
// caller, otherwise FALSE.
int GetFlag(object oObject, string sFlagType, int nFlag)
{
    int nFlags = GetLocalInt(oObject, sFlagType);
    if(nFlags & nFlag)
    {
        return TRUE;
    }
    return FALSE;
}*/

int GetFlag(object oObject, string sFlagType, int nFlag){
    return GetLocalInt(oObject, sFlagType) & nFlag;
}


