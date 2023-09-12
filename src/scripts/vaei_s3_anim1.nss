//::///////////////////////////////////////////////
//:: [Additional Animations: Animation 1]
//:: [vaei_s3_anim1.nss]
//:: Copyright (c) 2005 Aria Carina Velasco
//:://////////////////////////////////////////////
/*
   Plays Custom Looping Animation 1 (Point/charge!).
*/

#include "x2_inc_spellhook"
#include "vaei_inc_addanim"

void main()
{

    /*
      Bioware stuffs for all spells.
      Spellcast Hook Code
      Added 2003-06-23 by GeorgZ
      If you want to make changes to all spells,
      check x2_inc_spellhook.nss to find out more
    */

        if (!X2PreSpellCastCode())
        {
        // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
            return;
        }
    // End of Spell Cast Hook


    /* This section defines the animation played, together with its parameters.
       The parameters are configurable by the player through the extra AddnAnim dialogue;
         if unconfigured, optimized default values are used (those are stored in [vaei_inc_addanim])
       The feat behaviour can be overridden by setting iCustomAnimBehaviour on module to TRUE;
         that would execute [vaei_s3_cstanmX] instead */

    object oPC = OBJECT_SELF;

    int iAnimIndex = ANIMATION_LOOPING_CUSTOM1;
    int iCustomAnimScripts = GetLocalInt(GetModule(), "iCustomAnimBehaviour");

    float fAnimSpeed = GetLocalFloat(oPC, "fAddnAnim_Speed_1");
        if (fAnimSpeed == 0.0) fAnimSpeed = ADDNANIM_DEFAULT_SPEED_1;
    float fAnimDuration = GetLocalFloat(oPC, "fAddnAnim_Duration_1");
        if (fAnimDuration == 0.0) fAnimDuration = ADDNANIM_DEFAULT_DURATION_1;

    /* Main anim playing code begins here. */

    if (iCustomAnimScripts)
        ExecuteScript("vaei_s3_cstanm1", oPC);
    else
        AddnAnimWrapper(iAnimIndex, fAnimSpeed, fAnimDuration);

}
