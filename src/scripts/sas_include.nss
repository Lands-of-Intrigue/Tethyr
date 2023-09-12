// sas_include
// Michael G. Janicki
// 05 February 2003
/*
    Simple Addiction System v1.0-final

    Intended as an include file for use with addictive
    items.  Contains functions and 'constants' common to
    use with Simple Addiction System.

    The various properties for each addictive item are
    specified in "sas_modload" which should be merged into
    your module OnModuleLoad script.

    Special thanks to the NWN community at large for
    constant feedback.  Bugs were fixed and improvements
    added all because people took the time to test and
    report.
*/



/*
    Some things scripters may want to change follow.
*/

// Some common variable names just so changes can be made
// in one place.  If these conflict with module-wide variable
// names you use, just change them.
string sNeedHourVar = "nSAS_NeedHour";
string sNeedsEveryVar = "nSAS_NeedsEvery";
string sAddictedVar = "nSAS_IsAddicted";
string sWithdrawalVar = "nSAS_InWithdrawal";
string sLastUsedHourVar = "nSAS_LastUsedHour";
string sUseCountVar = "nSAS_UseCount";

// User-defined event number to signal 'monkeys' to look
// for addicts who are in withdrawal.  Change this one line
// if it interferes with an event number you already use.
int n_SAS_WITHDRAWAL_EVENT = 6111;


// Not likely that anything below here needs to be changed
// for casual use.

/*
    Structure definition for use in creating monkeys
    when the module is loaded.  This allows each and
    every addictive item to have completely different
    properties and effects.
*/

// Sorry I had to bury the tags down toward the end of
// the struct but you can't seem to have a string as the
// first element of a structure - causes all sorts of
// weirdness.
struct AddictiveItem
{
    int nNeedHours;         // hours until this item causes withdrawal
    int nWorsenHours;       // hours withdrawal time is reduced by on each use of this item
    int nTimesToOverdose;   // times of use in one game hour that may lead to overdose
    int nAddictionDC;       // DC to avoid addiction
    int nWithdrawalDC;      // DC to avoid withdrawal effects
    int nOverdoseDC;        // DC to avoid overdose
    int nGoodEffectReal;    // beneficial effect of item use
    int nGoodEffectVisual;  // associated visual
    float fGoodEffectDuration; // and duration
    int nBadEffectReal;     // negative effect of withdrawal
    int nBadEffectVisual;   // associated visual
    int nOverdoseEffectReal;    // effect from item overdose
    int nOverdoseEffectVisual;  // associated visual
    int nCureEffectVisual;  // visual effect for cure use
    string sItemTag;        // tag of item that causes this addiction
    string sCureTag;        // tag of item that cures this addiction
    string sNewAddictMsg;   // message new addicts receive
    string sOldAddictMsg;   // message old addicts receive
    string sWithdrawalMsg;  // message addict receives at withdrawal
    string sOverdoseMsg;    // message received on overdose
    string sCureMsg;        // message received when cured of this addiction
};


/*
    Function prototypes follow.
*/

void CureAddict(object oPC, int nItemIdx);    // Removes addiction from oPC.
void NewAddict(object oPC, int nItemIdx);     // Starts oPC addiction on item use.
void OldAddict(object oPC, int nItemIdx);     // Affects addicted oPC on item use.
void ApplyAddictionGoodEffect(object oPC, int nItemIdx); // Apply good effect to oPC.
void ApplyAddictionBadEffect(object oPC, int nItemIdx);  // Apply bad effect to oPC.
void RemoveAddictionGoodEffects(object oPC, int nItemIdx); // Remove good effects from oPC.
void RemoveAddictionBadEffects(object oPC, int nItemIdx);  // Remove bad effects from oPC.
int GetAddictiveItem(object oItem); // Determine if item is addictive.
int GetCurativeItem(object oItem);  // Determine if item is curative for addiction.
int GetPCNeedsEvery(object oPC, int nItemIdx); // get number of hours PC can go without use of an item
void SetPCNeedsEvery(object oPC, int nItemIdx, int nHours);
void ProcessAddict(object oPC, int nItemIdx); // See what kid of addict and respond accordingly.
int GetIsPCAddicted(object oPC, int nItemIdx); // Determine if oPC is addict.
void SetIsPCAddicted(object oPC, int nItemIdx, int nState); // Set oPC addiction state.
int GetIsPCInWithdrawal(object oPC, int nItemIdx); // Determine if oPC is in withdrawal.
void SetIsPCInWithdrawal(object oPC, int nItemIdx, int nState); // Set oPC withdrawal state.
void SetPCNeedHour(object oPC, int nItemIdx, int nHour); // Set hour oPC will next hit withdrawal
int GetPCNeedHour(object oPC, int nItemIdx); // Determine next time oPC goes into withdrawal.
void WithdrawAddict(object oPC, int nItemIdx); // Apply withdrawal to oPC.
int OverdosePC(object oPC, int nItemIdx); // Overdose oPC = death (fort. save)
void SetLastUsedHour(object oPC, int nItemIdx); // Record last hour PC used item - for overdose checks
int GetLastUsedHour(object oPC, int nItemIdx); // Get last hour PC used item - overdose checks
void SetPCUseCount(object oPC, int nItemIdx, int nCount); // Set times PC has used item in current game hour
int GetPCUseCount(object oPC, int nItemIdx); // Get times PC has used item in current game hour
int PCDidOverdose(object oPC, int nItemIdx); // Checks for overdose condition and overdoses if needed.
                               // returns TRUE = applied overdose

