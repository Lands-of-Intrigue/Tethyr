//::///////////////////////////////////////////////
//:: FileName sc_003
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/2/2017 7:16:45 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Restrict based on the player's class
	int iPassed = 0;
	if(GetLevelByClass(CLASS_TYPE_DRUID, GetPCSpeaker()) >= 1)
		iPassed = 1;
	if(iPassed == 0)
		return FALSE;

	return TRUE;
}
