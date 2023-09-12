//Must Declare int "nBreathType" Variable to Area Trigger

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
    int nDamage = 1;

    string sBreathType;
    string sBreath;
    string sDrownState;
    string sDrownDC;
    string sCurOxygenHD;
    string sMaxOxygenHD;
    string sDCCheck;
    string sAreaBreathType;

    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY);

    object oTarget = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTarget))
    {
        if(GetIsPC(oTarget))
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
            //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, SupernaturalEffect(EffectVisualEffect(566)), oCreature,4.0f);
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
            SendMessageToPC(oTarget, "Oxygen System v0.4");
            SendMessageToPC(oTarget, "------------------------");
            SendMessageToPC(oTarget, "Area: " + sAreaBreathType);
            if (DF_CheckBreathType(oTarget, nBreathType) == 1)
            {
                //1a. Replenish Oxygen
                //SendMessageToPC(oTarget, "1a");
                DF_ReplenishOxygen(oTarget);

                SendMessageToPC(oTarget, "State: Not Drowning");
                SendMessageToPC(oTarget, "Oxygen: " + sCurOxygenHD + "/" + sMaxOxygenHD);
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
                        SendMessageToPC(oTarget, "Oxygen: " + sCurOxygenHD + "/" + sMaxOxygenHD);
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
                        nDCCheck = ((d20(1))+(GetCONMod(oTarget)));
                        sDCCheck = IntToString(nDCCheck);
                        if (nDCCheck >= nDrownDC)
                        {

                        //SendMessageToPC(oTarget, "3b");
                        //3b. +1 DrownDC:
                        nDrownDC = (nDrownDC + 1);
                        DF_SetDrownDC(oTarget, nDrownDC);

                        SendMessageToPC(oTarget, "State: Oxygen Deprived");
                        SendMessageToPC(oTarget, "Oxygen: " + sCurOxygenHD + "/" + sMaxOxygenHD);
                        SendMessageToPC(oTarget, "Suffocate DC: " + sDrownDC);
                        SendMessageToPC(oTarget, "Check: " + sDCCheck);
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
                                SendMessageToPC(oTarget, "Oxygen: " + sCurOxygenHD + "/" + sMaxOxygenHD);
                                SendMessageToPC(oTarget, "Suffocate DC: " + sDrownDC);
                                SendMessageToPC(oTarget, "::::::::::::::::::::::::::::::::::::::::::::::::");
                            }
                            else
                            {
                                //4b. -1 Player HD
                                //SendMessageToPC(oTarget, "4b");
                                SendMessageToPC(oTarget, "State: Drowning");
                                SendMessageToPC(oTarget, "Oxygen: " + sCurOxygenHD + "/" + sMaxOxygenHD);
                                SendMessageToPC(oTarget, "Suffocate DC: " + sDrownDC);
                                SendMessageToPC(oTarget, "Check: " + sDCCheck);
                                SendMessageToPC(oTarget, "::::::::::::::::::::::::::::::::::::::::::::::::");

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
                        SendMessageToPC(oTarget, "Oxygen: " + sCurOxygenHD + "/" + sMaxOxygenHD);
                        SendMessageToPC(oTarget, "Suffocate DC: " + sDrownDC);
                        SendMessageToPC(oTarget, "::::::::::::::::::::::::::::::::::::::::::::::::");
                    }
                    else
                    {
                        //4b. -1 Player HD
                        //SendMessageToPC(oTarget, "4b");
                        SendMessageToPC(oTarget, "State: Drowning");
                        SendMessageToPC(oTarget, "Oxygen: " + sCurOxygenHD + "/" + sMaxOxygenHD);
                        SendMessageToPC(oTarget, "Suffocate DC: " + sDrownDC);
                        SendMessageToPC(oTarget, "::::::::::::::::::::::::::::::::::::::::::::::::");

                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                    }
                }
            }
        }
        oTarget = GetNextInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
    }
}
