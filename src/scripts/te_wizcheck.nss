//::///////////////////////////////////////////////
//:: FileName te_wizcheck
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/2/2016 8:00:25 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Restrict based on the player's class
	int iPassed = 0;
	if(GetLevelByClass(CLASS_TYPE_WIZARD, GetPCSpeaker()) >= 1)
		iPassed = 1;
	if(iPassed == 0)
		return FALSE;

	return TRUE;
}