/*
    This is all new since v0.3-beta.
    I needed a way to get out of the module-wide heartbeat
    for withdrawal checks.  As much as I don't like this
    method, it's the most reliable of the few I tried.
    Each addiction, because an addiction doesn't really
    exist physically, is represented by a "monkey on the
    addicts' backs".  Hence, functions that refer to a
    monkey are refering to actions on these 'non-existent'
    objects.  Each monkey stores the specifics of one and
    only one addiction.  So, if you want 300 different items
    in your module to be addictive, you'll end up with 300
    monkeys.  The monkeys can be signaled so that each monkey
    processes withdrawal effects for only its one addiction.
    This allowed me to get out of the heartbeat more quickly
    and to distribute the workload to the various monkeys.
    Internally, each monkey is referenced by an index number
    assigned to that monkey during module load.  I found this
    to be easier and slightly more efficient than passing
    the objects themselves.
*/

void CreateMonkey(struct AddictiveItem aItem); // ties a new monkey and it's properties to the module
object NewMonkey(); // creates representative object for an addiction
string GetNextMonkeyName(); // generates a new unique monkey name
int GetLastMonkeyIdx(); // returns the last numeric index in use by active monkeys
void SetLastMonkeyIdx(int nIdx); // sets last used monkey index (internal use only)
                                 // [incidentally, can we specify Private functions?]
string MonkeyNameFromIdx(int nIdx); // returns the name of a monkey given its index number
int MonkeyIdxFromName(string sMonkeyName); // unused, but handy in case you need it
string GetItemTag(int nItemIdx); // returns tag of addictive item monkey is responsible for
string GetCureTag(int nItemIdx); // returns tag of curative item monkey is responsible for
int GetTimesToOverdose(int nItemIdx);       // remaining functions
int GetOverdoseDC(int nItemIdx);            // all retrieve a specific
string GetOverdoseMessage(int nItemIdx);    // piece of data from
int GetWorsenHours(int nItemIdx);           // a specific monkey
string GetOldAddictMessage(int nItemIdx);
int GetAddictionDC(int nItemIdx);
int GetNeedHours(int nItemIdx);
string GetNewAddictMessage(int nItemIdx);
int GetWithdrawalDC(int nItemIdx);
string GetWithdrawalMessage(int nItemIdx);
string GetCureMessage(int nItemIdx);
float GetGoodEffectDuration(int nItemIdx);
effect GetGoodEffectFull(int nItemIdx);
effect GetBadEffectFull(int nItemIdx);
effect GetOverdoseEffectFull(int nItemIdx);
effect GetCureEffectVisual(int nItemIdx);
int GetGoodEffectType(int nItemIdx);
int GetBadEffectType(int nItemIdx);

effect LookupRealEffect(int nEffectType);   // takes an EFFECT_TYPE and returns a constructed effect
void WakeupMonkeys();   // used via module heartbeat to tell the monkeys to do their work


/*
    Function definitions follow.
*/

/*
    Called upon use of the designated curative through
    OnActivateItem.  Flags oPC as no longer addicted or
    in withdrawal, sends message to oPC and removes any
    residual effects of the addiction; but, does NOT
    remove residual effects of an overdose.
*/
void CureAddict(object oPC, int nItemIdx)
{
    if (GetIsPCAddicted(oPC, nItemIdx) == TRUE) // don't cure non-addicts
    {
        string sIdx = IntToString(nItemIdx);

        SetIsPCAddicted(oPC, nItemIdx, FALSE);
        SetIsPCInWithdrawal(oPC, nItemIdx, FALSE);
        DeleteLocalInt(oPC, sNeedHourVar + sIdx);
        DeleteLocalInt(oPC, sNeedsEveryVar + sIdx);
        DeleteLocalInt(oPC, sLastUsedHourVar + sIdx);
        DeleteLocalInt(oPC, sUseCountVar + sIdx);
        SendMessageToPC(oPC, GetCureMessage(nItemIdx));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            GetCureEffectVisual(nItemIdx),
                            oPC
                           );
        RemoveAddictionBadEffects(oPC, nItemIdx);
    }
    return;
}


/*
    Called upon use of addictive item through OnActivateItem
    for an oPC who was not previously addicted.  Flags oPC
    as addicted, sets withdrawal time for this oPC, sends
    message to oPC and applies positive effects of addictive
    item.  oPC gets a fortitude save against addiction.  If
    save passed, oPC is not addicted but still receives the
    positive effects of the item.
*/
void NewAddict(object oPC, int nItemIdx)
{
    if (FortitudeSave(oPC, GetAddictionDC(nItemIdx)) == 0) // failed save
    {
        SetIsPCAddicted(oPC, nItemIdx, TRUE);
        // Indicate when PC will next need the addictive item.
        SetPCNeedHour(oPC, nItemIdx, (GetTimeHour() + GetNeedHours(nItemIdx)) % 24);
        // Allow for addictions with varying withdrawal times.
        SetPCNeedsEvery(oPC, nItemIdx, GetNeedHours(nItemIdx));
        SendMessageToPC(oPC, GetNewAddictMessage(nItemIdx));
        SetIsPCInWithdrawal(oPC, nItemIdx, FALSE);
    }

    ApplyAddictionGoodEffect(oPC, nItemIdx);

    return;
}


