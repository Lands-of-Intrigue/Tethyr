////////////////////////////
// Seige Scripts
// Scripted by Urthen
////////////////////////////
// siege_fireend:
// Finishes firing the weapon.
////////////////////////////
// v1.1: Changed onager_rock calculation to include ONAGER_SHARD_RADIUS
// Added the "firing" variable
// Added Cannon and Scorpion ammo

#include "siege_include"
#include "x0_i0_spells"

void main()
{
    //Load up  the parameters..
    object oWeapon = GetLocalObject(OBJECT_SELF, "siege_used");

    //Following command added in 1.1
    SetLocalInt(oWeapon, "firing", FALSE);

    if(GetDistanceToObject(oWeapon) > DIST_AIMFIRE)
    {
        SendMessageToPC(OBJECT_SELF, "Firing failed: You moved too far.");
        return; //If the PC moved, then exit.
    }

    //Added this in 1.1: Purely cosmetic
    AssignCommand(oWeapon, SpeakString("FIRE!"));

    object oTarget = GetLocalObject(OBJECT_SELF, "siege_target");
    location lTarget = GetLocalLocation(OBJECT_SELF, "siege_location");
    object oAmmo = GetFirstItemInInventory(oWeapon);
    string sAmmo = GetTag(oAmmo);

    DestroyObject(oAmmo);  //Remove the ammo.

    int iDamage;

    effect eVisual, eDamage, eTotal;

    //Calculate + apply damage. Add different ammo damage types here.
    //The nice thing about the way the system is set up is that I dont have
    //to differentiate between different weapons here. Its all done by the ammo tag.

//A giant frikking spear. Not much too interesting about it though.
    if(sAmmo == "arbalest_standard")
    {
        iDamage = d6(7);

        eVisual = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
        eDamage = EffectDamage(iDamage, DAMAGE_TYPE_PIERCING);//link them so if their immune to piercing, they make no blood.
        eTotal = EffectLinkEffects(eVisual, eDamage);

        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTotal, oTarget)); //Damage the enemy and show effect.
        DelayCommand(0.5, NoXPForDeath(oTarget));//No XP if we just killed the target. Discourages people from hunting with siege.
    }

//An even bigger spear.
    if(sAmmo == "scorpion_spear")
    {
        iDamage = d8(9);

        eVisual = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
        eDamage = EffectDamage(iDamage, DAMAGE_TYPE_PIERCING);//link them so if their immune to piercing, they make no blood.
        eTotal = EffectLinkEffects(eVisual, eDamage);

        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTotal, oTarget)); //Damage the enemy and show effect.
        DelayCommand(0.5, NoXPForDeath(oTarget));//No XP if we just killed the target. Discourages people from hunting with siege.
    }

//A big ole rock. Hits the "target" for bludgeon damage, plus all targets in area with percing. (including target)
    if(sAmmo == "onager_rock")
    {
        oTarget = GetNearestObjectToLocation(OBJECT_TYPE_CREATURE, lTarget);

        location lNearest = GetLocation(oTarget);
        eVisual = EffectVisualEffect(VFX_COM_SPARKS_PARRY);

        if((GetDistanceBetweenLocations(lTarget, lNearest) < 5.0) && (oTarget != OBJECT_INVALID))
        {
            lTarget = lNearest;

            iDamage = d4(8);

             //Dont link them: The rock still smashes if their immune.
            eDamage = EffectDamage(iDamage, DAMAGE_TYPE_BLUDGEONING);

            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
            DelayCommand(1.0, NoXPForDeath(oTarget));
        } else
        {
            DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual, lTarget));
        }

        string sTag = "rockmark" + IntToString(Random(1000)); //Generate a random tag and hope it doesnt just happen do be a duplicate.
        CreateObject(OBJECT_TYPE_PLACEABLE, "plc_weathmark", lTarget, FALSE, sTag);
        object oMark = GetObjectByTag(sTag);
        DelayCommand(MARK_TIME, DestroyObject(oMark)); //Remove it after 30 seconds


        eVisual = EffectVisualEffect(VFX_FNF_SOUND_BURST);
        DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual, lTarget));//Show the shockwave effect

        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, ONAGER_SHARD_RADIUS, lTarget, FALSE, OBJECT_TYPE_CREATURE);
        eVisual = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);

        while(oTarget != OBJECT_INVALID)
        {
           int iAC = GetAC(oTarget);
           int iRoll = d20() + ONAGER_SHARD_MODIFIER;

           if(iRoll > iAC)
           {

//Onager Pierce damage dealt here.
                int iDamage = d4(3);


                eDamage = EffectDamage(iDamage, DAMAGE_TYPE_PIERCING);
                eTotal = EffectLinkEffects(eVisual, eDamage); //Do link them here.
                DelayCommand(1.1, ApplyEffectToObject(DURATION_TYPE_INSTANT, eTotal, oTarget));
                DelayCommand(1.1, NoXPForDeath(oTarget));
           }

           oTarget = GetNextObjectInShape(SHAPE_SPHERE, 15.0, lTarget, FALSE, OBJECT_TYPE_CREATURE);
        }


     }

    if(sAmmo == "cannon_web")
    {
        effect eAOE = EffectAreaOfEffect(AOE_PER_WEB, "siege_weba", "siege_webhb", "");

        DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, 45.0));

    }

    if(sAmmo == "cannon_dispel")
    {
        //Copied straight out of nw_s0_dismagic, with some variables changed

        int nCasterLevel = 7;
        effect eImpact = EffectVisualEffect(VFX_FNF_DISPEL);
        effect eVis = EffectVisualEffect(VFX_IMP_BREACH);

        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT | OBJECT_TYPE_PLACEABLE );
        while (GetIsObjectValid(oTarget))
        {
            if(GetObjectType(oTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
            {
                //--------------------------------------------------------------
                // Handle Area of Effects
                //--------------------------------------------------------------
                spellsDispelAoE(oTarget, OBJECT_SELF, nCasterLevel);
            }
            else if (GetObjectType(oTarget) == OBJECT_TYPE_PLACEABLE)
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DISPEL_MAGIC));
            }
            else
            {
                spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact, FALSE);
            }

           oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE,lTarget, FALSE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT | OBJECT_TYPE_PLACEABLE);
        }
    }
}
