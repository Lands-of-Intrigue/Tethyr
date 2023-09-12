//Must Declare int "nBreathType" Variable to Area Trigger
//nBreathType -
//Water = 1;
//Smog = 2;

#include "df_handler"
void main()
{
    int nBreathType;
    int nBreath;
    int nDrownState;
    int nDrownDC;
    int nCurOxygenHD;
    int nMaxOxygenHD;
    int nDCCheck;
    int nCONMod;
    int nTotal;
    int nDamage;

    string sBreathType;
    string sBreath;
    string sDrownState;
    string sDrownDC;
    string sCurOxygenHD;
    string sMaxOxygenHD;
    string sDCCheck;
    string sCONMod;
    string sTotal;
    string sAreaBreathType;

    effect eDamage;

    object oPCArea;

    object oTarget = GetFirstObjectInArea(OBJECT_SELF);
    if (GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
    {
        oTarget = GetNextObjectInArea(OBJECT_SELF);
    }
    while (GetIsObjectValid(oTarget))
    {
        if(DF_GetMaxOxygenHD(oTarget) == 0){DF_ReplenishOxygen(oTarget);}
        if(DF_GetDrownState(oTarget) == DF_DrownState_Drowning && GetCurrentHitPoints(oTarget) >= 1)
        {
           DF_SetCurrentOxygenHD(oTarget, 1);
        }
        if(DF_CheckBreathImmune(oTarget) != 1 && GetCurrentHitPoints(oTarget) >= 1 && GetObjectType(oTarget) == OBJECT_TYPE_CREATURE)
        {
            nBreathType = DF_CheckBreathAreaType(OBJECT_SELF);
            nBreath = DF_GetBreathType(oTarget, nBreathType);
            nDrownState = DF_GetDrownState(oTarget);
            nDrownDC = DF_GetDrownDC(oTarget);
            nCurOxygenHD = DF_GetCurrentOxygenHD(oTarget);
            nMaxOxygenHD = DF_GetMaxOxygenHD(oTarget);

            sBreathType = IntToString(nBreathType);
            sBreath = IntToString(nBreath);
            sDrownState = IntToString(nDrownState);
            sDrownDC = IntToString(nDrownDC);
            sCurOxygenHD = IntToString(nCurOxygenHD);
            sMaxOxygenHD = IntToString(nMaxOxygenHD);

            if (nBreathType == 1)
            {
                sAreaBreathType = "Water";
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, SupernaturalEffect(EffectVisualEffect(566)), oTarget,4.0f);
            }
            if (nBreathType == 2) {sAreaBreathType = "Smog";}
            if (nBreathType == 3) {sAreaBreathType = "Low Oxygen";}
            if (nBreathType == 4) {sAreaBreathType = "No Oxygen";}
            //Debugger
            //SendMessageToPC(oTarget, "BreathType: " + sBreathType);
            //SendMessageToPC(oTarget, "Breath: " + sBreath);
            //SendMessageToPC(oTarget, "DrownState: " + sDrownState);
            //SendMessageToPC(oTarget, "DrownDC: " + sDrownDC);
            //SendMessageToPC(oTarget, "Oxygen: " + sCurOxygenHD + "/" + sMaxOxygenHD);

            //STATE: NOT DROWNING
            //1b. Check WaterBreathing:
                //1 - GoTo 1a
                //0 - GoTo 2a
            //SendMessageToPC(oTarget, "1b");
            SendMessageToPC(oTarget, "::::::::::::::::::::::::::::::::::::::::::::::::");
            SendMessageToPC(oTarget, "Oxygen System v0.6.4");
            SendMessageToPC(oTarget, "------------------------");
            SendMessageToPC(oTarget, "Area: " + sAreaBreathType);
            if (DF_CheckBreathType(oTarget, nBreathType) == 1)
            {
                //1a. Replenish Oxygen
                //SendMessageToPC(oTarget, "1a");
                DF_ReplenishOxygen(oTarget);

                SendMessageToPC(oTarget, "State: Not Drowning");
                SendMessageToPC(oTarget, "O2: " + sCurOxygenHD + "/" + sMaxOxygenHD);
                SendMessageToPC(oTarget, "Suffocate DC: " + sDrownDC);
                SendMessageToPC(oTarget, "::::::::::::::::::::::::::::::::::::::::::::::::");
                return;

            }
            else
            {
                //STATE: HOLDING BREATH
                //2a. Check DrownState:
                    //0||1 - GoTo 2b
                    //2 - GoTo 4a
                //SendMessageToPC(oTarget, "2a");
                if (DF_GetDrownState(oTarget) != DF_DrownState_Drowning)
                {
                    //2b. Set DrownState 1
                    //Check Current Oxygen
                        //>0 - GoTo 2c
                        //=0 - GoTo 3a
                    //SendMessageToPC(oTarget, "2b");
                    DF_SetDrownState(oTarget, DF_DrownState_HoldingBreath);
                    if (DF_GetCurrentOxygenHD(oTarget) > 0)
                    {
                        //2c. -1 CurrentOxygen:
                            //GoTo 1b
                        //SendMessageToPC(oTarget, "2c");
                        nCurOxygenHD = (nCurOxygenHD-1);
                        DF_SetCurrentOxygenHD(oTarget, nCurOxygenHD);

                        SendMessageToPC(oTarget, "State: Holding Breath");
                        FloatingTextStringOnCreature("O2: " + sCurOxygenHD + "/" + sMaxOxygenHD, oTarget, FALSE);
                        SendMessageToPC(oTarget, "Suffocate DC: " + sDrownDC);
                        SendMessageToPC(oTarget, "::::::::::::::::::::::::::::::::::::::::::::::::");
                    }
                    else
                    {
                        //STATE: DROWNING CON CHECKS
                        //3a. Check DrownDC [10 + (1 per Round)]:
                          //Success - GoTo 3b
                          //Failure - GoTo 4a
                        //SendMessageToPC(oTarget, "3a");
                        nDCCheck = (d20(1));
                        nCONMod = GetCONMod(oTarget);
                        nTotal = nDCCheck+nCONMod;
                        sDCCheck = IntToString(nDCCheck);
                        sCONMod = IntToString(nCONMod);
                        sTotal = IntToString(nTotal);
                        if (nTotal >= nDrownDC && nDCCheck != 1 || nDCCheck == 20)
                        {
                            //SendMessageToPC(oTarget, "3b");
                            //3b. +1 DrownDC:
                            nDrownDC = (nDrownDC + 1);
                            DF_SetDrownDC(oTarget, nDrownDC);

                            SendMessageToPC(oTarget, "State: Oxygen Deprived");
                            SendMessageToPC(oTarget, "O2: " + sCurOxygenHD + "/" + sMaxOxygenHD);
                            SendMessageToPC(oTarget, "Suffocate DC: " + sDrownDC);
                            SendMessageToPC(oTarget, "Check: " + sDCCheck + "+" + sCONMod + "=" + sTotal);
                            SendMessageToPC(oTarget, "::::::::::::::::::::::::::::::::::::::::::::::::");
                        }
                        else
                        {
                            //STATE: DROWNING
                            //4a. Set DrownState 2
                            //Check CurrentOxygen:
                                //=0 - GoTo 4b
                                //>0 - GoTo 2b
                            //SendMessageToPC(oTarget, "4a");
                            DF_SetDrownState(oTarget, DF_DrownState_Drowning);
                            if (DF_GetCurrentOxygenHD(oTarget) > 0)
                            {
                                //2b. Set DrownState 1
                                //SendMessageToPC(oTarget, "2b");
                                DF_SetDrownState(oTarget, DF_DrownState_HoldingBreath);
                                DF_SetDrownDC(oTarget, 10);

                                SendMessageToPC(oTarget, "State: Holding Breath");
                                SendMessageToPC(oTarget, "O2: " + sCurOxygenHD + "/" + sMaxOxygenHD);
                                SendMessageToPC(oTarget, "Suffocate DC: " + sDrownDC);
                                SendMessageToPC(oTarget, "::::::::::::::::::::::::::::::::::::::::::::::::");
                            }
                            else
                            {
                                //4b. -1 Player HD
                                //SendMessageToPC(oTarget, "4b");
                                SendMessageToPC(oTarget, "State: Drowning");
                                SendMessageToPC(oTarget, "O2: " + sCurOxygenHD + "/" + sMaxOxygenHD);
                                SendMessageToPC(oTarget, "Suffocate DC: " + sDrownDC);
                                SendMessageToPC(oTarget, "Check: " + sDCCheck + "+" + sCONMod + "=" + sTotal);
                                SendMessageToPC(oTarget, "::::::::::::::::::::::::::::::::::::::::::::::::");

                                nDamage = GetCurrentHitPoints(oTarget);
                                eDamage = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY);
                                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                            }
                        }
                    }
                }
                else
                {
                    //STATE: DROWNING
                    //4a. Set DrownState 2
                    //Check CurrentOxygen:
                        //=0 - GoTo 4b
                        //>0 - GoTo 2b
                    //SendMessageToPC(oTarget, "4a");
                    DF_SetDrownState(oTarget, DF_DrownState_Drowning);
                    if (DF_GetCurrentOxygenHD(oTarget) > 0)
                    {
                        //2b. Set DrownState 1
                        //SendMessageToPC(oTarget, "2b");
                        DF_SetDrownState(oTarget, DF_DrownState_HoldingBreath);
                        DF_SetDrownDC(oTarget, 10);

                        SendMessageToPC(oTarget, "State: Holding Breath");
                        SendMessageToPC(oTarget, "O2: " + sCurOxygenHD + "/" + sMaxOxygenHD);
                        SendMessageToPC(oTarget, "Suffocate DC: " + sDrownDC);
                        SendMessageToPC(oTarget, "::::::::::::::::::::::::::::::::::::::::::::::::");
                    }
                    else
                    {
                        //4b. -1 Player HD
                        //SendMessageToPC(oTarget, "4b");
                        SendMessageToPC(oTarget, "State: Drowning");
                        SendMessageToPC(oTarget, "O2: " + sCurOxygenHD + "/" + sMaxOxygenHD);
                        SendMessageToPC(oTarget, "Suffocate DC: " + sDrownDC);
                        SendMessageToPC(oTarget, "::::::::::::::::::::::::::::::::::::::::::::::::");

                        nDamage = GetCurrentHitPoints(oTarget);
                        eDamage = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                    }
                }
            }
        }
        //oPCArea = GetArea(oTarget);
        //if (DF_CheckBreathAreaType(oPCArea) == 0)
        //    {
        //        DF_ReplenishOxygen(oTarget);
        //    }
        oTarget = GetNextObjectInArea(OBJECT_SELF);
        if (GetObjectType(oTarget) != OBJECT_TYPE_CREATURE)
        {
            oTarget = GetNextObjectInArea(OBJECT_SELF);
        }
    }
}