/*
    Called upon use of addictive item through OnActivateItem
    for an oPC who was previously addicted.  Updates withdrawal
    time for this oPC (applying worsening effect if needed),
    sends message to oPC, removes residual withdrawal effects
    and applies positive effects of addictive item.
*/
void OldAddict(object oPC, int nItemIdx)
{
    // Personal withdrawal timer for this PC.
    int nNeedsEvery = GetPCNeedsEvery(oPC, nItemIdx);

    // Set next time withdrawal will hit.
    SetPCNeedHour(oPC, nItemIdx, (GetTimeHour() +  nNeedsEvery) % 24);

    int nWorsenHours = GetWorsenHours(nItemIdx);
    if (nWorsenHours > 0 // Gets worse over time if true.
        && nNeedsEvery > 1 // If already at lowest timer, skip.
       )
    {
        if (nNeedsEvery > nWorsenHours)
        {
            nNeedsEvery -= nWorsenHours;
        } else
        {
            nNeedsEvery = 1;
        }
        SetPCNeedsEvery(oPC, nItemIdx, nNeedsEvery);
    }

    SendMessageToPC(oPC, GetOldAddictMessage(nItemIdx));
    SetIsPCInWithdrawal(oPC, nItemIdx, FALSE);
    ApplyAddictionGoodEffect(oPC, nItemIdx);

    return;
}


/*
    Called when addictive item is used by oPC.  Removes
    any harmful effects left over from withdrawal then
    applies positive effects of the addictive item.
*/
void ApplyAddictionGoodEffect(object oPC, int nItemIdx)
{
    RemoveAddictionBadEffects(oPC, nItemIdx);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                        GetGoodEffectFull(nItemIdx),
                        oPC,
                        GetGoodEffectDuration(nItemIdx)
                       );

    return;
}


/*
    Called when oPC has hit withdrawal and needs to use the
    addictive item again.  Removes any residual positive
    effects of the addiction then applies negative effects
    of the addictive item.
*/
void ApplyAddictionBadEffect(object oPC, int nItemIdx)
{
    // In case this PC is down to a short withdrawal timer,
    // make sure we remove good effects before applying
    // withdrawal.
    RemoveAddictionGoodEffects(oPC, nItemIdx);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                        GetBadEffectFull(nItemIdx),
                        oPC
                       );

    return;
}


/*
    Removes positive effects associated with the
    addictive item, whether applied by the addictive
    item or by something else.  Gives the PC yet another
    reason to kick the habit and prevents occurences
    of helpful effects lasting into withdrawal.
*/
void RemoveAddictionGoodEffects(object oPC, int nItemIdx)
{
    effect eHelpful = GetFirstEffect(oPC);
    while (GetIsEffectValid(eHelpful))
    {
        if (GetEffectType(eHelpful) == GetGoodEffectType(nItemIdx))
        {
            RemoveEffect(oPC, eHelpful);
        }
        eHelpful = GetNextEffect(oPC);
    }
    return;
}


/*
    Removes the negative effect associated
    with the addiction, whether it was applied by
    the addictive item or by something else.  Makes
    it a bit more interesting for the PC to find a
    reason to kick the habit.
*/
void RemoveAddictionBadEffects(object oPC, int nItemIdx)
{
    effect eHarmful = GetFirstEffect(oPC);
    while (GetIsEffectValid(eHarmful))
    {
        if (GetEffectType(eHarmful) == GetBadEffectType(nItemIdx))
        {
            RemoveEffect(oPC, eHarmful);
        }
        eHarmful = GetNextEffect(oPC);
    }
    return;
}


/*
    A LOT hinges on the next 2 functions, GetAddictiveItem()
    and GetCurativeItem().  They return an integer index
    indicating which monkey handles a specific addiction.
    I found passing an integer to be slightly more efficient
    than passing an object, so all other functions rely on
    the index to locate the proper properties.
*/

/*
    Use to determine if an activated item is an
    addictive item.
    Returns:    integer representing the index of the monkey
                  that handles this addiction
                zero indicates this item is not marked addictive
*/
int GetAddictiveItem(object oItem)
{
    int nFound = FALSE;
    int nIdx = 0;

    if (GetIsObjectValid(oItem) == TRUE)
    {
        string sTag = GetTag(oItem);
        int nLastIdx = GetLastMonkeyIdx();

        for (nIdx = 1; nIdx <= nLastIdx; nIdx++)
        {
            if (GetItemTag(nIdx) == sTag)
            {
                nFound = TRUE;
                break;
            }
        }
    }

    /* Yes, yes, yes... a ternary (?:) would work here
       but I'm a big fan of readability.
     */
    if (nFound == FALSE)
    {
        nIdx = 0;
    }

    return nIdx;
}


/*
    Use to determine if an activated item is an addiction
    curative item.
    Returns:    integer representing the index of the monkey
                  that handles this curative item
                zero indicates this item is not addiction cure
*/
int GetCurativeItem(object oItem)
{
    int nFound = FALSE;
    int nIdx = 0;

    if (GetIsObjectValid(oItem) == TRUE)
    {
        string sTag = GetTag(oItem);
        int nLastIdx = GetLastMonkeyIdx();

        for (nIdx = 1; nIdx <= nLastIdx; nIdx++)
        {
            if (GetCureTag(nIdx) == sTag)
            {
                nFound = TRUE;
                break;
            }
        }
    }

    if (nFound == FALSE)
    {
        nIdx = 0;
    }

    return nIdx;
}


/*
    Retrieves the number of hours between required uses
    of addictive item by oPC.
    Returns: 1 <= hours <= 23
*/
int GetPCNeedsEvery(object oPC, int nItemIdx)
{
    return GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"), sNeedsEveryVar + IntToString(nItemIdx));
}


