//::///////////////////////////////////////////////
//:: FileName te_conv_altchk
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/8/2017 11:56:26 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;

    if(GetLevelByClass(CLASS_TYPE_DRUID, GetPCSpeaker()) >= 13)
        iPassed = 1;

    if((iPassed == 0) && (GetLevelByClass(CLASS_TYPE_ASSASSIN, GetPCSpeaker()) >= 4))
        iPassed = 1;

    if((iPassed == 0) && (GetHasFeat(1203,GetPCSpeaker()) == TRUE))
        iPassed = 1;

    if((iPassed == 0) && (GetLocalInt(GetArea(GetPCSpeaker()),"iAlter") == 1))
        iPassed = 1;

    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
