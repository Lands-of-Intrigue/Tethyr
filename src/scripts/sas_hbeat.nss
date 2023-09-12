// sas_hbeat
// Michael G. Janicki
// 05 February 2003
/*
    Used as a module-wide OnHeartbeat script to handle
    withdrawl effects of addictive items.  If you want
    to add this to an existing heartbeat script, just
    copy the "if" block as-is and include "sas_include".
*/

#include "sas_include"

void main()
{
    // Check PCs for withdrawl once per game hour.
    if (GetLocalInt(GetModule(), "AddictCheckHour") != GetTimeHour())
    {
        // Update the check hour to current hour for withdrawl checks.
        SetLocalInt(GetModule(), "AddictCheckHour", GetTimeHour());

        // Wakeup the monkeys with a SignalEvent() and allow
        // the various monkeys to do the withdrawal work.
        // This gets us out of the heartbeat and splits the
        // workload across multiple monkeys.
        WakeupMonkeys();

    }
}
