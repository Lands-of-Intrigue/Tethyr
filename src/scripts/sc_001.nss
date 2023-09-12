//::///////////////////////////////////////////////
//:: FileName sc_001
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/6/2016 5:27:24 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "iMount") == 1))
		return FALSE;
	if(!(GetLocalInt(GetPCSpeaker(), "iStore") == 0))
		return FALSE;

	return TRUE;
}
