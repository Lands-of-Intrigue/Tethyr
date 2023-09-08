//:://////////////////////////////////////////////
//:: MainEntryScript
//:: TE_FirstArea
//:: Function(D20) 2016
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: David Novotny
//:: Created On: March 22, 2016
//:://////////////////////////////////////////////
#include "spawn_main"
#include "nw_i0_spells"
#include "x0_i0_match"
void main()
{
    object oPC = GetEnteringObject();
    object oArea = OBJECT_SELF;
    object oMod = GetModule();
    object oData = GetNearestObjectByTag("Area_Data_Object", oArea, 1);
    int iXPArea = GetLocalInt(oData,"iXPRate");
    int iXP;
    int nPrevMin = GetLocalInt(oPC, "PrevTimeMinute");
    int nPrevHr = GetLocalInt(oPC, "PrevTimeHour");
    switch (iXPArea)
                {
                    case 1: //Deserts
                    {
                        iXP = GetLocalInt(oMod,"iDesertXP");
                        break;
                    }
                    case 2: //Plains
                    {
                        iXP = GetLocalInt(oMod,"iPlainXP");
                        break;
                    }
                    case 3: //Hills
                    {
                        iXP = GetLocalInt(oMod,"iHillXP");
                        break;
                    }
                    case 4: //Marshes
                    {
                        iXP = GetLocalInt(oMod,"iMarshXP" );
                        break;
                    }
                    case 5: //Forests
                    {
                        iXP = GetLocalInt(oMod,"iForestXP");
                        break;
                    }
                    case 6: //Crypts
                    {
                        iXP = GetLocalInt(oMod,"iCryptXP");
                        break;
                    }
                    case 7: //Roads
                    {
                        iXP = GetLocalInt(oMod,"iRoadXP");
                        break;
                    }
                    case 8: //Towns
                    {
                        iXP = GetLocalInt(oMod,"iTownXP");
                        break;
                    }
                    case 9: //Temples
                    {
                        iXP = GetLocalInt(oMod,"iTempleXP");
                        break;
                    }
                    case 10: //Secret Areas
                    {
                        iXP = GetLocalInt(oMod,"iSecretXP");
                        break;
                    }
                    case 11: //Taverns
                    {
                        iXP = GetLocalInt(oMod,"iTavernXP");
                        break;
                    }
                    case 12: //Keeps
                    {
                        iXP = GetLocalInt(oMod,"iKeepXP");
                        break;
                    }
                    default:
                    {
                        iXP = 1;
                        break;
                    }
                }
    Spawn();

    //If they are a player continue.
    if(GetIsPC(oPC) != FALSE)
    {

        if (GetTimeMinute() == 6|11|16|21|26)
        {
            if ( GetTimeMinute() != nPrevMin)
            {
                SetLocalInt(oPC,"PrevTimeMinute",GetTimeMinute());
                //XP AWARDING SYSTEM
                GiveTrueXPToCreature(oPC, iXP,FALSE);
            }
        }

        //Burning Vampires
        if(GetLocalInt(oPC, "iPCAffliction") == 3|4)
        {
            if ( GetTimeHour() != nPrevHr)
            {
                SetLocalInt(oPC,"PrevTimeHour",GetTimeHour());
                //Vampire Dawn/Dusk messages.
                if (GetTimeHour() == 5 && GetTimeMinute() == 1)
                {
                    SendMessageToPC(oPC, "You feel an eerie sensation that you've come to associate with the rising sun.");
                }
                else if (GetTimeHour() == 18 && GetTimeMinute() == 1)
                {
                    SendMessageToPC(oPC, "You feel an soothing sensation that you've come to associate with the setting sun.");
                }
            }

            //BURN BABY BURN
            if (GetIsDay() == TRUE && GetIsAreaInterior(oArea) == FALSE)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d20(1), DAMAGE_TYPE_FIRE,DAMAGE_POWER_PLUS_TWENTY),oPC);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_IMP_FLAME_M), oPC, RoundsToSeconds(1));
            }
        }

        //Transforming werewolves.
        if(GetLocalInt(oPC, "iPCAffliction") == 1)
        {
            //If the moon is full, and it is nearly midnight...TRANSFORM!
            if((GetCalendarDay() == 27|28) && GetTimeHour() == 23|0|1 && GetHasEffect(EFFECT_TYPE_POLYMORPH,oPC) != TRUE)
            {
                if(GetTimeMinute() != nPrevMin)
                {
                    SetLocalInt(oPC,"PrevTimeMinute",GetTimeMinute());
                    if (d20(1) <= 4)
                    //Into a terribul wulf. They can cancel the polymorph, but will transform back anyway.
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectPolymorph(146, TRUE), oPC, HoursToSeconds(1));
                    }
                }

            }
            else
            {}
        }


   }
}
