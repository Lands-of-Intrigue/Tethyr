// sas_modload
// Michael G. Janicki
// 05 February 2003
/*
    This file indicates the method for establishing addictive
    item records in your module.  Each addictive item you want
    to have should have a block as below which defines the
    various parameters for the addiction.  Included as part
    of the example are 2 addictive items with varying properties
    for you to test and experiment with.
*/

#include "sas_include"

void main()
{
    struct AddictiveItem aItem;

    // To add a definition for a new addiction 'monkey' in
    // your module... copy everything from START_COPY down to
    // the END_COPY line and paste it before the function
    // return.  Then simply edit the properties to suit
    // your item.  Hopefully the names of the variables are
    // enough to tell what each is for, but the readme files
    // in the archive this was distributed in provide detail
    // if you need it.

    // Example addictive item definition.  This item has
    // a long time between withdrawals, but each time the
    // item is used, the next withdrawal moves 2 hours closer.
    // The beneficial effect is a random stat increase with
    // a duration of 1/3rd the time to initial withdrawal.
    // Withdrawal effect is a random stat decrease.  Overdose
    // is common with this item and the effect is a permanent
    // curse.
    // START_COPY
    aItem.sItemTag = "SAS_Seeds";
    aItem.sCureTag = "SAS_SeedCure";
    aItem.sNewAddictMsg = "You are now addicted to these seeds.";
    aItem.sOldAddictMsg = "You feel the warmth of your old friend.";
    aItem.sWithdrawalMsg = "You feel horrible cravings for the seeds.";
    aItem.sCureMsg = "Your addiction to seeds has been cured.";
    aItem.nNeedHours = 20;
    aItem.nWorsenHours = 2;
    aItem.nTimesToOverdose = 3;
    aItem.nAddictionDC = 15;
    aItem.nWithdrawalDC = 20;
    aItem.nOverdoseDC = 20;
    aItem.nGoodEffectReal = EFFECT_TYPE_ABILITY_INCREASE;
    aItem.nGoodEffectVisual = VFX_IMP_IMPROVE_ABILITY_SCORE;
    aItem.fGoodEffectDuration = (IntToFloat(aItem.nNeedHours) * HoursToSeconds(1)) / 3.0;
    aItem.nBadEffectReal = EFFECT_TYPE_ABILITY_DECREASE;
    aItem.nBadEffectVisual = VFX_IMP_REDUCE_ABILITY_SCORE;
    aItem.nOverdoseEffectReal = EFFECT_TYPE_CURSE;
    aItem.nOverdoseEffectVisual = VFX_IMP_DOOM;
    aItem.nCureEffectVisual = VFX_IMP_HEALING_X;
    CreateMonkey(aItem);
    // END_COPY

    // Second example addictive item.  This one has a shorter
    // withdrawal time and is more difficult to become addicted
    // to.  Withdrawal is relatively difficult to save against,
    // but overdose doesn't come often.  This addiction does
    // not get worse over time.  The beneficial effect is
    // haste, with a static 60 second duration.  Negative
    // effect is permanent deafness, and overdose results
    // in a random permanent disease.
    aItem.sItemTag = "SAS_Beef";
    aItem.sCureTag = "SAS_BeefCure";
    aItem.sNewAddictMsg = "You are now addicted to this wonderful food.";
    aItem.sOldAddictMsg = "This meal sates your appetite for a time.";
    aItem.sWithdrawalMsg = "You must find more of that incredible beef.";
    aItem.sCureMsg = "You are cured of the addiction to red meat.";
    aItem.nNeedHours = 8;
    aItem.nWorsenHours = 0;
    aItem.nTimesToOverdose = 5;
    aItem.nAddictionDC = 20;
    aItem.nWithdrawalDC = 25;
    aItem.nOverdoseDC = 10;
    aItem.nGoodEffectReal = EFFECT_TYPE_HASTE;
    aItem.nGoodEffectVisual = VFX_IMP_HASTE;
    aItem.fGoodEffectDuration = 60.0;
    aItem.nBadEffectReal = EFFECT_TYPE_DEAF;
    aItem.nBadEffectVisual = VFX_IMP_NEGATIVE_ENERGY;
    aItem.nOverdoseEffectReal = EFFECT_TYPE_DISEASE;
    aItem.nOverdoseEffectVisual = VFX_IMP_DISEASE_S;
    aItem.nCureEffectVisual = VFX_IMP_HEALING_S;
    CreateMonkey(aItem);


    // Haunspeir
    aItem.sItemTag = "Haunspeir";
    aItem.sCureTag = "AddictionCure";
    aItem.sNewAddictMsg = "You are now addicted to Haunspeir";
    aItem.sOldAddictMsg = "You've just taken another dose of a drug you're addicted to (Haunspeir).";
    aItem.sWithdrawalMsg = "Your body and mind ache for more Haunspeir";
    aItem.sCureMsg = "You are no longer addicted to Haunspeir";
    aItem.nNeedHours = 23;
    aItem.nWorsenHours = 0;
    aItem.nTimesToOverdose = 0;
    aItem.nAddictionDC = 8;
    aItem.nWithdrawalDC = 15;
    aItem.nOverdoseDC = 1;
    CreateMonkey(aItem);

    // Kammarth
    aItem.sItemTag = "Kammarth";
    aItem.sCureTag = "AddictionCure";
    aItem.sNewAddictMsg = "You are now addicted to Kammarth";
    aItem.sOldAddictMsg = "You've just taken another dose of a drug you're addicted to (Kammarth)";
    aItem.sWithdrawalMsg = "Your body and mind ache for more Kammarth";
    aItem.sCureMsg = "You are no longer addicted to Kammarth";
    aItem.nNeedHours = 13;
    aItem.nWorsenHours = 1;
    aItem.nTimesToOverdose = 0;
    aItem.nAddictionDC = 15;
    aItem.nWithdrawalDC = 19;
    aItem.nOverdoseDC = 1;
    CreateMonkey(aItem);

    // Mordayn Vapor
    aItem.sItemTag = "MordaynVapor";
    aItem.sCureTag = "AddictionCure";
    aItem.sNewAddictMsg = "You are now addicted to Mordayn Vapor";
    aItem.sOldAddictMsg = "You've just taken another dose of a drug you're addicted to (Mordayn Vapor)";
    aItem.sWithdrawalMsg = "Your body and mind ache for more Mordayn Vapor";
    aItem.sCureMsg = "You are no longer addicted to Mordayn Vapor";
    aItem.nNeedHours = 5;
    aItem.nWorsenHours = 3;
    aItem.nTimesToOverdose = 0;
    aItem.nAddictionDC = 18;
    aItem.nWithdrawalDC = 20;
    aItem.nOverdoseDC = 1;
    CreateMonkey(aItem);

    // Rhul
    aItem.sItemTag = "Rhul";
    aItem.sCureTag = "AddictionCure";
    aItem.sNewAddictMsg = "You are now addicted to Rhul";
    aItem.sOldAddictMsg = "You've just taken another dose of a drug you're addicted to (Rhul)";
    aItem.sWithdrawalMsg = "Your body and mind ache for more Rhul";
    aItem.sCureMsg = "You are no longer addicted to Rhul";
    aItem.nNeedHours = 6;
    aItem.nWorsenHours = 1;
    aItem.nTimesToOverdose = 0;
    aItem.nAddictionDC = 15;
    aItem.nWithdrawalDC = 17;
    aItem.nOverdoseDC = 1;
    CreateMonkey(aItem);

    // Sezarad Root
    aItem.sItemTag = "SezaradRoot";
    aItem.sCureTag = "AddictionCure";
    aItem.sNewAddictMsg = "You are now addicted to Sezarad Root";
    aItem.sOldAddictMsg = "You've just taken another dose of a drug you're addicted to (Sezarad Root)";
    aItem.sWithdrawalMsg = "Your body and mind ache for more Sezarad Root";
    aItem.sCureMsg = "You are no longer addicted to Sezarad Root";
    aItem.nNeedHours = 23;
    aItem.nWorsenHours = 0;
    aItem.nTimesToOverdose = 0;
    aItem.nAddictionDC = 10;
    aItem.nWithdrawalDC = 13;
    aItem.nOverdoseDC = 1;
    CreateMonkey(aItem);

    // Ziran
    aItem.sItemTag = "Ziran";
    aItem.sCureTag = "AddictionCure";
    aItem.sNewAddictMsg = "You are now addicted to Ziran";
    aItem.sOldAddictMsg = "You've just taken another dose of a drug you're addicted to (Ziran)";
    aItem.sWithdrawalMsg = "Your body and mind ache for more Ziran";
    aItem.sCureMsg = "You are no longer addicted to Ziran";
    aItem.nNeedHours = 3;
    aItem.nWorsenHours = 2;
    aItem.nTimesToOverdose = 0;
    aItem.nAddictionDC = 18;
    aItem.nWithdrawalDC = 20;
    aItem.nOverdoseDC = 1;
    CreateMonkey(aItem);

    return;
}