/*
    Sets the number of hours PC has until withdrawal begins.
    This timer will only use values between 1 and 23, adjusting
    other values accordingly.
*/
void SetPCNeedsEvery(object oPC, int nItemIdx, int nHours)
{
    // Correct for cases where a builder specified an
    // unworkable withdrawal timer for an item.  This is
    // just easier than the half-dozen checks that were
    // scattered around in the first version.
    if (nHours < 1) nHours = 1;
    if (nHours > 23) nHours = 23;
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"), sNeedsEveryVar + IntToString(nItemIdx), nHours);
    return;
}

/*
    Entry point when oPC is found to have used an
    addictive item through OnActivateItem.  Checks if
    oPC is already addicted or not and acts accordingly.
*/
void ProcessAddict(object oPC, int nItemIdx)
{
    // Even non-addicts can overdose.  It is possible
    // that a PC repeatedly uses an item and just manages
    // to save against the addiction each time.
    if (PCDidOverdose(oPC, nItemIdx) == FALSE)
    {
        if (GetIsPCAddicted(oPC, nItemIdx) == TRUE)
        {
            OldAddict(oPC, nItemIdx);
        } else
        {
            NewAddict(oPC, nItemIdx);
        }
    }
    return;
}


/*
    Used to determine if oPC is addicted or not.
    Returns:    TRUE = oPC is addicted
                FALSE = oPC is not addicted
*/
int GetIsPCAddicted(object oPC, int nItemIdx)
{
    return GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"), sAddictedVar + IntToString(nItemIdx));
}


/*
    Used to set addiction state of oPC.
    Set to TRUE = oPC is addicted
    Set to FALSE = oPC is not addicted
*/
void SetIsPCAddicted(object oPC, int nItemIdx, int nState)
{
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"), sAddictedVar + IntToString(nItemIdx), nState);
    return;
}


/*
    Used to determine if oPC is in withdrawal from an
    addictive item.
    Returns:    TRUE = oPC is in withdrawal
                FALSE = oPC is not in withdrawal or is not a PC.
*/
int GetIsPCInWithdrawal(object oPC, int nItemIdx)
{
    int nInWithdrawal = FALSE;

    if (GetIsPCAddicted(oPC, nItemIdx) == TRUE)
    {
        nInWithdrawal = GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"), sWithdrawalVar + IntToString(nItemIdx));
        if (nInWithdrawal == FALSE)
        {
            // We only check for a match of the current hour and
            // this PCs withdrawal timer.  This helps avoid problems
            // such as if the need hour is 1 tomorrow and current
            // hour is 23 today.  Once withdrawal is hit, the
            // withdrawal check above will catch and we don't need
            // to worry about the timer any more.
            if (GetPCNeedHour(oPC, nItemIdx) == GetLocalInt(GetModule(), "AddictCheckHour"))
            {
                nInWithdrawal = TRUE;
            }
        }
    }

    return nInWithdrawal;
}


/*
    Used to set withdrawal state of oPC.
    Set to TRUE = oPC is in withdrawal
    Set to FALSE = oPC is not in withdrawal
*/
void SetIsPCInWithdrawal(object oPC, int nItemIdx, int nState)
{
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"), sWithdrawalVar + IntToString(nItemIdx), nState);
    return;
}


/*
    Used to set the game hour at which oPC will
    next need to use addictive item.  This is also the
    hour at which oPC will hit withdrawal.
*/
void SetPCNeedHour(object oPC, int nItemIdx, int nHour)
{
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"), sNeedHourVar + IntToString(nItemIdx), nHour);
    return;
}


/*
    Used to determine the game hour at which oPC will
    next need to use addictive item.  This is also the
    hour at which oPC will hit withdrawal.
    Returns:    game hour 0-23
*/
int GetPCNeedHour(object oPC, int nItemIdx)
{
    return GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"), sNeedHourVar + IntToString(nItemIdx));
}


/*
    Used to apply withdrawal effects to oPC.  Flags
    oPC as in withdrawal, sends message to oPC and
    applies negative effects of addictive item.  oPC
    is allowed a fortitude save to avoid the effects
    this hour, but still gets flagged as being in
    withdrawal.
*/
void WithdrawAddict(object oPC, int nItemIdx)
{
    // I moved the message outside the save so that
    // the player gets some indication of what (s)he
    // was just forced to make a fortitude save against.
    SendMessageToPC(oPC, GetWithdrawalMessage(nItemIdx));
    SetIsPCInWithdrawal(oPC, nItemIdx, TRUE);

    if (FortitudeSave(oPC, GetWithdrawalDC(nItemIdx)) == 0) // failed save
    {
        ApplyAddictionBadEffect(oPC, nItemIdx);
    }

    return;
}


/*
    Used to apply an overdose to a using PC.  Allows the
    PC a fortitude save and if failed save, apply overdose effect.
    Prior settings of withdrawal state and time until
    withdrawal are NOT reset.
    Returns:    TRUE = overdose applied
                FALSE = overdose saved against
*/
int OverdosePC(object oPC, int nItemIdx)
{
    int nOverdosed = FALSE;

    if (FortitudeSave(oPC, GetOverdoseDC(nItemIdx)) == 0) // failed save
    {
        SendMessageToPC(oPC, GetOverdoseMessage(nItemIdx));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            GetOverdoseEffectFull(nItemIdx),
                            oPC
                           );
        nOverdosed = TRUE;
    }
    return nOverdosed;
}


