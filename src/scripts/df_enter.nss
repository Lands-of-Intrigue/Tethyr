#include "nw_i0_tool"
#include "df_handler"
void main()
{
    object oTarget = GetEnteringObject();
    SendMessageToPC(oTarget, "Entering Oxygen Deprived Area");

    //Variables
    int nBreathWater = (DF_CheckBreathType(oTarget, DF_BreathType_Water));
    string sBreathWater = "nBreathWater";
    int nBreathSmog = (DF_CheckBreathType(oTarget, DF_BreathType_Smog));
    string sBreathSmog = "nBreathSmog";
    int nDrownState = 0;
    string sDrownState = "nDrownState";
    int nDrownDC = 10;
    string sDrownDC = "nDrownDC";
    int nMaxOxygenHD = (GetAbilityModifier(ABILITY_CONSTITUTION, oTarget)*2);
    string sMaxOxygenHD = "nMaxOxygenHD";
    int nCurOxygenHD = nMaxOxygenHD;
    string sCurOxygenHD = "nCurOxygenHD";

    //Set Variables
    SetLocalInt(oTarget, sBreathWater, nBreathWater);
    SetLocalInt(oTarget, sBreathSmog, nBreathSmog);
    SetLocalInt(oTarget, sDrownState, nDrownState);
    SetLocalInt(oTarget, sDrownDC, nDrownDC);
    SetLocalInt(oTarget, sMaxOxygenHD, nMaxOxygenHD);
    SetLocalInt(oTarget, sCurOxygenHD, nCurOxygenHD);
}

