//::///////////////////////////////////////////////
//:: [Additional Animations: Animation 5]
//:: [vaei_s3_anim5.nss]
//:: Copyright (c) 2005 Aria Carina Velasco
//:://////////////////////////////////////////////
/*
   Plays Custom Looping Animation 5.
*/

#include "x0_i0_position"
#include "x2_inc_spellhook"
#include "vaei_inc_addanim"

float GetAppearanceModifierFromABAScaling(object oPC);

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
         if unconfigured, optimized default values are used (those are stored in [vaei_inc_addanim]) */

    object oPC = OBJECT_SELF;
    SendMessageToPC(oPC,"This animation has been disabled.");

    /*
    int iCustomAnimScripts = GetLocalInt(GetModule(), "iCustomAnimBehaviour");
    if (iCustomAnimScripts)                     // Moved up here per Alosynth's advice to save the declarations
    {
        ExecuteScript("vaei_s3_cstanm5", oPC);
        return;
    }

    // Real code begins here

    int iAnimIndex = ANIMATION_LOOPING_CUSTOM5;

    float fAnimSpeed = GetLocalFloat(oPC, "fAddnAnim_Speed_5");
        if (fAnimSpeed == 0.0) fAnimSpeed = ADDNANIM_DEFAULT_SPEED_5;
    float fAnimDuration = GetLocalFloat(oPC, "fAddnAnim_Duration_5");
        if (fAnimDuration == 0.0) fAnimDuration = ADDNANIM_DEFAULT_DURATION_5;

    float fDir = GetFacing(oPC);
    float fAppearanceModifier = GetAppearanceModifierFromABAScaling(oPC);
    float fJumpLength = 3.974 * fAppearanceModifier;
    location locJumpTo = GenerateNewLocation(oPC,
                                             fJumpLength,
                                             fDir,
                                             fDir);

    float fAngleOpposite = GetOppositeDirection(fDir);
    location locRunning = GenerateNewLocation(oPC,
                               DISTANCE_TINY,
                               fAngleOpposite,
                               fDir);

    vector vCurrent = GetPositionFromLocation(GetLocation(oPC));
    vector vToJump = GetPositionFromLocation(locJumpTo);
    vector vRunning = GetPositionFromLocation(locRunning);

    effect effTouchupInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    */

    /* Main anim playing code begins here. */
    /*
    if (!LineOfSightVector(vCurrent, vToJump))  // Can't jump where you can't see
    {
        SendMessageToPC(oPC, "Can't jump where you can't see!");
        return;
    }
    else if (!LineOfSightVector(vCurrent, vRunning)) // Need distance to run
    {
        SendMessageToPC(oPC, "Need space behind character to gather speed for jump!");
        return;
    }
    else
    {
        SetFootstepType(FOOTSTEP_TYPE_NONE, oPC);

        DelayCommand(0.3, SetCommandable(FALSE, oPC));
        AddnAnimWrapper(iAnimIndex, fAnimSpeed, fAnimDuration);
        DelayCommand(4.38, SetCommandable(TRUE, oPC));
        DelayCommand(4.40, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, effTouchupInvis, oPC, 1.0));
        DelayCommand(4.45, AssignCommand(oPC, ClearAllActions()));
        DelayCommand(4.49, ActionJumpToLocation(locJumpTo));
        DelayCommand(4.53, AssignCommand(oPC, ClearAllActions()));

        DelayCommand(5.0, SetFootstepType(FOOTSTEP_TYPE_DEFAULT, oPC));
    }
}

float GetAppearanceModifierFromABAScaling(object oPC)
{
    int iRacialType = GetRacialType(oPC);

    if (GetGender(oPC) == GENDER_MALE)
    {
        if(iRacialType == IP_CONST_RACIALTYPE_HUMAN)
            return 1.0;
        else if(iRacialType == IP_CONST_RACIALTYPE_HALFLING)
            return 0.65;
        else if(iRacialType == IP_CONST_RACIALTYPE_ELF)
            return 0.895;
        else if(iRacialType == IP_CONST_RACIALTYPE_DWARF)
            return 0.68;
        else if(iRacialType == IP_CONST_RACIALTYPE_GNOME)
            return 0.63;
        else return 1.03;
    }
    else
    {
        if(iRacialType == IP_CONST_RACIALTYPE_HUMAN)
            return 0.988;
        else if(iRacialType == IP_CONST_RACIALTYPE_HALFLING)
            return 0.632;
        else if(iRacialType == IP_CONST_RACIALTYPE_ELF)
            return 0.883;
        else if(iRacialType == IP_CONST_RACIALTYPE_DWARF)
            return 0.648;
        else if(iRacialType == IP_CONST_RACIALTYPE_GNOME)
            return 0.63;
        else return 0.997;
    }
    */
}