/*
    Used to set the game hour in which a PC last used
    a specific addictive item.  Used for overdose checks.
*/
void SetLastUsedHour(object oPC, int nItemIdx)
{
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"), sLastUsedHourVar + IntToString(nItemIdx), GetTimeHour());
    return;
}


/*
    Used to retrieve the game hour in which a PC last
    used a specific addictive item.
    Returns:    Game hour 0-23
*/
int GetLastUsedHour(object oPC, int nItemIdx)
{
    return GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"), sLastUsedHourVar + IntToString(nItemIdx));
}


/*
    Used to set the number of times PC has used this
    addictive item in the last game hour.
*/
void SetPCUseCount(object oPC, int nItemIdx, int nCount)
{
    SetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"), sUseCountVar + IntToString(nItemIdx), nCount);
    return;
}


/*
    Used to retrieve the number of times PC has used this
    addictive item in the last game hour.
*/
int GetPCUseCount(object oPC, int nItemIdx)
{
    return GetLocalInt(GetItemPossessedBy(oPC,"PC_Data_Object"), sUseCountVar + IntToString(nItemIdx));
}


/*
    Used to check for an overdose condition.  Compares
    current game hour to PC's last used hour and if same,
    see if PC has used this item too many times.  If so,
    then overdose the PC.  If no overdose, the usecount
    for this hour is increased; if overdose, the usecount
    is reset to zero.  If you do not want an overdose ever,
    set nTimesToOverdose to a non-positive integer in the
    item definition (typically in the OnModuleLoad script.)
*/
int PCDidOverdose(object oPC, int nItemIdx)
{
    int nOverdosed = FALSE;
    int nTimesToOverdose = GetTimesToOverdose(nItemIdx);

    if (nTimesToOverdose > 0) // FALSE here means item never causes overdose
    {
        int nUseCount = GetPCUseCount(oPC, nItemIdx);

        // You may note that this is not a true time-based
        // check (how astute of you).  It checks if the current
        // game hour is the same which serves our purpose well
        // enough.
        if (GetLastUsedHour(oPC, nItemIdx) != GetTimeHour())
        {
            nUseCount = 1; // Different hour so restart use count
        }
        else
        {
            ++nUseCount; // Tack on this use.
            if (nUseCount >= nTimesToOverdose) // possible overdose
            {
                if (OverdosePC(oPC, nItemIdx) == TRUE) // FALSE if PC makes fort. save
                {
                    nOverdosed = TRUE;
                    nUseCount = 0; // Wipe the slate
                }
            }
        }
        SetPCUseCount(oPC, nItemIdx, nUseCount);
        SetLastUsedHour(oPC, nItemIdx); // sets to current game hour
    }

    return nOverdosed;
}


/*
    Used to construct an object containing all of the
    properties of an individual addictive item.  Each
    addictive item you define during module load will
    have its own monkey.  The monkeys are nothing more
    than invisible objects created from a custom blueprint.
    Using this technique allows us to offload withdrawal
    work to the individual monkeys, rather than have a
    huge loop inside a huge loop all under control of the
    module-wide heartbeat.  I thought of attaching individual
    monkeys to PCs as they became addicted, but we run into
    problems with PCs dropping and reloading that way.
    I would prefer to not even have invisible objects to
    do this, but this is what we have to work with.
*/
void CreateMonkey(struct AddictiveItem aItem)
{
    object oMonkey = NewMonkey();

    // All these properties should be set and passed in
    // at module load time to construct the monkeys.
    if (GetIsObjectValid(oMonkey) == TRUE)
    {
        SetLocalString(oMonkey, "sItemTag", aItem.sItemTag);
        SetLocalString(oMonkey, "sCureTag", aItem.sCureTag);
        SetLocalString(oMonkey, "sNewAddictMsg", aItem.sNewAddictMsg);
        SetLocalString(oMonkey, "sOldAddictMsg", aItem.sOldAddictMsg);
        SetLocalString(oMonkey, "sWithdrawalMsg", aItem.sWithdrawalMsg);
        SetLocalString(oMonkey, "sOverdoseMsg", aItem.sOverdoseMsg);
        SetLocalString(oMonkey, "sCureMsg", aItem.sCureMsg);
        SetLocalInt(oMonkey, "nNeedHours", aItem.nNeedHours);
        SetLocalInt(oMonkey, "nWorsenHours", aItem.nWorsenHours);
        SetLocalInt(oMonkey, "nTimesToOverdose", aItem.nTimesToOverdose);
        SetLocalInt(oMonkey, "nAddictionDC", aItem.nAddictionDC);
        SetLocalInt(oMonkey, "nWithdrawalDC", aItem.nWithdrawalDC);
        SetLocalInt(oMonkey, "nOverdoseDC", aItem.nOverdoseDC);
        SetLocalInt(oMonkey, "nGoodEffectReal", aItem.nGoodEffectReal);
        SetLocalInt(oMonkey, "nGoodEffectVisual", aItem.nGoodEffectVisual);
        SetLocalFloat(oMonkey, "fGoodEffectDuration", aItem.fGoodEffectDuration);
        SetLocalInt(oMonkey, "nBadEffectReal", aItem.nBadEffectReal);
        SetLocalInt(oMonkey, "nBadEffectVisual", aItem.nBadEffectVisual);
        SetLocalInt(oMonkey, "nOverdoseEffectReal", aItem.nOverdoseEffectReal);
        SetLocalInt(oMonkey, "nOverdoseEffectVisual", aItem.nOverdoseEffectVisual);
        SetLocalInt(oMonkey, "nCureEffectVisual", aItem.nCureEffectVisual);

        SetLocalObject(GetModule(), GetNextMonkeyName(), oMonkey);

        // Had to add this in otherwise during withdrawal
        // handling, the monkeys have no way to know what
        // their index number is.  I don't like this kind
        // of redundancy and am open to suggestions here.
        SetLocalInt(oMonkey, "nMyIdx", GetLastMonkeyIdx());
    }

    return;
}


