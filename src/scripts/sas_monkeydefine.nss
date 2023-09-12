// sas_monkeydefine
// Michael G. Janicki
// 05 February 2003
/*
    OnUserDefined script for the custom placeable "SAS Monkey"
    (resref: "sasmonkey", tag: "SASMonkey")
    Waits for a specific signal from the module heartbeat
    script to wake up this monkey.  The monkey then goes
    out and searches for PCs afflicted with its particular
    addiction and applies withdrawal effects as necessary.
    This script is already specified as the OnUserDefined
    script for the monkey object included in the ERF.
*/

#include "sas_include"

void main()
{
    int nEvent = GetUserDefinedEventNumber();

    // n_SAS_WITHDRAWAL_EVENT is defined in "sas_include" as
    // 6111 by default.  Change it there if it conflicts
    // with another user-defined signal.
    if (nEvent == n_SAS_WITHDRAWAL_EVENT)
    {
        int nMyIdx = GetLocalInt(OBJECT_SELF, "nMyIdx");
        object oPC = GetFirstPC();

        while (GetIsPC(oPC) == TRUE)
        {
            if (GetIsPCInWithdrawal(oPC, nMyIdx) == TRUE)
            {
                WithdrawAddict(oPC, nMyIdx);
            }
            oPC = GetNextPC();
        }
    }

    return;
}

