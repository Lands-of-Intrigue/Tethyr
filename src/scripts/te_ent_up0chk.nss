//::///////////////////////////////////////////////
//:: FileName te_convclasslow
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/17/2016 11:57:32 AM
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC,"PC_Data_Object");

    int iEntUp = GetLocalInt(oItem,"te_ent_up");

    // Make sure the player has the required feats
    if(GetHasFeat(1152, GetPCSpeaker())&& iEntUp == 0)
        return TRUE;

    return FALSE;
}