/*
    Creates a new instance of a monkey object to store
    properties of one addictive item and to handle withdrawal
    timers for that particular addiction.
*/
object NewMonkey()
{
    // New monkeys representing addictions will be created at
    // the module's starting location.  Honestly, I dislike
    // this myself, but it's one of the few ways I could find
    // to ensure that we have a valid location to put the
    // fictional monkeys at.  Another option would be to
    // extract the starting area from the starting location
    // and rebuild a new location at coords 0.0,0.0,0.0 in
    // the starting area but I don't see what is gained from
    // that effort.
    location lLimbo = GetStartingLocation();
    object oMonkey = CreateObject(OBJECT_TYPE_PLACEABLE, "sasmonkey", lLimbo, FALSE);

    return oMonkey;
}


/*
    Used to retrieve the next available name for a monkey
    object during monkey creation.  Uses a simple index
    scheme to distinguish between monkeys.
*/
string GetNextMonkeyName()
{
    int nIdx = GetLastMonkeyIdx();

    // Hmm... possible race condition here.
    // Who'd ever think we needed a spinlock system?  I
    // smell new project.  Seriously, if anyone runs into
    // a situation where multiple monkeys come up with
    // the same index, I'd love to hear about it.  I'm
    // not certain how much concurrent processing the engine
    // does, but if there are races I'll add locking.
    nIdx++;
    SetLastMonkeyIdx(nIdx);

    return MonkeyNameFromIdx(nIdx);
}


/*
    Used to return the last index number used for created
    monkeys.  Handy for "for()" loops and for deciding the
    next available monkey index.
*/
int GetLastMonkeyIdx()
{
    // Monkeys have no zeroeth element.  The way that
    // GetNextMonkeyName() works will make the first
    // monkey at element 1.  This makes life a bit easier
    // for me as GetLastMonkeyIdx() should always return
    // an index for valid monkey, instead of 1 higher than
    // the last valid monkey.  Also this means a return of
    // zero indicates there are no addictive items in play.
    return GetLocalInt(GetModule(), "nLastMonkeyIdx");
}


/*
    Used to set the last integer used to uniquely identify
    a monkey.  Used primarily as an internal function
    during the creation of monkeys.
*/
void SetLastMonkeyIdx(int nIdx)
{
    // Be careful if you want to wildly call this function.
    // All the withdrawal routines will use this return
    // value as an upper bound.  Safest to just let
    // GetNextMonkeyName() use this internally.
    SetLocalInt(GetModule(), "nLastMonkeyIdx", nIdx);
    return;
}


/*
    Used to determine the monkey name associated with
    a particular numeric index.  These are the names of
    the object stored with SetLocalObject(GetModule(), MonkeyName, oMonkey);
*/
string MonkeyNameFromIdx(int nIdx)
{
    return ("oSASMonkey_" + IntToString(nIdx));
}


/*
    Used to retrieve the index number for a monkey given
    the monkey's unique name.  I think I stopped using
    this but it seemed handy enough to leave in.
*/
int MonkeyIdxFromName(string sMonkeyName)
{
    // This assumes you're using MonkeyNameFromIdx() to
    // build your monkey object names.  A more generic
    // version of this would start on the right end of
    // the string and work backwards until digits were
    // no longer present, then build the numeric from
    // that.  Oh well.
    int nIdxPos;
    int nLength;
    string sIdxVal;

    nIdxPos = FindSubString(sMonkeyName, "_") + 1;
    nLength = GetStringLength(sMonkeyName) - nIdxPos;
    sIdxVal = GetSubString(sMonkeyName, nIdxPos, nLength);

    return StringToInt(sIdxVal);
}


/*
    Used to retrieve the addictive item tag for which
    a particular monkey is responsible.
*/
string GetItemTag(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalString(oMonkey, "sItemTag");
}


/*
    Used to retrieve the curative item tag for which
    a particular monkey is responsible.
*/
string GetCureTag(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalString(oMonkey, "sCureTag");
}


/*
    Used to retrieve the number of times until overdose is
    checked for a particular addictive item.
*/
int GetTimesToOverdose(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalInt(oMonkey, "nTimesToOverdose");
}


/*
    Used to retrieve the DC associated with overdose for
    a particular addiction.
*/
int GetOverdoseDC(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalInt(oMonkey, "nOverdoseDC");
}


/*
    Used to retrieve the overdose message for a particular
    addiction.
*/
string GetOverdoseMessage(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalString(oMonkey, "sOverdoseMsg");
}


/*
    Used to retrieve the number of hours by which withdrawal
    moves closer by use for a particular addiction.
*/
int GetWorsenHours(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalInt(oMonkey, "nWorsenHours");
}


/*
    Used to retrieve the old addict message for
    a particular addiction.
*/
string GetOldAddictMessage(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalString(oMonkey, "sOldAddictMsg");
}


