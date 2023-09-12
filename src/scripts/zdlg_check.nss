//::///////////////////////////////////////////////
//:: zdlg_check
//:://////////////////////////////////////////////
/*
    Starting Conditional for conversation node in z-dialog
    This replaces all of z-dialog's check scripts, reducing the # of scripts by 12.
    You will need to adjust the conversation responses.
    USE: Place in each "Text Appears When" slot in a series of player respone options


    THANKS to Lightfoot8 for showing me how to create just one script that will work
    to initialize a consecutive series of custom tokens. The reason it works is that
    each "Text appears when" script is executed in order "top to bottom".
    See: http://social.bioware.com/forum/1/topic/192/index/8912939#8913155
*/
//:://////////////////////////////////////////////
//:: Original: pspeed - zdlg_check_01.nss,v 1.2 2005/08/07 04:38:30
//:: Rewritten: The Magus (2012 jan 21) based on Lightfoot8's recommendations
//:://////////////////////////////////////////////

#include "zdlg_include_i"

int StartingConditional()
{
    object oPC      = GetPCSpeaker();

    // Determine which "entry" we are checking. Cycles from 1 - 13 then starts over again.
    int nEntry      = GetLocalInt(oPC,"NEXT_ENTRY");
    if(!nEntry || nEntry>13)
        nEntry = 1;
    int nNextEntry = nEntry+1;
    if(nNextEntry>13)
        nNextEntry = 1;
    SetLocalInt(oPC,"NEXT_ENTRY",nNextEntry);

    return( _SetupDlgResponse( nEntry - 1, oPC ) );
}
