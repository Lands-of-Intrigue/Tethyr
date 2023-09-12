//::///////////////////////////////////////////////
//:: Invisibility Sphere
//:: NW_S0_InvSph.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All allies within 15ft are rendered invisible.
    Modified by : Rabidness
             on : June 20 , 2004
    Changes:
        - Fixed an issue where the AOE would dispell if the CASTER left the AOE
            ...when the AOE was supposed to be centered ON the caster.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

//Function called to remove the AOE effect when it is dead, since the normal
//AOE onExit script is disabled against the creator of the effect
//VvVvV This whole function has been added by Rabidness VvVvV
void main()
{

/*
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

    object oTarget = OBJECT_SELF;
    //Declare major variables including Area of Effect Object
    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
    int nDuration = TE_GetCasterLevel(OBJECT_SELF,GetLastSpellCastClass());
    int nMetaMagic = GetMetaMagicFeat();
    //Make sure duration does no equal 0
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    //Check Extend metamagic feat.
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;    //Duration is +100%
    }

    object oFriend = GetFirstObjectInShape(SHAPE_SPHERE, 10.0f,GetSpellTargetLocation(),FALSE,OBJECT_TYPE_CREATURE);

    while (GetIsObjectValid(oFriend) == TRUE)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oTarget, TurnsToSeconds(nDuration));
        oFriend = GetNextObjectInShape(SHAPE_SPHERE, 10.0f,GetSpellTargetLocation(),FALSE,OBJECT_TYPE_CREATURE);
    }


    //Apply Invis


}