/*
    Used to retrieve the DC associated with addiction for
    a particular addiction.
*/
int GetAddictionDC(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalInt(oMonkey, "nAddictionDC");
}


/*
    Used to retrieve the hours until withdrawal for
    a particular addiction.
*/
int GetNeedHours(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalInt(oMonkey, "nNeedHours");
}


/*
    Used to retrieve the new addict message associated with
    a particular addiction.
*/
string GetNewAddictMessage(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalString(oMonkey, "sNewAddictMsg");
}


/*
    Used to retrieve the DC associated with withdrawal for
    a particular addiction.
*/
int GetWithdrawalDC(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalInt(oMonkey, "nWithdrawalDC");
}


/*
    Used to retrieve the withdrawal message associated with
    a particular addiction.
*/
string GetWithdrawalMessage(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalString(oMonkey, "sWithdrawalMsg");
}


/*
    Used to retrieve the cure message associated with
    a particular addiction.
*/
string GetCureMessage(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalString(oMonkey, "sCureMsg");
}


/*
    Used to retrieve the duration for beneficial effects
    associated with a particular addictive item.
*/
float GetGoodEffectDuration(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalFloat(oMonkey, "fGoodEffectDuration");
}


/*
    Called via module-wide heartbeat to 'wakeup' the various
    monkeys created during module load.  Each monkey is
    signaled with a user-defined event, provoking each
    monkey to search through PCs to find addicts for whom
    the monkey is responsible.  This is the entry point
    for handling of withdrawal.
*/
void WakeupMonkeys()
{
    string sMonkeyName;
    object oMonkey;

    int nIdx;
    int nLastIdx = GetLastMonkeyIdx();

    for (nIdx = 1; nIdx <= nLastIdx; nIdx++)
    {
        sMonkeyName = MonkeyNameFromIdx(nIdx);
        oMonkey = GetLocalObject(GetModule(), sMonkeyName);

        // n_SAS_WITHDRAWAL_EVENT is defined above as 6111
        // Change it near the beginning of this file if that
        // event number conflicts with other events you use.
        if (GetIsObjectValid(oMonkey))
        {
            SignalEvent(oMonkey, EventUserDefined(n_SAS_WITHDRAWAL_EVENT));
        }
    }

    return;
}


/*
    Used to retrieve an effect suitable for ApplyEffect...().
    The effect is built from the specified real and visual
    effect for an addictive item.
*/
effect GetGoodEffectFull(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    int nReal = GetLocalInt(oMonkey, "nGoodEffectReal");
    int nVisual = GetLocalInt(oMonkey, "nGoodEffectVisual");

    effect eReal = LookupRealEffect(nReal);
    effect eVisual = EffectVisualEffect(nVisual);

    return EffectLinkEffects(eVisual, eReal);
}


/*
    Used to retrieve an effect suitable for ApplyEffect...().
    The effect is built from the specified real and visual
    effect for addictive item withdrawal.
*/
effect GetBadEffectFull(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    int nReal = GetLocalInt(oMonkey, "nBadEffectReal");
    int nVisual = GetLocalInt(oMonkey, "nBadEffectVisual");

    effect eReal = LookupRealEffect(nReal);
    effect eVisual = EffectVisualEffect(nVisual);

    return EffectLinkEffects(eVisual, eReal);
}


/*
    Used to retrieve an effect suitable for ApplyEffect...().
    The effect is built from the specified real and visual
    effect for an addictive item overdose.
*/
effect GetOverdoseEffectFull(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    int nReal = GetLocalInt(oMonkey, "nOverdoseEffectReal");
    int nVisual = GetLocalInt(oMonkey, "nOverdoseEffectVisual");

    effect eReal = LookupRealEffect(nReal);
    effect eVisual = EffectVisualEffect(nVisual);

    return EffectLinkEffects(eVisual, eReal);
}


/*
    Used to retrieve an effect suitable for ApplyEffect...().
    The effect is the visual effect specified for the cure
    process of a particular addiction.
*/
effect GetCureEffectVisual(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    int nVisual = GetLocalInt(oMonkey, "nCureEffectVisual");

    return EffectVisualEffect(nVisual);
}


/*
    Used to retrieve the EFFECT_TYPE_* specified as the
    beneficial effect for a particular addictive item.
*/
int GetGoodEffectType(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalInt(oMonkey, "nGoodEffectReal");
}


/*
    Used to retrieve the EFFECT_TYPE_* specified as the
    withdrawal effect for a particular addictive item.
*/
int GetBadEffectType(int nItemIdx)
{
    object oMonkey = GetLocalObject(GetModule(), MonkeyNameFromIdx(nItemIdx));
    return GetLocalInt(oMonkey, "nBadEffectReal");
}


/*
    Used to create effect based on the EFFECT_TYPE_*
    associated with a particular item, both beneficial
    and harmful.  Not all EFFECT_TYPE_* options are
    listed here, just the ones that I thought would
    get the most use.  You don't need to change anything
    here unless you want to add a new possible effect.
    To make use of the default values here, just specify
    the appropriate EFFECT_TYPE_ for your addictive item
    during monkey creation.
*/
effect LookupRealEffect(int nEffectType)
{
    effect eRet;

    // What I wouldn't give for a Set/GetLocalEffect()
    // in this language.
    switch (nEffectType)
    {
    case EFFECT_TYPE_ABILITY_DECREASE:
        eRet = EffectAbilityDecrease(Random(6), Random(3));
        break;

    case EFFECT_TYPE_ABILITY_INCREASE:
        eRet = EffectAbilityIncrease(Random(6), Random(3));
        break;

    case EFFECT_TYPE_AC_DECREASE:
        eRet = EffectACDecrease(Random(10));
        break;

    case EFFECT_TYPE_AC_INCREASE:
        eRet = EffectACIncrease(Random(10));
        break;

    case EFFECT_TYPE_ATTACK_DECREASE:
        eRet = EffectAttackDecrease(Random(10));
        break;

    case EFFECT_TYPE_ATTACK_INCREASE:
        eRet = EffectAttackIncrease(Random(10));
        break;

    case EFFECT_TYPE_BLINDNESS:
        eRet = EffectBlindness();
        break;

    case EFFECT_TYPE_CHARMED:
        eRet = EffectCharmed();
        break;

    case EFFECT_TYPE_CONCEALMENT:
        eRet = EffectConcealment(Random(100));
        break;

    case EFFECT_TYPE_CONFUSED:
        eRet = EffectConfused();
        break;

    case EFFECT_TYPE_CURSE:
        eRet = EffectCurse();
        break;

    case EFFECT_TYPE_DAMAGE_DECREASE:
        eRet = EffectDamageDecrease(Random(10));
        break;

    case EFFECT_TYPE_DAMAGE_INCREASE:
        eRet = EffectDamageIncrease(DAMAGE_BONUS_1d6);
        break;

    case EFFECT_TYPE_DAMAGE_REDUCTION:
        eRet = EffectDamageReduction(Random(5), Random(7), 20);
        break;

    case EFFECT_TYPE_DARKNESS:
        eRet = EffectDarkness();
        break;

    case EFFECT_TYPE_DAZED:
        eRet = EffectDazed();
        break;

    case EFFECT_TYPE_DEAF:
        eRet = EffectDeaf();
        break;

    case EFFECT_TYPE_DISEASE:
        eRet = EffectDisease(Random(17));
        break;

    case EFFECT_TYPE_DISPELMAGICALL:
        eRet = EffectDispelMagicAll(Random(9));
        break;

    case EFFECT_TYPE_DISPELMAGICBEST:
        eRet = EffectDispelMagicBest(Random(9));
        break;

    case EFFECT_TYPE_DOMINATED:
        eRet = EffectDominated();
        break;

    case EFFECT_TYPE_ENTANGLE:
        eRet = EffectEntangle();
        break;

    case EFFECT_TYPE_FRIGHTENED:
        eRet = EffectFrightened();
        break;

    case EFFECT_TYPE_HASTE:
        eRet = EffectHaste();
        break;

    case EFFECT_TYPE_IMMUNITY:
        eRet = EffectImmunity(Random(33));
        break;

    case EFFECT_TYPE_IMPROVEDINVISIBILITY:
        eRet = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
        break;

    case EFFECT_TYPE_INVISIBILITY:
        eRet = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
        break;

    case EFFECT_TYPE_MISS_CHANCE:
        eRet = EffectMissChance(Random(100));
        break;

    case EFFECT_TYPE_MOVEMENT_SPEED_DECREASE:
        eRet = EffectMovementSpeedDecrease(Random(75));
        break;

    case EFFECT_TYPE_MOVEMENT_SPEED_INCREASE:
        eRet = EffectMovementSpeedIncrease(Random(75));
        break;

    case EFFECT_TYPE_NEGATIVELEVEL:
        eRet = EffectNegativeLevel(1);
        break;

    case EFFECT_TYPE_PARALYZE:
        eRet = EffectParalyze();
        break;

    case EFFECT_TYPE_POISON:
        eRet = EffectPoison(Random(44));
        break;

    case EFFECT_TYPE_POLYMORPH:
        eRet = EffectPolymorph(Random(5));
        break;

    case EFFECT_TYPE_REGENERATE:
        eRet = EffectRegenerate(Random(3), IntToFloat(Random(20)));
        break;

    case EFFECT_TYPE_SANCTUARY:
        eRet = EffectSanctuary(Random(5));
        break;

    case EFFECT_TYPE_SAVING_THROW_DECREASE:
        eRet = EffectSavingThrowDecrease(Random(3), Random(3));
        break;

    case EFFECT_TYPE_SAVING_THROW_INCREASE:
        eRet = EffectSavingThrowIncrease(Random(3), Random(3));
        break;

    case EFFECT_TYPE_SEEINVISIBLE:
        eRet = EffectSeeInvisible();
        break;

    case EFFECT_TYPE_SILENCE:
        eRet = EffectSilence();
        break;

    case EFFECT_TYPE_SLEEP:
        eRet = EffectSleep();
        break;

    case EFFECT_TYPE_SLOW:
        eRet = EffectSlow();
        break;

    case EFFECT_TYPE_SPELL_IMMUNITY:
        eRet = EffectSpellImmunity();
        break;

    case EFFECT_TYPE_SPELL_RESISTANCE_DECREASE:
        eRet = EffectSpellResistanceDecrease(Random(10));
        break;

    case EFFECT_TYPE_SPELL_RESISTANCE_INCREASE:
        eRet = EffectSpellResistanceIncrease(Random(10));
        break;

    case EFFECT_TYPE_STUNNED:
        eRet = EffectStunned();
        break;

    case EFFECT_TYPE_TEMPORARY_HITPOINTS:
        eRet = EffectTemporaryHitpoints(Random(20));
        break;

    case EFFECT_TYPE_ULTRAVISION:
        eRet = EffectUltravision();
        break;

    default:
        break;
    }

    return eRet;
}

